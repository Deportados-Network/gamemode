
ESX = exports["es_extended"]:getSharedObject()

local CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged, isInShopMenu = false, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
end

function SendToCommunityService(community_services_count)
    TriggerServerEvent("esx_CommunityService:sendToCommunityService", community_services_count)
end

CreateThread(function()
	while true do
		local msec = 1000

		local ranks = {
			"boss",
			"subjefe",
			"comisariogeneral",
			"comisariomayor"
		}

		local playerPed = PlayerPedId()
		local playerPos = GetEntityCoords(playerPed)

		for i,v in pairs(ranks) do
			if (ESX.PlayerData and ESX.PlayerData.job) then
				local playerGradeName = ESX.PlayerData.job.grade_name
				if playerGradeName == v and #(playerPos - Config.WashMoneyLocation) < 7 then
					msec = 0
					DrawMarker(1, Config.WashMoneyLocation, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 120, false, false, 0, false)
					
					if playerGradeName == v and #(playerPos - Config.WashMoneyLocation) < 1.5 then
						ESX.ShowHelpNotification("Pulsa ~INPUT_CONTEXT~ para lavar dinero")
			
						if (IsControlJustPressed(0, 38)) then
							TriggerServerEvent('esx_policejob:washMoney')
						end
					end
				end
			end
		end

		Wait(msec)
	end
end)

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		
		sex = (skin.sex == 0) and "male" or "female"

		uniformObject = Config.Uniforms[uniform][sex]

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)

			if uniform == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			ESX.ShowNotification(TranslateCap('no_outfit'))
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	exports['ox_lib']:registerContext({
		id = "police_wear",
		title = "Vestuario de la policia",
		options = {
			{title = "Ropa de civil", icon = "fas fa-tshirt", onSelect = function()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
					SetPedArmour(playerPed, 0)
                end)
			end},
			{title = "Uniforme", icon = "fas fa-tshirt", onSelect = function()
				setUniform(ESX.PlayerData.job.grade_name, playerPed)
				SetPedArmour(playerPed, 0)
			end},
			{title = "Chaleco antibalas", icon = "fas fa-tshirt", onSelect = function()
				setUniform('antibalas', playerPed)
				SetPedArmour(playerPed, 100)
			end}
		}
	})
	exports['ox_lib']:showContext("police_wear")
end

function OpenArmoryMenu(station)
	exports['ox_lib']:registerContext({
		id = "police_armory",
		title = "Armería de la policia",
		options = {

			{title = "Tienda policial", icon = "fas fa-shopping-cart", onSelect = function()
				exports.ox_inventory:openInventory('shop', { type = 'PoliceArmoury', id = 1 })
			end},
			{title = "Inventario general", icon = "fas fa-box-open", onSelect = function()
				exports.ox_inventory:openInventory('stash', {id = 'society_police', owner = station})
			end}
		}
	})
	exports['ox_lib']:showContext("police_armory")
	return ESX.CloseContext()
end

RegisterNetEvent('ox_lib:cl:notification', function(title, description, type)
	exports['ox_lib']:notify({
		title = title,
		description = description,
		type = type
	})
end)

function openBuyWeaponsMenu(station)
	local elements = {}
	local playerLevel = ESX.GetPlayerData().job.grade

	for i,v in pairs(Config.PoliceStations[station].Weapons[playerLevel]) do
		table.insert(elements, {title = v.label, icon = "gun", onSelect = function()
			if (v.ammo) then
				exports['ox_lib']:registerContext({
					id = "weapon_submenu",
					title = "Selecciona una opción",
					menu = "police_armory_buy",
					options = {
						{title = "Agarrar arma", icon = "fas fa-shopping-cart", onSelect = function()
							TriggerServerEvent('esx_policejob:buyWeapon', v.name, v.price, v.ammo)
						end},
						{title = "Agarrar munición", icon = "fas fa-shopping-cart", onSelect = function()
							TriggerServerEvent('esx_policejob:getAmmo', v.ammo)
						end},
					}
				})
				exports['ox_lib']:showContext("weapon_submenu")
			else
				TriggerServerEvent('esx_policejob:buyWeapon', v.name, v.price, v.ammo)
			end
		end})
	end

	exports['ox_lib']:registerContext({
		id = "police_armory_buy",
		title = "Armería de la policia",
		options = elements
	})

	exports['ox_lib']:showContext("police_armory_buy")
end

