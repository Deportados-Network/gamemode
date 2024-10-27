-- @vars
ESX = exports['es_extended']:getSharedObject()
local mafias = {}
local invitations = {}

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    if resourceName == GetCurrentResourceName() then
        Citizen.Wait(60000) -- Espera 60 segundos después del inicio del recurso antes de ejecutar el siguiente bloque de código

        -- Aquí colocas el código que deseas que se ejecute después de la espera de 60 segundos
    end
end)

-- @commands
RegisterCommand('vermafia', function(src, args)
    if (args[1]) then
        local player = ESX.GetPlayerFromId(tonumber(args[1]))
        if (player) then
            TriggerClientEvent('bm_mafia:requestMafiaInfo', player.source, src)
        end
    end
end)


RegisterCommand('codigo', function(src, args)
    local player = ESX.GetPlayerFromId(src)
    if (args[1]) then
        local discord
        for i,v in pairs(GetPlayerIdentifiers(src)) do
            if (string.find(v, "discord:")) then
                discord = v
                break
            end
        end
        discord = string.gsub(discord, "discord:", "")

        local query = MySQL.query.await('SELECT * FROM bm_mafias')

        for i,v in pairs(query) do
            local codes = json.decode(v.codes)

            if (codes[args[1]] and codes[args[1]] == discord) then
                local mafia = getMafiaByName(v.name)

                if (mafia) then
                    for k,val in pairs(mafias) do
                        local member = val.getPlayerByIdentifier(player.identifier)
                        if (member) then
                            val.removeMember(player.identifier)
                            break
                        end
                    end
                    mafia.addMember(player.identifier, 0, GetPlayerName(player.source))
                    local member = mafia.getPlayerByIdentifier(player.identifier)
                    if (member) then
                        TriggerClientEvent('bm_mafias:setPlayerData', player.source, {
                            id = mafia.id,
                            playerRank = member.rank,
                            vehicleList = mafia.getMetadata().vehicleList,
                            points = {
                                garage = mafia.getMetadata().garage or {},
                                revive = mafia.getMetadata().revive or {},
                                shopmafia = mafia.getMetadata().shopmafia or {},
                                wardobe = mafia.getMetadata().wardobe or {},
                                inventory = mafia.getMetadata().inventory or {},
                                accesories = mafia.getMetadata().accesories or {},
                                shop = mafia.getMetadata().shop or {}
                            },
                            vehicleColor = mafia.getMetadata().vehicleColor,
                            members = mafia.getMetadata().members,
                            wardobeList = mafia.getMetadata().clothes,
                            level = mafia.level,
                            name = mafia.name
                        })
                    end
                    player.showNotification("Has entrado en una mafia!")
                end
                break
            end
        end
    else
        player.showNotification("Debes ingresar un codigo.", "error")
    end
end)

-- @events
RegisterNetEvent('bm_mafia:giveInfo', function(playerInfo, playerId)
    TriggerClientEvent('chat:addMessage', playerId, {
        template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Mafia</span>&nbspEste usuario pertenece a la mafia: <span class="badge badge-staff">{0}</span>',
        args = {(playerInfo.name and playerInfo.name or "No pertenece a una mafia.")}
    })
end)

RegisterNetEvent('bm_mafias:create', function(cache)
    MySQL.insert('INSERT INTO bm_mafias (name, metadata, level) VALUES (?, ?, ?)', {
        cache.name,
        json.encode(cache.metadata),
        tostring(cache.level)
    })
    local query = MySQL.query.await('SELECT id FROM bm_mafias WHERE name = ?', {cache.name})
    mafias[cache.name] = createMafia(cache.name, cache.metadata, cache.level, query[1].id)
    exports.ox_inventory:RegisterStash(cache.name, "Inventario ("..cache.name..")", 400, 3000000000, cache.name)
end)

RegisterNetEvent('bm_mafias:buy', function(item, price)
    local player = ESX.GetPlayerFromId(source)

    if (player.getAccount('bank').money >= price) then
        player.addInventoryItem(item, 1)
        player.removeAccountMoney('bank', price)
    else
        player.showNotification("No tienes suficiente dinero.", "error")
    end
end)

