-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
ESX = exports["es_extended"]:getSharedObject()
local shops, savedOutfits = {}, {}

-- ESX Events
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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    closeMenu()
end)

-- Appearance Events

RegisterNetEvent('fivem-appearance:skinCommand')
AddEventHandler('fivem-appearance:skinCommand', function()
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('fivem-appearance:save', appearance)
			ESX.SetPlayerData('ped', PlayerPedId())
		else
			ESX.SetPlayerData('ped', PlayerPedId())
		end
	end, config)
end)

RegisterNetEvent('fivem-appearance:setOutfit')
AddEventHandler('fivem-appearance:setOutfit', function(data)
	local pedModel = data.ped
	local pedComponents = data.components
	local pedProps = data.props
	local playerPed = PlayerPedId()
	local currentPedModel = exports['fivem-appearance']:getPedModel(playerPed)
	if currentPedModel ~= pedModel then
    	exports['fivem-appearance']:setPlayerModel(pedModel)
		Wait(500)
		playerPed = PlayerPedId()
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
		ESX.SetPlayerData('ped', PlayerPedId())
	else
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
		ESX.SetPlayerData('ped', PlayerPedId())
	end
end)

RegisterNetEvent('fivem-appearance:saveOutfit', function()
    local input = lib.inputDialog(Strings.save_outfit_title, {Strings.save_outfit_info})
    if input then
        local name = input[1]
        local playerPed = PlayerPedId()
        local pedModel = exports['fivem-appearance']:getPedModel(playerPed)
        local pedComponents = exports['fivem-appearance']:getPedComponents(playerPed)
        local pedProps = exports['fivem-appearance']:getPedProps(playerPed)
        TriggerServerEvent('fivem-appearance:saveOutfit', name, pedModel, pedComponents, pedProps)
    end
end)

AddEventHandler('fivem-appearance:clothingMenu', function(price)
    
    openShop('clothing_menu', price)
end)

RegisterNetEvent('fivem-appearance:deleteOutfitMenu', function()
    local outfits = lib.callback.await('fivem-appearance:getOutfits', 100)
    local Options = {}
    if outfits then
        Options = {
            {
                title = Strings.go_back_title,
                event = 'fivem-appearance:clothingShop'
            }
        }
        for i=1, #outfits do
            Options[#Options + 1] = {
                title = outfits[i].name,
                serverEvent = 'fivem-appearance:deleteOutfit',
                args = outfits[i].id 
            }
        end
    else
        Options = {
            {
                title = Strings.go_back_title,
                description = Strings.go_back_desc,
                event = 'fivem-appearance:clothingShop'
            }
        }
    end
    lib.registerContext({
        id = 'outfit_delete_menu',
        title = Strings.delete_outfits_title,
        options = Options
    })
    lib.showContext('outfit_delete_menu')
end)

RegisterNetEvent('fivem-appearance:browseOutfits', function()
    local outfits = lib.callback.await('fivem-appearance:getOutfits', 100)
    local Options = {}
    if outfits then 
        Options = {
            {
                title = Strings.go_back_title,
                event = 'fivem-appearance:clothingShop'
            }
        }
        for i=1, #outfits do 
            Options[#Options + 1] = {
                title = outfits[i].name,
                event = 'fivem-appearance:setOutfit',
                args = {
                    ped = outfits[i].ped,
                    components = outfits[i].components,
                    props = outfits[i].props
                }
            }
        end
    else
        Options = {
            {
                title = Strings.go_back_title,
                description = Strings.go_back_desc,
                event = 'fivem-appearance:clothingShop'
            }
        }
    end
    lib.registerContext({
        id = 'outfit_menu',
        title = Strings.browse_outfits_title,
        options = Options
    })
    lib.showContext('outfit_menu')
end)

RegisterNetEvent('fivem-appearance:clothingShop', function(price)
	lib.registerContext({
		id = 'clothing_menu',
		title = Strings.clothing_shop_title,
		options = {
			{
				title = Strings.change_clothing_title,
				description = Strings.change_clothing_desc,
				arrow = false,
				event = 'fivem-appearance:clothingMenu',
                args = price
			},
			{
				title = Strings.browse_outfits_title,
				description = Strings.browse_outfits_desc,
				arrow = false,
				event = 'fivem-appearance:browseOutfits'
			},
			{
				title = Strings.save_outfit_title,
				description = Strings.save_outfit_desc,
				arrow = false,
				event = 'fivem-appearance:saveOutfit'
			},
			{
				title = Strings.delete_outfit_title,
				description = Strings.delete_outfit_desc,
				arrow = false,
				event = 'fivem-appearance:deleteOutfitMenu'
			},
		}
	})
	lib.showContext('clothing_menu')
end)

