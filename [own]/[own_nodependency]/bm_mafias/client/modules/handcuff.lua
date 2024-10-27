RegisterNetEvent('bm_mafias:playerHandcuff', function()
    isHandcuff    = not isHandcuff
	local playerPed = PlayerPedId()

	CreateThread(function()
		if isHandcuff then
			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end
	
			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
	
	
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)
		else
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			DisplayRadar(true)
		end
	end)
end)

RegisterNetEvent('bm_mafias:arrested', function(copId)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(copId))

	RequestAnimDict("mp_arrest_paired")

	while not HasAnimDictLoaded("mp_arrest_paired") do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(playerPed, targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_left", 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(playerPed, true, false)
end)

RegisterNetEvent('bm_mafias:arrest', function()
	local playerPed = PlayerPedId()

	RequestAnimDict("mp_arrest_paired")

	while not HasAnimDictLoaded("mp_arrest_paired") do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, "mp_arrest_paired", "cop_p2_back_left", 8.0, -8.0, 5500, 33, 0, false, false, false)
end)