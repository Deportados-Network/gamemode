ESX = nil
local banned = {}

function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('vender:cochesbanned', function(source, cb)
    cb(banned)
end)

function coche(vendedor, comprador, matr, price, name)
    local xPlayervend = ESX.GetPlayerFromId(vendedor)
    local xPlayercomp = ESX.GetPlayerFromId(comprador)
    local ownerId = GetPlayerIdentifiers(comprador)[1]
    local ownerAntiguoId = GetPlayerIdentifiers(vendedor)[1]

    MySQL.Async.execute(
        'UPDATE `owned_vehicles` SET `owner` = @owner WHERE `owner` = @ownerantiguo AND `vehicle` LIKE "%" .. @matr .. "%"',
        {
            ['@owner'] = ownerId,
            ['@ownerantiguo'] = ownerAntiguoId,
            ['@matr'] = trim(matr)
        },
        function(rowsChanged)
            if rowsChanged > 0 then
                registerDB(ownerAntiguoId, ownerId, matr, price, name)
                TriggerClientEvent('chat:addMessage', comprador, { args = { "^1Vendedor", playerName .. " te ha vendido un coche. ¡Ahora te pertenece!" }, color = { 255, 0, 0 } })
                TriggerClientEvent('chat:addMessage', vendedor, { args = { "^1Vendedor", "Has vendido el coche correctamente." }, color = { 255, 0, 0 } })
                xPlayercomp.removeMoney(price)
                xPlayervend.addMoney(price)
            else
                TriggerClientEvent('chat:addMessage', vendedor, { args = { "^1Vendedor", "No tienes ningún vehículo con esa matrícula para vender." }, color = { 255, 0, 0 } })
            end
        end
    )
end

RegisterServerEvent('vender:esmicoche')
AddEventHandler('vender:esmicoche', function(matr, id, price, car, name)
    local source = source
    local var = false
    local ident = GetPlayerIdentifiers(source)[1]

    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier", { ['@identifier'] = ident }, function(data)
        if data[1] then
            for i = 1, #data, 1 do
                local vehicle = json.decode(data[i].vehicle)
                if trim(tostring(vehicle.plate)) == trim(tostring(matr)) then
                    var = true
                    break
                end
            end
        end
        TriggerClientEvent('vender:esmicochecallback', source, var, id, price, matr, car, name)
    end)
end)

RegisterServerEvent('vender:vendococheser')
AddEventHandler('vender:vendococheser', function(id, precio, matr, car, name)
    TriggerClientEvent('vender:vendocoche', id, precio, source, matr, car, name)
end)

function registerDB(vendedor, comprador, matr, price, name)
    local hour = os.time()
    local tiempo = os.date('%c', hour)

    MySQL.Async.execute("INSERT INTO dk_vender (`seller`, `buyer`, `car`, `hour`, `price`, `name`) VALUES (@vendedor, @comprador, @matr, @hour, @price, @name)",
        {
            ['@vendedor'] = vendedor,
            ['@comprador'] = comprador,
            ['@matr'] = matr,
            ['@hour'] = tiempo,
            ['@price'] = price,
            ['@name'] = name
        }
    )
end

RegisterServerEvent('vender:handleroferta')
AddEventHandler('vender:handleroferta', function(var, vendedor, matr, price, name)
    if var then
        local xPlayer = ESX.GetPlayerFromId(source)
        if price <= xPlayer.getMoney() then
            TriggerClientEvent('chat:addMessage', vendedor, { args = { "^1Vendedor", "¡Han aceptado tu oferta!" }, color = { 255, 0, 0 } })
            TriggerClientEvent('chat:addMessage', source, { args = { "^1Vendedor", "Has aceptado la oferta." }, color = { 255, 0, 0 } })
            coche(vendedor, source, matr, price, name)
        else
            TriggerClientEvent('chat:addMessage', vendedor, { args = { "^1Vendedor", "No tienes suficiente dinero." }, color = { 255, 0, 0 } })
            TriggerClientEvent('chat:addMessage', source, { args = { "^1Vendedor", "No tienes suficiente dinero." }, color = { 255, 0, 0 } })
        end
    else
        TriggerClientEvent('chat:addMessage', vendedor, { args = { "^1Vendedor", "Han rechazado tu oferta." }, color = { 255, 0, 0 } })
        TriggerClientEvent('chat:addMessage', source, { args = { "^1Vendedor", "Has rechazado la oferta." }, color = { 255, 0, 0 } })
    end
end)

RegisterCommand('vendercoche', function(source, args, user)
    local source = source
    if #args == 1 then
        TriggerClientEvent('chat:addMessage', source, { args = { "^1Vendedor", "Debes especificar un precio." }, color = { 255, 0, 0 } })
    else
        if GetPlayerName(tostring(args[1])) then
            local id1 = tonumber(args[1])
            local precio = tonumber(args[2])
            if precio <= 5000 then
                TriggerClientEvent('chat:addMessage', source, { args = { "^1Vendedor", "El precio no es válido. Debe ser mayor a 5000." }, color = { 255, 0, 0 } })
                return
            end
            TriggerClientEvent("vender:compruebocoche", source, id1, precio)
        else
            TriggerClientEvent('chat:addMessage', source, { args = { "^1Vendedor", "La ID es incorrecta." }, color = { 255, 0, 0 } })
        end
    end
end)