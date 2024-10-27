-- @vars
local shopMetadata = {inShop = false, currentVehicle = nil}
ESX = exports['es_extended']:getSharedObject()

-- @threads
CreateThread(function()
    for i,v in pairs(Config.vehicleShops) do
        local blip = AddBlipForCoord(v.enterCoords.xyz)
        SetBlipSprite (blip, 326)
        SetBlipDisplay(blip, 17)
        SetBlipScale  (blip, 0.7) 
        SetBlipColour  (blip, 5) 
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Concesionario VIP")
        EndTextCommandSetBlipName(blip)
    end
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i,v in pairs(Config.vehicleShops) do
            if #(playerCoords - v.enterCoords) < 3 then
                msec = 0
                create3D(vec3(v.enterCoords.xy, v.enterCoords.z+2), "Pulsa ~b~E~w~ para entrar al concesionario")
                if (IsControlJustPressed(0, 38)) then
                    enterVehicleShop(playerPed, v.showingCoords, v.playerFreezeC, v.vehicles, v.cid, v.enterCoords)
                end
            end
        end

        Wait(msec)
    end
end)

-- @funcs
function create3D(coords, text)
    local x, y, z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
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

function enterVehicleShop(playerPed, showingCoords, playerFreeze, vehicleList, vehIndx, enterCoords)
    FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, playerFreeze.xyz)
    SetEntityHeading(playerPed, playerFreeze.w)
    shopMetadata.metadata = {
        showingCoords = showingCoords,
        playerFreeze = playerFreeze,
        vehicleList = vehicleList,
        vehIndx = vehIndx,
        enterCoords = enterCoords
    }
    shopMetadata.inShop = true

    local elements = {}

    for i,v in pairs(vehicleList) do
        table.insert(elements, {label = v.label.." - <span style='color: purple;'>"..v.coins.."v</span>", model = v.model, vehicleShopIdx = vehIndx})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_vip', {
        title = "Tienda vip",
        align = "right",
        elements = elements
    }, function(data, menu)
        local generatedId = math.random(1, 999)
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'vehicle_captchas', {
            title = "Escribe el siguiente numero para confirmar: "..generatedId
        }, function(datas, menus)
            if (tonumber(datas.value) == generatedId) then
                menus.close()
                ESX.TriggerServerCallback('bm_vipdealer:buyVehicle', function(success, model, spawn, heading, plate)
                    if success then
                        shopMetadata.inShop = false
                        menu.close()
                        showroomDelete()
                        FreezeEntityPosition(playerPed, false)
                        SetEntityVisible(playerPed, true)
                        ESX.Game.SpawnVehicle(GetHashKey(model), spawn, heading, function(veh)
                            TaskWarpPedIntoVehicle(playerPed, veh, -1)
                            SetVehicleNumberPlateText(veh, plate)
                        end)
                        ESX.ShowNotification("Gracias por adquirir este vehiculo en nuestro concesionario VIP <3.")
                    else
                        ESX.ShowNotification("No tienes suficiente dinero.")
                    end
                end, data.current.model, exports['esx_vehicleshop']:GeneratePlate(), data.current.vehicleShopIdx)
            else
                menus.close()
                ESX.ShowNotification("Has cancelado la compra.")
            end
        end, function(datas, menus)
            menu.close()
        end)
    end, function(data, menu)
        FreezeEntityPosition(playerPed, false)
        SetEntityVisible(playerPed, true)
        SetEntityCoords(playerPed, vec3(enterCoords.xy, enterCoords.z+1))
        shopMetadata.metadata = nil
        shopMetadata.inShop = false
        menu.close()
    end, function(data, menu)
        showroomDelete()
    
        ESX.Game.SpawnLocalVehicle(data.current.model, vec3(showingCoords.xyz), showingCoords.w, function(veh)
            shopMetadata.currentVehicle = veh
            TaskWarpPedIntoVehicle(playerPed, veh, -1)
            FreezeEntityPosition(veh, true)
            ClearAreaOfVehicles(showingCoords.xyz, 30.0, 0, 0, 0, 0, 0)
        end)
    end)

    showroomDelete()
    
    ESX.Game.SpawnLocalVehicle(elements[1].model or "blista", vec3(showingCoords.xyz), showingCoords.w, function(veh)
        shopMetadata.currentVehicle = veh
        TaskWarpPedIntoVehicle(playerPed, veh, -1)
		FreezeEntityPosition(veh, true)
        ClearAreaOfVehicles(showingCoords.xyz, 30.0, 0, 0, 0, 0, 0)
    end)
end

function showroomDelete()
    DeleteVehicle(shopMetadata.currentVehicle)
    DeleteEntity(shopMetadata.currentVehicle)
    shopMetadata.currentVehicle = nil
end

AddEventHandler('onResourceStop', function(res)
    if (res == GetCurrentResourceName()) then
        showroomDelete()
        if (shopMetadata.inShop) then
            local playerPed = PlayerPedId()
            FreezeEntityPosition(playerPed, false)
            SetEntityVisible(playerPed, true)
            SetEntityCoords(playerPed, vec3(shopMetadata.metadata.enterCoords.xy, shopMetadata.metadata.enterCoords.z+1))
        end
    end
end)