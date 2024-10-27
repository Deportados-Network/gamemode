function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('depo_notify:Alert')
AddEventHandler('depo_notify:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)

-- RegisterCommand('success', function()
-- 	exports['depo_notify']:Alert("SUCCESS", "You have sent <span style='color:#47cf73'>420€</span> to Tommy!", 5000, 'correcto')
-- end)
-- 
-- RegisterCommand('info', function()
-- 	exports['depo_notify']:Alert("INFO", "The Casino has opened!", 5000, 'general')
-- end)
-- 
-- RegisterCommand('error', function()
-- 	exports['depo_notify']:Alert("ERROR", "Please try again later!", 5000, 'error')
-- end)
-- 
-- RegisterCommand('warning', function()
-- 	exports['depo_notify']:Alert("WARNING", "You are getting nervous!", 5000, 'advertencia')
-- end)
-- 
-- RegisterCommand('phone', function()
-- 	exports['depo_notify']:Alert("SMS", "<span style='color:#f38847'>Tommy: </span> Where are you?", 5000, 'mensajes')
-- end)