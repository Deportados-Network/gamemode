ESX = exports["es_extended"]:getSharedObject()

local zones = {}

Citizen.CreateThread(function()
    local blip_radius = {}
    local blip_marker = {}

    for k,v in pairs(Zones) do
        -- create zones depend of type

        if v['zone']['type'] == 'poly' then
            zones[k] = lib.zones.poly({
                points = v['zone']['coords'],
                thickness = v['zone']['thickness'],
                debug = v['zone']['debug'],
                inside = v['zone']['action'].inside,
                onEnter = v['zone']['action'].onEnter,
                onExit = v['zone']['action'].onExit
            })
        elseif v['zone']['type'] == 'box' then
            zones[k] = lib.zones.box({
                coords = v['zone']['coords'][1],
                size = v['zone']['size'],
                rotation = v['zone']['rotation'],
                debug = v['zone']['debug'],
                inside = v['zone']['action'].inside,
                onEnter = v['zone']['action'].onEnter,
                onExit = v['zone']['action'].onExit
            })
        elseif v['zone']['type'] == 'sphere' then
            zones[k] = lib.zones.sphere({
                coords = v['zone']['coords'][1],
                radius = v['zone']['radius'],
                debug = v['zone']['debug'],
                inside = v['zone']['action'].inside,
                onEnter = v['zone']['action'].onEnter,
                onExit = v['zone']['action'].onExit
            })
        end

        -- create radius blip if enabled
        if v['blip']['blip_radius']['enabled'] then
            blip_radius[k] = AddBlipForRadius(v['blip']['blip_radius']['coords']['X'], v['blip']['blip_radius']['coords']['Y'], v['blip']['blip_radius']['coords']['Z'], v['blip']['blip_radius']['radius'])
            SetBlipHighDetail(blip_radius[k], true)
            SetBlipColour(blip_radius[k], v['blip']['blip_radius']['color'])
            SetBlipAlpha(blip_radius[k], v['blip']['blip_radius']['alpha'])
            SetBlipAsShortRange(blip_radius[k], true)
        end
        -- create blip if enabled
        if v['blip']['blip_marker']['enabled'] then
            blip_marker[k] = AddBlipForCoord(v['blip']['blip_marker']['coords']['X'], v['blip']['blip_marker']['coords']['Y'], v['blip']['blip_marker']['coords']['Z'])
            SetBlipSprite(blip_marker[k], v['blip']['blip_marker']['sprite'])
            SetBlipDisplay(blip_marker[k], v['blip']['blip_marker']['display'])
            SetBlipScale(blip_marker[k], v['blip']['blip_marker']['scale'])
            SetBlipColour(blip_marker[k], v['blip']['blip_marker']['color'])
            SetBlipAsShortRange(blip_marker[k], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v['blip']['blip_marker']['text'])
            EndTextCommandSetBlipName(blip_marker[k])
        end
    end
end)

-- ZONAS ROJAS

local dentroDeZonaRoja = {}

function InsideRojaZone(self)
    local playerID = PlayerId()

    if not dentroDeZonaRoja[playerID] then
        local message = "Entraste en una zona roja!"

        exports['depo_notify']:Alert("ZONA ROJA", (message), 5000, 'error')

        dentroDeZonaRoja[playerID] = true
    end
end

function ExitRojaZone(self)
    exports['depo_notify']:Alert("ZONA ROJA", "Saliste en una zona roja!", 5000, 'error')

    local playerID = PlayerId()
    
    dentroDeZonaRoja[playerID] = false
end

-- ZONAS DE SECUESTRO

local dentroDeZonaSecuestro = {}

function InsideSecuestroZone(self)
    local playerID = PlayerId()

    if not dentroDeZonaSecuestro[playerID] then
        local message = "Entraste en zona de secuestro!"

        exports['depo_notify']:Alert("ZONA DE SECUESTRO", (message), 5000, 'error')

        dentroDeZonaSecuestro[playerID] = true
    end
end

function ExitSecuestroZone(self)
    exports['depo_notify']:Alert("ZONA DE SECUESTRO", "Saliste en zona de secuestro!", 5000, 'error')

    local playerID = PlayerId()
    
    dentroDeZonaSecuestro[playerID] = false
end

-- ZONAS DE ROBO

local dentroDeZonaRobo = {}

