-- @vars
core    = exports['es_extended']:getSharedObject()
lib     = {}
admins  = {}

AddEventHandler('esx:playerLoaded', function(source, Player)
    if (lib.hasRank(source, 1)) then
        admins[source] = true
    end
end)

AddEventHandler('playerDropped', function()
    if (lib.hasRank(source, 1)) then
        if (admins[source]) then
            admins[source] = nil
        end
    end
end)

RegisterCommand('reloadMyself', function(src)
    if (lib.hasRank(src, 1)) then
        if (not admins[src]) then
            admins[src] = true
        end
    end
end)

-- @funcs
function lib.hasRank(playerId, minimunRank)
    local playerRank = lib.getPlayerRank(playerId)

    if (playerRank >= minimunRank) then
        return true
    else
        return false
    end
end

function lib.getPlayerRank(playerId, withColor)
    local player    = core.GetPlayerFromId(playerId)
    
    if (player) then
        local query     = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {player.identifier})
        local rankLabel = ""
        local rank = ""

        if (query[1]) then
            for i,v in pairs(Config) do
                if (v.level == query[1].admin) then
                    rankLabel = v.label
                    rank = i
                    break
                end
            end
            return query[1].admin, (withColor and Config[rank].color and "^"..Config[rank].color..rankLabel or rankLabel), rank
        else
            return 0, "Usuario"
        end
    else
        return 0, "Usuario"
    end
end

function lib.setRank(playerId, rank, senderId)
    local player = core.GetPlayerFromId(playerId)
    
    local rankExists = false
    local rankLabel  = ""
    for i,v in pairs(Config) do
        if (v.level == rank) then
            rankExists = true
            rankLabel = v.label
            break
        end
    end

    if (rankExists) then
        if (rank == 0) then
            admins[playerId] = nil
        else
            admins[playerId] = true
        end
        MySQL.query.await('UPDATE users SET admin = ?, temp_admin = ? WHERE identifier = ?', {rank, rank, player.identifier})
        TriggerClientEvent('bm_lib:sendNotify', playerId, "Permisos administrativos", "Te han otorgado el rango administrativo **"..rankLabel.."**", "success")
        if (senderId > 0) then
            TriggerClientEvent('bm_lib:sendNotify', senderId, "Permisos administrativos", "Le has otorgado a "..GetPlayerName(playerId).." el rango administrativo **"..rankLabel.."**", "success")
        else
            print("Le has otorgado a "..GetPlayerName(playerId).." el rango administrativo **"..rankLabel.."**")
        end
    else
        if (senderId > 0) then
            TriggerClientEvent('bm_lib:sendNotify', senderId, "Error", "El rango especificado no existe.", "error")
        else
            print("El rango especificado no existe.")
        end
    end
end

function lib.notifyAllAdmins(data)
    for i,v in pairs(admins) do
        TriggerClientEvent('bm_lib:sendNotify', i, data.title, data.message, data.type)
    end
end

function lib.sendNotify(playerId, data)
    TriggerClientEvent('bm_lib:sendNotify', playerId, data.title, data.message, data.type)
end

function lib.playerCooldown(uid, playerId, seconds)
	local self = {}

	self.uid = uid
	self.playerId = playerId
	self.seconds = seconds
	self.counter = 0

	function self.addCounter()
		if (self.counter < seconds) then
			SetTimeout(1000, function()
				self.counter = self.counter + 1
				return self.addCounter()
			end)
		else
			self.uid[self.playerId] = nil
		end
	end

    function self.remainingTime()
        return self.seconds - self.counter
    end

	self.addCounter()

	return self
end

function initLib()
    return lib
end
exports('initLib', initLib)