function openBuyAccesoriesMenu(station)
	local elements = {}

	for i,v in pairs(Config.PoliceStations[station].Accesories) do
		table.insert(elements, {title = v.label, icon = "gun", onSelect = function()
			TriggerServerEvent('esx_policejob:buyWeapon', v.name, v.price, v.ammo, v.quantity)
		end})
	end

	exports['ox_lib']:registerContext({
		id = "police_accesories_buy",
		title = "Comprar accesorios",
		options = elements
	})

	exports['ox_lib']:showContext("police_accesories_buy")
end


function OpenPoliceActionsMenu()
    local elements = {
        {label = "Interacción ciudadana", value = "citizen_interaction"},
        {label = "Robos", value = "robbery"},
        {label = "Mensaje programado", value = "send_message"},
        {label = "Interacción con vehículos", value = "vehicle_interaction"},
        {label = "Spawnear objetos", value = "spawn_objects"}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_police_menu', {
        title    = 'Policia',
        align    = 'right',
        elements = elements
    }, function(data, menu)
        local action = data.current.value

        if action == "citizen_interaction" then
            OpenCitizenInteractionMenu()
 elseif action == "robbery" then
    ESX.TriggerServerCallback('esx_policejob:getRobs', function(stores)
        local ox = exports['ox_lib']
        local opts = {}
        local shopOpts = {}
        local bankOpts = {}

        table.insert(opts, {title = "Tiendas", menu = "show_shops", icon = "fas fa-store"})
        table.insert(opts, {title = "Bancos", menu = "show_banks", icon = "fas fa-university"})
        for i,v in pairs(stores) do
            if (v.family == "shop") then
                table.insert(shopOpts, {title = v.nameOfStore, onSelect = function()
                    SetNewWaypoint(v.coords.x, v.coords.y)
                    ESX.ShowNotification("Se ha marcado el robo en el GPS")
                end, icon = (v.isRobbed and "fas fa-exclamation-triangle" or "fas fa-store"), metadata = {(v.isRobbed and "En Progreso" or "Libre")}})
            elseif (v.family == "bank") then
                table.insert(bankOpts, {title = v.nameOfStore, onSelect = function()
                    SetNewWaypoint(v.coords.x, v.coords.y)
                    ESX.ShowNotification("Se ha marcado el robo en el GPS")
                end, icon = (v.isRobbed and "fas fa-exclamation-triangle" or "fas fa-university"), metadata = {(v.isRobbed and "En Progreso" or "Libre")}})
            end
        end

        ox:registerContext({
            id = "show_shops",
            title = "Tiendas",
            menu = "robs",
            options = shopOpts
        })

        ox:registerContext({
            id = "show_banks",
            title = "Bancos",
            menu = "robs",
            options = bankOpts
        })

        ox:registerContext({
            id = "robs",
            title = "Robos",
            options = opts
        })

        ox:showContext("robs")
    end)

        elseif action == "send_message" then
            local input = ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'send_message_menu', {
                title = 'Mensaje programado'
            }, function(data2, menu2)
                menu2.close()
                TriggerServerEvent('esx_policejob:automaticMsg', data2.value)
            end, function(data2, menu2)
                menu2.close()
            end)
        	--
        elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'), value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'), value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('impound'), value = 'impound'})
			end

			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = _U('vehicle_interaction'),
				align    = 'right',
				elements = elements
			}, function(data2, menu2)
				local coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value

				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					if action == 'vehicle_infos' then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
							executecommand("do tu madre")
						end
					elseif action == 'impound' then
						-- is the script busy?
						if currentTask.busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

						currentTask.busy = true
						currentTask.task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)

						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while currentTask.busy do
								Citizen.Wait(1000)

								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and currentTask.busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(currentTask.task)
									ClearPedTasks(playerPed)
									currentTask.busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end)
          --
        elseif action == "spawn_objects" then
            local elements4 = {
                {unselectable = true, label = "Objetos"},
                {label = "Cono", value = "cone", model = 'prop_roadcone02a'},
                {label = "Barrera", value = "barrier", model = 'prop_barrier_work05'},
                {label = "Púas", value = "spikestrips", model = 'p_ld_stinger_s'},
                {label = "Caja", value = "box", model = 'prop_boxpile_07d'},
                {label = "Dinero", value = "cash", model = 'hei_prop_cash_crate_half_full'}
            }

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_objects_menu', {
                title    = 'Spawnear objetos',
                align    = 'right',
                elements = elements4
            }, function(data4, menu4)
                local data2 = {current = data4}
                local playerPed = PlayerPedId()
                local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
                local objectCoords = (coords + forward * 1.0)

                ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
                    SetEntityHeading(obj, GetEntityHeading(playerPed))
                    PlaceObjectOnGroundProperly(obj)
                end)

                menu4.close()
            end, function(data4, menu4)
                menu4.close()
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end


