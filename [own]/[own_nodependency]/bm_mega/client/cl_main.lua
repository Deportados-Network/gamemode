-- @vars
ESX = exports['es_extended']:getSharedObject()
ox = exports['ox_lib']

-- @threads
CreateThread(function()
    local notified = false
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        
        if (IsPedDeadOrDying(playerPed) or IsEntityDead(playerPed)) then
            if (not notified) then
                notified = true
            end
        else
            if (notified) then
                notified = false
            end
        end

        local playerData = ESX.GetPlayerData()

        if (playerData.job and playerData.job.name == "ambulance") then
            for i,v in pairs(GetActivePlayers()) do
                local ped = GetPlayerPed(v)
                local pedPos = GetEntityCoords(ped)
    
                if (IsPedDeadOrDying(ped) or IsEntityDead(ped)) and #(playerPos - pedPos) < 30.0 then
                    msec = 0
                    DrawMarker(32, vec3(pedPos.xy, pedPos.z+1), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 0, false)
                end
            end
        end

        Wait(msec)
    end
end)

-- @funcs
function createText(text, coords, ped)
    local coords = coords
    if coords == nil then
        local npcHead = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
        coords = vec3(npcHead.x, npcHead.y, npcHead.z+0.35)
    else
        coords = vector3(coords.x, coords.y, coords.z)
    end

    local camCoords = GetGameplayCamCoords()
    local distance = #(coords - camCoords)

    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(0.0 * scale, 0.40 * scale)
    SetTextFont(0)
    SetTextColour(255, 255, 255, 255)  
    SetTextOutline()
    SetTextCentre(true)

    SetDrawOrigin(coords, 0)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

RegisterNetEvent('bm_mega:deleteVehicles', function()
    for i,v in pairs(GetGamePool('CVehicle')) do
        local Driver = GetPedInVehicleSeat(v, -1)
        if (not IsPedAPlayer(Driver)) then
            SetVehicleHasBeenOwnedByPlayer(v, false) 
            SetEntityAsMissionEntity(v, false, false) 
            DeleteVehicle(v)
        end
    end
end)

--OCULTA HUD DEFAULT tiempo de 0 a 2000

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        HideHudComponentThisFrame(3) -- CASH
        HideHudComponentThisFrame(4) -- MP CASH
        HideHudComponentThisFrame(2) -- weapon icon
        HideHudComponentThisFrame(9) -- STREET NAME
        HideHudComponentThisFrame(7) -- Area NAME
        HideHudComponentThisFrame(8) -- Vehicle Class
        HideHudComponentThisFrame(6) -- Vehicle Name
    end
end)

Citizen.CreateThread(function()
--    for i = 1, 12 do
   --     EnableDispatchService(i, false)
   -- end
    while true do
        Wait(0)
        --[[SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)]]
        DisableControlAction( 0, 36, true ) -- INPUT_DUCK  
    end
end)

---- SANTI NO CERRA
local accesoriosSynced = {}

RegisterNetEvent("syncAccesorio")
AddEventHandler("syncAccesorio", function(accesorio)
    accesoriosSynced[accesorio] = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = GetPlayerPed(-1)

        for accesorio, synced in pairs(accesoriosSynced) do
            if DoesEntityExist(playerPed) and IsEntityDead(playerPed) == false and GetPedDrawableVariation(playerPed, GetPedDrawableVariationIndex(playerPed, GetPedDrawableVariation(playerPed, accesorio))) ~= 0 then
                SetPedPropIndex(playerPed, accesorio, 0, 0, 2)  -- Ajusta los parámetros según sea necesario
            end
        end
    end
end)


