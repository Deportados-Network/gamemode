-- @events
RegisterNetEvent('bm_mafias:out.inVehicle', function()
    local playerPed = PlayerPedId()

    if isHandcuff then
		if not (IsPedInAnyVehicle(playerPed)) then
            local vehicle, distance = ESX.Game.GetClosestVehicle()

            if vehicle and distance < 5 then
                local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

                for i=maxSeats - 1, 0, -1 do
                    if IsVehicleSeatFree(vehicle, i) then
                        freeSeat = i
                        break
                    end
                end

                if freeSeat then
                    TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
                end
            end
        else
            local GetVehiclePedIsIn = GetVehiclePedIsIn
            local IsPedSittingInAnyVehicle = IsPedSittingInAnyVehicle
            local TaskLeaveVehicle = TaskLeaveVehicle
            if IsPedSittingInAnyVehicle(playerPed) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                TaskLeaveVehicle(playerPed, vehicle, 64)
            end
        end
	end
end)