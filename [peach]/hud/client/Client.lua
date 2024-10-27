local PlayerPedId, NetworkIsPlayerTalking, GetPlayerSprintStaminaRemaining, SendNUIMessage = PlayerPedId, NetworkIsPlayerTalking, GetPlayerSprintStaminaRemaining, SendNUIMessage
local money, bank, black_money, coins = 0, 0, 0, 0
local loaded = false

function GetPlayerMugshot(ped, transparent)
    if not DoesEntityExist(ped) then return end
    local mugshot = transparent and RegisterPedheadshotTransparent(ped) or RegisterPedheadshot(ped)

    while not IsPedheadshotReady(mugshot) do
        Wait(5000)
    end

    return mugshot, GetPedheadshotTxdString(mugshot)
end

local mostrar = true 

RegisterCommand(Config.CommandHideHud, function ()
    if mostrar then 
         mostrar = false
    else 
        mostrar = true
    end
end)

AddEventHandler('playerSpawned', function() 
    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end
 
    PlayerData = ESX.GetPlayerData()
    for i = 1, #PlayerData.accounts do
        if PlayerData.accounts[i].name == 'money' then
            money = PlayerData.accounts[i].money
        elseif PlayerData.accounts[i].name == 'bank' then
            bank = PlayerData.accounts[i].money
        elseif PlayerData.accounts[i].name == 'coins' then
            coins = PlayerData.accounts[i].money
        elseif PlayerData.accounts[i].name == 'black_money' then
            black_money = PlayerData.accounts[i].money
        end
    end

    SendNUIMessage({
        action = 'UpdateMoney';
        money = money;
        bank = bank;
        coins = coins;
        black_money = black_money;
    })

    SendNUIMessage({
        action = 'UpdateJob', 
        job = PlayerData.job.label,
        jobb = PlayerData.job.grade_label
    })
    
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if account.name == 'money' then
        money = account.money
    elseif account.name == 'bank' then
        bank = account.money
    elseif account.name == 'coins' then
        coins = account.money
    elseif account.name == 'black_money' then
        black_money = account.money
    end
    SendNUIMessage({
        action = 'UpdateMoney';
        money = money;
        bank = bank;
        coins = coins;
        black_money = black_money;
    })
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    SendNUIMessage({
        action = 'UpdateJob', 
        job = job.label,
        jobb = job.grade_label
    })

end)

----------
-- OCULTAR CUANDO USAN /hud
----------
CreateThread(function() 
    while true do 
        Wait(1000)
        if mostrar then
            local player = PlayerPedId()
            local playerid = PlayerId()

            SendNUIMessage({
                action = 'VerHud',
                food = food, 
                water = water,
                nombre = GetPlayerName(playerid),
                pid = GetPlayerServerId(playerid),
                talking = NetworkIsPlayerTalking(playerid),
            })
        else
            SendNUIMessage({
                action = 'OcultarHud'
            })
        end
    end
end)
----------
-- OCULTAR CUANDO USAN /hud
----------

CreateThread(function() 
        while true do 
            Wait(1000)
            if not IsPauseMenuActive() and loaded then --and mostrar
                local player = PlayerPedId()
                local playerid = PlayerId()

                SendNUIMessage({
                    action = 'update',
                    food = food, 
                    water = water,
                    nombre = GetPlayerName(playerid),
                    pid = GetPlayerServerId(playerid),
                    talking = NetworkIsPlayerTalking(playerid),
                })
            else
                SendNUIMessage({
                    action = 'hideAllHud'
                })
            end
        end
end)

CreateThread(function() 
    while true do 
        Wait(Config.timetomugshot)
        if not IsPauseMenuActive() and loaded then --and mostrar
            local playerPed = PlayerPedId()
            local mugshot, mugshotStr = GetPlayerMugshot(playerPed, true)

            SendNUIMessage({
                action = 'mugshotes',
                img = mugshotStr,
            })
        else
            SendNUIMessage({
                action = 'hideAllHud'
            })
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            while ESX.GetPlayerData().job == nil do
                Wait(10)
            end
         
            PlayerData = ESX.GetPlayerData()
            loaded = true
            for i = 1, #PlayerData.accounts do
                if PlayerData.accounts[i].name == 'money' then
                    money = PlayerData.accounts[i].money
                elseif PlayerData.accounts[i].name == 'bank' then
                    bank = PlayerData.accounts[i].money
                elseif PlayerData.accounts[i].name == 'coins' then
                    coins = PlayerData.accounts[i].money
                elseif PlayerData.accounts[i].name == 'black_money' then
                    black_money = PlayerData.accounts[i].money
                end
            end
            SendNUIMessage({
                action = 'UpdateMoney';
                money = money;
                bank = bank;
                coins = coins;
                black_money = black_money;
            })

            SendNUIMessage({
                action = 'UpdateJob', 
                job = PlayerData.job.label,
                jobb = PlayerData.job.grade_label
            })

            break
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    SendNUIMessage({
        action = 'UpdateJob', 
        job = xPlayer.job.label,
        datajob = xPlayer.job.name,
        jobb = xPlayer.job.grade_label
    })
end)

AddEventHandler('pma-voice:setTalkingMode', function()
    SendNUIMessage({ 
        action = 'UpdateVoice', 
        value = LocalPlayer.state.proximity and LocalPlayer.state.proximity.mode or "Normal" })
end)



food, water = 0, 0
CreateThread(function()
    while true do
        Wait(Config.StatusUpdateInterval)
        if not IsPauseMenuActive() and loaded then --and mostrar
            GetStatus(function(data)
                food = data[1]
                water = data[2]
            end)
        end
    end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(200)
        
-- 		if not Config.ui.showMinimap then
-- 				DisplayRadar(true)
-- 			end

-- 			if Config.ui.showMinimap == false then
-- 				DisplayRadar(false)
-- 			end
--         end
-- end)