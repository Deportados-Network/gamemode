-- @events
RegisterNetEvent('bm_admin:sendReport', function(data)
    local source = source
    if (reportsCooldown[source]) then
        TriggerClientEvent('chatMessage', source, "Reportes", {255, 0, 0}, "Debes esperar " .. reportsCooldown[source].seconds - reportsCooldown[source].counter .. " segundos para enviar otro reporte.")
        return
    end

    local player = core.GetPlayerFromId(source)
    local reportId = #reports + 1
    reports[reportId] = {
        reportId = reportId,
        reporter = player.source,
        reporterName = GetPlayerName(player.source),
        reason = data.reason,
        category = data.category,
        target = data.target,
        targetName = GetPlayerName(data.target)
    }

    local targetId = data.target
    local badgeTemplate = '<span class="badge badge-report" style="width: 100%; display: block; white-space: normal;"> <span class="badge badge-alert"><i class="fas fa-bell"></i></span>&nbsp <span style="color: gray;">[#{3}]</span> <span style="color: lightgreen;">{2}</span> envió un nuevo reporte. <br> <span class="facu-report" </span> utiliza /reports para ver todos los reportes detalladamente. </span>'

    if (lib.hasRank(source, 1)) then
    TriggerClientEvent('chat:addMessage', -1, {
        template = badgeTemplate,
        args = {"", "#"..reportId, GetPlayerName(player.source), player.source, GetPlayerName(data.target) or "^1Ninguno", data.category}
    })
    end

end)