CreateThread(function()
    for i=1, #Config.ClothingShops do
        if Config.ClothingShops[i].blip.enabled then
            createBlip(Config.ClothingShops[i].coords, Config.ClothingShops[i].blip.sprite, Config.ClothingShops[i].blip.color, Config.ClothingShops[i].blip.string, Config.ClothingShops[i].blip.scale)
        end
    end
    for i=1, #Config.BarberShops do
        if Config.BarberShops[i].blip.enabled then
            createBlip(Config.BarberShops[i].coords, Config.BarberShops[i].blip.sprite, Config.BarberShops[i].blip.color, Config.BarberShops[i].blip.string, Config.BarberShops[i].blip.scale)
        end
    end
    for i=1, #Config.TattooShops do
        if Config.TattooShops[i].blip.enabled then
            createBlip(Config.TattooShops[i].coords, Config.TattooShops[i].blip.sprite, Config.TattooShops[i].blip.color, Config.TattooShops[i].blip.string, Config.TattooShops[i].blip.scale)
        end
    end
end)

CreateThread(function()
    shops = consolidateShops()
    local textUI = {}
    while true do
        local sleep = 2000
        if #shops > 0 then
            local coords = GetEntityCoords(cache.ped)
            for k,v in pairs(shops) do
                local dist = #(coords - v.coords)
                if dist < (v.distance + 1) then
                    if not textUI[k] then
                        lib.showTextUI(showTextUI(v.store))
                        textUI[k] = true
                    end
                    sleep = 0
                    if IsControlJustReleased(0, 38) then
                        openShop(v.store, v.price)
                    end
                elseif dist > v.distance and textUI[k] then
                    lib.hideTextUI()
                    textUI[k] = nil
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterCommand('propfix', function()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)

RegisterCommand('reloadchar', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(appearance)
        exports['fivem-appearance']:setPlayerAppearance(appearance)
    end)
end)

--cd_multicharacter compatibility
RegisterNetEvent('skinchanger:loadSkin2')
AddEventHandler('skinchanger:loadSkin2', function(ped, skin)
    if not skin.model then skin.model = 'mp_m_freemode_01' end
    	exports['fivem-appearance']:setPedAppearance(ped, skin)
    if cb ~= nil then
        cb()
    end
end)

-- esx_skin/skinchanger compatibility(The best I/we can)
AddEventHandler('skinchanger:getSkin', function(cb)
    while not ESX.PlayerLoaded do
        Wait(1000)
    end
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(appearance)
        cb(appearance)
    end)
end)

RegisterNetEvent('skinchanger:loadSkin')
AddEventHandler('skinchanger:loadSkin', function(skin, cb)
	if not skin.model then skin.model = 'mp_m_freemode_01' end
	exports['fivem-appearance']:setPlayerAppearance(skin)
	if cb ~= nil then
		cb()
	end
end)

