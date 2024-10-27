-- @vars
local showHud = true
ESX = exports['es_extended']:getSharedObject()
local weaponList = {
    [GetHashKey("WEAPON_DAGGER")] = "Daga",
    [GetHashKey("WEAPON_BAT")] = "Bate",
    [GetHashKey("WEAPON_BOTTLE")] = "Botella rota",
    [GetHashKey("WEAPON_CROWBAR")] = "Palanca",
    [GetHashKey("WEAPON_FLASHLIGHT")] = "Linterna",
    [GetHashKey("WEAPON_GOLFCLUB")] = "Palo de golf",
    [GetHashKey("WEAPON_HAMMER")] = "Martillo",
    [GetHashKey("WEAPON_HATCHET")] = "Hacha",
    [GetHashKey("WEAPON_KNUCKLE")] = "Puño americano",
    [GetHashKey("WEAPON_KNIFE")] = "Cuchillo",
    [GetHashKey("WEAPON_MACHETE")] = "Machete",
    [GetHashKey("WEAPON_SWITCHBLADE")] = "Navaja",
    [GetHashKey("WEAPON_NIGHTSTICK")] = "Porra",
    [GetHashKey("WEAPON_WRENCH")] = "Llave inglesa",
    [GetHashKey("WEAPON_BATTLEAXE")] = "Hacha de batalla",
    [GetHashKey("WEAPON_POOLCUE")] = "Taco de billar",

    [GetHashKey("WEAPON_PISTOL")] = "Pistola",
    [GetHashKey("WEAPON_COMBATPISTOL")] = "Pistola de combate",
    [GetHashKey("WEAPON_APPISTOL")] = "Pistola AP",
    [GetHashKey("WEAPON_PISTOL50")] = "Pistola .50",
    [GetHashKey("WEAPON_SNSPISTOL")] = "Pistola SNS",
    [GetHashKey("WEAPON_HEAVYPISTOL")] = "Pistola pesada",
    [GetHashKey("WEAPON_VINTAGEPISTOL")] = "Pistola vintage",
    [GetHashKey("WEAPON_FLAREGUN")] = "Pistola de bengalas",
    [GetHashKey("WEAPON_MARKSMANPISTOL")] = "Pistola de tirador",
    [GetHashKey("WEAPON_REVOLVER")] = "Revólver",
    [GetHashKey("WEAPON_DOUBLEACTION")] = "Revólver de doble acción",

    [GetHashKey("WEAPON_MICROSMG")] = "Micro SMG",
    [GetHashKey("WEAPON_SMG")] = "SMG",
    [GetHashKey("WEAPON_ASSAULTSMG")] = "SMG de asalto",
    [GetHashKey("WEAPON_COMBATPDW")] = "PDW de combate",
    [GetHashKey("WEAPON_MACHINEPISTOL")] = "Pistola automática",
    [GetHashKey("WEAPON_MINISMG")] = "Mini SMG",
    [GetHashKey("WEAPON_GUSENBERG")] = "Gusenberg",
    
    [GetHashKey("WEAPON_ASSAULTRIFLE")] = "Rifle de asalto",
    [GetHashKey("WEAPON_CARBINERIFLE")] = "Rifle de carabina",
    [GetHashKey("WEAPON_ADVANCEDRIFLE")] = "Rifle avanzado",
    [GetHashKey("WEAPON_SPECIALCARBINE")] = "Carabina especial",
    [GetHashKey("WEAPON_BULLPUPRIFLE")] = "Rifle bullpup",
    [GetHashKey("WEAPON_COMPACTRIFLE")] = "Rifle compacto",

    [GetHashKey("WEAPON_PUMPSHOTGUN")] = "Escopeta",
    [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = "Escopeta de cañón recortado",
    [GetHashKey("WEAPON_BULLPUPSHOTGUN")] = "Escopeta bullpup",
    [GetHashKey("WEAPON_ASSAULTSHOTGUN")] = "Escopeta de asalto",
    [GetHashKey("WEAPON_MUSKET")] = "Mosquete",
    [GetHashKey("WEAPON_HEAVYSHOTGUN")] = "Escopeta pesada",
    [GetHashKey("WEAPON_DBSHOTGUN")] = "Escopeta DB",
    [GetHashKey("WEAPON_AUTOSHOTGUN")] = "Escopeta automática",

    [GetHashKey("WEAPON_SNIPERRIFLE")] = "Rifle de francotirador",
    [GetHashKey("WEAPON_HEAVYSNIPER")] = "Francotirador pesado",
    [GetHashKey("WEAPON_MARKSMANRIFLE")] = "Rifle de tirador",
    [GetHashKey("WEAPON_RAILGUN")] = "Cañón de riel",
    [GetHashKey("WEAPON_HOMINGLAUNCHER")] = "Lanzacohetes guiado",
    [GetHashKey("WEAPON_GRENADELAUNCHER")] = "Lanzagranadas",
    [GetHashKey("WEAPON_COMPACTLAUNCHER")] = "Lanzador compacto",
    [GetHashKey("WEAPON_RPG")] = "Lanzacohetes",
    [GetHashKey("WEAPON_MINIGUN")] = "Minigun",
    [GetHashKey("WEAPON_FIREWORK")] = "Fuegos artificiales",
}
local date, hour = nil, nil

-- @threads
CreateThread(function()
    while ESX.GetPlayerData() == nil do
        Wait(0)
    end

    while ESX.GetPlayerData().accounts == nil do
        Wait(0)
    end
    while true do
        local playerPed = PlayerPedId()
        local playerData = ESX.GetPlayerData()
        local hunger, thirst, drunk = 0, 0, 0

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)

        local bank, black_money, money, vip = 0, 0, 0, 0

        for i,v in pairs(playerData.accounts) do
            if v.name == 'bank' then
                bank = v.money
            elseif v.name == 'black_money' then
                black_money = v.money
            elseif v.name == 'money' then
                money = v.money
            elseif v.name == 'vip' then
                vip = v.money
            end
        end

        local fuel

        if (GetResourceState('LegacyFuel') == 'started') then
            fuel = math.floor(exports['LegacyFuel']:GetFuel(GetVehiclePedIsIn(playerPed, false)))
        else
            fuel = 0
        end

        SendNUIMessage({
            action = "update",
            job = ("%s - %s"):format(playerData.job.label, playerData.job.grade_label),
            accounts = {bank, black_money, money, vip},
            ammo = GetAmmoInPedWeapon(playerPed, GetSelectedPedWeapon(playerPed)),
            weapon = weaponList[GetSelectedPedWeapon(playerPed)],
            vehicle = IsPedInAnyVehicle(playerPed, false),
            vehicleSpeed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(playerPed, false)) * 3.6),
            fuel = fuel,
            hunger = math.floor(hunger),
            thirst = math.floor(thirst),
            playerId = GetPlayerServerId(PlayerId()),
            date = date,
            hour = hour,
            show = showHud,
            mhz = exports['x-radiolist']:getCurrentRadio()
        })

        Wait(1500)
    end
