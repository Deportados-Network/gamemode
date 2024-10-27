-- @vars
ESX = exports['es_extended']:getSharedObject()
local lib = exports['bm_lib']:initLib()
local askId = {}
local blacklistedWords = {
}

-- @vars
local cooldowns = {}  -- Almacena las marcas de tiempo de los últimos comandos ejecutados
local cooldownTime = 6  -- Tiempo de cooldown en segundos

-- @commands
RegisterCommand("twt", function(playerId, args)
    local player = ESX.GetPlayerFromId(playerId)

    local isDead = MySQL.query.await('SELECT is_dead FROM users WHERE identifier = ?', {player.identifier})

    if (isDead[1].is_dead) then
        return TriggerClientEvent('chat:addMessage', playerId, {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "No puedes usar este comando estando muerto."}
        })
    end
    -- Verifica si ha pasado suficiente tiempo desde el último uso del comando
    local currentTime = os.time()

    if cooldowns[playerId] and (currentTime - cooldowns[playerId]) < cooldownTime then
        local remainingTime = cooldownTime - (currentTime - cooldowns[playerId])
        return TriggerClientEvent('chat:addMessage', playerId, {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "Debes esperar ^9" .. remainingTime .. " segundos ^7antes de usar este comando nuevamente."}
        })
    end

    if (not args[1]) then
        return TriggerClientEvent('chat:addMessage', playerId, {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "No puedes dejar el tweet vacío."}
        })
    end

    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    -- El comando se ejecutó con éxito, actualiza la marca de tiempo
    cooldowns[playerId] = os.time()

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-twt"><i class="fab fa-twitter"></i></span>&nbsp^2[{1}]</span>&nbsp@{2}:&nbsp&nbsp^5{0}',
        args = {message, "#"..playerId, player.getName()}
    })
end)

RegisterCommand('ooc', function(source, args, rawCommand)
    local player = ESX.GetPlayerFromId(playerId)
    local message = table.concat(args, ' ', 1)
    local playerName = GetPlayerName(source)
    
    local playerCoords = GetEntityCoords(GetPlayerPed(source))

    
    local players = GetPlayers()
    for _, player in ipairs(players) do
        local targetCoords = GetEntityCoords(GetPlayerPed(player))
        local distance = #(playerCoords - targetCoords)
        local maxDistance = 10.0
        
        if player ~= source and distance <= maxDistance then
            TriggerClientEvent('chat:addMessage', player, {
                template = '<span class="badge badge-gray">OOC</span>&nbsp <span class="badge badge-gray">{2}</span>&nbsp<span class="badge badge-white">{1}</span>&nbsp&nbsp{0}',
                args = {message, playerName,"[#"..player .."]"}
            })
        end
    end
end)

--------------------------------------------------------------
RegisterCommand("mp", function(playerId, args)
    local targetId = tonumber(args[1])
    local message = table.concat(args, " ", 2)

    local player = ESX.GetPlayerFromId(playerId)
    local target = ESX.GetPlayerFromId(targetId)

    if (target) then
        local playerRank = lib.getPlayerRank(playerId)
        local targetRank = lib.getPlayerRank(targetId)

        if (playerRank > 0) then
            if (not args[2]) then
                return player.showNotification("Debes escribir un mensaje.", "error")
            end

            TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-naranja"><i class="fas fa-lock"></i> MENSAJE ENVIADO</span>&nbspLe has enviado al administrador ^1{2}</span> El siguiente mensaje: ^5&nbsp{0}',
                args = {message, "#"..targetId, GetPlayerName(targetId)}
            })

            TriggerClientEvent('chat:addMessage', targetId, {
                template = '<span class="badge badge-naranja"><i class="fas fa-lock"></i> MP</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}',
                args = {message, "#"..playerId, GetPlayerName(playerId)}
            })
        else
            if (targetRank > 0) then
                if (not args[2]) then
                    return player.showNotification("Debes escribir un mensaje.", "error")
                end

                TriggerClientEvent('chat:addMessage', playerId, {
                    template = '<span class="badge badge-naranja"><i class="fas fa-lock"></i> MP</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}',
                    args = {message, "#"..targetId, GetPlayerName(targetId)}
                })

                TriggerClientEvent('chat:addMessage', targetId, {
                    template = '<span class="badge badge-naranja"><i class="fas fa-lock"></i> MP</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}',
                    args = {message, "#"..playerId, GetPlayerName(playerId)}
                })
            else
                player.showNotification("El jugador no es staff.", "error")
            end
        end
    else
        player.showNotification("El jugador no está conectado.", "error")
    end