function OpenCitizenInteractionMenu()
    local elements = {
        {label = "Documento de identidad", value = "show_id"},
        {label = "Cachear", value = "search"},
        {label = "Esposar", value = "handcuff"},
        {label = "Escoltar", value = "escort"},
        {label = 'Vehiculo', value = "vehicle_interaction"},
        {label = "Multas", value = "fines"},
        {label = "Multas impagadas", value = "unpaid_fines"},
        {label = "Servicio Comunitario", value = "community_service"},
        {label = "Ver Policias conectados", value = "view_police_players"}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction_menu', {
        title    = 'Interacción ciudadana',
        align    = 'right',
        elements = elements
    }, function(data, menu)
        local action = data.current.value
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if action == "show_id" then
            OpenIdentityCardMenu(closestPlayer)
        elseif action == "search" then
            OpenBodySearchMenu(closestPlayer)
        elseif action == "handcuff" then
            TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
        elseif action == "escort" then
            TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
        elseif action == "vehicle_interaction" then
            OpenVehicleInteractionMenu()
        elseif action == "fines" then
            ESX.TriggerServerCallback('esx_policejob:getFineTypes', function(fineTypes)
                local finesMenu = {}

                for _, fine in ipairs(fineTypes) do
                    local priceLabel = '<span style="color: red;">$' .. fine.amount .. '</span>'
                    table.insert(finesMenu, {
                        label = fine.label .. ' - ' .. priceLabel,
                        value = 'fine_' .. fine.id,
                        amount = fine.amount,
                    })
                end

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fines_menu', {
                    title    = 'Multas',
                    align    = 'right',
                    elements = finesMenu
                }, function(data2, finesMenu)
                    local fineId = tonumber(data2.current.value:match('%d+'))
                    local fineAmount = data2.current.amount

                    -- En lugar de pagar la multa directamente, enviaremos la multa al servidor
                    TriggerServerEvent('esx_policejob:applyFine', GetPlayerServerId(closestPlayer), fineId, fineAmount)

                    finesMenu.close()
                end, function(data2, finesMenu)
                    finesMenu.close()
                end)
            end)
        elseif action == "unpaid_fines" then
            -- Implementa la lógica para multas impagadas
        elseif action == "community_service" then
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Menú de servicio comunitario', {
                    title = "Menú de servicio comunitario",
                }, function (data2, menu)
                    local community_services_count = tonumber(data2.value)

                    if community_services_count == nil then
                        ESX.ShowNotification('Cantidad de Servicio comunitario inválida')
                    else
                        local affectedPlayerId = GetPlayerServerId(closestPlayer)
                        local senderName = GetPlayerName(PlayerId())
                        TriggerServerEvent("esx_communityservice:sendToCommunityServicess", affectedPlayerId, community_services_count)
                    end

                    menu.close()
                end, function (data2, menu)
                    menu.close()
                end)
            end
        elseif action == "view_police_players" then
            if not isSubMenuOpen then
                isSubMenuOpen = true
                ESX.TriggerServerCallback('esx_policejob:getPolicePlayers', function(policePlayers)
                    local playerList = {}
                    for _, player in ipairs(policePlayers) do
                        local playerNameWithId = string.format("[%s] %s", player.id, player.name)
                        table.insert(playerList, {label = playerNameWithId, value = player.id})
                    end

                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_players_menu', {
                        title    = 'Jugadores con rango de policía',
                        align    = 'right',
                        elements = playerList
                    }, function(data, subMenu)
                        
                    end, function(data, subMenu)
                        subMenu.close()
                        isSubMenuOpen = false  
                    end)
                end)
            end
        end

        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end