AddEventHandler('onResourceStart', function(res)
    if (GetCurrentResourceName() == res) then
        MySQL.query('SELECT * FROM bm_mafias', {}, function(result)
            local count = 0
            for i,v in pairs(result) do
                count = count + 1
                mafias[v.name] = createMafia(v.name, json.decode(v.metadata), v.level, v.id)
                exports.ox_inventory:RegisterStash(v.name, "Inventario ("..v.name..")", 400, 3000000000, v.name)
            end
            print("[INFO] [MAFIAS] "..count.." mafias cargadas.")
        end)
    end
end)

RegisterNetEvent('bm_mafias:createClothes', function(mafiaName, name, skin)
    local mafia = getMafiaByName(mafiaName)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)
        local member = mafia.getPlayerByIdentifier(player.identifier)
        if (member) then
            mafia.addWardobeClothes(name, skin)
        end
    end
end)

RegisterNetEvent('bm_mafias:deleteClothes', function(name)
    local mafia = getMafiaByName(mafiaName)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)
        local member = mafia.getPlayerByIdentifier(player.identifier)
        if (member) then
            mafia.removeWardobeClothes(name)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded', function(playerId)
    local player = ESX.GetPlayerFromId(playerId)
    for i,v in pairs(mafias) do
        local member = v.getPlayerByIdentifier(player.identifier)
        if (member) then
            TriggerClientEvent('bm_mafias:setPlayerData', player.source, {
                id = v.id,
                playerRank = member.rank,
                vehicleList = v.metadata.vehicleList or {},
                points = {
                    garage = v.metadata.garage or {},
                    revive = v.metadata.revive or {},
                    shopmafia = v.metadata.shopmafia or {},
                    wardobe = v.metadata.wardobe or {},
                    inventory = v.metadata.inventory or {},
                    accesories = v.metadata.accesories or {},
                    shop = v.metadata.shop or {}
                },
                vehicleColor = v.metadata.vehicleColor,
                wardobeList = v.metadata.clothes or {},
                level = v.level,
                name = v.name
            })
            break
        end
    end
end)

RegisterNetEvent('bm_mafias:requestHandcuff', function(playerId, name)
    local mafia = getMafiaByName(name)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)

        if (mafia.getPlayerByIdentifier(player.identifier)) then
            TriggerClientEvent('bm_mafias:playerHandcuff', playerId)

            TriggerClientEvent('bm_mafias:arrested', playerId, source)
            TriggerClientEvent('bm_mafias:arrest', source)
        end
    end
end)

RegisterNetEvent('bm_mafias:requestJoinVeh', function(playerId, name)
    local mafia = getMafiaByName(name)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)

        if (mafia.getPlayerByIdentifier(player.identifier)) then
            TriggerClientEvent('bm_mafias:out.inVehicle', playerId)
        end
    end
end)

RegisterNetEvent('bm_mafias:requestDrag', function(playerId, name)
    local mafia = getMafiaByName(name)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)

        if (mafia.getPlayerByIdentifier(player.identifier)) then
            TriggerClientEvent('bm_mafias:dragPlayer', playerId, source)
        end
    end
end)

RegisterNetEvent('bm_mafias:requestCacheo', function(playerId, name)
    local mafia = getMafiaByName(name)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)

        if (mafia.getPlayerByIdentifier(player.identifier)) then
            exports.ox_inventory:openInventory(GetPlayerServerId(NetworkGetEntityOwner(entity.target)), 'player')
        end
    end
end)

RegisterNetEvent('bm_mafias:addMember', function(mafiaName, playerId)
    local mafia = getMafiaByName(mafiaName)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)

        local member = mafia.getPlayerByIdentifier(player.identifier)
        if (member and member.rank == 1) then
            invitations[playerId] = true
            print(playerId, "invited")
            TriggerClientEvent("bm_mafias:inviteMafia", playerId, mafiaName)
        end
    end
end)

