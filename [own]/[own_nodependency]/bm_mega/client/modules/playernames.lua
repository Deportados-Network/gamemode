-- @vars
local mpGamerTags = {}
local isStaff = false
local playerLoaded = false

-- @events
RegisterNetEvent('esx:playerLoaded', function()
    playerLoaded = true
    ESX.TriggerServerCallback('bm_mega:isStaff', function(staff)
        isStaff = staff
    end)
end)

-- @threads
CreateThread(function()
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        for i,ent in pairs(GetActivePlayers()) do
            local v = GetPlayerPed(ent)
            if (IsPedAPlayer(v) and ent ~= PlayerId()) then
                local targetPos = GetEntityCoords(v)
                local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(v))

                local canShow = #(playerPos - targetPos) < 10.0 and HasEntityClearLosToEntity(PlayerPedId(), v, 17)

                if (isStaff) then
                    canShow = true
                end
                
                if canShow then
                    msec = 0
                    
                    local nameTag

                    if (isStaff) then
                        nameTag = ('%s [#%s]'):format(GetPlayerName(ent), targetId)
                    else
                        canShow = false
                    end
                    
                    if (isStaff) then
                        Create3D(vec3(targetPos.xy, targetPos.z+1), nameTag)
                    else
                        canShow = false
                    end
                end
            end
        end

        Wait(msec)
    end
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

function Create3D(coords, text)
    local x, y, z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scales
    if (#(GetEntityCoords(PlayerPedId()) - coords) < 3) then
        scales = scale*fov
    else
        scales = 0.5
    end
    if onScreen then
        SetTextScale(0.0*scales, 0.55*scales)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(5)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end