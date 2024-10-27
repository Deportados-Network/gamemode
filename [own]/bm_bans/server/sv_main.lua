-- @vars
local bannedPlayers = {}
ESX = exports['es_extended']:getSharedObject()

function convertirCamelANormal(camelCase)
    local normal = camelCase:gsub("(%u)", " %1"):gsub("^%s", ""):lower()
    return normal
end

-- @threads
CreateThread(function()
    local query = MySQL.query.await('SELECT * FROM bans')
    local c = 0

    for i,v in pairs(query) do
        if (v.active == 1) then
            c = c + 1
            bannedPlayers[v.id] = createBan({
                banId = v.id,
                steam = v.steam,
                license = v.license,
                discord = v.discord,
                ip = v.ip,
                live = v.live,
                tokens = json.decode(v.tokens),
                reason = convertirCamelANormal(v.reason),  
                expiry = v.expiry,
                permanent = v.permanent,
                admin = v.admin,
                exactTime = v.exactTime
            })
        end
    end
    print(("[^4bm_bans^7] [^2INFO^7] %s bans loaded."):format(c))
end)


-- @commands
RegisterCommand('banPlayer', function(src, args)
    if (src == 0) then
        local target = args[1] -- @ License
        local reason = args[2]
        local time   = args[3] -- @ -1 = Permanent, > 0 = Seconds
        local admin  = args[4]  -- El cuarto argumento ahora es el nombre del administrador

        if (not target or not reason or not time or not admin) then
            return print("[^4bm_bans^7] [^1ERROR^7] Invalid arguments.")
        end

        reason = convertirCamelANormal(reason)  
        banPlayer(target, reason, tonumber(time), admin)  

            local roleId = "1177846968119214143"
            local discordMessage = {
                username = "depo | Sanciones",
                content = string.format("<@&%s>```Un Usuario fue baneado\n\nLicencia: %s\nTiempo: %s segundos.\nStaff: %s\nRazón: %s.```", roleId, target, time, admin, reason)
            }

            local jsonMessage = json.encode(discordMessage)

            PerformHttpRequest('https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-', function(statusCode, text, headers)
            end, 'POST', jsonMessage, { ['Content-Type'] = 'application/json' })
    end
end)


RegisterCommand('kickPlayer', function(source, args)
    local targetLicense = args[1]
    local reason = args[2]
    local admin = args[3]

    if not targetLicense or not reason or not admin then
        print("[^1ERROR^7] Argumentos inválidos. Uso: /kickPlayer [license] [razon] [admin]")
        return
    end

    reason = convertirCamelANormal(reason)

    local target = nil
    for _, player in ipairs(GetPlayers()) do
        local license = GetPlayerIdentifier(player, 1)

        if license == targetLicense then
            target = player
            break
        end
    end

    if target then
        DropPlayer(target, "Has sido expulsado por el administrador " .. admin .. ". Razón: " .. reason)
    else
        print("[^1ERROR^7] Jugador no encontrado con la licencia: " .. targetLicense)
    end

    local discordMessage = {
        username = "depo | Sanciones",
        content = string.format("```js\nUn Usuario fue expulsado\n\nLicencia: ".. target .."\nTiempo: ".. time .." segundos.\nStaff: ".. admin .."\nRazón: ".. reason ..".```")
    }

    local jsonMessage = json.encode(discordMessage)

    PerformHttpRequest('https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-', function(statusCode, text, headers)
    end, 'POST', jsonMessage, { ['Content-Type'] = 'application/json' })
end, false)



RegisterCommand("findDiscord", function(source, args)

    local discord = args[1]

    discordId = GetPlayerIdentifier(discord, 4)

    print(discordId)
  
end)

RegisterCommand('unbanPlayer', function(src, args)
    if (src == 0) then
        local target = args[1] -- @ License

        if (not target) then
            return print("[^4bm_bans^7] [^1ERROR^7] Invalid arguments.")
        end

        local banId

        for i,v in pairs(bannedPlayers) do
            if (v.license == "license:"..target) then
                banId = v.banId
                break
            end
        end

        local ban = bannedPlayers[banId]

        if (ban) then
            ban.deleteBan()
            print(("[^4bm_bans^7] [^2INFO^7] %s has been unbanned."):format(target))
        else
            print(("[^4bm_bans^7] [^1ERROR^7] %s is not banned."):format(target))
        end
    end
end)