RegisterNetEvent('bm_mafias:removeMember', function(name, identifier)
    local mafia = getMafiaByName(name)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)
        local member = mafia.getPlayerByIdentifier(player.identifier)

        if (member and member.rank == 1) then
            local targetMember = mafia.getPlayerByIdentifier(identifier)
            local target = ESX.GetPlayerFromIdentifier(identifier)
            mafia.removeMember(identifier)

            TriggerClientEvent('chat:addMessage', source, {
                template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Mafia</span>&nbspHas expulsado a: <span class="badge badge-staff">{0}</span>',
                args = {targetMember.name}
            })
    
            if (target) then
                TriggerClientEvent('bm_mafias:setPlayerData', target.source, {})

                TriggerClientEvent('chat:addMessage', target.source, {
                    template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Mafia</span>&nbspFuiste expulsado de la mafia',
                    args = {mafia.name}
                })
            end
        end
    end
end)

RegisterNetEvent('bm_mafias:washMoney', function()
    local player = ESX.GetPlayerFromId(source)

    local blackMoney = player.getAccount('black_money').money

    if (blackMoney > 0) then
        player.removeAccountMoney('black_money', blackMoney)
        player.addMoney(blackMoney*0.8)
        TriggerClientEvent('chat:addMessage', player.source, {
            template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Mafia</span>&nbsp&nbspTenías <span class="badge-staff-wb">{0}$</span> de dinero negro, y te he dado <span class="badge-highstaff-wb">{1}$</span>, me quede el 20%',
            args = {blackMoney, math.floor(blackMoney*0.8)}
        })
    else
        TriggerClientEvent('chat:addMessage', player.source, {
            template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Mafia</span>&nbsp&nbsp<span class="badge-staff-wb">{0}</span>',
            args = {"No tienes dinero negro."}
        })
    end
end)

RegisterNetEvent('bm_mafias:buyBproof', function(quantity)
    local player = ESX.GetPlayerFromId(source)
    local result = MySQL.query.await('SELECT * FROM mafias_stock')

    if (result[1] and result[1].bproof > 0 and result[1].bproof >= quantity) then
        local blackMoney = player.getAccount('black_money').money
        if (blackMoney >= (50000*quantity)) then
            player.removeAccountMoney('black_money', 50000*quantity)
            player.addInventoryItem("armour", quantity)
            MySQL.update('UPDATE mafias_stock SET bproof = bproof -  1')
        else
            player.showNotification("No tienes suficiente dinero.")
        end
    else
        player.showNotification("No queda stock.")
    end
end)

RegisterNetEvent('bm_mafias:buyBullets', function(quantity)
    local player = ESX.GetPlayerFromId(source)
    local result = MySQL.query.await('SELECT * FROM mafias_stock')

    if (result[1] and result[1].smgbullets > 0 and result[1].smgbullets >= quantity) then
        local blackMoney = player.getAccount('black_money').money
        if (blackMoney >= (100*quantity)) then
            player.removeAccountMoney('black_money', 100*quantity)
            player.addInventoryItem("ammo-9", quantity)
            MySQL.update('UPDATE mafias_stock SET smgbullets = smgbullets -  1')
        else
            player.showNotification("No tienes suficiente dinero.")
        end
    else
        player.showNotification("No queda stock.")
    end
end)

RegisterNetEvent('bm_mafias:buyammo45', function(quantity)
    local player = ESX.GetPlayerFromId(source)
    local result = MySQL.query.await('SELECT * FROM mafias_stock')

    if (result[1] and result[1].smgbullets > 0 and result[1].smgbullets >= quantity) then
        local blackMoney = player.getAccount('black_money').money
        if (blackMoney >= (150*quantity)) then
            player.removeAccountMoney('black_money', 150*quantity)
            player.addInventoryItem("ammo-45", quantity)
            MySQL.update('UPDATE mafias_stock SET smgbullets = smgbullets -  1')
        else
            player.showNotification("No tienes suficiente dinero.")
        end
    else
        player.showNotification("No queda stock.")
    end
end)

