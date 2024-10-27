ESX = exports['es_extended']:getSharedObject()


ESX.RegisterServerCallback('sly_ids:isStaff', function(playerId, callback)
    local lib = exports['bm_lib']:initLib()

    callback(lib.hasRank(playerId, 1))
end)