-- @handler
AddEventHandler('playerConnecting', function(name, kick, deferrals)
    local playerId = source
    local isBanned, banId = false, 0
    deferrals.defer()
    Wait(0)
    
    deferrals.update(("Espera mientras validamos sus datos..."))

    for i,v in pairs(bannedPlayers) do
        if (v.checkAnyIdentifierMatch(playerId)) then
            isBanned = true
            banId = v.banId
            break
        end
    end
    
    Wait(0)

    if (isBanned) then
        local ban = bannedPlayers[banId]
        local is, text = ban.isBanned()

        if (is) then
            deferrals.done(text)
        else
            deferrals.done("Tu baneo ha expirado, recuerda leer las normas para que no vuelva a ocurrir.\nVuelve a conectarte.")
        end
    else
        local ids = GetPlayerIdentifiers(playerId)
        local license

        for i,v in pairs(ids) do
            if (v:find("license:")) then
                license = v
                break
            end
        end
        
        local toks = {}
        local numOfTokens = GetNumPlayerTokens(playerId) - 1
        
        for i = 1, numOfTokens do
            toks[i] = GetPlayerToken(playerId, i)
        end

        license = license:gsub("license:", "")

        MySQL.query.await('UPDATE users SET important_ids = ? WHERE identifier = ?', {json.encode({
            identifiers = ids,
            tokens = toks,
            name = GetPlayerName(playerId)
        }), license})

        deferrals.done()
    end
end)

-- @funcs
function banPlayer(targetId, reason, time, admin)
    local target = ESX.GetPlayerFromIdentifier(targetId)

    if target then
        local steamHex, license, discord, ip, live
        local tokens = {}

        for i, v in pairs(GetPlayerIdentifiers(target.source)) do
            if v:find("steam:") then
                steamHex = v
            elseif v:find("license:") then
                license = v
            elseif v:find("discord:") then
                discord = v
            elseif v:find("ip:") then
                ip = v
            elseif v:find("live:") then
                live = v
            end
        end

        local numOfTokens = GetNumPlayerTokens(target.source) - 1

        for i = 1, numOfTokens do
            tokens[i] = GetPlayerToken(target.source, i)
        end

        if numOfTokens == 0 then
            tokens = GetPlayerTokens(target.source)
        end

        local adminPlayer = ESX.GetPlayerFromIdentifier(admin)
        local adminName = admin
        if adminPlayer then
            adminName = GetPlayerName(adminPlayer.source)
        end

        local expiry = (time == -1 and 0 or time)
        local permanent = (time == -1 and 1 or 0)
        local banId = generateBanId()
        local curTime = os.time()

        MySQL.query.await('INSERT INTO bans (id, license, discord, steam, ip, live, tokens, reason, expiry, permanent, admin, exactTime, active) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,1)', {
            banId,
            license,
            discord,
            steamHex,
            ip,
            live,
            json.encode(tokens),
            reason,
            expiry,
            permanent,
            adminName,
            curTime
        })

        bannedPlayers[banId] = createBan({
            banId = banId,
            steam = steamHex,
            license = license,
            discord = discord,
            ip = ip,
            live = live,
            tokens = tokens,
            reason = reason,
            expiry = expiry,
            permanent = permanent,
            admin = adminName,
            exactTime = curTime
        })

        DropPlayer(target.source, "Staff: ".. admin .." | Fuiste baneado. Razon: ".. reason .. "")
    else
        -- Consulta de base de datos para obtener información del usuario
        local query = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {targetId})

        -- Imprimir información de depuración
        print("Resultado de la consulta de usuario:", json.encode(query))

        if query[1] then
            local steamHex, license, discord, ip, live
            local tokens = {}
            local ids = json.decode(query[1].important_ids)

            for i, v in pairs(ids.identifiers) do
                if v:find("steam:") then
                    steamHex = v
                elseif v:find("license:") then
                    license = v
                elseif v:find("discord:") then
                    discord = v
                elseif v:find("ip:") then
                    ip = v
                elseif v:find("live:") then
                    live = v
                end
            end

            for i, v in pairs(ids.tokens) do
                tokens[i] = v
            end

            local expiry = (time == -1 and 0 or time)
            local permanent = (time == -1 and 1 or 0)
            local banId = generateBanId()
            local curTime = os.time()

            MySQL.query.await('INSERT INTO bans (id, license, discord, steam, ip, live, tokens, reason, expiry, permanent, admin, exactTime, active) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,1)', {
                banId,
                license,
                discord,
                steamHex,
                ip,
                live,
                json.encode(tokens),
                reason,
                expiry,
                permanent,
                admin,
                curTime
            })

            bannedPlayers[banId] = createBan({
                banId = banId,
                steam = steamHex,
                license = license,
                discord = discord,
                ip = ip,
                live = live,
                tokens = tokens,
                reason = reason,
                expiry = expiry,
                permanent = permanent,
                admin = admin,
                exactTime = curTime
            })
        else
            print("El usuario no existe.")
        end
    end
