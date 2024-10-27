local loadingScreenFinished = false

RegisterNetEvent('esx_identity:alreadyRegistered')
AddEventHandler('esx_identity:alreadyRegistered', function()
	while not loadingScreenFinished do
		Citizen.Wait(100)
	end

	TriggerEvent('esx_skin:playerRegistered')
end)

RegisterNetEvent('ox_lib:client:notify', function(title, description, type)
	local ox = exports['ox_lib']

	ox:notify({
        title = title,
        description = description,
        type = type,
        position = "bottom-right",
        style = {
            position = "relative",
            bottom = "60px",
            backgroundColor = "#000000b7",
            boxShadow = "rgba(0, 0, 0, 0.192)"
        },
    })
end)

AddEventHandler('esx:loadingScreenOff', function()
	loadingScreenFinished = true
end)

if not Config.UseDeferrals then
	local guiEnabled, isDead = false, false

	AddEventHandler('esx:onPlayerDeath', function(data)
		isDead = true
	end)

	AddEventHandler('esx:onPlayerSpawn', function(spawn)
		isDead = false
	end)

	function EnableGui(state)
		SetNuiFocus(state, state)
		guiEnabled = state

		SendNUIMessage({
			type = "enableui",
			enable = state
		})

		if (state) then
			TriggerServerEvent("esx_identity:bucket", "playerId")
		end
	end

	RegisterNetEvent('esx_identity:showRegisterIdentity')
	AddEventHandler('esx_identity:showRegisterIdentity', function()
		TriggerEvent('esx_skin:resetFirstSpawn')

		if not isDead then
			EnableGui(true)
		end
	end)

	RegisterNUICallback('register', function(data, cb)
		ESX.TriggerServerCallback('esx_identity:registerIdentity', function(callback)
			if callback then
				local ox = exports['ox_lib']
				ox:notify({
					title = "Registro",
					description = "Has sido llevado a una dimensión aparte para que puedas crear tu personaje sin problemas.",
					type = "inform",
					position = "bottom-right",
					style = {
						position = "relative",
						bottom = "60px",
						backgroundColor = "#000000b7",
						boxShadow = "rgba(0, 0, 0, 0.192)"
					},
				})
				EnableGui(false)
				TriggerEvent('esx_skin:playerRegistered')
				TriggerEvent('esx_skin:openSaveableMenu', function() 
					loadingScreenFinished = true
					TriggerServerEvent("esx_identity:bucket")
				end, function() 
					loadingScreenFinished = true
					TriggerServerEvent("esx_identity:bucket")
				end)
			else
				ESX.ShowNotification(_U('registration_error'))
			end
		end, data)
	end)

	Citizen.CreateThread(function()
		while true do
			local msec = 750
			if guiEnabled then
				msec = 5
				DisableControlAction(0, 1,   true) -- LookLeftRight
				DisableControlAction(0, 2,   true) -- LookUpDown
				DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
				DisableControlAction(0, 142, true) -- MeleeAttackAlternate
				DisableControlAction(0, 30,  true) -- MoveLeftRight
				DisableControlAction(0, 31,  true) -- MoveUpDown
				DisableControlAction(0, 21,  true) -- disable sprint
				DisableControlAction(0, 24,  true) -- disable attack
				DisableControlAction(0, 25,  true) -- disable aim
				DisableControlAction(0, 47,  true) -- disable weapon
				DisableControlAction(0, 58,  true) -- disable weapon
				DisableControlAction(0, 263, true) -- disable melee
				DisableControlAction(0, 264, true) -- disable melee
				DisableControlAction(0, 257, true) -- disable melee
				DisableControlAction(0, 140, true) -- disable melee
				DisableControlAction(0, 141, true) -- disable melee
				DisableControlAction(0, 143, true) -- disable melee
				DisableControlAction(0, 75,  true) -- disable exit vehicle
				DisableControlAction(27, 75, true) -- disable exit vehicle
			end
			Citizen.Wait(msec)
		end
	end)
end