function InsideRoboZone(self)
    local playerID = PlayerId()

    if not dentroDeZonaRobo[playerID] then
        local message = "Entraste a una zona de robo!"

        exports['depo_notify']:Alert("ZONA DE ROBO", (message), 5000, 'error')

        dentroDeZonaRobo[playerID] = true
    end
end

function ExitRoboZone(self)
    exports['depo_notify']:Alert("ZONA DE ROBO", "Saliste de una zona de robo!", 5000, 'error')

    local playerID = PlayerId()
    
    dentroDeZonaRobo[playerID] = false
end

-- ZONAS SEGURAS

local dentroDeZonaSegura = {}

function InsideSafeZone(self)
    local playerID = PlayerId()

    if not dentroDeZonaSegura[playerID] then
        local message = "Entraste a una zona segura!"

        exports['depo_notify']:Alert("ZONA SEGURA", (message), 5000, 'general')

        dentroDeZonaSegura[playerID] = true
    end
    
    if IsPedArmed(cache.ped, GetHashKey("WEAPON_UNARMED")) then
        SetCurrentPedWeapon(cache.ped, GetHashKey("WEAPON_UNARMED"), true)
        DisablePlayerFiring(cache.ped, true)
        SetWeaponDamageModifierThisFrame(GetSelectedPedWeapon(cache.ped), -1000)
    end

    DisableControlAction(2, 37, true)
    DisableControlAction(0, 106, true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 69, true)
    DisableControlAction(0, 70, true)
    DisableControlAction(0, 92, true)
    DisableControlAction(0, 114, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 331, true)
    DisableControlAction(0, 68, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(0, 263, true)
    DisableControlAction(0, 264, true)

    if IsPedInAnyVehicle(cache.ped, false) then
        veh = GetVehiclePedIsUsing(cache.ped)
        SetEntityCanBeDamaged(veh, false)
    end

    SetPedCanRagdoll(cache.ped, false)
    ClearPedBloodDamage(cache.ped)
    ResetPedVisibleDamage(cache.ped)
    ClearPedLastWeaponDamage(cache.ped)
    SetCanAttackFriendly(cache.ped, false, false)
    NetworkSetFriendlyFireOption(false)

    for _, players in pairs(GetActivePlayers()) do
        local target = GetPlayerPed(players)

        if IsPedInAnyVehicle(target, true) then
            target_veh = GetVehiclePedIsUsing(target)
            SetEntityNoCollisionEntity(PlayerPedId(), target_veh, true)
            SetEntityNoCollisionEntity(target_veh, PlayerPedId(), true)
        end

        if IsPedInAnyVehicle(cache.ped, true) then
            player_veh = GetVehiclePedIsUsing(cache.ped)
            SetEntityNoCollisionEntity(target, player_veh, true)
            SetEntityNoCollisionEntity(player_veh, target, true)
        end

        if IsPedInAnyVehicle(cache.ped, true) and IsPedInAnyVehicle(target, true) then
            SetEntityNoCollisionEntity(GetVehiclePedIsUsing(cache.ped), GetVehiclePedIsUsing(target), true)
            SetEntityNoCollisionEntity(GetVehiclePedIsUsing(target), GetVehiclePedIsUsing(cache.ped), true)
        end

        SetEntityNoCollisionEntity(PlayerPedId(), target, true)

        SetEntityNoCollisionEntity(target, PlayerPedId(), true)
    end
end

function ExitSafezone(self)
    exports['depo_notify']:Alert("ZONA SEGURA", "Saliste de una zona segura!", 5000, 'general')

    local playerID = PlayerId()
    
    dentroDeZonaSegura[playerID] = false

    SetPedCanRagdoll(cache.ped, true)
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(cache.ped, true, false)

    if IsPedInAnyVehicle(cache.ped, false) then
        veh = GetVehiclePedIsUsing(cache.ped)
        SetEntityCanBeDamaged(veh, true)
    end

    SetPedMoveRateOverride(PlayerId(), 0.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.00)
end

function SwitchDimension(dimensionId)
    local passengers = {}

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        local maxpeds = GetVehicleMaxNumberOfPassengers(veh)
        for i = -1, maxpeds do
            if not IsVehicleSeatFree(veh, i) then
                local ped = GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(veh, i)))
                table.insert(passengers , {
                    serverId  = ped,
                })
            end
        end
    end
    local switch_bucket = lib.callback.await('depo_zones:switchBucket', false, dimensionId, IsPedInAnyVehicle(PlayerPedId(), false), passengers)
    if switch_bucket then print("[DEBUG]: Switching bucket to "..dimensionId) end
end