end)


RegisterCommand("pfa", function(playerId, args)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    if (player.getJob().name ~= 'police') then
        return player.showNotification("No eres policía.")
    end

    local badgeTemplate = ' <span class="badge badge-pfa" style="display: block; width: 100%;"><span class="badge badge-policia"><i class="fas fa-car"></i></span>&nbsp[<span style="color: #8D8787">{1}</span>]&nbsp[<span style="color: #6da7ed">{2}</span>] ANUNCIO POLICIA: <br> &nbsp&nbsp<span style="color: #6da7ed">{0}</span></span></span>'

    TriggerClientEvent('chat:addMessage', -1, {
        template = badgeTemplate,
        args = {message, "#"..playerId, player.getName(), player.getJob().grade_label}
    })
end)


RegisterCommand("gna", function(playerId, args)
    local message = table.concat(args, " ")


    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

   -- if (player.getJob().name ~= 'gna') then
    --    return player.showNotification("No eres GNA.")
   -- end

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-gna">GENDARMERIA</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp[<span style="color: #58E54F">{3}</span>]&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}</span>',
        args = {message, "#"..playerId, player.getName(), player.getJob().grade_label}
    })
end)

RegisterCommand('modlist', function(source, args, rawCommand)
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local playerPed = GetPlayerPed(playerId)
        if (lib.hasRank(playerId, 1)) then
            local playerName = GetPlayerName(playerId)
            TriggerClientEvent('chatMessage', source, "[^1Staff^7] El administrador ^2(" .. playerId .. ") ^5" .. playerName .. " ^7está ^4moderando^7.")
        end
    end
end)


RegisterCommand('unmod', function(source, args, rawCommand)
    -- Aquí puedes agregar tu lógica personalizada para quitar los permisos de moderador.
    -- Por ejemplo, puedes hacer una consulta a la base de datos y establecer los permisos a 0.
    -- Asegúrate de tener acceso a las funciones y recursos necesarios para realizar esta operación.
    -- También ten en cuenta que este es solo un código de referencia y puede requerir modificaciones adicionales para que funcione correctamente.

    -- Ejemplo de código para quitar los permisos
    local playerId = source
    local identifiers = GetPlayerIdentifiers(playerId)
    local rockstarLicense = nil
    for i, v in pairs(identifiers) do
        if (string.match(v, 'license:')) then
            rockstarLicense = v
            break
        end
    end

    if rockstarLicense then
        rockstarLicense = rockstarLicense:sub(9)
        -- Realiza la actualización en la base de datos para quitar los permisos
        MySQL.query.await('UPDATE users SET admin = ? WHERE identifier = ?', {0, rockstarLicense})
        TriggerClientEvent('chat:addMessage', source, {args = {'Se te han quitado los permisos de moderador.'}})
        DropPlayer(source, 'Permisos quitados, vuelve a conectar')
    else
        -- No se encontró la licencia de Rockstar Games
        TriggerClientEvent('chat:addMessage', source, {args = {'No se pudo encontrar la licencia de Rockstar Games.'}})
    end
end)


RegisterCommand('sc', function(playerId, args)
    local player = ESX.GetPlayerFromId(playerId)
    local currentJob = nil
    local message = table.concat(args, ' ')

    for i,v in pairs(config.jobs) do 
        if (player.getJob().name == i) then
            currentJob = i
            break
        end
    end

    if (currentJob) then
        local xPlayers = ESX.GetExtendedPlayers('job', currentJob)

        local cfg = config.jobs[currentJob]
        for _, xPlayer in pairs(xPlayers) do
            TriggerClientEvent('chat:addMessage', xPlayer.source, {
                template = cfg.badge..'&nbsp<span class="badge badge-gray">{0}</span>&nbsp[<span style="color: '..cfg.color..'">{1}</span>]&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{3}',
                args = {"#"..playerId, player.getJob().grade_label, player.getName(), message}
            })
        end
    end
end)    




