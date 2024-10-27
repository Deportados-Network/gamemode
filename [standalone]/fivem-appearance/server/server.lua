-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

ESX = exports["es_extended"]:getSharedObject()

MySQL.ready(function()
	MySQL.Sync.execute(
		"CREATE TABLE IF NOT EXISTS `outfits` (" ..
			"`id` int NOT NULL AUTO_INCREMENT, " ..
			"`identifier` varchar(60) NOT NULL, " ..
			"`name` longtext, " ..
			"`ped` longtext, " ..
			"`components` longtext, " ..
			"`props` longtext, " ..
			"PRIMARY KEY (`id`), " ..
			"UNIQUE KEY `id_UNIQUE` (`id`) " ..
		") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; "
	)
end)

-- Events

RegisterServerEvent('fivem-appearance:save')
AddEventHandler('fivem-appearance:save', function(appearance)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.update('UPDATE users SET skin = ? WHERE identifier = ?', {json.encode(appearance), xPlayer.identifier})
end)

RegisterServerEvent("fivem-appearance:saveOutfit")
AddEventHandler("fivem-appearance:saveOutfit", function(name, pedModel, pedComponents, pedProps)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.insert.await('INSERT INTO outfits (identifier, name, ped, components, props) VALUES (?, ?, ?, ?, ?)', {xPlayer.identifier, name, json.encode(pedModel), json.encode(pedComponents), json.encode(pedProps)})
end)

RegisterServerEvent("fivem-appearance:deleteOutfit")
AddEventHandler("fivem-appearance:deleteOutfit", function(id)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('DELETE FROM `outfits` WHERE `id` = @id', {
		['@id'] = id
	})
end)

-- Callbacks

lib.callback.register('fivem-appearance:getPlayerSkin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local users = MySQL.query.await('SELECT skin FROM outfits users identifier = ?', {xPlayer.identifier})
	if users then
		local user, appearance = users[1]
		if user.skin then
			appearance = json.decode(user.skin)
		end
	end
	return appearance
end)

lib.callback.register('fivem-appearance:payFunds', function(source, price)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xAccountMoney = xPlayer.getAccount(Config.PaymentAccount).money 
	if xAccountMoney < price then 
		return false 
	else
		xPlayer.removeAccountMoney(Config.PaymentAccount, price)
		return true
	end
end)

lib.callback.register('fivem-appearance:getOutfits', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    local outfits = {}
    local result = MySQL.query.await('SELECT * FROM outfits WHERE identifier = ?', {xPlayer.identifier})
	if result then
		for i=1, #result, 1 do
			outfits[#outfits + 1] = {
				id = result[i].id,
				name = result[i].name,
				ped = json.decode(result[i].ped),
				components = json.decode(result[i].components),
				props = json.decode(result[i].props)
			}
		end
		return outfits
	else
		return false
	end
end)

-- Commands
ESX.RegisterCommand('skin', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('fivem-appearance:skinCommand')
end, false, {help = Strings.skin_command_help, validate = true, arguments = {
	{name = 'playerId', help = Strings.skin_command_arg_help, type = 'player'}
}})

-- esx_skin/skinchanger compatibility
getGender = function(model)
    if model == 'mp_f_freemode_01' then
        return 1
    else
        return 0
    end
end

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local users = MySQL.query.await('SELECT skin FROM users WHERE identifier = ?', {xPlayer.identifier})
	if users then
		local user, appearance = users[1]
		local jobSkin = {
			skin_male   = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}
		if user.skin then
			appearance = json.decode(user.skin)
		elseif user.skin == nil then
			appearance = json.decode('{"eyeColor":-1,"components":[{"drawable":0,"texture":0,"component_id":0},{"drawable":0,"texture":0,"component_id":2},{"drawable":0,"texture":0,"component_id":3},{"drawable":0,"texture":0,"component_id":5},{"drawable":0,"texture":0,"component_id":7},{"drawable":0,"texture":0,"component_id":9},{"drawable":0,"texture":0,"component_id":10},{"drawable":0,"texture":0,"component_id":1},{"drawable":15,"texture":0,"component_id":8},{"drawable":42,"texture":0,"component_id":11},{"drawable":46,"texture":0,"component_id":4},{"drawable":7,"texture":0,"component_id":6}],"hair":{"highlight":0,"style":12,"color":55},"props":[{"drawable":-1,"texture":-1,"prop_id":0},{"drawable":-1,"texture":-1,"prop_id":1},{"drawable":-1,"texture":-1,"prop_id":2},{"drawable":-1,"texture":-1,"prop_id":6},{"drawable":-1,"texture":-1,"prop_id":7}],"tattoos":[],"headBlend":{"skinMix":0,"skinFirst":0,"shapeFirst":0,"shapeMix":0,"skinSecond":0,"shapeSecond":0},"model":"mp_m_freemode_01","faceFeatures":{"cheeksBoneWidth":0,"cheeksBoneHigh":0,"neckThickness":0,"cheeksWidth":0,"chinBoneLowering":0,"chinBoneLenght":0,"chinBoneSize":0,"chinHole":0,"eyeBrownForward":0,"lipsThickness":0,"jawBoneBackSize":0,"eyesOpening":0,"nosePeakSize":0,"noseBoneTwist":0,"eyeBrownHigh":0,"noseWidth":0,"jawBoneWidth":0,"nosePeakLowering":0,"noseBoneHigh":0,"nosePeakHigh":0},"headOverlays":{"ageing":{"style":0,"opacity":0,"color":0},"blush":{"style":0,"opacity":0,"color":0},"chestHair":{"style":0,"opacity":0,"color":0},"lipstick":{"style":0,"opacity":0,"color":0},"beard":{"style":0,"opacity":0,"color":0},"makeUp":{"style":0,"opacity":0,"color":0},"eyebrows":{"style":0,"opacity":0,"color":0},"moleAndFreckles":{"style":0,"opacity":0,"color":0},"bodyBlemishes":{"style":0,"opacity":0,"color":0},"complexion":{"style":0,"opacity":0,"color":0},"blemishes":{"style":0,"opacity":0,"color":0},"sunDamage":{"style":0,"opacity":0,"color":0}}}')
		end
		appearance.sex = getGender(appearance.model)
		cb(appearance, jobSkin)
	end
end)
