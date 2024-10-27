core.RegisterCommand('fuel', 1, function(xPlayer, args, showError)
	if not xPlayer then
		return print('[^1ERROR^7] The xPlayer value is nil')
	end
	
    TriggerClientEvent('bm_admin:setFuel', xPlayer.source, (args.quantity or 100))
end, false, {help = "Llena de gasolina un vehículo", validate = false, arguments = {
	{name = 'quantity',validate = false, help = "Cantidad de gasolina", type = 'number'}
}}) 

core.RegisterCommand('armor', 1, function(xPlayer, args, showError)
	if not xPlayer then
		return print('[^1ERROR^7] The xPlayer value is nil')
	end
	
	local playerRank, label, rankName = lib.getPlayerRank(xPlayer.source, true)
	local rankLabel = label:sub(3)

	if (GetPlayerName(args.playerId) == nil) then
		return
	end

	TriggerClientEvent('chat:addMessage', args.playerId, {
		template = '<span class="badge badge-{2}">{3}</span> <span class="badge badge-white">{0}</span> <span class="badge badge-gray">[#{1}]</span> te ha dado <span style="color: #6da7ed">'..(args.armadura or 100)..'%</span> de armadura.',
		args = {GetPlayerName(xPlayer.source), xPlayer.source, rankName, rankLabel}
	})
	TriggerClientEvent('chat:addMessage', xPlayer.source, {
		template = '<span class="badge badge-staff">{0}</span> Le has dado armadura a <span class="badge badge-gray">{1}</span>',
		args = {"SISTEMA", "@"..GetPlayerName(args.playerId)}
	})

    TriggerClientEvent('bm_admin:armor', args.playerId, (args.armadura or 100))
end, false, {help = "Da de comer y beber a una persona", validate = false, arguments = {
	{name = 'playerId', validate = false, help = "ID del jugador", type = 'number'},
	{name = 'armadura', validate = false, help = "Cantidad de armadura", type = 'number'}
}}) 

core.RegisterCommand('eat', 1, function(xPlayer, args, showError)
	if not xPlayer then
		return print('[^1ERROR^7] The xPlayer value is nil')
	end
	
	local playerRank, label, rankName = lib.getPlayerRank(xPlayer.source, true)
	local rankLabel = label:sub(3)

	if (GetPlayerName(args.playerId) == nil) then
		return
	end

	TriggerClientEvent('chat:addMessage', args.playerId, {
		template = '<span class="badge badge-{2}">{3}</span> <span class="badge badge-white">{0}</span> <span class="badge badge-gray">[#{1}]</span> te ha llenado la comida y el agua.',
		args = {GetPlayerName(xPlayer.source), xPlayer.source, rankName, rankLabel}
	})
	TriggerClientEvent('chat:addMessage', xPlayer.source, {
		template = '<span class="badge badge-staff">{0}</span> Le has dado comida y agua a <span class="badge badge-gray">{1}</span>',
		args = {"SISTEMA", "@"..GetPlayerName(args.playerId)}
	})

    TriggerClientEvent('bm_admin:eat', args.playerId)
end, false, {help = "Da de comer y beber a una persona", validate = false, arguments = {
	{name = 'playerId', validate = false, help = "ID del jugador", type = 'number'}
}}) 

core.RegisterCommand('eatall', 1, function(xPlayer, args, showError)
	if not xPlayer then
		return print('[^1ERROR^7] The xPlayer value is nil')
	end

	local playerRank, label, rankName = lib.getPlayerRank(xPlayer.source, true)
	local rankLabel = label:sub(3)

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<span class="badge badge-{2}">{3}</span> <span class="badge badge-white">{0}</span> <span class="badge badge-gray">[#{1}]</span> le ha llenado la comida y el agua a tod@s.',
		args = {GetPlayerName(xPlayer.source), xPlayer.source, rankName, rankLabel}
	})
	TriggerClientEvent('chat:addMessage', xPlayer.source, {
		template = '<span class="badge badge-staff">{0}</span> Le has dado comida y agua a <span class="badge badge-gray">{1}</span>',
		args = {"SISTEMA", "@TODOS"}
	})

	TriggerClientEvent('bm_admin:eat', -1)