RegisterCommand("same", function(playerId, args)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    if (player.getJob().name ~= 'ambulance') then
        return player.showNotification("No eres SAME.")
    end

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-same"><i class="fas fa-ambulance"></i></span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp[<span style="color: #3aa75e">{3}</span>]&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}',
        args = {message, "#"..playerId, player.getName(), player.getJob().grade_label}
    })
end)

RegisterCommand("bennys", function(playerId, args)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    if (player.getJob().name ~= 'mechanic') then
        return player.showNotification("No eres un Mecánico.")
    end

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-naranja">BENNYS</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}',
        args = {message, "#"..playerId, player.getName(), player.getJob().grade_label}
    })
end)

RegisterCommand("rp", function(playerId, args)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    if (player.getJob().name ~= 'gordotunning') then
        return player.showNotification("No eres un Mecánico de Gordo Tunning.")
    end

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-naranja">GORDO TUNNING</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}',
        args = {message, "#"..playerId, player.getName(), player.getJob().grade_label}
    })
end)

RegisterCommand("casino", function(playerId, args)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    if (player.getJob().name ~= 'casino') then
        return player.showNotification("No eres jefe de casino.")
    end

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-streamer">DIAMOND CASINO</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">@{2}</span>&nbsp&nbsp{0}',
        args = {message, "#"..playerId, player.getName(), player.getJob().grade_label}
    })
end)

RegisterCommand("me", function(playerId, args)
    local player = ESX.GetPlayerFromId(playerId)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    TriggerClientEvent('bm_chat:sendProximityMessage', -1, playerId, 
    '<span class="badge badge-me"><i class="fas fa-user"></i> ME</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">{2}</span>&nbsp&nbsp<span style="color: #729dc4">{0}</span>',
    {message, "#"..playerId, "@"..player.getName()})
end)

RegisterCommand("dado", function(playerId, args)
    local player = ESX.GetPlayerFromId(playerId)

    math.randomseed(os.time())
    TriggerClientEvent('bm_chat:sendProximityMessage', -1, playerId, 
    '<span class="badge badge-naranja"><i class="fas fa-dice"></i></span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">{2}</span>&nbsp&nbspSaldría un <span style="color: #e87f1c;">{0}</span>',
    {math.random(1, 6), "#"..playerId, "@"..player.getName()})
end)

RegisterCommand("do", function(playerId, args)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estas usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    TriggerClientEvent('bm_chat:sendProximityMessage', -1, playerId, 
    '<span class="badge badge-do"><i class="fas fa-user"></i> DO</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">{2}</span>&nbsp&nbsp<span style="color: #866eba">{0}</span>',
    {message, "#"..playerId, "@"..player.getName()})
end)

RegisterCommand("gr", function(playerId, args)
    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span> {1}',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    local player = ESX.GetPlayerFromId(playerId)

    TriggerClientEvent('bm_chat:sendProximityMessage', -1, playerId, 
    '<span class="badge badge-gr"><i class="fas fa-volume-up"></i> GR</span>&nbsp<span class="badge badge-gray">{1}</span>&nbsp<span class="badge badge-white">{2}</span>&nbsp&nbsp<span style="color: #ba6e6e">{0}</span>',
    {message, "#"..playerId, "@"..player.getName()})
end)

RegisterCommand('aduty', function(source, args)
    local playerId = source
    local player = ESX.GetPlayerFromId(playerId)
    local playerRank, label, rankName = lib.getPlayerRank(playerId, true)

    if playerRank == 0 then
        TriggerClientEvent('showNotification', playerId, "Solo los staffs pueden usar este comando.", "error")
        return
    end

    TriggerClientEvent('sergi:ropaAdmin', playerId)
end, false)

