# Robo iniciado

TriggerEvent('chat:addMessage', {
    template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Robos</span>&nbsp<span class="badge badge-gray">{2}</span> &nbsp {0} &nbsp<span class="badge badge-roboexitoso">{1}</span>',
    args = {"Se inicio el robo al ", "Banco Central", "#"..GetPlayerServerId(PlayerId())}
})

# Robo cancelado
TriggerEvent('chat:addMessage', {
    template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Robos</span>&nbsp<span class="badge badge-gray">{2}</span> &nbsp {0} &nbsp<span class="badge badge-robocancelled">{1}</span>',
    args = {"Se canceló el robo al ", "Banco Central", "#"..GetPlayerServerId(PlayerId())}
})

# Robo completado
TriggerEvent('chat:addMessage', {
    template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Robos</span>&nbsp<span class="badge badge-gray">{2}</span> &nbsp {0} &nbsp<span class="badge badge-robo">{1}</span>',
    args = {"Se completo el robo al ", "Banco Central", "#"..GetPlayerServerId(PlayerId())}
})