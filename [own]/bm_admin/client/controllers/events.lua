RegisterNetEvent('bm_admin:healPlayer', function()
    SetEntityHealth(lib.cache.playerPed, GetEntityMaxHealth(lib.cache.playerPed))
    core.ShowNotification("Un administrador te ha curado.", "success")
end)

RegisterNetEvent('bm_admin:setFuel', function(quant)
    local playerPed = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(playerPed, false)

    exports['LegacyFuel']:SetFuel(playerVeh, quant)
end)

RegisterNetEvent('bm_admin:eat', function()
    TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
end)

RegisterNetEvent('bm_admin:armor', function(quant)
    SetPedArmour(PlayerPedId(), quant)
end)