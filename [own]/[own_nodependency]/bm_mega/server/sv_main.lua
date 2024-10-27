-- @vars
ESX = exports['es_extended']:getSharedObject()

-- @callbacks
ESX.RegisterServerCallback('bm_mega:rent:bike', function(playerId, callback, price)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if (xPlayer.getAccount("bank").money >= price) then
        xPlayer.removeAccountMoney("bank", price)
        callback(true)
    else
        callback(false, "No tienes suficiente dinero")
    end
end)

AddEventHandler('onResourceStart', function(res)
    if (res == GetCurrentResourceName()) then
        local xPlayers = ESX.GetExtendedPlayers()
        GlobalState.players = #xPlayers
    end
end)


function syncPlayers()
    SetTimeout(20000, function()
        local xPlayers = ESX.GetExtendedPlayers()
        GlobalState.players = #xPlayers
        syncPlayers()
    end)
end
syncPlayers()

ESX.RegisterServerCallback('bm_mega:isStaff', function(playerId, callback)
    local lib = exports['bm_lib']:initLib()

    callback(lib.hasRank(playerId, 1))
end)

ESX.RegisterServerCallback('bm_mega:hasMoney', function(playerId, callback, price)
    local player = ESX.GetPlayerFromId(playerId)

    if (player.getAccount("bank").money >= price) then
        player.removeAccountMoney("bank", price)
        callback(true)
    else
        callback(false)
    end
end)

ESX.RegisterUsableItem('fixkit', function(playerId)
    TriggerClientEvent('bm_mega:fixVehicle', playerId)
end)

ESX.RegisterServerCallback('bm_mega:doctorInService', function(playerId, callback)
    local xPlayers = ESX.GetExtendedPlayers()
    local medicosEnServicio = 0

    for i=1, #xPlayers do
        local player = xPlayers[i]
        if player.job.name == 'ambulance' then
            medicosEnServicio = medicosEnServicio + 1
        end
    end

    callback({name = GetPlayerName(playerId), medicos = medicosEnServicio})
end)

ESX.RegisterServerCallback('bm_mega:initialveh:claim', function(playerId, callback)
    local player = ESX.GetPlayerFromId(playerId)
    MySQL.query('SELECT initial_pack FROM users WHERE identifier = ?', {
        player.identifier
    }, function(result)
        if result[1].initial_pack == 1 then
            MySQL.query.await('UPDATE users SET initial_pack = 0 WHERE identifier = ?', {
                player.identifier
            })
            callback(true)
        else
            callback(false)
        end
    end)
end)

exports['bm_security']:register('bm_mega:initialveh:claim', function(playerId, plate, properties, model)
    local player = ESX.GetPlayerFromId(playerId)
    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {
        player.identifier,
        plate,
        json.encode(properties)
    })
end)

RegisterNetEvent("bm_mega:doctor:heal", function(typeOf)
    local player = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetExtendedPlayers()
  --  local medicosEnServicio = 0

   -- for i=1, #xPlayers do
     --   local player = xPlayers[i]
     --   if player.job.name == 'ambulance' then
     --      medicosEnServicio = medicosEnServicio + 1
     --   end
    --end

    --if medicosEnServicio >= 1 then
    --    player.showNotification("No puedes curarte, hay medicos en servicio", "error")
      --  return 
    --end
    if (typeOf == "heal") then
        if (player.getAccount('bank').money >= 15000) then
            player.removeAccountMoney('bank', 15000)
            player.showNotification("Te has curado por 15000$")
            TriggerClientEvent('bm_mega:doctor:heal', source)
        else
            player.showNotification("No tienes suficiente dinero", "error")
        end
    else
        if (player.getAccount('bank').money >= 25000) then
            player.removeAccountMoney('bank', 25000)
            player.showNotification("Te has curado por 25000$")
            TriggerClientEvent('esx_ambulancejob:revive', source)
        else
            player.showNotification("No tienes suficiente dinero", "error")
        end
    end
end)
RegisterNetEvent('bm_mega:removeItem', function(item)
    local player = ESX.GetPlayerFromId(source)

    player.removeInventoryItem(item, 1)
end)

RegisterNetEvent("bm_mega:doctor:buy", function(item)
    if (item == "bandage") then
        local player = ESX.GetPlayerFromId(source)

        if (player.getAccount('bank').money >= 300) then
            player.removeAccountMoney('bank', 300)
            player.addInventoryItem('bandage', 1)
            player.showNotification("Has comprado una venda por 300$")
        else
            player.showNotification("No tienes suficiente dinero", "error")
        end
    end
end)

RegisterNetEvent('bm_mega:joblisting:apply', function(job)
    local allowedJobs = {
        ['delivery'] = "Repartidor",
        ['unemployed'] = "Desempleado",
        ["courier"] = "Cartero",
        ["farmer"] = "Agricultor"
    }

    local player = ESX.GetPlayerFromId(source)

    if (not allowedJobs[job]) then
        player.showNotification("Este trabajo no existe", "error")
        return print(("El jugador %s intento ponerse el trabajo %s"):format(GetPlayerName(source), job))
    end

    TriggerClientEvent('chat:addMessage', source, {
        template = '<span class="badge badge-solid-purple"><i class="fas fa-exclamation-circle"></i> {0}</span> {1} <span class="badge badge-highstaff">{2}</span>',
        args = {"Oficina de empleo", ("Has obtenido un nuevo trabajo"), allowedJobs[job]}
    })

    player.setJob(job, 0)
end)