function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {
			{icon = "fas fa-user", title = TranslateCap('name', data.name)},
			{icon = "fas fa-user", title = TranslateCap('job', ('%s - %s'):format(data.job, data.grade))}
		}

		if Config.EnableESXIdentity then
			elements[#elements+1] = {icon = "fas fa-user", title = TranslateCap('sex', TranslateCap(data.sex))}
			elements[#elements+1] = {icon = "fas fa-user", title = TranslateCap('sex', TranslateCap(data.sex))}
			elements[#elements+1] = {icon = "fas fa-user", title = TranslateCap('height', data.height)}
		end

		if Config.EnableESXOptionalneeds and data.drunk then
			elements[#elements+1] = {title = TranslateCap('bac', data.drunk)}
		end

		if data.licenses then
			elements[#elements+1] = {title = TranslateCap('license_label')}

			for i=1, #data.licenses, 1 do
				elements[#elements+1] = {title = data.licenses[i].label}
			end
		end

		ESX.OpenContext("right", elements, nil, function(menu)
			OpenPoliceActionsMenu()	
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu(player)
	if Config.OxInventory then
		ESX.CloseContext()
		exports.ox_inventory:openInventory('player', GetPlayerServerId(player))
		return
	end

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {
			{unselectable = true, icon = "fas fa-user", title = TranslateCap('search')}
		}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				elements[#elements+1] = {
					icon = "fas fa-money",
					title    = TranslateCap('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				}
				break
			end
		end

		table.insert(elements, {label = TranslateCap('guns_label')})

		for i=1, #data.weapons, 1 do
			elements[#elements+1] = {
				icon = "fas fa-gun",
				title    = TranslateCap('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			}
		end

		elements[#elements+1] = {title = TranslateCap('inventory_label')}

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				elements[#elements+1] = {
					icon = "fas fa-box",
					title    = TranslateCap('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				}
			end
		end

		ESX.OpenContext("right", elements, function(menu,element)
			local data = {current = element}
			if data.current.value then
				TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end)
	end, GetPlayerServerId(player))
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bill_name', {
		title = "Razón"
	}, function(data, menu)
		menu.close()
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'bill_price', {
			title = "Precio"
		}, function(data2, menu2)
			menu2.close()

			exports['bm_security']:call('esx_billing:sendBill', true, GetPlayerServerId(player), 'society_police', data.value, tonumber(data2.value))
		end)
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
		local elements = {
			{unselectable = true, icon = "fas fa-scroll", title = TranslateCap('fine')}
		}

		for k,fine in ipairs(fines) do
			elements[#elements+1] = {
				icon = "fas fa-scroll",
				title     = ('%s <span style="color:green;">%s</span>'):format(fine.label, TranslateCap('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			}
		end

		ESX.OpenContext("right", elements, function(menu,element)
			local data = {current = element}
			if Config.EnablePlayerManagement then
				exports['bm_security']:call('esx_billing:sendBill', true, GetPlayerServerId(player), 'society_police', TranslateCap('fine_total', data.current.fineLabel), data.current.amount)
			else
				exports['bm_security']:call('esx_billing:sendBill', true, GetPlayerServerId(player), '', TranslateCap('fine_total', data.current.fineLabel), data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end)
	end, category)
end

function LookupVehicle()
	local elements = {
		{unselectable = true, icon = "fas fa-car", title = "Base de datos"},
		{title = "Matricula", input = true, inputType = "text", inputPlaceholder = "ABC 123"},
		{icon = "fas fa-check-double", title = "Buscar", value = "lookup"}
	}

	ESX.OpenContext("right", elements, function(menu,element)
		local data = {value = menu.eles[2].inputValue}
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(TranslateCap('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
				local elements = {
					{unselectable = true, icon = "fas fa-car", title = element.title},
					{unselectable = true, icon = "fas fa-car", title = TranslateCap('plate', retrivedInfo.plate)}			
				}

				if not retrivedInfo.owner then
					elements[#elements+1] = {unselectable = true, icon = "fas fa-user", title = TranslateCap('owner_unknown')}
				else
					elements[#elements+1] = {unselectable = true, icon = "fas fa-user", title = TranslateCap('owner', retrivedInfo.owner)}
				end

				ESX.OpenContext("right", elements, nil, function(menu)
					OpenPoliceActionsMenu()
				end)
			end, data.value)
		end
	end)
end

function ShowPlayerLicense(player)
	local elements = {
		{unselectable = true, icon = "fas fa-scroll", title = TranslateCap('license_revoke')}
	}

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					elements[#elements+1] = {
						icon = "fas fa-scroll",
						title = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					}
				end
			end
		end

		ESX.OpenContext("right", elements, function(menu,element)
			local data = {current = element}
			ESX.ShowNotification(TranslateCap('licence_you_revoked', data.current.label, playerData.name))
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), TranslateCap('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end)
	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {
		{unselectable = true, icon = "fas fa-scroll", title = TranslateCap('unpaid_bills')}
	}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			elements[#elements+1] = {
				unselectable = true,
				icon = "fas fa-scroll",
				title = ('%s - <span style="color:red;">%s</span>'):format(bill.label, TranslateCap('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			}
		end

		ESX.OpenContext("right", elements, nil, nil)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
		local elements = {
			{unselectable = true, icon = "fas fa-car", title = TranslateCap('vehicle_info')},
			{icon = "fas fa-car", title = TranslateCap('plate', retrivedInfo.plate)}
			
		}

		if not retrivedInfo.owner then
			elements[#elements+1] = {unselectable = true, icon = "fas fa-user", title = TranslateCap('owner_unknown')}
		else
			elements[#elements+1] = {unselectable = true, icon = "fas fa-user", title = TranslateCap('owner', retrivedInfo.owner)}
		end

		ESX.OpenContext("right", elements, nil, nil)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
		local elements = {
			{unselectable = true, icon = "fas fa-gun", title = TranslateCap('get_weapon_menu')}
		}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				elements[#elements+1] = {
					icon = "fas fa-gun",
					title = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				}
			end
		end

		ESX.OpenContext("right", elements, function(menu,element)
			local data = {current = element}
			ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
				ESX.CloseContext()
				OpenGetWeaponMenu()
			end, data.current.value)
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {
		{unselectable = true, icon = "fas fa-gun", title = TranslateCap('put_weapon_menu')}
	}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = joaat(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			elements[#elements+1] = {
				icon = "fas fa-gun",
				title = weaponList[i].label,
				value = weaponList[i].name
			}
		end
	end

	ESX.OpenContext("right", elements, function(menu,element)
		local data = {current = element}
		ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
			ESX.CloseContext()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end)
end

function OpenBuyWeaponsMenu()
	local elements = {
		{unselectable = true, icon = "fas fa-gun", title = TranslateCap('armory_weapontitle')}
	}
	local playerPed = PlayerPedId()

	for k,v in ipairs(Config.AuthorizedWeapons[ESX.PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local components, label = {}
		local hasWeapon = HasPedGotWeapon(playerPed, joaat(v.weapon), false)

		if v.components then
			for i=1, #v.components do
				if v.components[i] then
					local component = weapon.components[i]
					local hasComponent = HasPedGotWeaponComponent(playerPed, joaat(v.weapon), component.hash)

					if hasComponent then
						label = ('%s: <span style="color:green;">%s</span>'):format(component.label, TranslateCap('armory_owned'))
					else
						if v.components[i] > 0 then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, TranslateCap('armory_item', ESX.Math.GroupDigits(v.components[i])))
						else
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, TranslateCap('armory_free'))
						end
					end

					components[#components+1] = {
						icon = "fas fa-gun",
						title = label,
						componentLabel = component.label,
						hash = component.hash,
						name = component.name,
						price = v.components[i],
						hasComponent = hasComponent,
						componentNum = i
					}
				end
			end
		end

		if hasWeapon and v.components then
			label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		elseif hasWeapon and not v.components then
			label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, TranslateCap('armory_owned'))
		else
			if v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, TranslateCap('armory_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, TranslateCap('armory_free'))
			end
		end

		elements[#elements+1] = {
			icon = "fas fa-gun",
			title = label,
			weaponLabel = weapon.label,
			name = weapon.name,
			components = components,
			price = v.price,
			hasWeapon = hasWeapon
		}
	end

	ESX.OpenContext("right", elements, function(menu,element)
		local data = {current = element}
		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(TranslateCap('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(TranslateCap('armory_money'))
				end
			end, data.current.name, 1)
		end
	end)
end

function OpenWeaponComponentShop(components, weaponName, parentShop)

	ESX.OpenContext("right", components, function(menu,element)
		local data = {current = element}
		if data.current.hasComponent then
			ESX.ShowNotification(TranslateCap('armory_hascomponent'))
		else
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(TranslateCap('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					parentShop.close()
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(TranslateCap('armory_money'))
				end
			end, weaponName, 2, data.current.componentNum)
		end
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
		local elements = {
			{unselectable = true, icon = "fas fa-box", title = TranslateCap('police_stock')}
		}

		for i=1, #items, 1 do
			elements[#elements+1] = {
				icon = "fas fa-box",
				title = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			}
		end

		ESX.OpenContext("right", elements, function(menu,element)
			local data = {current = element}
			local itemName = data.current.value

			local elements2 = {
				{unselectable = true, icon = "fas fa-box", title = element.title},
				{title = TranslateCap('quantity'), input = true, inputType = "number", inputMin = 1, inputMax = 150, inputPlaceholder = "Amount to withdraw.."},
				{icon = "fas fa-check-double", title = "Confirm", value = "confirm"}
			}

			ESX.OpenContext("right", elements2, function(menu2,element2)
				local data2 = {value = menu2.eles[2].inputValue}
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification(TranslateCap('quantity_invalid'))
				else
					ESX.CloseContext()
					TriggerServerEvent('esx_policejob:getStockItem', itemName, count)

					Wait(300)
					OpenGetStocksMenu()
				end
			end)
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
		local elements = {
			{unselectable = true, icon = "fas fa-box", title = TranslateCap('inventory')}
		}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				elements[#elements+1] = {
					icon = "fas fa-box",
					title = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				}
			end
		end

		ESX.OpenContext("right", elements, function(menu,element)
			local data = {current = element}
			local itemName = data.current.value

			local elements2 = {
				{unselectable = true, icon = "fas fa-box", title = element.title},
				{title = TranslateCap('quantity'), input = true, inputType = "number", inputMin = 1, inputMax = 150, inputPlaceholder = "Amount to withdraw.."},
				{icon = "fas fa-check-double", title = "Confirm", value = "confirm"}
			}

			ESX.OpenContext("right", elements2, function(menu2,element2)
				local data2 = {value = menu2.eles[2].inputValue}
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification(TranslateCap('quantity_invalid'))
				else
					ESX.CloseContext()
					TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

					Wait(300)
					OpenPutStocksMenu()
				end
			end)
		end)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if job.name == 'police' then
		Wait(1000)
		TriggerServerEvent('esx_policejob:forceBlip')
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = TranslateCap('phone_police'),
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTV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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.EnableESXService and not playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = TranslateCap('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = TranslateCap('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = TranslateCap('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = TranslateCap('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = TranslateCap('open_bossmenu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.CloseContext()
	end

	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = TranslateCap('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == `p_ld_stinger_s` then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		RemoveAnimDict('mp_arresting')

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)

		if Config.EnableHandcuffTimer then
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end

			StartHandcuffTimer()
		end
	else
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
	if isHandcuffed then
		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

CreateThread(function()
	local wasDragged

	while true do
		local Sleep = 1500

		if isHandcuffed and dragStatus.isDragged then
			Sleep = 50
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(ESX.PlayerData.ped, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(ESX.PlayerData.ped, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(ESX.PlayerData.ped, true, false)
		end
	Wait(Sleep)
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local vehicle, distance = ESX.Game.GetClosestVehicle()

		if vehicle and distance < 5 then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local GetVehiclePedIsIn = GetVehiclePedIsIn
	local IsPedSittingInAnyVehicle = IsPedSittingInAnyVehicle
	local TaskLeaveVehicle = TaskLeaveVehicle
	if IsPedSittingInAnyVehicle(ESX.PlayerData.ped) then
		local vehicle = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
		TaskLeaveVehicle(ESX.PlayerData.ped, vehicle, 64)
	end
end)

-- Handcuff
CreateThread(function()
	local DisableControlAction = DisableControlAction
	local IsEntityPlayingAnim = IsEntityPlayingAnim
	while true do
		local Sleep = 1000

		if isHandcuffed then
			Sleep = 0
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(ESX.PlayerData.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
					RemoveAnimDict('mp_arresting')
				end)
			end
		end
	Wait(Sleep)
	end
end)

-- Draw markers and more
CreateThread(function()
	while true do
		local Sleep = 1500
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			Sleep = 500
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited = false, false
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.PoliceStations) do
				for i=1, #v.Cloakrooms, 1 do
					local distance = #(playerCoords - v.Cloakrooms[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Cloakrooms, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						Sleep = 0
						
						if distance < Config.MarkerSize.x then
							ESX.ShowFloatingHelpNotification((CurrentActionMsg or "cargando"), vec3(v.Cloakrooms[i].xy, v.Cloakrooms[i].z+0.3))
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
						end
					end
				end
				
				for i=1, #v.Armories, 1 do
					local distance = #(playerCoords - v.Armories[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Armories, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						Sleep = 0
						
						if distance < Config.MarkerSize.x then
							ESX.ShowFloatingHelpNotification((CurrentActionMsg or "cargando"), vec3(v.Armories[i].xy, v.Armories[i].z+0.3))
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
						end
					end
				end

				if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						local distance = #(playerCoords - v.BossActions[i])

						if distance < Config.DrawDistance then
							DrawMarker(Config.MarkerType.BossActions, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							Sleep = 0
							
							if distance < Config.MarkerSize.x then
								ESX.ShowFloatingHelpNotification((CurrentActionMsg or "cargando"), vec3(v.BossActions[i].xy, v.BossActions[i].z+0.3))
								isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
							end
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end
		end
	Wait(Sleep)
	end
end)

-- Enter / Exit entity zone events
CreateThread(function()
	local trackedEntities = {
		`prop_roadcone02a`,
		`prop_barrier_work05`,
		`p_ld_stinger_s`,
		`prop_boxpile_07d`,
		`hei_prop_cash_crate_half_full`
	}

	while true do
		local Sleep = 1500

			local GetEntityCoords = GetEntityCoords
			local GetClosestObjectOfType = GetClosestObjectOfType
			local DoesEntityExist = DoesEntityExist
			local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
	
			local closestDistance = -1
			local closestEntity   = nil

			for i=1, #trackedEntities, 1 do
				local object = GetClosestObjectOfType(playerCoords, 3.0, trackedEntities[i], false, false, false)

				if DoesEntityExist(object) then
					Sleep = 500
					local objCoords = GetEntityCoords(object)
					local distance = #(playerCoords - objCoords)

					if closestDistance == -1 or closestDistance > distance then
						closestDistance = distance
						closestEntity   = object
					end
				end
			end

			if closestDistance ~= -1 and closestDistance <= 3.0 then
				if LastEntity ~= closestEntity then
					TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
					LastEntity = closestEntity
				end
			else
				if LastEntity then
					TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
					LastEntity = nil
				end
			end
		Wait(Sleep)
	end
end)

CreateThread(function()
	while true do
		local msec = 1000

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local playerData = ESX.GetPlayerData()
		local playerVehicle = IsPedInAnyVehicle(playerPed, false)

		for i,v in pairs(Config.PoliceStations) do
			for indx, val in pairs(v.Vehicles) do
				if playerData.job and playerData.job.name == "police" and #(playerCoords - val.Spawner.xyz) < 20.0 then
					msec = 0
					DrawMarker(36, val.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 111, 168, 100, false, true, 2, true, false, false, false)

					if playerData.job and playerData.job.name == "police" and #(playerCoords - val.Spawner.xyz) < 3.0 then
						ESX.ShowFloatingHelpNotification(playerVehicle and "~r~[E]~w~ Guardar vehiculo" or "~r~[E]~w~ Garage", vec3(val.Spawner.xyz))
						if (IsControlJustPressed(0, 38)) then
							if (IsPedInAnyVehicle(playerPed)) then
								DeleteVehicle(GetVehiclePedIsIn(playerPed))
								DeleteEntity(GetVehiclePedIsIn(playerPed))
							else
								openGarage(i, indx)
							end
						end
					end
				end
			end
		end

		Wait(msec)
	end
end)

function openGarage(station, spawn)
	local elements = {}

	for i,v in pairs(Config.PoliceStations[station].Vehicles[spawn].VehicleList) do
		table.insert(elements, {title = v.label, icon = "fas fa-car", onSelect = function()
			createVeh(v.car, station, spawn)
		end})
	end

	exports['ox_lib']:registerContext({
		id = "police_garage",
		title = "Garaje",
		options = elements
	})

	exports['ox_lib']:showContext("police_garage")
end

function createVeh(model, station, spawn)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
	local vehicle = CreateVehicle(GetHashKey(model), Config.PoliceStations[station].Vehicles[spawn].SpawnCoords.xyz, Config.PoliceStations[station].Vehicles[spawn].w, true, false)
	SetVehicleNumberPlateText(vehicle, "POLICIA")
	TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

    if model == "polmav" then
        SetVehicleLivery(vehicle, 2)
    end

	if (GetResourceState("LegacyFuel") == "started") then
		exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
	end
end

ESX.RegisterInput("police:interact", "(ESX PoliceJob) Interact", "keyboard", "E", function()
	if not CurrentAction then 
		return 
	end

	if not ESX.PlayerData.job or (ESX.PlayerData.job and not ESX.PlayerData.job.name == 'police') then
		return
	end
	if CurrentAction == 'menu_cloakroom' then
		OpenCloakroomMenu()
	elseif CurrentAction == 'menu_armory' then
		if not Config.EnableESXService then
			OpenArmoryMenu(CurrentActionData.station)
		elseif playerInService then
			OpenArmoryMenu(CurrentActionData.station)
		else
			ESX.ShowNotification(TranslateCap('service_not'))
		end
	elseif CurrentAction == 'menu_boss_actions' then
		ESX.CloseContext()
		TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
			menu.close()

			CurrentAction     = 'menu_boss_actions'
			CurrentActionMsg  = TranslateCap('open_bossmenu')
			CurrentActionData = {}
		end, { wash = false }) -- disable washing money
	elseif CurrentAction == 'remove_entity' then
		DeleteEntity(CurrentActionData.entity)
	end

	CurrentAction = nil
end)

ESX.RegisterInput("police:quickactions", "(ESX PoliceJob) Quick Actions", "keyboard", "F6", function()
	if not ESX.PlayerData.job or (ESX.PlayerData.job.name ~= 'police') or isDead then
		return
	end

	if not Config.EnableESXService then
		OpenPoliceActionsMenu()
	elseif playerInService then
		OpenPoliceActionsMenu()
	else
		ESX.ShowNotification(TranslateCap('service_not'))
	end
end)

--[[ CreateThread(function()
	while true do
		local Sleep = 1000

		if CurrentAction then
			Sleep = 0
			ESX.ShowHelpNotification(CurrentActionMsg)
		end
		Wait(Sleep)
	end
end) ]]

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.EnableESXService then
			TriggerServerEvent('esx_service:disableService', 'police')
		end

		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(TranslateCap('unrestrained_timer'))
		TriggerEvent('esx_policejob:unrestrain')
		handcuffTimer.active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(TranslateCap('impound_successful'))
	currentTask.busy = false
end

if ESX.PlayerLoaded and ESX.PlayerData.job == 'police' then
	SetTimeout(1000, function()
		TriggerServerEvent('esx_policejob:forceBlip')
	end)
end

local ox = exports['ox_lib']
RegisterCommand('cvec', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    ox:setClipboard("vec3("..round(playerCoords.x, 2)..", "..round(playerCoords.y, 2)..", "..round(playerCoords.z, 2)..")")
end)

RegisterCommand('cvec4', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    ox:setClipboard("vec4("..round(playerCoords.x, 2)..", "..round(playerCoords.y, 2)..", "..round(playerCoords.z, 2)..", "..round(GetEntityHeading(PlayerPedId()), 2)..")")
end)

RegisterCommand('cvec2', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    ox:setClipboard("vec2("..round(playerCoords.x, 2)..", "..round(playerCoords.y, 2)..")")
end)

RegisterCommand('heading', function()
    local heading = GetEntityHeading(PlayerPedId())
    ox:setClipboard(round(heading, 2))
end)

RegisterCommand('ctable', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    ox:setClipboard("{x = "..round(playerCoords.x, 2)..", y = "..round(playerCoords.y, 2)..", z = "..round(playerCoords.z, 2).."}")
end)

RegisterCommand('ctableh', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    ox:setClipboard("{x = "..round(playerCoords.x, 2)..", y = "..round(playerCoords.y, 2)..", z = "..round(playerCoords.z, 2)..", heading = "..round(GetEntityHeading(PlayerPedId()), 2).."}")
end)

RegisterCommand('cjson', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    ox:setClipboard('{"x": '..round(playerCoords.x, 2)..', "y": '..round(playerCoords.y, 2)..', "z": '..round(playerCoords.z, 2)..'}')
end)

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function AddMarkers()
    for _, marker in ipairs(teleportMenuMarkers) do
        marker.blip = AddBlipForCoord(marker.coords.x, marker.coords.y, marker.coords.z)
        SetBlipSprite(marker.blip, 1)
        SetBlipDisplay(marker.blip, 4)
        SetBlipScale(marker.blip, 0.8)
        SetBlipColour(marker.blip, 3)
        SetBlipAsShortRange(marker.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(marker.label)
        EndTextCommandSetBlipName(marker.blip)
    end
end