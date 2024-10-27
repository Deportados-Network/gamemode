--[[ 
    
if not HasStreamedTextureDictLoaded("marker") then
            RequestStreamedTextureDict("marker", true)
            while not HasStreamedTextureDictLoaded("marker") do
                Wait(1)
            end
        end
        DrawMarker(9, -1062.76, -281.93, 37.71, 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, false, 2, true, "marker", "marker", false)

 ]]

local tps = {
    {from = vec3(428.1, -986.15, 30.71), to = vec3(614.32, -3057.77, 6.07)}
}

local tpcayoperico = {
    {from = vec3(4516.84, -4519.83, 4.21), to = vec3(3826.68, -4667.17, 1.93)} 
}

local pfa = {
    {from = vec3(437.26, -978.95, 30.69), to = vec3(-448.39, 6007.89, 31.72)}
}

CreateThread(function()
    while true do
        local msec = 500

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local playerData = ESX.GetPlayerData()

        if (playerData and playerData.job.name == "police" or playerData and playerData.job.name == "ambulance" ) then
            for i,v in pairs(tps) do
                if #(playerCoords - v.from) < 20.0 then
                    msec = 0
                    DrawMarker(24, v.from, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, false, false, 0, false)
                    if #(playerCoords - v.from) < 3.0 then
                        ESX.ShowFloatingHelpNotification("~r~[E]~w~ TP alquiler de lanchas", vec3(v.to))
    
                        if (IsControlJustPressed(0, 38)) then
                            SetEntityCoords(playerPed, v.to)
                        end
                    end
                end
    
                if #(playerCoords - v.to) < 20.0 then
                    msec = 0
                    DrawMarker(24, v.to, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, false, false, 0, false)
                    if #(playerCoords - v.to) < 3.0 then
                        ESX.ShowFloatingHelpNotification("~r~[E]~w~ Central de LSPD", vec3(v.to))
    
                        if (IsControlJustPressed(0, 38)) then
                            SetEntityCoords(playerPed, v.from)
                        end
                    end
                end
            end
        end
        
        Wait(msec)
    end
end)

CreateThread(function()
    while true do
        local msec = 500

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local playerData = ESX.GetPlayerData()

        if (playerData and playerData.job.name == "police") then
            for i,v in pairs(pfa) do
                if #(playerCoords - v.from) < 20.0 then
                    msec = 0
                    DrawMarker(24, v.from, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.7, 0, 0, 255, 255, false, false, 0, false)
                    if #(playerCoords - v.from) < 3.0 then
                        ESX.ShowFloatingHelpNotification("~r~[E]~w~ Central de Paleto", vec3(v.to))
    
                        if (IsControlJustPressed(0, 38)) then
                            SetEntityCoords(playerPed, v.to)
                        end
                    end
                end
    
                if #(playerCoords - v.to) < 20.0 then
                    msec = 0
                    DrawMarker(24, v.to, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, false, false, 0, false)
                    if #(playerCoords - v.to) < 3.0 then
                        ESX.ShowFloatingHelpNotification("~r~[E]~w~ Central de LSPD", vec3(v.to))
    
                        if (IsControlJustPressed(0, 38)) then
                            SetEntityCoords(playerPed, v.from)
                        end
                    end
                end
            end
        end
        
        Wait(msec)
    end
end)

CreateThread(function()
    while true do
        local msec = 500

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local playerData = ESX.GetPlayerData()

        if (playerData and playerData.job.name == "police") then
            for i,v in pairs(tpcayoperico) do
                if #(playerCoords - v.from) < 20.0 then
                    msec = 0
                    DrawMarker(24, v.from, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, false, false, 0, false)
                    if #(playerCoords - v.from) < 3.0 then
                        ESX.ShowFloatingHelpNotification("~r~[E]~w~ Central de Cayo Perico", vec3(v.to))
    
                        if (IsControlJustPressed(0, 38)) then
                            SetEntityCoords(playerPed, v.to)
                        end
                    end
                end
    
                if #(playerCoords - v.to) < 20.0 then
                    msec = 0
                    DrawMarker(24, v.to, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, false, false, 0, false)
                    if #(playerCoords - v.to) < 3.0 then
                        ESX.ShowHelpNotification("~r~[E]~w~ TP alquiler de lanchas")
    
                        if (IsControlJustPressed(0, 38)) then
                            SetEntityCoords(playerPed, v.from)
                        end
                    end
                end
            end
        end
        
        Wait(msec)
    end
end)