RegisterNetEvent('bm_mafias:buyWeapon', function(weapon, price, vtable, quant)
    local player = ESX.GetPlayerFromId(source)

    local result = MySQL.query.await('SELECT '..vtable..' FROM mafias_stock')

    if (vtable == 'smg') then
        if (result[1] and result[1].smg <= 0) then
            return player.showNotification("No queda stock.")
        end
    end
    if (vtable == 'ak') then
        if (result[1] and result[1].ak <= 0) then
            return player.showNotification("No queda stock.")
        end
    end
    if (vtable == 'smg_assault') then
        if (result[1] and result[1].smg_assault <= 0) then
            return player.showNotification("No queda stock.")
        end
    end
    if (vtable == 'revolver') then
        if (result[1] and result[1].revolver <= 0) then
            return player.showNotification("No queda stock.")
        end
    end
    if (vtable == 'carabina') then
        if (result[1] and result[1].carabina <= 0) then
            return player.showNotification("No queda stock.")
        end
    end
    if (vtable == 'microsmg') then
        if (result[1] and result[1].microsmg <= 0) then
            return player.showNotification("No queda stock.")
        end
    end

    local blackMoney = player.getAccount('black_money').money
    if (blackMoney >= price) then
        player.removeAccountMoney('black_money', price)
        player.addInventoryItem(weapon, (quant and quant or 1))
        MySQL.update('UPDATE mafias_stock SET '..vtable..' = '..vtable..' -  1')
    else
        player.showNotification("No tienes suficiente dinero.")
    end
end)

RegisterNetEvent('bm_mafia:addToMafia', function(mafiaName)
    local mafia = getMafiaByName(mafiaName)

    if (mafia) then
        local player = ESX.GetPlayerFromId(source)
        if (invitations[source]) then
            invitations[source] = nil
            for i,v in pairs(mafias) do
                local member = v.getPlayerByIdentifier(player.identifier)
                if (member) then
                    v.removeMember(player.identifier)
                    break
                end
            end
            mafia.addMember(player.identifier, 0, GetPlayerName(player.source))
            local player = ESX.GetPlayerFromId(source)
            for i,v in pairs(mafias) do
                local member = v.getPlayerByIdentifier(player.identifier)
                if (member) then
                    TriggerClientEvent('bm_mafias:setPlayerData', player.source, {
                        id = v.id,
                        playerRank = member.rank,
                        vehicleList = v.metadata.vehicleList,
                        points = {
                            garage = v.metadata.garage or {},
                            revive = v.metadata.revive or {},
                            shopmafia = v.metadata.shopmafia or {},
                            wardobe = v.metadata.wardobe or {},
                            inventory = v.metadata.inventory or {},
                            accesories = v.metadata.accesories or {},
                            shop = v.metadata.shop or {}
                        },
                        vehicleColor = v.metadata.vehicleColor,
                        members = v.metadata.members,
                        wardobeList = v.metadata.clothes,
                        level = v.level,
                        name = v.name
                    })
                    break
                end
            end
            player.showNotification("Has aceptado la solicitud a la mafia/banda.")
        else
            player.showNotification("No has sido invitado a esta mafia, o la invitación a expirado.")
        end
    end
end)

RegisterNetEvent('bm_mafias:requestSync', function()
    local source = source
    Wait(1000)
    local player = ESX.GetPlayerFromId(source)
    for i,v in pairs(mafias) do
        local member = v.getPlayerByIdentifier(player.identifier)
        if (member) then
            TriggerClientEvent('bm_mafias:setPlayerData', player.source, {
                id = v.id,
                playerRank = member.rank,
                vehicleList = v.metadata.vehicleList,
                points = {
                    garage = v.metadata.garage or {},
                    revive = v.metadata.revive or {},
                    shopmafia = v.metadata.shopmafia or {},
                    wardobe = v.metadata.wardobe or {},
                    inventory = v.metadata.inventory or {},
                    accesories = v.metadata.accesories or {},
                    shop = v.metadata.shop or {}
                },
                vehicleColor = v.metadata.vehicleColor,
                members = v.metadata.members,
                wardobeList = v.metadata.clothes,
                level = v.level,
                name = v.name
            })
            break
        end
    end
end)

