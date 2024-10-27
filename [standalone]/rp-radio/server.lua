ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('rp-radio:hasRadio', function(playerId, callback)
    local player = ESX.GetPlayerFromId(playerId)

    callback(player.getInventoryItem('radio').count > 0)
end)

ESX.RegisterUsableItem('radio', function(src)
    local player = ESX.GetPlayerFromId(src)

    TriggerClientEvent('rp-radio:use', src)
end)