-- @vars
local dev = false

-- @command
RegisterCommand('dev', function()
    dev = not dev

    if (dev) then
        local propList = {}

        for i,v in pairs(exports['hashtoname']:getProps()) do
            propList[v.HashIs] = v.ModNam
        end

        CreateThread(function()
            while dev do
                local playerPed = PlayerPedId()
                local playerPos = GetEntityCoords(playerPed)

                for i,v in pairs(GetGamePool("CObject")) do
                    local propPos = GetEntityCoords(v)

                    local propName

                    if (propList[GetEntityModel(v)]) then
                        propName = propList[GetEntityModel(v)]
                    else
                        propName = GetEntityModel(v)
                    end
                    
                    if #(playerPos - propPos) < 1.2 then
                        createText("~b~"..propName.."~w~\n["..math.floor(#(playerPos - propPos)).."m]", propPos)

                        if (IsControlJustPressed(0, 38)) then
                            local ox = exports['ox_lib']

                            ox:setClipboard(GetEntityModel(v))
                        end
                    elseif #(playerPos - propPos) < 3.0 then
                        createText(propName.."\n["..math.floor(#(playerPos - propPos)).."m]", propPos)
                    end
                end

                Wait(0)
            end
        end)
    end
end)