function deleteVehiclesAfter30mins()
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-staff">{0}</span>&nbsp {1}',
        args = {"SISTEMA", "Todos los vehículos desocupados serán eliminados en 30 minutos."}
    })
    
    Wait(15 * 60000)  -- 15 minutos restantes
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-staff">{0}</span>&nbsp {1}',
        args = {"SISTEMA", "Todos los vehículos desocupados serán eliminados en 15 minutos."}
    })
    
    Wait(10 * 60000)  -- 5 minutos restantes
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-staff">{0}</span>&nbsp {1}',
        args = {"SISTEMA", "Todos los vehículos desocupados serán eliminados en 10 minutos."}
    })
    
    Wait(5 * 60000)  -- 1 minuto restante
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-staff">{0}</span>&nbsp {1}',
        args = {"SISTEMA", "Todos los vehículos desocupados serán eliminados en 5 minutos."}
    })
    
    Wait(4 * 60000)  -- 1 minuto restante
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-staff">{0}</span>&nbsp {1}',
        args = {"SISTEMA", "Todos los vehículos desocupados serán eliminados en 1 minuto."}
    })

    Wait(60000)  -- 30 segundos restantes
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-staff">{0}</span>&nbsp {1}',
        args = {"SISTEMA", "Todos los vehículos desocupados serán eliminados en 30 segundos."}
    })

    Wait(30000)  -- 0 segundos restantes
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-staff">{0}</span>&nbsp {1}',
        args = {"SISTEMA", "Todos los vehículos desocupados han sido eliminados."}
    })

    TriggerClientEvent('bm_mega:deleteVehicles', -1)
end


AddEventHandler('playerConnecting', function(name, kick, deferrals)
    local player = source
    local steamId, discord, xbox, live, ip, license = "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"
    deferrals.defer()

    Wait(0)
    
    for i,v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamId = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbox = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            live = v
        end
    end

    sendToDiscord("Nueva conexión", ("Nombre: %s\nSteam: %s\nXbox: %s\nIP: %s\nDiscord: %s\nLicense: %s\nLive: %s"):format(name, steamId, xbox, ip, discord, license, live), "Conexión entrante", config.connect, 5763719)

    Wait(0)

    deferrals.done()
end)

AddEventHandler('playerDropped', function()
    local player = source

    local steamId, discord, xbox, live, ip, license = "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"

    for i,v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamId = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbox = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            live = v
        end
    end

    sendToDiscord("Desconexión", ("Nombre: %s\nSteam: %s\nXbox: %s\nIP: %s\nDiscord: %s\nLicense: %s\nLive: %s"):format(GetPlayerName(player), steamId, xbox, ip, discord, license, live), "Desconexión", config.connect, 15548997)
end)

RegisterServerEvent('baseevents:onPlayerKilled', function(killerID, deathData)
    local victimId = source

    local killer = ESX.GetPlayerFromId(killerID)

    if victimId ~= killerID then
        local steamId, discord, xbox, live, ip, license = "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"
        local steamId2, discord2, xbox2, live2, ip2, license2 = "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"

        for i,v in pairs(GetPlayerIdentifiers(victimId)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamId = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xbox = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                live = v
            end
        end

        for i,v in pairs(GetPlayerIdentifiers(killerID)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamId2 = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xbox2 = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip2 = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord2 = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license2 = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                live2 = v
            end
        end

        sendToDiscord("Muerte", ("%s a matado a %s\n\n**Asesino**\n```ID: %s\nSteam: %s\nXbox: %s\nIP: %s\nDiscord: %s\nLicense: %s\nLive: %s\n\n**Victima**```\nID: %s\nSteam: %s\nXbox: %s\nIP: %s\nDiscord: %s\nLicense: %s\nLive: %s```"):format(GetPlayerName(killerID), GetPlayerName(victimId), killerID, steamId2, xbox2, ip2, discord2, license2, live2, victimId, steamId, xbox, ip, disocrd, license, live), "Log de Muerte", config.deaths, 9936031)
    end
end)

AddEventHandler('chatMessage', function(playerId, playerName, message)
	CancelEvent()

    sendToDiscord("CHAT", ("Jugador: %s [%s]\nComando: %s"):format(playerName, playerId, message), "Log de Chat", config.chat, 9936031)
end)

function sendToDiscord(name, message, username, webhook, color)
	local embed = {
		{
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message
		}
	}
  
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = username, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

 CreateThread(function()
    deleteVehiclesAfter20mins()
 end)



------------- SANTI NO CERRAR

 local accesorios = {
    "Gorro",    -- Puedes agregar más accesorios según sea necesario
    "Anteojos",
    -- Agrega otros accesorios aquí
}

AddEventHandler("playerSpawned", function()
    local player = source

    for _, accesorio in ipairs(accesorios) do
        TriggerClientEvent("syncAccesorio", player, accesorio)
    end
end)

RegisterServerEvent("syncAccesorio")
AddEventHandler("syncAccesorio", function(accesorio)
    local player = source

    TriggerClientEvent("syncAccesorio", player, accesorio)
end)
