ESX = exports['es_extended']:getSharedObject()
local lib = exports['bm_lib']:initLib()

RegisterCommand('comserv', function(source, args)
	if (lib.hasRank(source, 1)) then
		if args[1] and GetPlayerName(args[1]) ~= nil and tonumber(args[2]) then
			local affectedPlayerId = tonumber(args[1])
			local amountOfCommunityService = tonumber(args[2])

			TriggerEvent('esx_communityservice:sendToCommunityServicess', affectedPlayerId, amountOfCommunityService)

			local senderName = GetPlayerName(source)
			local affectedPlayerName = GetPlayerName(affectedPlayerId)

			local discordMessage = {
				username = "depo | Comms",
				content = string.format("```\nSe aplicaron servicios comunitarios!\n\nCantidad: %d acciones\nSancionado: %s\nPor: %s```", amountOfCommunityService, affectedPlayerName, senderName)
			}

			local jsonMessage = json.encode(discordMessage)

			PerformHttpRequest('https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-', function(statusCode, text, headers)
			end, 'POST', jsonMessage, { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('chat:addMessage', source, {
				template = '<span class="badge badge-staff">{0}</span> {1}',
				args = {'SISTEMA', "La ID del jugador no es valida, o la cantidad de acciones."}
			})
		end
	else
		TriggerClientEvent('chat:addMessage', source, {
			template = '{0}: {1}',
			args = {'^8[depo]^7', "No tienes permisos suficientes."}
		})
	end
end)

RegisterCommand('endcomserv', function(source, args, user)
	if (lib.hasRank(source, 1)) then
		if args[1] then
			if GetPlayerName(args[1]) ~= nil then
				TriggerEvent('esx_communityservice:endCommunityServiceCommands', tonumber(args[1]))
			else
				TriggerClientEvent('chat:addMessage', source, {
					template = '<span class="badge badge-staff">{0}</span> {1}',
					args = {'SISTEMA', "La ID no es valida"}
				})
			end
		else
			TriggerEvent('esx_communityservice:endCommunityServiceCommands', source)
		end
	else
		TriggerClientEvent('chat:addMessage', source, {
			template = '<span class="badge badge-staff">{0}</span> {1}',
			args = {'SISTEMA', "No tienes permisos suficientes."}
		})
	end
end)

RegisterServerEvent('esx_communityservice:endCommunityServiceCommands')
AddEventHandler('esx_communityservice:endCommunityServiceCommands', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)

-- unjail after time served
RegisterServerEvent('esx_communityservice:finishCommunityService')
AddEventHandler('esx_communityservice:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('esx_communityservice:completeService')
AddEventHandler('esx_communityservice:completeService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {
		identifier
	}, function(result)

		if result[1] then
			MySQL.update('UPDATE communityservice SET actions_remaining = actions_remaining - 1 WHERE identifier = ?', {
				identifier
			})
		else 
			print ("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:extendService')
AddEventHandler('esx_communityservice:extendService', function()

	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {
		identifier
	}, function(result)

		if result[1] then
			MySQL.update('UPDATE communityservice SET actions_remaining = actions_remaining + ? WHERE identifier = ?', {
				Config.ServiceExtensionOnEscape,
				identifier
			})
		else 
			print ("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:sendToCommunityServicess')
AddEventHandler('esx_communityservice:sendToCommunityServicess', function(target, actions_count)

	local identifier = GetPlayerIdentifiers(target)[1]

	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {
		identifier
	}, function(result)
		if result[1] then
			MySQL.update('UPDATE communityservice SET actions_remaining = ? WHERE identifier = ?', {
				actions_count,
				identifier
			})
		else
			MySQL.insert('INSERT INTO communityservice (identifier, actions_remaining) VALUES (?, ?)', {
				identifier,
				actions_count
			})
		end
	end)
	
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<span class="badge badge-pfa">{0}</span>&nbsp <span class="badge badge-white">{1}</span>',
		args = {'SERVICIOS', ""..GetPlayerName(target).."^7 fue condenado a ^9"..actions_count.."^7 servicios comunitarios."}
	})

	TriggerClientEvent('esx_communityservice:inCommunityService', target, actions_count)
end)

RegisterServerEvent('esx_communityservice:checkIfSentenced')
AddEventHandler('esx_communityservice:checkIfSentenced', function()
	local _source = source -- cannot parse source to client trigger for some weird reason
	local identifier = GetPlayerIdentifiers(_source)[1] -- get steam identifier

	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {
		identifier
	}, function(result)
		if result[1] ~= nil and result[1].actions_remaining > 0 then
			TriggerClientEvent('esx_communityservice:inCommunityService', _source, tonumber(result[1].actions_remaining))
		end
	end)
end)

function releaseFromCommunityService(target)

	local identifier = GetPlayerIdentifiers(target)[1]
	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {
		identifier
	}, function(result)
		if result[1] then
			MySQL.query('DELETE from communityservice WHERE identifier = ?', {
				identifier
			})

			TriggerClientEvent('chat:addMessage', -1, {
				template = '<span class="badge badge-pfa">{0}</span>&nbsp <span class="badge badge-white">{1}</span>',
				args = {'SERVICIOS', ""..GetPlayerName(target).."^7 ha terminado sus servicios comunitarios."}
			})
		end
	end)

	TriggerClientEvent('esx_communityservice:finishCommunityService', target)
end