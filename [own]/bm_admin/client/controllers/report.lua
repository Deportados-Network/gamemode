-- @commands
RegisterCommand('report', function()
    openReportMenu()
end)

-- @events
RegisterNetEvent('bm_admin:openReports', function(reports)
    ox:registerContext({
        id = "reports_menu",
        title = "Reportes",
        options = {
            {title = "Reportes de jugadores", onSelect = function()
                openPlayerReports(reports)
            end, icon = "fa-solid fa-users"},

            {title = "Reportes de bugs", onSelect = function()
                openBugsReports(reports)
            end, icon = "fa-solid fa-bug"},
        }
    })

    ox:showContext('reports_menu')
end)


-- @funcs
function openBugsReports(reports)
    local options = {}
    for k, v in pairs(reports) do
        if (v.category == 'bug') then
            table.insert(options, {
                title = "Report #"..v.reportId,
                onSelect = function()
                    openBugReport(v)
                end,
                metadata = {
                    "Reportado por: "..v.reporterName,
                },
                icon = "fa-solid fa-bug"
            })
        end
    end

    ox:registerContext({
        id = "bugs_reports",
        title = "Reportes de bugs",
        options = options
    })

    ox:showContext('bugs_reports')
end

function openBugReport(data)
    ox:registerContext({
        id = "bug_report",
        title = "Reporte #"..data.reportId,
        options = {
            {title = "Información", metadata = {
                "Reportado por: "..data.reporterName,
            }, icon = "fa-solid fa-info-circle"},
            {title = "Razón", metadata = {
                "Razón del reporte: "..data.reason,
            }, icon = "fa-solid fa-user"},
            {title = "Atender reporte", onSelect = function()
                TriggerServerEvent('bm_admin:teleportToPlayer', data.reporter, false)
                TriggerServerEvent('bm_admin:reportAtendido', data.reportId)
                TriggerServerEvent('bm_admin:closeReport', data.reportId)
            end, icon = "fa-solid fa-check"},
        }
    })

    ox:showContext('bug_report')
end

function openReportMenu()
    local input = ox:inputDialog('Sistema de reportes', {
        { type = "input", label = "Razón", placeholder = "Escribe un motivo" },
        { type = "input", label = "Jugador", placeholder = "ID del jugador (no necesario)" },
        { type = 'select', label = 'Categoría', options = {
            { value = 'player', label = 'Reportar jugador' },
            { value = 'bug', label = 'Reportar bug' }
        }}
    })
    
    TriggerServerEvent('bm_admin:sendReport', {
        reason = input[1],
        target = (input[2] or 0),
        category = input[3]
    })
end

function openPlayerReports(reports)
    local options = {}
    for k, v in pairs(reports) do
        if (v.category == 'player') then
            table.insert(options, {
                title = "Report #"..v.reportId,
                onSelect = function()
                    openPlayerReport(v)
                end,
                metadata = {
                    "Reportado por: "..v.reporterName,
                    "Reportado a: "..(v.targetName or "Desconectado")
                },
                icon = "fa-solid fa-user"
            })
        end
    end

    ox:registerContext({
        id = "player_reports",
        title = "Reportes de jugadores",
        options = options
    })

    ox:showContext('player_reports')
end

function openPlayerReport(data)
    ox:registerContext({
        id = "player_report",
        title = "Reporte #"..data.reportId,
        options = {
            {title = "Información", metadata = {
                "Reportado por: "..data.reporterName,
                "Reportado a: "..(data.targetName or "N/A")
            }, icon = "fa-solid fa-info-circle"},
            {title = "Razón", metadata = {
                "Razón del reporte: "..data.reason,
            }, icon = "fa-solid fa-user"},
            {title = "Atender reporte", onSelect = function()
                TriggerServerEvent('bm_admin:teleportToPlayer', data.reporter, false)
                TriggerServerEvent('bm_admin:closeReport', data.reportId)
            end, icon = "fa-solid fa-check"},
        }
    })

    ox:showContext('player_report')
end
