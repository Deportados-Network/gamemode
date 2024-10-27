-- @vars
local events = {}

-- @funcs
function call(eventName, canChange, ...)
    if events[eventName] then
        TriggerServerEvent(events[eventName].name, canChange, ...)
    else
        print("[^1bm_security^7] [^1ERROR^7] Event not found: ^1"..eventName.."^7")
    end
end
exports('call', call)

-- @events
RegisterNetEvent('bm_security:syncEvents', function(ev)
    events = ev
end)