-- @commands
RegisterCommand('syncMafias', function(src)
    local player = ESX.GetPlayerFromId(src)
    for i,v in pairs(mafias) do
        local member = v.getPlayerByIdentifier(player.identifier)
        if (member) then
            TriggerClientEvent('bm_mafias:setPlayerData', player.source, {
                id = v.id,
                playerRank = member.rank,
                vehicleList = v.metadata.vehicleList,
                points = {
                    garage = v.metadata.garage or {},
                    revive = v.metadata.revive or {},
                    shopmafia = v.metadata.shopmafia or {},
                    wardobe = v.metadata.wardobe or {},
                    inventory = v.metadata.inventory or {},
                    accesories = v.metadata.accesories or {},
                    shop = v.metadata.shop or {}
                },
                vehicleColor = v.metadata.vehicleColor,
                members = v.metadata.members,
                wardobeList = v.metadata.clothes,
                level = v.level,
                name = v.name
            })
            break
        end
    end
end)

RegisterCommand('setmafia', function(src, args)
    if (args[1] and args[2] and args[3]) then
        local player = ESX.GetPlayerFromId(tonumber(args[1]))
        if (args[2] == "rem") then
            for i,v in pairs(mafias) do
                local member = v.getPlayerByIdentifier(player.identifier)
                if (member) then
                    v.removeMember(player.identifier)
                    TriggerClientEvent('bm_mafias:setPlayerData', player.source, {})
                    break
                end
            end
            return ESX.GetPlayerFromId(src).showNotification("Le has quitado el rango de mafia a este usuario.")
        end

        local mafia = getMafiaByName(args[2])

        if (mafia) then
            if (player) then
                for i,v in pairs(mafias) do
                    local member = v.getPlayerByIdentifier(player.identifier)
                    if (member) then
                        v.removeMember(player.identifier)
                        break
                    end
                end
                mafia.addMember(player.identifier, tonumber(args[3]), GetPlayerName(player.source))
                TriggerClientEvent('bm_mafias:setPlayerData', player.source, {
                    id = mafia.id,
                    playerRank = tonumber(args[3]),
                    vehicleList = mafia.metadata.vehicleList,
                    points = {
                        garage = mafia.metadata.garage or {},
                        revive = mafia.metadata.revive or {},
                        shopmafia = mafia.metadata.shopmafia or {},
                        wardobe = mafia.metadata.wardobe or {},
                        inventory = mafia.metadata.inventory or {},
                        accesories = mafia.metadata.accesories or {},
                        shop = mafia.metadata.shop or {}
                    },
                    vehicleColor = mafia.metadata.vehicleColor,
                    members = mafia.metadata.members,
                    wardobeList = mafia.metadata.clothes,
                    level = mafia.level,
                    name = mafia.name
                })
            end
        end
    end
end)

