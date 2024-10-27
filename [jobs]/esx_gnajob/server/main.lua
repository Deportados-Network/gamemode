if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'gna', Config.MaxInService)
	end
end

local webhook = "https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-"
function sendToDiscord(name, message, footer)
	local embed = {
		  {
			  ["color"] = 3447003,
			  ["title"] = "**".. name .."**",
			  ["description"] = message
		  }
	  }
  
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Logs Armería", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

TriggerEvent('esx_phone:registerNumber', 'gna', TranslateCap('alert_gna'), true, true)
TriggerEvent('esx_society:registerSociety', 'gna', 'gna', 'society_gna', 'society_gna', 'society_gna', {type = 'public'})

RegisterNetEvent('esx_gnajob:automaticMsg', function(storeName)
	local player = ESX.GetPlayerFromId(source)

	if (player.getJob().name ~= "gna") then
		return
	end

	TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-gna"><i class="fas fa-user"></i> GENDARMERIA</span>&nbsp&nbsp<span class="badge badge-robo"><i class="fas fa-university"></i> '..storeName..'</span>&nbsp&nbspSE CORTAN NEGOCIACIONES, COMIENZAN LOS 10 SEGUNDOS DE GRACIA!!',
        args = {}
    })
	SetTimeout(10000, function()
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<span class="badge badge-gna"><i class="fas fa-user"></i> GENDARMERIA</span>&nbsp&nbsp<span class="badge badge-robo"><i class="fas fa-university"></i> '..storeName..'</span>&nbsp&nbspComienza el TIROTEO!!',
			args = {}
		})
	end)
end)

AddEventHandler('onResourceStart', function(res)
	if (res ~= GetCurrentResourceName()) then return end

	exports.ox_inventory:RegisterStash("society_gna", "Inventario de la GNA", 600, 300000000, "GNA")
end)

RegisterNetEvent('esx_gnajob:buyWeapon', function(name, price, ammo, quantity)
	local player = ESX.GetPlayerFromId(source)

	if (player.getJob().name == "gna") then
		local quant = (quantity or 1)
		if (player.getAccount("bank").money >= price*quant) then
			player.removeAccountMoney("bank", price*quant)
			player.addInventoryItem(name, quant)
			if (ammo) then
				player.addInventoryItem(ammo, 50)
			end
			sendToDiscord("Nuevo Item", ("Jugador: %s\nRango: %s\nArma/Item: %s\nIdentifier: %s"):format(GetPlayerName(source).." ["..source.."]", player.getJob().grade_label, name, player.identifier))
		else
			TriggerClientEvent('ox_lib:cl:notification', player.source, "Error", "No tienes suficiente dinero.", "error")
		end
	end
end)

RegisterNetEvent('esx_gnajob:washMoney', function()
	local player = ESX.GetPlayerFromId(source)
	local blackMoney = player.getAccount('black_money').money

	local ranks = {
		"subCoronel",
		"coronel",
		"instructor",
		"SubJefe",
		"Jefe"


	}

	local isRank = false
	for i,v in pairs(ranks) do
		if (player.getJob().grade_name == v) then
			isRank = true
			break
		end
	end

	if (not isRank) then return DropPlayer(source, "Hacker") end

	if (blackMoney) then
		player.removeAccountMoney('black_money', blackMoney)
		player.addMoney(blackMoney)
	else
		player.showNotification("No tienes dinero negro.")
	end
end)

RegisterNetEvent('esx_policejob:automaticMsg', function(storeName)
	local player = ESX.GetPlayerFromId(source)

	if (player.getJob().name ~= "gna") then
		return
	end

	TriggerClientEvent('chat:addMessage', -1, {
        template = '<span class="badge badge-gna">GENDARMERIA</span>&nbsp&nbsp<span class="badge badge-robo"><i class="fas fa-university"></i> '..storeName..'</span>&nbsp&nbspSE CORTAN NEGOCIACIONES, COMIENZAN LOS 10 SEGUNDOS DE GRACIA!!',
        args = {}
    })
	SetTimeout(10000, function()
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<span class="badge badge-gna">GENDARMERIA</span>&nbsp&nbsp<span class="badge badge-robo"><i class="fas fa-university"></i> '..storeName..'</span>&nbsp&nbspComienza el TIROTEO!!',
			args = {}
		})
	end)