end)

local serverStats = false
RegisterCommand('open_server_stats', function()
    serverStats = not serverStats
    ESX.TriggerServerCallback('bm_hud:getCopsAndPlayers', function(cops, medicos, gendarmes, players)
        SendNUIMessage({
            action = "serverStats",
            show = serverStats,
            cops = cops,
            medicos = medicos,
            gendarmes = gendarmes,
            players = players,
            maxPlayers = GetConvarInt('sv_maxclients', 128)
        })
    end)
end)
RegisterKeyMapping('open_server_stats', 'Abrir estadísticas del servidor', 'keyboard', 'Z')


CreateThread(function()
    while true do

        ESX.TriggerServerCallback('bm_hud:askDate', function(hours, dates)
            date = dates
            hour = hours
        end)

        Wait(60000)
    end
end)

-- @funcs
RegisterCommand('hud', function()
    showHud = not showHud

    if (showHud) then
        TriggerEvent('chat:addMessage', {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "Has ^9activado^7 el hud."}
        })
    else
        TriggerEvent('chat:addMessage', {
            template = '<span class="badge badge-staff">{0}</span> {1}',
            args = {"SISTEMA", "Has ^1desactivado^7 el hud."}
        })
    end

    SendNUIMessage({
        action = "show",
        show = showHud
    })
end)