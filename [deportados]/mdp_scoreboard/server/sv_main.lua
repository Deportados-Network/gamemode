ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('bm_hud:askDate', function(playerId, callback)
    local hora = os.date("%H:%M")
    local fecha = os.date("%d/%m/%Y")

    callback(hora, fecha)
end)

ESX.RegisterServerCallback('bm_hud:getCopsAndPlayers', function(playerId, callback)
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    local medicos = ESX.GetExtendedPlayers('job', 'ambulance')
    local gendarmes = ESX.GetExtendedPlayers('job', 'gna')
    local players = ESX.GetExtendedPlayers()

    callback(#xPlayers, #medicos, #gendarmes, #players)
end)