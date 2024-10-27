RegisterNetEvent('bm_mafias:dragPlayer', function(copId)
    local playerPed = PlayerPedId()
    
    if (isHandcuff) then
        isDragged = not isDragged

        local copPed = GetPlayerPed(GetPlayerFromServerId(copId))

        if (DoesEntityExist(copPed) and IsPedOnFoot(copPed) and not IsPedDeadOrDying(copPed, true)) then
            if (isDragged) then
                CreateThread(function()
                    while isDragged do
                        AttachEntityToEntity(playerPed, copPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                        Wait(0)
                    end
                end)
            else
                DetachEntity(playerPed, true, false)
            end
        end
    end
end)