end



RegisterCommand("listplayers", function(source, args, rawCommand)
    local playerList = {}
    
    for _, player in ipairs(GetPlayers()) do
        local playerName = GetPlayerName(player)
        local ping  = GetPlayerPing(player)
        local playerIdentifier = GetPlayerIdentifier(player)
        

        table.insert(playerList, {
            name = playerName,
            identifier = playerIdentifier,
            ping = ping
        })
    end

    print("^2Lista de Jugadores Conectados:")

    for i, playerInfo in ipairs(playerList) do
        local message = string.format("Nombre: %s | Identifier: %s | Ping: %s", playerInfo.name, playerInfo.identifier, playerInfo.ping)
        print(message)
    end
end, false)



function createBan(data)
    local self = {}

    self.banId = data.banId
    self.steamHex = data.steam
    self.license = data.license
    self.discord = data.discord
    self.ip = data.ip
    self.live = data.live
    self.tokens = data.tokens
    self.reason = data.reason
    self.expiry = data.expiry
    self.permanent = data.permanent
    self.admin = data.admin
    self.exactTime = data.exactTime

    function self.deleteBan()
        MySQL.query.await('UPDATE bans SET active = 0 WHERE id = ?', {self.banId})
        bannedPlayers[self.banId] = nil
    end

    function self.checkAnyIdentifierMatch(playerId)
        local identifiers = GetPlayerIdentifiers(playerId)

        for i,v in pairs(identifiers) do
            if (v == self.steamHex or v == self.license or v == self.discord or v == self.ip or v == self.live) then
                return true
            end
        end

        local numOfTokens = GetNumPlayerTokens(playerId) - 1
        local tokens = {}

        for i = 1, numOfTokens do
            tokens[i] = GetPlayerToken(playerId, i)
        end

        if (tokens == 0) then
            tokens = GetPlayerTokens(playerId)
        end

        for i,v in pairs(tokens) do
            for i2,v2 in pairs(self.tokens) do
                if (v == v2) then
                    return true
                end
            end
        end

        return false
    end

    function self.isBanned()
        local isPerm = (self.permanent == 1 and true or false)
        if (isPerm) then
            --local text = "\n\n🌐 Ban ID: "..self.banId.."\n📝 Razón: "..self.reason.."\n⏰ Estado: Permanente"
            local text = "⛔ Fuiste baneado permanentemente del servidor ⛔. Si crees que fue una sancion injusta, puedes apelar el baneo en nuestro Discord. (discord.gg/deporoleplay) ✔️\n\n🌐 Ban ID: "..self.banId.."\n📝 Razón: "..self.reason.."\n👮‍♂️ Administrador: "..self.admin.."\n⏰ Tiempo: HWID - Permanente"

            return true, text
        else
            local timeDiff = os.difftime(os.time(), self.exactTime)

            if (timeDiff >= self.expiry) then
                self.deleteBan()
                return false
            else
                local days = math.floor((self.expiry - timeDiff)/86400)
                local hours = math.floor(((self.expiry - timeDiff)/3600)%24)
                local minutes = math.floor(((self.expiry - timeDiff)/60)%60)
                local seconds = math.floor((self.expiry - timeDiff)%60)
                --local text = "\n\n🌐 Ban ID: "..self.banId.."\n📝 Razón: "..self.reason.."\n⏰ Tiempo restante: "
                local text = "⛔Estas baneado del servidor⛔. Si crees que este baneo fue injusto, puedes apelarlo en nuestro Discord. (discord.gg/deporoleplay) ✔️\n\n🌐 Ban ID: "..self.banId.."\n📝 Razón: "..self.reason.."\n👮‍♂️ Administrador: "..self.admin.."\n⏰ Tiempo restante: "

                if (days > 0) then
                    text = text..days.."d, "
                end

                if (hours > 0) then
                    text = text..hours.."h, "
                end

                if (minutes > 0) then
                    text = text..minutes.."m, "
                end

                if (seconds > 0) then
                    text = text..seconds.."s"
                end

                return true, text
            end
        end
    end

    return self
end

function generateBanId()
    local banId = math.random(1, 10000)
    local exists = false

    for i,v in pairs(bannedPlayers) do
        if (v.banId == banId) then
            exists = true
            break
        end
    end

    if (exists) then
        return generateBanId()
    else
        return banId
    end
end