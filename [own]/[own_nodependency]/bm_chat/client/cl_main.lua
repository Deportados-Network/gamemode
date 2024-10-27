

-- @vars
ESX = exports['es_extended']:getSharedObject()


-- @events
RegisterNetEvent('bm_chat:sendProximityMessage')
AddEventHandler('bm_chat:sendProximityMessage', function(playerId, template, args)
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(target)
	local playerCoords = GetEntityCoords(playerPed)
	local targetCoords = GetEntityCoords(targetPed)

	if target ~= -1 then
		if target == player or #(playerCoords - targetCoords) < 20 then
            local args = args
            if (target == player) then
                args[3] = "TÚ"
            end

            TriggerEvent('chat:addMessage', {
                template = template,
                args = args
            })
		end
	end
end)

RegisterCommand("staff", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)

    -- Verifica si el jugador es un policía (ajusta según tu lógica específica)
        -- Establece la ropa según las especificaciones
        SetPedComponentVariation(player, 4, 49, 0, 0)  -- Piernas
        SetPedComponentVariation(player, 6, 64, 5, 0)   -- Zapatos
        SetPedComponentVariation(player, 11, 15, 0, 0)  -- Camisa
        SetPedComponentVariation(player, 9, 0, 0, 0)   -- Armadura
        SetPedComponentVariation(player, 11, 178, 0, 0)  -- Chaqueta
        SetPedPropIndex(player, 0, 91, 0, 0)  -- Casco

        TriggerEvent("chatMessage", "[depo]", {255, 0, 0}, "Entraste en servicio como STAFF!")
end, false)

RegisterCommand('healems', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then 
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        local health = GetEntityHealth(closestPlayerPed)

        if health > 0 then
            ESX.ShowNotification('Curando...')
            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
            Wait(10000)
            ClearPedTasks(playerPed)

            SetEntityHealth(closestPlayerPed, 200)
            ESX.ShowNotification('El jugador mÃ¡s cercano ha sido curado.')
        else
            ESX.ShowNotification('El jugador no estÃ¡ consciente.')
        end
    else
        ESX.ShowNotification('No hay jugadores cercanos.')
    end
end, false)

RegisterCommand('reviveems', function()
    -- Obtener el jugador ejecutor del comando
    local playerPed = GetPlayerPed(-1)

    -- Obtener la posición del jugador
    local playerCoords = GetEntityCoords(playerPed)

    -- Obtener todos los jugadores activos en el servidor
    local players = GetActivePlayers()

    -- Iterar sobre los jugadores activos
    for _, player in ipairs(players) do
        local targetPed = GetPlayerPed(player)

        -- Comprobar si el jugador cercano está inconsciente
        if IsPedDeadOrDying(targetPed, true) then
            -- Obtener la posición del jugador cercano
            local targetCoords = GetEntityCoords(targetPed)

            -- Calcular la distancia entre el jugador ejecutor y el jugador cercano
            local distance = #(playerCoords - targetCoords)

            -- Comprobar si el jugador cercano está dentro de un rango específico
            if distance <= 2.0 then
                -- Realizar la animación de RCP en el jugador ejecutor
                RequestAnimDict("mini@cpr@char_a@cpr_str")
                while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
                    Citizen.Wait(0)
                end
                TaskPlayAnim(playerPed, "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 1.0, -1, -1, 50, 0, false, false, false)

                -- Esperar unos segundos para simular la duración de la animación
                Citizen.Wait(5000)

                -- Revivir al jugador cercano utilizando esx_ambulancejob:revive
                TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(player))

                -- Detener la animación en el jugador ejecutor
                ClearPedTasks(playerPed)

                -- Notificar al jugador ejecutor
                TriggerEvent('chat:addMessage', {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {'[Servidor]', 'Has revivido al jugador cercano.'}
                })

                -- Salir del bucle después de revivir al primer jugador encontrado
                break
            end
        end
    end
end)

RegisterNetEvent('sergi:quitarRopaAdmin')
AddEventHandler('sergi:quitarRopaAdmin', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

RegisterNetEvent('bm_chat:messageToEveryone', function(message, name, id, steamName)
    ESX.TriggerServerCallback('bm_chat:isAdmin', function(isAdmin)
        if (isAdmin) then
            TriggerEvent('chat:addMessage', {
                template = '<span class="badge badge-anon"> <i class="fas fa-user-secret"></i></span> <span class="badge badge-gray"> {1} </span> &nbsp <span class="badge badge-white"> @{2} </span> &nbsp {0}',
                args = {message, id, steamName}
            })
        else
            TriggerEvent('chat:addMessage', {
                template = '<span class="badge badge-anon"> <i class="fas fa-user-secret"></i></span> <span class="badge badge-gray"> {1} </span> &nbsp <span class="badge badge-white"> @{2} </span> &nbsp {0}',
                args = {message, id, name}
            })
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)  -- Espera 1 segundo (puedes ajustar este valor según tus necesidades)
        
        -- Coloca aquí el código que deseas ejecutar en cada iteración del bucle
        SetPedUsingActionMode(PlayerPedId(), -1, -1, 1)
    end
end)

