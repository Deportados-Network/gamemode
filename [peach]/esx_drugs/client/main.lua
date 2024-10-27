local menuOpen = false
local inZoneDrugShop = false
local inRangeMarkerDrugShop = false
local cfgMarker = Config.Marker;

--slow loop
CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distDrugShop = #(coords - Config.CircleZones.DrugDealer.coords)

		inRangeMarkerDrugShop = false
		if(distDrugShop <= Config.Marker.Distance) then
			inRangeMarkerDrugShop = true
		end

		if distDrugShop < 1 then
			inZoneDrugShop = true
		else
			inZoneDrugShop = false
			if menuOpen then
				menuOpen=false
			end
		end

		Wait(500)
	end
end)

--drawk marker
local color = {r = 255, g = 255, b = 255, a = 255}

CreateThread(function()
    while true do 
        local Sleep = 1500
        if inRangeMarkerDrugShop then
            Sleep = 0
            local coordsMarker = Config.CircleZones.DrugDealer.coords
            DrawMarker(
                cfgMarker.Type, coordsMarker.x, coordsMarker.y, coordsMarker.z - 1.0,
                0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
                cfgMarker.Size, color.r, color.g, color.b, color.a,
                false, true, 2, false, nil, nil, false
            )
        end
        Wait(Sleep)
    end
end)


--main loop
CreateThread(function ()
	while true do 
		local Sleep = 1500
		if inZoneDrugShop and not menuOpen then
			Sleep = 0
			ESX.ShowHelpNotification(TranslateCap('dealer_prompt'),true)
			if IsControlJustPressed(0, 38) then
				OpenDrugShop()
			end
		end
	Wait(Sleep)
	end
end)

-- CAMIONETA DE MARIHUANA

local sellingInProgress = false
local deliveryVehicle = nil
local currentDelivery = nil
local deliveryMarker = nil

function StartDrugSelling()
    if sellingInProgress then
        return
    end

    local playerPed = PlayerPedId()

    local playerData = ESX.GetPlayerData()
    local marijuanaCount = 0

    for _, item in pairs(playerData.inventory) do
        if item.name == 'marijuana' and item.count >= 100 then
            marijuanaCount = item.count
            break
        end
    end

    local vehicleHash = GetHashKey("baller6")
    local spawnPoint = vector3(-283.92, 2534.54, 74.67)

    RequestModel(vehicleHash)

    while not HasModelLoaded(vehicleHash) do
        Wait(500)
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == vehicleHash then
        deliveryVehicle = vehicle
    else
        deliveryVehicle = CreateVehicle(vehicleHash, spawnPoint.x, spawnPoint.y, spawnPoint.z, spawnPoint.w, true, false)
        TaskWarpPedIntoVehicle(playerPed, deliveryVehicle, -1)
    end

    sellingInProgress = true

    local deliveryDestination = vector3(1204.65, -3116.99, 5.54)

    deliveryMarker = AddBlipForCoord(deliveryDestination.x, deliveryDestination.y, deliveryDestination.z)
    SetBlipSprite(deliveryMarker, 1)
    SetBlipColour(deliveryMarker, 5)
    SetNewWaypoint(deliveryDestination.x, deliveryDestination.y)

    currentDelivery = {
        vehicle = deliveryVehicle,
        destination = deliveryDestination,
        payment = 1000
    }

    ESX.ShowNotification("Entrega la camioneta de Marihuana al comprador!")

    SetVehicleEngineOn(deliveryVehicle, true, true)

    TriggerEvent('chat:addMessage', {
                template = '<span class="badge badge-staff">{0}</span> {1}',
				args = {'DROGAS', "Se vio una camioneta pasar por ^5Sandy Shores - Iglesia^0 con cargas ilegales!"}
            })
end

function EndDrugSelling()
    if not sellingInProgress then
        return
    end

    local playerPed = PlayerPedId()

    sellingInProgress = false

    local payment = currentDelivery.payment

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey("baller6") and GetVehiclePedIsIn(playerPed, false) == currentDelivery.vehicle then

        local itemToRemove = 'marijuana'
        local itemAmountToRemove = 100

        TriggerServerEvent('esx_inventoryhud:removeItem', itemToRemove, itemAmountToRemove)

        if deliveryMarker then
            RemoveBlip(deliveryMarker)
            deliveryMarker = nil
        end

        if DoesEntityExist(currentDelivery.vehicle) then
            ESX.Game.DeleteVehicle(currentDelivery.vehicle)
        end

        TriggerServerEvent('esx_blackmoney:give', 500000)

        ESX.ShowNotification("Has recibido $500.000 por la venta de Marihuana")
    else
        ESX.ShowNotification("El comprador se fue, no vio la Baller y se asustó!")
        if deliveryMarker then
            RemoveBlip(deliveryMarker)
            deliveryMarker = nil
        end

        if DoesEntityExist(currentDelivery.vehicle) then
            ESX.Game.DeleteVehicle(currentDelivery.vehicle)
        end
    end

    TriggerEvent('chat:addMessage', {
                template = '<span class="badge badge-staff">{0}</span> {1}',
				args = {'DROGAS', "La camioneta de cargas ilegales fue entregada con exito en la ^5Terminal (Puerto)"}
            })
end

function OpenDrugShop()
    local playerData = ESX.GetPlayerData()
    local hasMarijuana = false
    local marijuanaCount = 0

    for _, item in pairs(playerData.inventory) do
        if item.name == 'marijuana' and item.count >= 100 then
            hasMarijuana = true
            marijuanaCount = item.count
            break
        end
    end

	if not hasMarijuana then
	    ESX.ShowNotification("No te dare una camioneta si no tienes 100 de Marihuana!.")
	    return
	end


    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'drug_shop',
        {
            title    = 'Venta de Droga',
            align    = 'right',
            elements = {
                {label = 'Comenzar trayecto de venta', value = 'sell_marijuana'},
            }
        },
        function(data, menu)
            local action = data.current.value

            if action == 'sell_marijuana' then
                menu.close()
                StartDrugSelling()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if sellingInProgress then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local deliveryCoords = currentDelivery.destination

            local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, deliveryCoords.x, deliveryCoords.y, deliveryCoords.z, true)

            if distance < 40.0 then
                DrawMarker(1, deliveryCoords.x, deliveryCoords.y, deliveryCoords.z - 1.0, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 1.0, 255, 255, 255, 200, 0, 1, 2, 0, nil, nil, 0)

                if distance < 1.5 then
                    ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para completar la entrega.")

                    if IsControlJustReleased(0, 38) then
                        EndDrugSelling()
                    end
                end
            end
        end
    end
end)








AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.CloseContext()
		end
	end
end)

function OpenBuyLicenseMenu(licenseName)
	menuOpen = true
	local license = Config.LicensePrices[licenseName]

	local elements = {
		{unselectable = true, title = TranslateCap('purchase_license')},
		{title = ('%s - <span style="color:green;">%s</span>'):format(license.label, TranslateCap('dealer_item', ESX.Math.GroupDigits(license.price))), value = licenseName, price = license.price, licenseName = license.label}
	}

	ESX.OpenContext("right", elements, function(menu,element)
		ESX.TriggerServerCallback('esx_drugs:buyLicense', function(boughtLicense)
			if boughtLicense then
				ESX.CloseContext()
				ESX.ShowNotification(TranslateCap('license_bought', element.licenseName, ESX.Math.GroupDigits(element.price)))
			else
				ESX.ShowNotification(TranslateCap('license_bought_fail', element.licenseName))
			end
		end, element.value)
	end, function(menu)
		menuOpen = false
	end)
end
