-- @vars
local showIds = false

-- @threads
CreateThread(function()
    while true do
        local msec = 1000
        if (showIds) then
            local activePlayers = GetActivePlayers()

            for i,v in pairs(activePlayers) do
                local playerPed = GetPlayerPed(v)
                local playerCoords = GetEntityCoords(playerPed)

                if (playerPed ~= PlayerPedId()) then
                    if #(GetEntityCoords(PlayerPedId()) - playerCoords) < 500.0 then
                        msec = 0
                        createText("["..GetPlayerServerId(NetworkGetEntityOwner(playerPed)).."] "..GetPlayerName(v).." [~r~"..(GetEntityHealth(playerPed)-100).."~w~] [~b~"..GetPedArmour(playerPed).."~w~]", nil, playerPed)
                    end
                end
            end
        end
        Wait(msec)
    end
end)

-- @commands
RegisterCommand('reparar', function(src, args)
    core.TriggerServerCallback('bm_admin:isAdmin', function(is)
        if (is) then
            if (args[1]) then
                local playerFound
                for i,v in pairs(GetActivePlayers()) do
                    if (GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(v))) == tonumber(args[1])) then
                        playerFound = v
                    end
                end
                if not (playerFound) then
                    return TriggerEvent('chat:addMessage', {
                        template = '<span class="badge badge-staff">{0}</span> {1}',
                        args = {"SISTEMA", "No se encontro al jugador, asegurate de estar a menos de 500m de el."}
                    })
                end
                local playerVeh = GetVehiclePedIsIn(GetPlayerPed(playerFound))
        
                if DoesEntityExist(playerVeh) then
                    TriggerEvent('chat:addMessage', {
                        template = '<span class="badge badge-staff">{0}</span> {1}',
                        args = {"SISTEMA", "Tomando el control, espera..."}
                    })
                    if not takeControl(playerVeh) then
                        return TriggerEvent('chat:addMessage', {
                            template = '<span class="badge badge-staff">{0}</span> {1}',
                            args = {"SISTEMA", "No se pudo obtener el control de la entidad."}
                        })
                    end
                    
                    SetVehicleHasBeenOwnedByPlayer(playerVeh, true)

                    SetVehicleFixed(playerVeh)
                    SetVehicleDeformationFixed(playerVeh)
                    TriggerEvent('chat:addMessage', {
                        template = '<span class="badge badge-staff">{0}</span> {1}',
                        args = {"SISTEMA", "Reparado."}
                    })
                end
            end
        end
    end)
end)

RegisterCommand('abrircoche', function(src, args)
    core.TriggerServerCallback('bm_admin:isAdmin', function(is)
        if (is) then
            if (args[1]) then
                local playerFound
                for i,v in pairs(GetActivePlayers()) do
                    if (GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(v))) == tonumber(args[1])) then
                        playerFound = v
                    end
                end
                if not (playerFound) then
                    return TriggerEvent('chat:addMessage', {
                        template = '<span class="badge badge-staff">{0}</span> {1}',
                        args = {"SISTEMA", "No se encontro al jugador, asegurate de estar a menos de 500m de el."}
                    })
                end
                local playerVeh = GetVehiclePedIsIn(GetPlayerPed(playerFound))
        
                if DoesEntityExist(playerVeh) then
                    TriggerEvent('chat:addMessage', {
                        template = '<span class="badge badge-staff">{0}</span> {1}',
                        args = {"SISTEMA", "Tomando el control, espera..."}
                    })
                    if not takeControl(playerVeh) then
                        return TriggerEvent('chat:addMessage', {
                            template = '<span class="badge badge-staff">{0}</span> {1}',
                            args = {"SISTEMA", "No se pudo obtener el control de la entidad."}
                        })
                    end
        
                    SetVehicleDoorsLocked(playerVeh, 1)
			        SetVehicleDoorsLockedForPlayer(playerVeh, PlayerId(), false)
                    TriggerEvent('chat:addMessage', {
                        template = '<span class="badge badge-staff">{0}</span> {1}',
                        args = {"SISTEMA", "Abierto."}
                    })
                end
            end
        end
    end)
end)

function createText(text, coords, ped)
    local coords = coords
    if coords == nil then
        local npcHead = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
        coords = vec3(npcHead.x, npcHead.y, npcHead.z+0.35)
    else
        coords = vector3(coords.x, coords.y, coords.z)
    end

    local camCoords = GetGameplayCamCoords()
    local distance = #(coords - camCoords)

    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(0.0 * scale, 0.40 * scale)
    SetTextFont(0)
    SetTextColour(255, 255, 255, 255)  
    SetTextOutline()
    SetTextCentre(true)

    SetDrawOrigin(coords, 0)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

-- @events
RegisterNetEvent('bm_admin:showPlayersIds', function()
    showIds = not showIds
end)

function takeControl(ent)
    if (NetworkHasControlOfEntity(ent)) then
        return true
    end

    while not (NetworkHasControlOfEntity(ent)) do
        NetworkRequestControlOfEntity(ent)
        Wait(0)
    end

    if (not NetworkHasControlOfEntity(ent)) then
        return false
    end

    local netHandle = NetworkGetNetworkIdFromEntity(ent)
    ReqControlId(netHandle)
    SetNetworkIdCanMigrate(netHandle, true)
    
    return true
end

function ReqControlId(id)
    if (not NetworkHasControlOfNetworkId(id)) then
        NetworkRequestControlOfNetworkId(id)
    end

    return true and NetworkHasControlOfNetworkId(id)
end