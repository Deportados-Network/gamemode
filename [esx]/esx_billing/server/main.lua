
RegisterNetEvent('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
		if string.match(sharedAccountName, "society_") then
			local jobName = string.gsub(sharedAccountName, 'society_', '')
			if xPlayer.job.name ~= jobName then
				print(("[^2ERROR^7] Player ^5%s^7 Attempted to Send bill from a society (^5%s^7), but does not have the correct Job - Possibly Cheats"):format(xPlayer.source, sharedAccountName))
				return
			end
			TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
				if account then
					MySQL.insert('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (?, ?, ?, ?, ?, ?)', {xTarget.identifier, xPlayer.identifier, 'society', sharedAccountName, label, amount},
					function(rowsChanged)
						xTarget.showNotification(TranslateCap('received_invoice'))
					end)
				else
					print(("[^2ERROR^7] Player ^5%s^7 Attempted to Send bill from invalid society - ^5%s^7"):format(xPlayer.source, sharedAccountName))
				end
			end)
		else
			MySQL.insert('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (?, ?, ?, ?, ?, ?)', {xTarget.identifier, xPlayer.identifier, 'player', xPlayer.identifier, label, amount},
			function(rowsChanged)
				xTarget.showNotification(TranslateCap('received_invoice'))
			end)
		end
	end
end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT amount, id, label FROM billing WHERE identifier = ?', {xPlayer.identifier},
	function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		MySQL.query('SELECT amount, id, label FROM billing WHERE identifier = ?', {xPlayer.identifier},
		function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, billId)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.single('SELECT sender, target_type, target, amount FROM billing WHERE id = ?', {billId},
    function(result)
        if result then
            local amount = result.amount
            local xTarget = ESX.GetPlayerFromIdentifier(result.target)
            print ("xTarget")

            if not xTarget then
                print(('ERROR: Player %s attempted to pay bill for %s, but the target is not online.'):format(xPlayer.identifier, result.target))
                xPlayer.showNotification(TranslateCap('target_not_online'))
                cb()
                return
            end

            print(('INFO: Player %s is attempting to pay bill for %s'):format(xPlayer.identifier, result.target))

            if result.target_type == 'player' then
                if xPlayer.getMoney() >= amount then
                    print(('INFO: Player %s has enough cash to pay the bill'):format(xPlayer.identifier))

                    MySQL.update('DELETE FROM billing WHERE id = ?', {billId},
                    function(rowsChanged)
                        if rowsChanged == 1 then
                            xPlayer.removeMoney(amount, "Bill Paid")
                            xTarget.addMoney(amount, "Paid bill")

                            xPlayer.showNotification(TranslateCap('paid_invoice', ESX.Math.GroupDigits(amount)))
                            xTarget.showNotification(TranslateCap('received_payment', ESX.Math.GroupDigits(amount)))
                        end

                        cb()
                    end)
                elseif xPlayer.getAccount('bank').money >= amount then
                    print(('INFO: Player %s has enough money in the bank to pay the bill'):format(xPlayer.identifier))

                    MySQL.update('DELETE FROM billing WHERE id = ?', {billId},
                    function(rowsChanged)
                        if rowsChanged == 1 then
                            xPlayer.removeAccountMoney(bank, amount)
          					print ("primero")
                            xTarget.addAccountMoney(bank, amount)
                            print ("segundo")
                            xPlayer.showNotification(TranslateCap('paid_invoice', ESX.Math.GroupDigits(amount)))
                            xTarget.showNotification(TranslateCap('received_payment', ESX.Math.GroupDigits(amount)))
                        end

                        cb()
                    end)
                else
                    xTarget.showNotification(TranslateCap('target_no_money'))
                    xPlayer.showNotification(TranslateCap('no_money'))
                    print(('ERROR: Player %s attempted to pay bill but did not have enough money. Needed: %s, Player Money: %s, Player Bank: %s'):format(xPlayer.identifier, amount, xPlayer.getMoney(), xPlayer.getAccount('bank').money))
                    cb()
                end
            else
                -- Lógica para el caso 'society' (si es necesario)
            end
        end
    end)
end)


