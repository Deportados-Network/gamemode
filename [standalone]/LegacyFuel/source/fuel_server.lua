ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount = ESX.Math.Round(price)

	if price > 0 then
		xPlayer.removeMoney(amount)
		xPlayer.addInventoryItem("WEAPON_PETROLCAN", 1)
	end
end)