end)

RegisterNetEvent('esx_gnajob:getAmmo', function(ammo)
	local player = ESX.GetPlayerFromId(source)

	if (player.getJob().name ~= "gna") then
		print(("[INFO] [HACKER] %s intentó obtener munición de la policía."):format(player.identifier))
		return DropPlayer(source, "¿Dónde vas intentando usar esto?")
	end

	sendToDiscord("Munición", ("Jugador: %s\nRango: %s\nTipo de munición: %s\nIdentifier: %s"):format(GetPlayerName(source).." ["..source.."]", player.getJob().grade_label, ammo, player.identifier))
	player.addInventoryItem(ammo, 50)
end)

ESX.RegisterServerCallback('esx_gnajob:getRobs', function(playerId, callback)
	exports["esx_holdup"]:getRobs(function(robs)
		local stores = {}
	
		for i,v in pairs(robs) do
			table.insert(stores, {nameOfStore = v.nameOfStore, isRobbed = v.isRobbed, coords = v.position, family = v.family})
		end
	
		callback(stores)
	end)
end)

RegisterNetEvent('esx_gnajob:confiscatePlayerItem')
AddEventHandler('esx_gnajob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local source = source
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'gna' then
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit The Confuscation System!'):format(sourceXPlayer.source))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				sourceXPlayer.showNotification(TranslateCap('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				targetXPlayer.showNotification(TranslateCap('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			else
				sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
			end
		else
			sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		local targetAccount = targetXPlayer.getAccount(itemName)

		-- does the target player have enough money?
		if targetAccount.money >= amount then
			targetXPlayer.removeAccountMoney(itemName, amount, "Confiscated")
			sourceXPlayer.addAccountMoney   (itemName, amount, "Confiscated")

			sourceXPlayer.showNotification(TranslateCap('you_confiscated_account', amount, itemName, targetXPlayer.name))
			targetXPlayer.showNotification(TranslateCap('got_confiscated_account', amount, itemName, sourceXPlayer.name))
		else
			sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
		end

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end

		-- does the target player have weapon?
		if targetXPlayer.hasWeapon(itemName) then
			targetXPlayer.removeWeapon(itemName)
			sourceXPlayer.addWeapon   (itemName, amount)

			sourceXPlayer.showNotification(TranslateCap('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
			targetXPlayer.showNotification(TranslateCap('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
		else
			sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
		end
	end
end)

RegisterNetEvent('esx_gnajob:handcuff')
AddEventHandler('esx_gnajob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'gna' then
		TriggerClientEvent('esx_gnajob:handcuff', target)
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Handcuffs!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_gnajob:drag')
AddEventHandler('esx_gnajob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'gna' then
		TriggerClientEvent('esx_gnajob:drag', target, source)
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Dragging!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_gnajob:putInVehicle')
AddEventHandler('esx_gnajob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'gna' then
		TriggerClientEvent('esx_gnajob:putInVehicle', target)
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Garage!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_gnajob:OutVehicle')
AddEventHandler('esx_gnajob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'gna' then
		TriggerClientEvent('esx_gnajob:OutVehicle', target)
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Dragging Out Of Vehicle!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_gnajob:getStockItem')
AddEventHandler('esx_gnajob:getStockItem', function(itemName, count)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gna', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(TranslateCap('have_withdrawn', count, inventoryItem.name))
			else
				xPlayer.showNotification(TranslateCap('quantity_invalid'))
			end
		else
			xPlayer.showNotification(TranslateCap('quantity_invalid'))
		end
	end)
end)

RegisterNetEvent('esx_gnajob:putStockItems')
AddEventHandler('esx_gnajob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gna', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(TranslateCap('have_deposited', count, inventoryItem.name))
		else
			xPlayer.showNotification(TranslateCap('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_gnajob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	if notify then
		xPlayer.showNotification(TranslateCap('being_searched'))
	end

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		if Config.EnableESXIdentity then
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')

			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	end
end)

ESX.RegisterServerCallback('esx_gnajob:getFineList', function(source, cb, category)
	MySQL.query('SELECT * FROM fine_types WHERE category = ?', {category},
	function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_gnajob:getVehicleInfos', function(source, cb, plate)
	local retrivedInfo = {
		plate = plate
	}
	if Config.EnableESXIdentity then
		MySQL.single('SELECT users.firstname, users.lastname FROM owned_vehicles JOIN users ON owned_vehicles.owner = users.identifier WHERE plate = ?', {plate},
		function(result)
			if result then
				retrivedInfo.owner = ('%s %s'):format(result.firstname, result.lastname)
			end
			cb(retrivedInfo)
		end)
	else
		MySQL.scalar('SELECT owner FROM owned_vehicles WHERE plate = ?', {plate},
		function(owner)
			if owner then
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)
				if xPlayer then
					retrivedInfo.owner = xPlayer.getName()
				end
			end
			cb(retrivedInfo)
		end)
	end
end)

ESX.RegisterServerCallback('esx_gnajob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_gna', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_gnajob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_gna', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
		end)
end)

ESX.RegisterServerCallback('esx_gnajob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_gna', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_gnajob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Buy Invalid Weapon - ^5%s^7!'):format(source, weaponName))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price, "Weapon Bought")
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)
			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price, "Weapon Component Bought")
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('[^3WARNING^7] Player ^5%s^7 Attempted To Buy Invalid Weapon Component - ^5%s^7!'):format(source, componentNum))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_gnajob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Buy Invalid Vehicle - ^5%s^7!'):format(source, vehicleProps.model))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price, "Job Vehicle Bought")

			MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (?, ?, ?, ?, ?, ?)', { xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, xPlayer.job.name, true},
			function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_gnajob:storeNearbyVehicle', function(source, cb, plates)
	local xPlayer = ESX.GetPlayerFromId(source)

	local plate = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE owner = ? AND plate IN (?) AND job = ?', {xPlayer.identifier, plates, xPlayer.job.name})

	if plate then
		MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?', {xPlayer.identifier, plate, xPlayer.job.name},
		function(rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(plate)
			end
		end)
	else
		cb(false)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for i = 1, #vehicles do
		local vehicle = vehicles[i]
		if GetHashKey(vehicle.model) == vehicleHash then
			return vehicle.price
		end
	end

	return 0
end

ESX.RegisterServerCallback('esx_gnajob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gna', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_gnajob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

AddEventHandler('playerDropped', function()
	local playerId = source
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer and xPlayer.job.name == 'gna' then
			Wait(5000)
			TriggerClientEvent('esx_gnajob:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('esx_gnajob:spawned')
AddEventHandler('esx_gnajob:spawned', function()
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'gna' then
		Wait(5000)
		TriggerClientEvent('esx_gnajob:updateBlip', -1)
	end
end)

RegisterNetEvent('esx_gnajob:forceBlip')
AddEventHandler('esx_gnajob:forceBlip', function()
	for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'gna')) do
		TriggerClientEvent('esx_gnajob:updateBlip', xPlayer.source)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Wait(5000)
		for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'gna')) do
			TriggerClientEvent('esx_gnajob:updateBlip', xPlayer.source)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'gna')
	end
end)

--gnajob conectados santi

ESX.RegisterServerCallback('esx_gnajob:getPolicePlayers', function(source, cb)
    local gnaPlayers = {}

    for _, player in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(player)

        if xPlayer and xPlayer.job and xPlayer.job.name == 'gna' then
            table.insert(gnaPlayers, {id = xPlayer.source, name = xPlayer.getName()})
        end
    end

    cb(gnaPlayers)
end)