RegisterCommand('salirstaff', function(source, args)
    local playerId = source
    local player = ESX.GetPlayerFromId(playerId)
    local playerRank, label, rankName = lib.getPlayerRank(playerId, true)

    if playerRank == 0 then
        TriggerClientEvent('showNotification', playerId, "Solo los staffs pueden usar este comando.", "error")
        return
    end

    TriggerClientEvent('sergi:quitarRopaAdmin', playerId)
end, false)

-- @vars
local anonCooldowns = {}  
local anonCooldownTime = 6  

local discordWebhookUrl = 'https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-'

RegisterCommand("anon", function(playerId, args)
    local player = ESX.GetPlayerFromId(playerId)
    local isDead = MySQL.query.await('SELECT is_dead FROM users WHERE identifier = ?', {player.identifier})

    if (isDead[1].is_dead) then
        return TriggerClientEvent('chat:addMessage', playerId, {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "No puedes usar este comando estando muerto."}
        })
    end

    local currentTime = os.time()

    if anonCooldowns[playerId] and (currentTime - anonCooldowns[playerId]) < anonCooldownTime then
        local remainingTime = anonCooldownTime - (currentTime - anonCooldowns[playerId])
        return TriggerClientEvent('chat:addMessage', playerId, {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "Debes esperar ^9" .. remainingTime .. " segundos ^7antes de usar este comando nuevamente."}
        })
    end

    if (not args[1]) then
        return TriggerClientEvent('chat:addMessage', playerId, {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "No puedes dejar el anon vacío."}
        })
    end

    local message = table.concat(args, " ")

    for _, word in pairs(blacklistedWords) do
        if (string.find(string.upper(message), word)) then
            return TriggerClientEvent('chat:addMessage', playerId, {
                template = '<span class="badge badge-staff">{0}</span>',
                args = {"SISTEMA", "Estás usando palabras que no están permitidas, debes aguardar a que las facciones lleguen a tu robo sin saturar el chat, recuerda cumplir esto para no ser baneado.."}
            })
        end
    end

    anonCooldowns[playerId] = os.time()

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-anon"><i class="fas fa-user-secret"></i></span>&nbsp ^2[#{1}] ^7{4}',
        args = {GetPlayerName(playerId), playerId, rankName, rankLabel, message}
    })


    PerformHttpRequest(discordWebhookUrl, function(err, text, headers) end, 'POST', json.encode({
        username = "depo | ANON",
        content = string.format("[ANON] (%s): %s", playerId, message)
    }), { ['Content-Type'] = 'application/json' })
end)


RegisterCommand("id", function(source, args, rawCommand)
	local player = ESX.GetPlayerFromId(source).identifier
	local rango = 0
	local xPlayer = ESX.GetPlayerFromId(source)
	if rango == 0 then
		if args[1] and tonumber(args[1]) then
			local targetId = tonumber(args[1])
			local xTarget = ESX.GetPlayerFromId(targetId)
			if xTarget then
				local targetPing = GetPlayerPing(xTarget.source)
				local pingColor = '<span class="badge badge-same">'
				if (targetPing > 70 and targetPing < 100) then
					pingColor = '<span class="badge badge-manager">'
				elseif (targetPing > 100) then
					pingColor = '<span class="badge badge-robocancelled">'
				end
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<span class="badge badge-staff">SISTEMA</span>&nbsp ID > '..pingColor..''..GetPlayerPing(xTarget.source)..'ms</span> <span class="badge badge-white">' ..GetPlayerName(xTarget.source).. ' <span style="color: #919191;">[#'..xTarget.source.. "]</span></span> ",
                    args = {}
                })
			end
		else
			local xTarget = ESX.GetPlayerFromId(source)
			local targetPing = GetPlayerPing(source)
			local pingColor = '<span class="badge badge-same">'
			if (targetPing > 70 and targetPing < 100) then
				pingColor = '<span class="badge badge-manager">'
			elseif (targetPing > 100) then
				pingColor = '<span class="badge badge-robocancelled">'
			end
            TriggerClientEvent('chat:addMessage', source, {
                template = '<span class="badge badge-staff">SISTEMA</span>&nbsp ID > '..pingColor..''..GetPlayerPing(xTarget.source)..'ms</span> <span class="badge badge-white">' ..GetPlayerName(xTarget.source).. ' <span style="color: #919191;">[#'..xTarget.source.. "]</span></span> ",
                args = {}
            })
		end
	end