end, false, {help = "Da de comer y beber a todos", validate = false, arguments = {}}) 

core.RegisterCommand('givemoneyall', 1, function(xPlayer, args, showError)
    if not xPlayer then
        return print('[^1ERROR^7] El valor de xPlayer es nulo')
    end

    local playerRank, label, rankName = lib.getPlayerRank(xPlayer.source, true)
    local rankLabel = label:sub(3)

    -- Verifica si se proporcionaron los argumentos correctos
    if #args == 2 then
        local tipoDePlata = args[1]
        local cantidadDePlata = tonumber(args[2])

        if tipoDePlata and cantidadDePlata then
            for _, playerId in ipairs(GetPlayers()) do
                local targetXPlayer = ESX.GetPlayerFromId(playerId)

                if targetXPlayer then
                    if tipoDePlata == "efectivo" then
                        targetXPlayer.addMoney('money', cantidadDePlata)
                    elseif tipoDePlata == "banco" then
                        targetXPlayer.addAccountMoney('bank', cantidadDePlata)
                    end
                end
            end

            TriggerClientEvent('chat:addMessage', -1, {
                template = '<span class="badge badge-{2}">{3}</span> <span class="badge badge-white">{0}</span> <span class="badge badge-gray">[#{1}]</span> le ha dado $' .. cantidadDePlata .. ' de ' .. tipoDePlata .. ' a tod@s.',
                args = {GetPlayerName(xPlayer.source), xPlayer.source, rankName, rankLabel}
            })

            TriggerClientEvent('chat:addMessage', xPlayer.source, {
                template = '<span class="badge badge-staff">{0}</span> Has dado $' .. cantidadDePlata .. ' de ' .. tipoDePlata .. ' a <span class="badge badge-gray">@TODOS</span>',
                args = {"SISTEMA"}
            })
        else
            -- Mensaje si los argumentos no son válidos
            TriggerClientEvent('chat:addMessage', xPlayer.source, {
                template = '<span class="badge badge-staff">{0}</span> Uso incorrecto del comando. Ejemplo: /givemoneyall efectivo 5000',
                args = {"SISTEMA"}
            })
        end
    else
        -- Mensaje si no se proporcionaron suficientes argumentos
        TriggerClientEvent('chat:addMessage', xPlayer.source, {
            template = '<span class="badge badge-staff">{0}</span> Uso incorrecto del comando. Ejemplo: /givemoneyall efectivo 5000',
            args = {"SISTEMA"}
        })
    end
end, false, {help = "Da dinero a todos los jugadores", validate = false, arguments = {
    {name = 'tipoDePlata', help = 'Tipo de dinero (efectivo/banco)', type = 'string'},
    {name = 'cantidadDePlata', help = 'Cantidad de dinero', type = 'number'}
}})



core.RegisterCommand('healall', 1, function(xPlayer, args, showError)
	if not xPlayer then
		return print('[^1ERROR^7] The xPlayer value is nil')
	end
	
	local playerRank, label, rankName = lib.getPlayerRank(xPlayer.source, true)
	local rankLabel = label:sub(3)

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<span class="badge badge-{2}">{3}</span> <span class="badge badge-white">{0}</span> <span class="badge badge-gray">[#{1}]</span> curó a tod@s.',
		args = {GetPlayerName(xPlayer.source), xPlayer.source, rankName, rankLabel}
	})
	TriggerClientEvent('chat:addMessage', xPlayer.source, {
		template = '<span class="badge badge-staff">{0}</span> Has curado a <span class="badge badge-gray">{1}</span>',
		args = {"SISTEMA", "@TODOS"}
	})

	TriggerClientEvent('esx_basicneeds:healPlayer', -1)
end, false, {help = "Cura a todos", validate = false, arguments = {}}) 