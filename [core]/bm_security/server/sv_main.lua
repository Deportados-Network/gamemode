-- @vars
local registeredEvents = {}

-- @funcs
local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function delete(eventName)
    if (registeredEvents[eventName]) then
        RemoveEventHandler(registeredEvents[eventName])
        print("[^1bm_security^7] [^1DELETED^7] Event deleted: ^5"..eventName.."^7")
        registeredEvents[eventName] = nil
        TriggerClientEvent('bm_security:syncEvents', -1, registeredEvents)
    end
end
exports('delete', delete)

function register(eventName, func, changeShit)
    local reloadedAlert = false
    local newName = uuid()..":"..eventName
    if registeredEvents[eventName] then
        RemoveEventHandler(registeredEvents[eventName])
        if (not changeShit) then
            print("[^1bm_security^7] ["..(changeShit and "^6EVENT-USED" or "^5RELOADED").."^7] Event reloaded: ^1"..eventName.."^7 as ^4"..newName.."^7")
        end
        TriggerClientEvent('bm_security:syncEvents', -1, registeredEvents)
        reloadedAlert = true
    end
    if (not reloadedAlert) then
        print("[^1bm_security^7] [^2LOADED^7] Event registered: ^1"..eventName.."^7 as ^4"..newName.."^7")
    end
    local event = RegisterNetEvent(newName, function(canChange, ...)
        func(source, ...)

        if (canChange) then
            return register(eventName, func, true)
        end
    end)
    registeredEvents[eventName] = event
    TriggerClientEvent('bm_security:syncEvents', -1, registeredEvents)
end
exports('register', register)

-- @events
AddEventHandler('esx:playerLoaded', function(source, player)
    print("[^1bm_security^7] [^2LOADED^7] Events loaded for player ^4"..player.identifier.."^7")
    TriggerClientEvent('bm_security:syncEvents', source, registeredEvents)
end)

RegisterCommand('resync', function()
    TriggerClientEvent('bm_security:syncEvents', -1, registeredEvents)
end)