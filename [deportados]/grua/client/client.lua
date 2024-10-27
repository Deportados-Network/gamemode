RegisterNetEvent("wld:delallveh")
AddEventHandler("wld:delallveh", function ()
    local totalvehc = 0
    local notdelvehc = 0
    TriggerEvent('chatMessage', '[Grua]', {255, 0, 0},"^3TODOS LOS VEHÍCULOS DESOCUPADOS SERÁN ELIMINADOS EN 2 MINUTOS")
    Citizen.Wait(60000)
    TriggerEvent('chatMessage', '[Grua]', {255, 0, 0},"^3TODOS LOS VEHÍCULOS DESOCUPADOS SERÁN ELIMINADOS EN 1 MINUTO")
    Citizen.Wait(50000)
    TriggerEvent('chatMessage', '[Grua]', {255, 0, 0},"^3TODOS LOS VEHÍCULOS DESOCUPADOS SERÁN ELIMINADOS EN 10 SEGUNDOS")
    Citizen.Wait(10000)
    TriggerEvent('chatMessage', '[Grua]', {255, 0, 0},"^3TODOS LOS VEHÍCULOS DESOCUPADOS HAN SIDO ELIMINADOS")
    Citizen.Wait(1)

    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then SetVehicleHasBeenOwnedByPlayer(vehicle, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then DeleteVehicle(vehicle) end
            if (DoesEntityExist(vehicle)) then notdelvehc = notdelvehc + 1 end
        end
        totalvehc = totalvehc + 1 
    end
    local vehfrac = totalvehc - notdelvehc .. " / " .. totalvehc
    Citizen.Trace("^3Se borraron"..vehfrac.." vehiculos en el server!")
end)