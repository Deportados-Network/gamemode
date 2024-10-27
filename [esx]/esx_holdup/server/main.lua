local families = {
	["shop"] = false
}
local robbers = {}

RegisterServerEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function(currentStore)
	local source = source
	families[Stores[currentStore].family] = false
	Stores[currentStore].isRobbed = false
	for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', Stores[currentStore].job)) do
		TriggerClientEvent('esx_holdup:killBlip', xPlayer.source)
	end
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Robos</span>&nbsp<span class="badge badge-gray">{2}</span> &nbsp {0} &nbsp<span class="badge badge-robocancelled">{1}</span>&nbsp(^5'..(Stores[currentStore].job == "police" and "POLICIA" or "PSG")..'^7)',
		args = {"Se canceló el robo al ", Stores[currentStore].nameOfStore, "#"..source}
	})
	if robbers[source] then
		TriggerClientEvent('esx_holdup:tooFar', source)
		ESX.ClearTimeout(robbers[source])
        robbers[source] = nil
	end
end)

RegisterServerEvent('esx_holdup:robberyStarted')
AddEventHandler('esx_holdup:robberyStarted', function(currentStore)
	local source  = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	if Stores[currentStore] then
		if (Stores[currentStore].needToBeMafia) then
			if (not exports['bm_mafias']:isPlayerInMafia(source)) then
				return TriggerClientEvent('chat:addMessage', source, {
					template = '<span class="badge badge-staff">{0}</span> {1}',
					args = {"SISTEMA", "No eres mafia, no puedes robar esto."}
				})
			end
		end
		local store = Stores[currentStore]
		if (os.time() - store.lastRobbed) < Config.TimerBeforeNewRob and store.lastRobbed ~= 0 then
			TriggerClientEvent('esx:showNotification', source, TranslateCap('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lastRobbed)))
			return
		end
		if not families[Stores[currentStore].family] then
			local xPlayers = ESX.GetExtendedPlayers('job', Stores[currentStore].job)
			if #xPlayers >= Stores[currentStore].minPolices then
				families[Stores[currentStore].family] = Stores[currentStore].nameOfStore
				for i=1, #(xPlayers) do 
					local xPlayer = xPlayers[i]
					TriggerClientEvent('esx_holdup:setBlip', xPlayer.source, Stores[currentStore].position)
				end
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Robos</span>&nbsp<span class="badge badge-gray">{2}</span> &nbsp {0} &nbsp<span class="badge badge-roboexitoso">{1}</span>&nbsp(^5'..(Stores[currentStore].job == "police" and "POLICIA" or "PSG")..'^7)',
					args = {"Se inicio el robo al ", store.nameOfStore, "#"..source}
				})
				TriggerClientEvent('esx:showNotification', source, TranslateCap('started_to_rob', store.nameOfStore))
				TriggerClientEvent('esx:showNotification', source, TranslateCap('alarm_triggered'))
				TriggerClientEvent('esx_holdup:currentlyRobbing', source, currentStore)
				TriggerClientEvent('esx_holdup:startTimer', source)
				Stores[currentStore].lastRobbed = os.time()
				robbers[source] = ESX.SetTimeout(store.secondsRemaining * 1000, function()
					families[Stores[currentStore].family] = false
					Stores[currentStore].isRobbed = false
                    if xPlayer then
                        TriggerClientEvent('esx_holdup:robberyComplete', source, store.reward)
                        if Config.GiveBlackMoney then
                            xPlayer.addAccountMoney('black_money', store.reward, "Robbery")
                        else
                            xPlayer.addMoney(store.reward, "Robbery")
                        end
                        local xPlayers = ESX.GetExtendedPlayers('job', Stores[currentStore].job)
												for i=1, #(xPlayers) do 
													local xPlayer = xPlayers[i]
                            TriggerClientEvent('esx_holdup:killBlip', xPlayer.source)
                        end
						TriggerClientEvent('chat:addMessage', -1, {
							template = '<span class="badge badge-celeste"><i class="fas fa-skull"></i> Robos</span>&nbsp<span class="badge badge-gray">{2}</span> &nbsp {0} &nbsp<span class="badge badge-robo">{1}</span>&nbsp(^5'..(Stores[currentStore].job == "police" and "POLICIA" or "PSG")..'^7)',
							args = {"Se completo el robo al ", store.nameOfStore, "#"..source}
						})
                    end
				end)
			else
				TriggerClientEvent('esx:showNotification', source, TranslateCap('min_police', Stores[currentStore].minPolices))
			end
		else
			TriggerClientEvent('esx:showNotification', source, TranslateCap('robbery_already'))
		end
	end
end)

exports('getRobs', function(callback)
	local storesTemp = Stores

	for i,v in pairs(families) do
		for k,val in pairs(storesTemp) do
			if (val.nameOfStore == v) then
				val.isRobbed = true
			end
		end
	end

	callback(storesTemp)
end)