AddEventHandler('skinchanger:loadDefaultModel', function(loadMale, cb)
    if loadMale then
        TriggerEvent('skinchanger:loadSkin',json.decode('{"faceFeatures":{"chinBoneLowering":0,"jawBoneBackSize":0,"cheeksBoneWidth":0,"noseBoneHigh":0,"nosePeakSize":0,"chinHole":0,"chinBoneSize":0,"cheeksBoneHigh":0,"noseWidth":0,"nosePeakLowering":0,"eyesOpening":0,"jawBoneWidth":0,"chinBoneLenght":0,"neckThickness":0,"lipsThickness":0,"cheeksWidth":0,"nosePeakHigh":0,"noseBoneTwist":0,"eyeBrownForward":0,"eyeBrownHigh":0},"props":[{"prop_id":0,"texture":-1,"drawable":-1},{"prop_id":1,"texture":-1,"drawable":-1},{"prop_id":2,"texture":-1,"drawable":-1},{"prop_id":6,"texture":-1,"drawable":-1},{"prop_id":7,"texture":-1,"drawable":-1}],"headBlend":{"skinSecond":0,"shapeMix":0,"skinMix":0,"shapeSecond":0,"shapeFirst":0,"skinFirst":0},"hair":{"style":12,"color":55,"highlight":0},"headOverlays":{"blush":{"style":0,"color":0,"opacity":0},"ageing":{"style":0,"color":0,"opacity":0},"bodyBlemishes":{"style":0,"color":0,"opacity":0},"lipstick":{"style":0,"color":0,"opacity":0},"beard":{"style":0,"color":0,"opacity":0},"blemishes":{"style":0,"color":0,"opacity":0},"eyebrows":{"style":0,"color":0,"opacity":0},"sunDamage":{"style":0,"color":0,"opacity":0},"complexion":{"style":0,"color":0,"opacity":0},"makeUp":{"style":0,"color":0,"opacity":0},"moleAndFreckles":{"style":0,"color":0,"opacity":0},"chestHair":{"style":0,"color":0,"opacity":0}},"model":"mp_m_freemode_01","tattoos":[],"eyeColor":-1,"components":[{"texture":0,"component_id":0,"drawable":0},{"texture":0,"component_id":1,"drawable":0},{"texture":0,"component_id":2,"drawable":12},{"texture":0,"component_id":3,"drawable":0},{"texture":0,"component_id":5,"drawable":0},{"texture":0,"component_id":7,"drawable":0},{"texture":0,"component_id":8,"drawable":15},{"texture":0,"component_id":9,"drawable":0},{"texture":0,"component_id":10,"drawable":0},{"texture":0,"component_id":11,"drawable":69},{"texture":9,"component_id":4,"drawable":44},{"texture":0,"component_id":6,"drawable":1}]}'))
    else
        local skin = json.decode('{"faceFeatures":{"chinBoneLowering":0,"jawBoneBackSize":0,"cheeksBoneWidth":0,"noseBoneHigh":0,"nosePeakSize":0,"chinHole":0,"chinBoneSize":0,"cheeksBoneHigh":0,"noseWidth":0,"nosePeakLowering":0,"eyesOpening":0,"jawBoneWidth":0,"chinBoneLenght":0,"neckThickness":0,"lipsThickness":0,"cheeksWidth":0,"nosePeakHigh":0,"noseBoneTwist":0,"eyeBrownForward":0,"eyeBrownHigh":0},"props":[{"prop_id":0,"texture":-1,"drawable":-1},{"prop_id":1,"texture":-1,"drawable":-1},{"prop_id":2,"texture":-1,"drawable":-1},{"prop_id":6,"texture":-1,"drawable":-1},{"prop_id":7,"texture":-1,"drawable":-1}],"headBlend":{"skinSecond":0,"shapeMix":0,"skinMix":0,"shapeSecond":0,"shapeFirst":0,"skinFirst":0},"hair":{"style":12,"color":55,"highlight":0},"headOverlays":{"blush":{"style":0,"color":0,"opacity":0},"ageing":{"style":0,"color":0,"opacity":0},"bodyBlemishes":{"style":0,"color":0,"opacity":0},"lipstick":{"style":0,"color":0,"opacity":0},"beard":{"style":0,"color":0,"opacity":0},"blemishes":{"style":0,"color":0,"opacity":0},"eyebrows":{"style":0,"color":0,"opacity":0},"sunDamage":{"style":0,"color":0,"opacity":0},"complexion":{"style":0,"color":0,"opacity":0},"makeUp":{"style":0,"color":0,"opacity":0},"moleAndFreckles":{"style":0,"color":0,"opacity":0},"chestHair":{"style":0,"color":0,"opacity":0}},"model":"mp_m_freemode_01","tattoos":[],"eyeColor":-1,"components":[{"texture":0,"component_id":0,"drawable":0},{"texture":0,"component_id":1,"drawable":0},{"texture":0,"component_id":2,"drawable":12},{"texture":0,"component_id":3,"drawable":0},{"texture":0,"component_id":5,"drawable":0},{"texture":0,"component_id":7,"drawable":0},{"texture":0,"component_id":8,"drawable":15},{"texture":0,"component_id":9,"drawable":0},{"texture":0,"component_id":10,"drawable":0},{"texture":0,"component_id":11,"drawable":69},{"texture":9,"component_id":4,"drawable":44},{"texture":0,"component_id":6,"drawable":1}]}')
        skin.model = 'mp_f_freemode_01'
        TriggerEvent('skinchanger:loadSkin',skin)
    end
end)

RegisterNetEvent('skinchanger:loadClothes')
AddEventHandler('skinchanger:loadClothes', function(skin, clothes)
    local playerPed = PlayerPedId()
    local outfit = convertClothes(clothes)
    exports['fivem-appearance']:setPedComponents(playerPed, outfit.Components)
    exports['fivem-appearance']:setPedProps(playerPed, outfit.Props)
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb, isNew)
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('fivem-appearance:save', appearance)
			ESX.SetPlayerData('ped', PlayerPedId())
			if submitCb then submitCb() end
		else
			if cancelCb then cancelCb() end
			ESX.SetPlayerData('ped', PlayerPedId())
		end
	end, config)
end)