end)

RegisterCommand("streamon", function(source, args)
    local playerId = source
    local message = table.concat(args, " ")

    local player = ESX.GetPlayerFromId(playerId)
    local playerRank, label, rankName = lib.getPlayerRank(playerId, true)

    if (playerRank == 0 ) then
        return player.showNotification("Solo los streamers pueden usar este comando.", "error")
    end

    local cfg = exports['bm_lib']:getConfig()
    local rankLabel = label:sub(3)
    
    local stream = MySQL.Sync.fetchScalar('SELECT stream FROM users WHERE identifier = @identifier', {
        ['@identifier'] = player.identifier
    })

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge2 badge-streamer"> <i class="fal fa-comment-alt-lines"></i> STREAM</span> <span class="badge badge-white">@{0}</span> '.. stream ..' &nbsp STREAM ON.',
        args = {GetPlayerName(playerId), rankName, rankLabel, message}
    })
end)


RegisterCommand("anuncio", function(playerId, args)
    local message = table.concat(args, " ")

    local player = ESX.GetPlayerFromId(playerId)
    local playerRank, label, rankName = lib.getPlayerRank(playerId, true)

    if (playerRank == 0) then
        return player.showNotification("Solo los staffs pueden usar este comando.", "error")
    end

    local cfg = exports['bm_lib']:getConfig()
    local rankLabel = label:sub(3)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge2 badge-staff">ANUNCIO</span> <span class="badge badge-white">@{0}</span> &nbsp {4}',
        args = {GetPlayerName(playerId), playerId, rankName, rankLabel, message}
    })
end)

RegisterCommand("sc", function(playerId, args)
    if (playerId == 0) then
        if (not args[1] or not args[2]) then
            return print("Porfavor usa: /sc <name> <message>")
        end
        
        local message = table.concat(args, " ", 2)

        local xPlayers = ESX.GetExtendedPlayers()
        
        for i,v in pairs(xPlayers) do
            if (lib.hasRank(v.source, 1)) then
                TriggerClientEvent('chat:addMessage', v.source, {
                    template = '<span class="badge badge-highstaff">STAFF [#{1}]</span> <span class="badge badge-white">{0}</span> <span class="badge badge-{2}">{3}</span> &nbsp {4}',
                    args = {"CONSOLA", 0, "root", args[1], message}
                })
            end
        end
    else
        local message = table.concat(args, " ")
        local player = ESX.GetPlayerFromId(playerId)
        local playerRank, label, rankName = lib.getPlayerRank(playerId, true)

        if (playerRank == 0) then
            return player.showNotification("Solo los staffs pueden usar este comando.", "error")
        end

        local cfg = exports['bm_lib']:getConfig()
        local rankLabel = label:sub(3)
        local xPlayers = ESX.GetExtendedPlayers()
        
        for i,v in pairs(xPlayers) do
            if (lib.hasRank(v.source, 1)) then
                TriggerClientEvent('chat:addMessage', v.source, {
                    template = '<span class="badge badge-highstaff">STAFF [#{1}]</span> <span class="badge badge-white">{0}</span> <span class="badge badge-{2}">{3}</span> &nbsp {4}',
                    args = {GetPlayerName(playerId), playerId, rankName, rankLabel, message}
                })
            end
        end
    end
end)

-- @callbacks
ESX.RegisterServerCallback('bm_chat:isAdmin', function(playerId, callback)
    local player = ESX.GetPlayerFromId(playerId)

    if (lib.hasRank(playerId, 1)) then
        callback(true)
    else
        callback(false)
    end
end)