-- @callbacks
ESX.RegisterServerCallback('bm_mafias:isAdmin', function(playerId, callback)
    if (isAdmin(playerId)) then
        callback(true)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback('bm_mafias:getAll', function(playerId, callback)
    callback(mafias)
end)

ESX.RegisterServerCallback('bm_mafias:getWeaponsInStock', function(playerId, callback)
    MySQL.query('SELECT * FROM mafias_stock', {}, function(result)
        if (result[1]) then
            callback({
                smg = result[1].smg,
                ak = result[1].ak,
                smg_assault = result[1].smg_assault,
                revolver = result[1].revolver,
                carabina = result[1].carabina,
                microsmg = result[1].microsmg,
                bproof = result[1].bproof,
                suppressor = result[1].suppressor,
                smgbullets = result[1].smgbullets,
                pistolbullets = result[1].pistolbullets
            })
        else
            callback({})
        end
    end)
end)

function createMafia(name, metadata, level, id)
    local self = {}

    self.id = id
    self.name = name
    self.metadata = metadata or {}  -- Manejar el caso en que metadata sea nulo
    self.metadata.members = self.metadata.members or {}
    self.metadata.clothes = self.metadata.clothes or {}
    self.metadata.vehicleColor = self.metadata.vehicleColor or {
        primaryColor = {r = 0, g = 0, b = 0},
        secondaryColor = {r = 0, g = 0, b = 0}
    }
    self.level = level

    -- Inicializar los puntos que no existen
    self.metadata.garage = self.metadata.garage or {}
    self.metadata.revive = self.metadata.revive or {}
    self.metadata.shopmafia = self.metadata.shopmafia or {}
    self.metadata.wardobe = self.metadata.wardobe or {}
    self.metadata.inventory = self.metadata.inventory or {}
    self.metadata.accesories = self.metadata.accesories or {}
    self.metadata.shop = self.metadata.shop or {}



    function self.getMetadata()
        return self.metadata
    end

    function self.changeColor(set, rgb)
        if (self.metadata.vehicleColor[set]) then
            self.metadata.vehicleColor[set] = rgb
            self.save()
            self.syncMembers()
            return true
        end
        return false
    end

    function self.addMember(identifier, rank, name)
        self.metadata.members[identifier] = {rank = rank, name = name}
        self.save()
        self.syncMembers()
    end

    function self.removeMember(identifier)
        if (self.metadata.members[identifier]) then
            self.metadata.members[identifier] = nil
            self.save()
            self.syncMembers()
            return true
        end
        return false
    end

    function self.getPlayerByIdentifier(identifier)
        if (self.metadata.members[identifier]) then
            return self.metadata.members[identifier]
        end

        return nil
    end

    function self.addWardobeClothes(name, skin)
        self.metadata.clothes[name] = skin
        self.save()
        self.syncMembers()
    end

    function self.removeWardobeClothes(name)
        if (self.metadata.clothes[name]) then
            self.metadata.clothes[name] = nil
            self.save()
            self.syncMembers()
        end
    end

    function self.save()
        MySQL.update('UPDATE bm_mafias SET metadata = ? WHERE name = ?', {
            json.encode(self.metadata),
            self.name
        })
        return true
    end

    function self.syncMembers()
        TriggerClientEvent('bm_mafias:setPlayerData', -1, {
            id = self.id,
            vehicleList = self.metadata.vehicleList,
            points = {
                garage = self.metadata.garage or {},
                revive = self.metadata.revive or {},
                shopmafia = self.metadata.shopmafia or {},
                wardobe = self.metadata.wardobe or {},
                inventory = self.metadata.inventory or {},
                accesories = self.metadata.accesories or {},
                shop = self.metadata.shop or {}
            },
            vehicleColor = self.metadata.vehicleColor,
            members = self.metadata.members,
            wardobeList = self.metadata.clothes,
            level = self.level,
            name = self.name
        }, self.name)
    end

    self.save()

    return self
end

function isAdmin(playerId)
  local player = ESX.GetPlayerFromId(playerId)
    local bmLib = exports['bm_lib']:initLib()

    if (bmLib.hasRank(playerId, 1)) then
        return true
    end
    return false
end


function getMafiaByName(name)
    if (mafias[name]) then
        return mafias[name]
    end
    return nil
end



function isPlayerInMafia(playerId)
    local player = ESX.GetPlayerFromId(playerId)

    local inMafia = false
    
    for i,v in pairs(mafias) do
        if (v.getPlayerByIdentifier(player.identifier)) then
            inMafia = true
            break
        end
    end

    return inMafia
end
exports("isPlayerInMafia", isPlayerInMafia)

CreateThread(function()
    while true do
        invitations = {}
        Wait(10000)
    end
end)


RegisterNetEvent("bm_mafias:doctor:heal", function(typeOf)
    local player = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetExtendedPlayers()

    if (typeOf == "heal") then
        if (player.getAccount('bank').money >= 0) then
            player.removeAccountMoney('bank', 0)
            player.showNotification("Te has curado gratuitamente por ser mafioso.")
            TriggerClientEvent('bm_mega:doctor:heal', source)
        else
            player.showNotification("No tienes suficiente dinero", "error")
        end
    else
        if (player.getAccount('bank').money >= 0) then
            player.removeAccountMoney('bank', 0)
            player.showNotification("Has sido revivido gratuitamente por ser mafioso.")
            TriggerClientEvent('esx_ambulancejob:revive', source)
        else
            player.showNotification("No tienes suficiente dinero", "error")
        end
    end
end)


