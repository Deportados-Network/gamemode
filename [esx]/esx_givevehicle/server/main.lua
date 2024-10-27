ESX = exports['es_extended']:getSharedObject()

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('givecar', function(source, args)
	givevehicle(source, args, 'car')
end)

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('giveplane', function(source, args)
	givevehicle(source, args, 'airplane')
end)

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('giveboat', function(source, args)
	givevehicle(source, args, 'boat')
end)

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('giveheli', function(source, args)
	givevehicle(source, args, 'helicopter')
end)

function givevehicle(_source, _args, vehicleType)
	if havePermission(_source) then
		if _args[1] == nil or _args[2] == nil then
			TriggerClientEvent('esx:showNotification', _source, '~r~/givevehicle playerID carModel [plate]')
		elseif _args[3] ~= nil then
			local playerName = GetPlayerName(_args[1])
			local plate = _args[3]
			if #_args > 3 then
				for i=4, #_args do
					plate = plate.." ".._args[i]
				end
			end	
			plate = string.upper(plate)
			TriggerClientEvent('esx_giveownedcar:spawnVehiclePlate', _source, _args[1], _args[2], plate, playerName, 'player', vehicleType)
		else
			local playerName = GetPlayerName(_args[1])
			TriggerClientEvent('esx_giveownedcar:spawnVehicle', _source, _args[1], _args[2], playerName, 'player', vehicleType)
		end
	else
		TriggerClientEvent('esx:showNotification', _source, '~r~You don\'t have permission to do this command!')
	end
end

RegisterCommand('_givecar', function(source, args)
	_givevehicle(source, args, 'car')
end)

RegisterCommand('givecarconsole', function(source, args, rawCommand)
    local targetIdentifier = args[1]
    local carModel = args[2]
    local plate = args[3]
    local vehicleType = 'car'  -- Cambia esto según el tipo de vehículo que estás dando

    if not targetIdentifier or not carModel or not plate then
        print('Usage: /givecarconsole <targetIdentifier> <carModel> <plate>')
        return
    end

    local foundTarget = false

    for _, player in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(player)

        if xPlayer and xPlayer.identifier == targetIdentifier then
            givevehicle(0, {player, carModel, plate}, vehicleType)
            foundTarget = true
            break
        end
    end

    if not foundTarget then
        print('Player not found with identifier: ' .. targetIdentifier)
    end
end, false)


RegisterCommand('_giveplane', function(source, args)
	_givevehicle(source, args, 'airplane')
end)

RegisterCommand('_giveboat', function(source, args)
	_givevehicle(source, args, 'boat')
end)

RegisterCommand('_giveheli', function(source, args)
	_givevehicle(source, args, 'helicopter')
end)

-- Función para dar un vehículo desde la consola del servidor
function giveAutoVehicleFromConsole(targetIdentifier, carModel, plate, vehicleType)
    local targetPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

    if not targetPlayer then
        print('Player not found with identifier: ' .. targetIdentifier)
        return
    end

    local playerName = GetPlayerName(targetPlayer.source)
    plate = string.upper(plate)

    print('Giving vehicle to player: ' .. playerName)

    -- Utiliza TriggerEvent para ejecutar el comando en el lado del cliente
    TriggerEvent('esx_giveownedcar:spawnVehiclePlate', targetPlayer.source, carModel, plate, playerName, 'console', vehicleType)

    -- Agrega código aquí para almacenar el vehículo en el garaje (si es necesario)
end

-- Función para dar un vehículo desde la consola del servidor
function _givevehicle(_, _args, vehicleType)
    local targetIdentifier = _args[1]
    local carModel = _args[2]
    local plate = _args[3]

    if targetIdentifier == nil or carModel == nil or plate == nil then
        print('Usage: /darauto identifier carModel plate')
    else
        giveAutoVehicleFromConsole(targetIdentifier, carModel, plate, vehicleType)
    end
end

-- Registra el comando para ser ejecutado desde la consola del servidor
RegisterCommand('darauto', function(source, args, rawCommand)
    local targetIdentifier = args[1]
    local carModel = args[2]
    local plate = args[3]
    local vehicleType = 'car'  -- Cambia esto según el tipo de vehículo que estás dando

    _givevehicle(0, {targetIdentifier, carModel, plate}, vehicleType)
end, false)






RegisterCommand('delcarplate', function(source, args)
	if havePermission(source) then
		if args[1] == nil then
			TriggerClientEvent('esx:showNotification', source, '~r~/delcarplate <plate>')
		else
			local plate = args[1]
			if #args > 1 then
				for i=2, #args do
					plate = plate.." "..args[i]
				end		
			end
			plate = string.upper(plate)
			
			local result = MySQL.query.await('DELETE FROM owned_vehicles WHERE plate = ?', {
				plate
			})
			if result == 1 then
				TriggerClientEvent('esx:showNotification', source, _U('del_car', plate))
			elseif result == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('del_car_error', plate))
			end		
		end
	else
		TriggerClientEvent('esx:showNotification', source, '~r~You don\'t have permission to do this command!')
	end		
end)

RegisterCommand('_delcarplate', function(source, args)
    if source == 0 then
		if args[1] == nil then	
			print("SYNTAX ERROR: _delcarplate <plate>")
		else
			local plate = args[1]
			if #args > 1 then
				for i=2, #args do
					plate = plate.." "..args[i]
				end		
			end
			plate = string.upper(plate)
			
			local result = MySQL.query.await('DELETE FROM owned_vehicles WHERE plate = ?', {
				plate
			})
			if result == 1 then
				print('Deleted car plate: ' ..plate)
			elseif result == 0 then
				print('Can\'t find car with plate is ' ..plate)
			end
		end
	end
end)


--functions--

RegisterServerEvent('esx_giveownedcar:setVehicle')
AddEventHandler('esx_giveownedcar:setVehicle', function (vehicleProps, playerID, vehicleType)
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.query('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type) VALUES (?, ?, ?, ?, ?)',
	{
		xPlayer.identifier,
		vehicleProps.plate,
		json.encode(vehicleProps),
		1,
		vehicleType
	}, function ()
		if Config.ReceiveMsg then
			TriggerClientEvent('esx:showNotification', _source, _U('received_car', string.upper(vehicleProps.plate)))
		end
	end)
end)

RegisterServerEvent('esx_giveownedcar:printToConsole')
AddEventHandler('esx_giveownedcar:printToConsole', function(msg)
	print(msg)
end)

function havePermission(_source)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerGroup = xPlayer.getGroup()
	local isAdmin = false
	local lib = exports['bm_lib']:initLib()
	if lib.hasRank(_source, 1) then
		isAdmin = true
	end
	
	if IsPlayerAceAllowed(_source, "giveownedcar.command") then isAdmin = true end
	
	return isAdmin
end
