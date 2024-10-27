ESX = exports['es_extended']:getSharedObject()
local isRunningWorkaround = false
local lockedVehicles = {}

function StartWorkaroundTask()
    if isRunningWorkaround then
        return
    end

    local timer = 0
    local playerPed = PlayerPedId()
    isRunningWorkaround = true

    while timer < 100 do
        Citizen.Wait(0)
        timer = timer + 1

        local vehicle = GetVehiclePedIsTryingToEnter(playerPed)

        if DoesEntityExist(vehicle) then
            local lockStatus = GetVehicleDoorLockStatus(vehicle)

            if lockStatus == 4 then
                ClearPedTasks(playerPed)
            end
        end
    end

    isRunningWorkaround = false
end

local lockedVehicles = {} -- Tabla para almacenar el estado de bloqueo y el último jugador que bloqueó cada vehículo

function ToggleVehicleLock()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle

    Citizen.CreateThread(function()
        StartWorkaroundTask()
    end)

    if IsPedInAnyVehicle(playerPed, false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    else
        vehicle = GetClosestVehicle(coords, 8.0, 0, 71)
    end

    if not DoesEntityExist(vehicle) then
        return
    end

    local vehiclePlate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    local lockStatus = GetVehicleDoorLockStatus(vehicle)

    if lockStatus == 1 then -- unlocked
        if not lockedVehicles[vehiclePlate] or lockedVehicles[vehiclePlate] == PlayerId() then
            SetVehicleDoorsLocked(vehicle, 2)
            PlayVehicleDoorCloseSound(vehicle, 1)
            lockedVehicles[vehiclePlate] = PlayerId() -- Actualizamos el último jugador que bloqueó el vehículo
            TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_locked') } })
        else
            -- El vehículo fue bloqueado por otra persona
            TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_locked_by_other') } })
        end
    elseif lockStatus == 2 then -- locked
        if lockedVehicles[vehiclePlate] == PlayerId() then
            SetVehicleDoorsLocked(vehicle, 1)
            PlayVehicleDoorOpenSound(vehicle, 0)
            TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_unlocked') } })
        else
            -- El vehículo no puede ser desbloqueado por otra persona
            TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_cant_unlock') } })
        end
    end

    -- Verificar si el jugador es el dueño antes de permitirle entrar al vehículo desbloqueado
    local playerIdentifier = GetPlayerIdentifier(PlayerId(), false)
    local vehicleData = ESX.GetVehicles()[vehiclePlate]
    if vehicleData and vehicleData.owner == playerIdentifier then
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    end
end




RegisterCommand('vehicle:lock', function()
    ToggleVehicleLock()
end)
RegisterKeyMapping('vehicle:lock', "Abrir/cerrar tu vehículo", "keyboard", "u")