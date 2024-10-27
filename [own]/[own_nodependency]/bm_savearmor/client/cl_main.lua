RegisterNetEvent('esx:playerLoaded', function()
    TriggerServerEvent('bm_savearmor:set')
    TriggerEvent('esx:restoreLoadout')
end)

CreateThread(function()
    Wait(30000)
    TriggerEvent('esx:restoreLoadout')
end)

RegisterCommand('desbugearinv', function()
    TriggerEvent('esx:restoreLoadout')
end)