-- @vars
ESX = exports['es_extended']:getSharedObject()
local playerData = {}
local cache = {metadata = {members = {}, vehicleColor = {primaryColor = {r = 0, g = 0, b = 0}, secondaryColor = {r = 0, g = 0, b = 0}}}}
local clothesCache = {}
local mafiaBlip = nil
isHandcuff = false
isDragged = false
local weapons = {
    [GetHashKey('WEAPON_PISTOL')] = { suppressor = GetHashKey('component_at_pi_supp_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_PISTOL50')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE') },
    [GetHashKey('WEAPON_COMBATPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_APPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_HEAVYPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE') },
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = nil, grip = nil, skin = nil },
    [GetHashKey('WEAPON_SMG')] = { sight = GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"), suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_SMG_VARMOD_LUXE'), sight = GetHashKey("COMPONENT_AT_SCOPE_MACRO_02") },
    [GetHashKey('WEAPON_MICROSMG')] = { sight = GetHashKey("COMPONENT_AT_SCOPE_MACRO"), suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE') },
    [GetHashKey('WEAPON_ASSAULTSMG')] = { sight = GetHashKey("COMPONENT_AT_SCOPE_MACRO"), suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = { sight = GetHashKey('COMPONENT_AT_SCOPE_MACRO'), suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_CARBINERIFLE')] = { sight = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'), suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = { sight = GetHashKey('COMPONENT_AT_SCOPE_SMALL'), suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE') },
    [GetHashKey('WEAPON_SPECIALCARBINE')] = { sight = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'), suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = { sight = GetHashKey('COMPONENT_AT_SCOPE_SMALL'), suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_SR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil },
    [GetHashKey('WEAPON_SNIPERRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = nil, grip = nil, skin = nil },
    [GetHashKey('WEAPON_COMBATPDW')] = { sight = GetHashKey('COMPONENT_AT_SCOPE_SMALL'), suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil }
}

-- @exports
function isPlayerMafia()
    return playerData and playerData.name, (playerData and playerData.name and playerData.name or nil), playerData
end
exports('isPlayerMafia', isPlayerMafia)



function IsPointValid(playerData, pointName)
    local isValid = playerData.points[pointName] and playerData.points[pointName].x ~= nil
    return isValid
end

-- @threads
CreateThread(function()
    while true do
        local msec = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if (playerData.name) then
            if not HasStreamedTextureDictLoaded("marker") then
                RequestStreamedTextureDict("marker", true)
                while not HasStreamedTextureDictLoaded("marker") do
                    Wait(1)
                end
            end
            if (playerData.points.garage) then
                if #(playerCoords - vec3(playerData.points.garage.x, playerData.points.garage.y, playerData.points.garage.z)) < 10.0 then
                    msec = 0
                    DrawMarker(9, vec3(playerData.points.garage.x, playerData.points.garage.y, playerData.points.garage.z), 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, false, 2, true, "marker", "marker", false)
                    if #(playerCoords - vec3(playerData.points.garage.x, playerData.points.garage.y, playerData.points.garage.z)) < 1.5 then
                        ESX.ShowFloatingHelpNotification((IsPedInAnyVehicle(playerPed) and "~INPUT_CONTEXT~ Guardar vehiculo" or "~INPUT_CONTEXT~ Garaje"), vector3(playerData.points.garage.x, playerData.points.garage.y, playerData.points.garage.z))
                        if (IsControlJustPressed(0, 38)) then
                            if (IsPedInAnyVehicle(playerPed)) then
                                DeleteEntity(GetVehiclePedIsIn(playerPed))
                                DeleteVehicle(GetVehiclePedIsIn(playerPed))
                            else
                                openGarageMenu(playerData.points.garage.x, playerData.points.garage.y, playerData.points.garage.z, playerData.points.garage.w)
                            end
                        end
                    end
                end
            end

            if (playerData.points.revive) then
                if #(playerCoords - vec3(playerData.points.revive.x, playerData.points.revive.y, playerData.points.revive.z)) < 10.0 then
                    msec = 0
                    DrawMarker(9, vec3(playerData.points.revive.x, playerData.points.revive.y, playerData.points.revive.z), 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, false, 2, true, "marker", "marker", false)
                    if #(playerCoords - vec3(playerData.points.revive.x, playerData.points.revive.y, playerData.points.revive.z)) < 1.5 then
                        ESX.ShowFloatingHelpNotification(("~INPUT_CONTEXT~ Revivir"), vector3(playerData.points.revive.x, playerData.points.revive.y, playerData.points.revive.z))
                        if (IsControlJustPressed(0, 38)) then
                            openReviveMenu()
                        end
                    end
                end
            end



            if (playerData.points.wardobe) then
                if #(playerCoords - vec3(playerData.points.wardobe.x, playerData.points.wardobe.y, playerData.points.wardobe.z)) < 10.0 then
                    msec = 0
                    DrawMarker(9, vec3(playerData.points.wardobe.x, playerData.points.wardobe.y, playerData.points.wardobe.z), 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, false, 2, true, "marker", "marker", false)
                    if #(playerCoords - vec3(playerData.points.wardobe.x, playerData.points.wardobe.y, playerData.points.wardobe.z)) < 1.5 then
                        ESX.ShowFloatingHelpNotification("~INPUT_CONTEXT~ Vestuario", vec3(playerData.points.wardobe.x, playerData.points.wardobe.y, playerData.points.wardobe.z))
                        if (IsControlJustPressed(0, 38)) then
                            openWardobeMenu()
                        end
                    end
                end
            end

            if (playerData.points.shopmafia) then
                if #(playerCoords - vec3(playerData.points.shopmafia.x, playerData.points.shopmafia.y, playerData.points.shopmafia.z)) < 10.0 then
                    msec = 0
                    DrawMarker(9, vec3(playerData.points.shopmafia.x, playerData.points.shopmafia.y, playerData.points.shopmafia.z), 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, false, 2, true, "marker", "marker", false)
                    if #(playerCoords - vec3(playerData.points.shopmafia.x, playerData.points.shopmafia.y, playerData.points.shopmafia.z)) < 1.5 then
                        ESX.ShowFloatingHelpNotification("~INPUT_CONTEXT~ Tienda", vec3(playerData.points.shopmafia.x, playerData.points.shopmafia.y, playerData.points.shopmafia.z))
                        if (IsControlJustPressed(0, 38)) then
                            exports.ox_inventory:openInventory('shop', { type = 'Mafias', id = 4 })
                        end
                    end
                end
            end


            if (playerData.points.inventory) then
                if #(playerCoords - vec3(playerData.points.inventory.x, playerData.points.inventory.y, playerData.points.inventory.z)) < 10.0 then
                    msec = 0
                    DrawMarker(9, vec3(playerData.points.inventory.x, playerData.points.inventory.y, playerData.points.inventory.z), 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,false, false, 2, true, "marker", "marker", false)
                    if #(playerCoords - vec3(playerData.points.inventory.x, playerData.points.inventory.y, playerData.points.inventory.z)) < 1.5 then
                        ESX.ShowFloatingHelpNotification("~INPUT_CONTEXT~ Inventario", vec3(playerData.points.inventory.x, playerData.points.inventory.y, playerData.points.inventory.z))
                        if (IsControlJustPressed(0, 38)) then
                            exports['ox_lib']:registerContext({
                                id = "mafias_armory",
                                title = "Inventario de mafia",
                                options = {
                                    {title = "Inventario general", icon = "fas fa-box-open", onSelect = function()
                                        exports.ox_inventory:openInventory('stash', {id = playerData.name, owner = playerData.name})
                                    end}
                                }
                            })
                            exports['ox_lib']:showContext("mafias_armory")
                            --fas fa-shopping-cart
                        end
                    end
                end
            end
        end

        Wait(msec)
    end
end)

-- @events
RegisterNetEvent('bm_mafias:setPlayerData', function(player, checkMafia)
    if (checkMafia) then
        if (playerData and playerData.name == checkMafia) then
            local tempRank = playerData.playerRank
            playerData = player
            playerData.playerRank = tempRank
        end
    else
        playerData = player
    end

    createMafiaBlip()
    createMafiaBlip2()
end)

RegisterNetEvent("bm_mafias:inviteMafia", function(mafiaName)
    local alert = lib.alertDialog({
        header = 'Invitación a banda',
        content = 'Has sido invitado a la banda/mafia "'..mafiaName..'"',
        centered = true,
        cancel = true
    })
    
    if (alert == 'confirm') then
        TriggerServerEvent('bm_mafia:addToMafia', mafiaName)
    end
end)

-- @commands
RegisterCommand('menu_de_mafia', function(src, args)
    if (playerData and playerData.name) then
        openMafiaMenu()
    end
end)
RegisterKeyMapping('menu_de_mafia', 'Abrir el menú de mafia', 'keyboard', 'F5')

RegisterCommand('administrarmafia', function(src, args)
    if (playerData and playerData.name and playerData.playerRank == 1) then
        openBossMenu()
    end
end)

RegisterCommand('crearmafia', function(src, args)
    ESX.TriggerServerCallback('bm_mafias:isAdmin', function(is)
        if (is) then
            openCreatorMenu()
        end
    end)
end)

-- @funcs
function openGarageMenu(x,y,z,w)
    local elems = {}
    table.insert(elems, {
        id = 'garage_mafia',
        title = 'Garaje de mafia',
        options = {}
    })

    if (playerData.vehicleList) then
        for i,v in pairs(playerData.vehicleList) do
            table.insert(elems[1].options, {
                title = v,
                onSelect = function(args)
                    RequestModel(v)
                    while not HasModelLoaded(v) do
                        Wait(0)
                    end
                    local vehicle = CreateVehicle(GetHashKey(v), x, y, z, w, true, false)
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    SetVehicleCustomPrimaryColour(vehicle, playerData.vehicleColor.primaryColor.r, playerData.vehicleColor.primaryColor.g, playerData.vehicleColor.primaryColor.b)
                    SetVehicleCustomSecondaryColour(vehicle, playerData.vehicleColor.secondaryColor.r, playerData.vehicleColor.secondaryColor.g, playerData.vehicleColor.secondaryColor.b)
                end
            })
        end
    else
        table.insert(elems[1].options, {
            title = "No hay vehículos configurados."
        })
    end

    lib.registerContext(elems)
    lib.showContext('garage_mafia')
end

function openReviveMenu()
    local elems = {}
    table.insert(elems, {
        id = 'revive_mafia',
        title = 'Revivir de mafia',
        options = {
            {
                title = "Curarse",
                icon = "fas fa-heartbeat",
                onSelect = function()
                    TriggerServerEvent("bm_mafias:doctor:heal", "heal")
                end,
                metadata = {"Precio: GRATIS"}
            },
            {
                title = "Revivir",
                icon = "fas fa-heartbeat",
                onSelect = function()
                    TriggerServerEvent("bm_mafias:doctor:heal", "revive")
                end,
                metadata = {"Precio: GRATIS"}
            },
        }

    })

    lib.registerContext(elems)
    lib.showContext('revive_mafia')
end




function openWardobeMenu()
    local elems = {}
    table.insert(elems, {
        id = 'wardobe_mafia',
        title = 'Conjuntos de mafia',
        options = {}
    })

    local count = 0
    for i,v in pairs(playerData.wardobeList) do
        count = count + 1
    end

    if (playerData.wardobeList and count > 0) then
        for i,v in pairs(playerData.wardobeList) do
            table.insert(elems[1].options, {
                title = i,
                onSelect = function(args)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        sex = (skin.sex == 0) and "mp_m_freemode_01" or "mp_f_freemode_01"
                        
                        if (v.model ~= sex) then
                            return
                        end

                        local playerPed = PlayerPedId()
                        exports['fivem-appearance']:setPedComponents(playerPed, v.components)
                        exports['fivem-appearance']:setPedProps(playerPed, v.props)
                    end)
                end
            })
        end
    else
        table.insert(elems[1].options, {
            title = "No hay conjuntos creados :C"
        })
    end
    table.insert(elems[1].options, {
        title = "Crear",
        onSelect = function()
            local input = lib.inputDialog('Conjunto', {'Nombre'})

            if not input then return end
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('bm_mafias:createClothes', playerData.name, input[1], skin)
            end)
        end
    })

    lib.registerContext(elems)
    lib.showContext('wardobe_mafia')
end

function openAccesoriesMenu()
    lib.showContext("accesories_menu")
end

function openCreatorMenu()
    local elems = {
        id = 'mafia_creator',
        title = 'Creador de bandas/mafias',
        options = {
            {
                title = 'Nombre',
                description = (cache.name and cache.name or 'Sin especificar'),
                onSelect = function(args)
                    local input = lib.inputDialog('Menú de creación', {'Nombre'})

                    if not input then return end
                    cache.name = input[1]
                end,
                args = {name = (cache.name and cache.name or 'Sin especificar')}
            },
            {
                title = 'Nivel de mafia',
                description = (cache.level and cache.level or "1"),
                onSelect = function(args)
                    local input = lib.inputDialog('Menú de creación', {'Nivel'})

                    if not input then return end
                    cache.level = input[1]
                end,
                args = {level = (cache.level and cache.level or "1")}
            },
            {
                title = 'Puntos',
                menu = 'points',
                description = 'Seleccionador de puntos'
            },
            {
                title = 'Vehículos del garaje',
                menu = 'garageConfig',
                description = 'Lista de coches'
            },
            {
                title = 'Color primario',
                description = 'Color primario',
                onSelect = function()
                    local input = lib.inputDialog('Color primario', {'R', 'G', 'B'})

                    if not input then return end
                    cache.metadata.vehicleColor.primaryColor.r = tonumber(input[1])
                    cache.metadata.vehicleColor.primaryColor.g = tonumber(input[2])
                    cache.metadata.vehicleColor.primaryColor.b = tonumber(input[3])
                end
            },
            {
                title = 'Color secundario',
                description = 'Color secundario',
                onSelect = function()
                    local input = lib.inputDialog('Color secundario', {'R', 'G', 'B'})

                    if not input then return end
                    cache.metadata.vehicleColor.secondaryColor.r = tonumber(input[1])
                    cache.metadata.vehicleColor.secondaryColor.g = tonumber(input[2])
                    cache.metadata.vehicleColor.secondaryColor.b = tonumber(input[3])
                end
            },
            {
                title = 'Crear',
                onSelect = function()
                    TriggerServerEvent('bm_mafias:create', cache)
                    cache = {metadata = {members = {}, vehicleColor = {primaryColor = {r = 0, g = 0, b = 0}, secondaryColor = {r = 0, g = 0, b = 0}}}}
                end
            },
        },
        {
            id = 'points',
            title = 'Selección de puntos',
            menu = 'mafia_creator',
            options = {
                ['Garaje'] = {
                    onSelect = function(args)
                        cache.metadata.garage = vec4(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
                        ESX.ShowNotification("Coordenadas de garaje añadidas.")
                    end
                },
                ['Punto de revivir'] = {
                    onSelect = function(args)
                        cache.metadata.revive = vec4(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
                        ESX.ShowNotification("Coordenadas de revive añadidas.")
                    end
                },
                ['Tienda (tier 3)'] = {
                    onSelect = function(args)
                        cache.metadata.shopmafia = vec4(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
                        ESX.ShowNotification("Coordenadas de tienda añadidas.")
                    end
                },
                ['Inventario'] = {
                    onSelect = function(args)
                        cache.metadata.inventory = vec3(GetEntityCoords(PlayerPedId()))
                        ESX.ShowNotification("Coordenadas de inventario añadidas.")
                    end
                },
                ['Conjuntos de ropa'] = {
                    onSelect = function(args)
                        cache.metadata.wardobe = vec3(GetEntityCoords(PlayerPedId()))
                        ESX.ShowNotification("Coordenadas de conjuntos añadidas.")
                    end
                },
                ['Accesorios'] = {
                    onSelect = function(args)
                        cache.metadata.accesories = vec3(GetEntityCoords(PlayerPedId()))
                        ESX.ShowNotification("Coordenadas de accesorios añadidas.")
                    end
                },
            }
        },
        {
            id = 'garageConfig',
            title = 'Configurador del garaje',
            menu = 'mafia_creator',
            options = {
                ['Añadir'] = {
                    onSelect = function(args)
                        local input = lib.inputDialog('Vehículo', {'Modelos (ej: adder,t20,tyrus)'})

                        if not input then return end
                        cache.metadata.vehicleList = {}
                        for value in string.gmatch(input[1], "([^,]+)") do
                            table.insert(cache.metadata.vehicleList, value)
                        end
                        ESX.ShowNotification("Vehículos añadidos.")
                    end
                }
            } 
        }
    }
    lib.registerContext(elems)
    lib.showContext('mafia_creator')
end

function openShops()
    lib.showContext('shops_menu')
end

function create3D(coords, text)
    local x, y, z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(5)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


function openBossMenu()
    local elems = {}
    table.insert(elems, {
        id = 'boss_admin',
        title = 'Administración de mafia',
        options = {}
    })

    for i,v in pairs(playerData.members) do
        if (GetPlayerName(PlayerId()) ~= v.name) then
            table.insert(elems[1].options, {
                title = v.name,
                onSelect = function(args)
                    TriggerServerEvent('bm_mafias:removeMember', playerData.name, i)
                end
            })
        end
    end

    table.insert(elems[1].options, {
        title = "Añadir miembro",
        onSelect = function()
            local input = lib.inputDialog('Añadir', {'ID'})

            if not input then return end
            TriggerServerEvent('bm_mafias:addMember', playerData.name, tonumber(input[1]))
        end
    })

    lib.registerContext(elems)
    lib.showContext('boss_admin')
end

function openMafiaMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mafia_menu', {
        title = "Acciones",
        align = 'right',
        elements = {
            {label = 'Cachear', value = 'search'},
            {label = 'Meter/sacar del vehículo', value = 'ms'},
            {label = 'Poner/quitar precintos', value = 'handcuff'},
            {label = 'Poner bolsa en la cabeza', value = 'setb'},
            {label = 'Quitar bolsa en la cabeza', value = 'qb'},
            {label = 'Escoltar/soltar', value = 'drag'},
        }
    }, function(data, menu)
        local cPlayer, cDist = ESX.Game.GetClosestPlayer()
        if (data.current.value == 'search') then
            ExecuteCommand('me Le cachea')
            if (cPlayer ~= -1 and cDist <= 3) then
                exports.ox_inventory:openInventory('player', GetPlayerServerId(cPlayer))
            end
        elseif (data.current.value == "ms") then
            if (cPlayer ~= -1 and cDist <= 3) then
                TriggerServerEvent('bm_mafias:requestJoinVeh', GetPlayerServerId(cPlayer), playerData.name)
            end
        elseif (data.current.value == "handcuff") then
            if (cPlayer ~= -1 and cDist <= 3) then
                TriggerServerEvent('bm_mafias:requestHandcuff', GetPlayerServerId(cPlayer), playerData.name)
            end
        elseif (data.current.value == "setb") then
            ExecuteCommand('me Saca una bolsa de su bolsillo y se la coloca en la cabeza')
            ExecuteCommand('do Se vería al sujeto con una bolsa en la cabeza')
        elseif (data.current.value == "qb") then
            ExecuteCommand('me Le quita la bolsa de la cabeza')
        elseif (data.current.value == "drag") then
            if (cPlayer ~= -1 and cDist <= 3) then
                TriggerServerEvent('bm_mafias:requestDrag', GetPlayerServerId(cPlayer), playerData.name)
            end
        end
    end, function(data, menu)
        menu.close()
    end)
    --lib.showContext("interaction_mafia_menu")
end

function createNPC(model, x,y,z,h)
    hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    crearNPC = CreatePed(5, hash, x,y,z,h, false, true)
    FreezeEntityPosition(crearNPC, true)
    SetEntityInvincible(crearNPC, true)
    SetBlockingOfNonTemporaryEvents(crearNPC, true)
end

function createMafiaBlip()
    if (mafiaBlip) then
        RemoveBlip(mafiaBlip)
        mafiaBlip = nil
    end
    if (playerData and playerData.name) then
        if (mafiaBlip == nil) then
            mafiaBlip = AddBlipForCoord(playerData.points.inventory.x, playerData.points.inventory.y, playerData.points.inventory.z)
            SetBlipSprite (mafiaBlip, 429)
            SetBlipDisplay(mafiaBlip, 4)
            SetBlipScale  (mafiaBlip, 0.7) 
            SetBlipColour(mafiaBlip, 1)
            SetBlipAsShortRange(mafiaBlip, true)
        
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("Casa de Mafia")
            EndTextCommandSetBlipName(mafiaBlip)
        end
    end
end

function createMafiaBlip2()
    if (mafiaBlip2) then
        RemoveBlip(mafiaBlip2)
        mafiaBlip2 = nil
    end
    if (playerData and playerData.name) then
        if (mafiaBlip2 == nil) then
            mafiaBlip2 = AddBlipForCoord(1253.841797, -2565.613281, 42.709106)
            SetBlipSprite (mafiaBlip2, 110)
            SetBlipDisplay(mafiaBlip2, 4)
            SetBlipScale  (mafiaBlip2, 0.7) 
            SetBlipColour(mafiaBlip2, 12)
            SetBlipAsShortRange(mafiaBlip2, true)
        
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("Venta de Armas")
            EndTextCommandSetBlipName(mafiaBlip2)
        end
    end
end

lib.registerContext({
    id = 'interaction_mafia_menu',
    title = 'Menú de interacción',
    options = {
        {
            title = 'Cachear',
            onSelect = function(args)
                ExecuteCommand('me lo cachea')
                local cPlayer, cDist = ESX.Game.GetClosestPlayer()
                if (cPlayer ~= -1 and cDist <= 3) then
                    TriggerServerEvent('bm_mafias:requestCacheo', GetPlayerServerId(cPlayer), playerData.name)
                end
            end
        },
        {
            title = 'Meter/sacar del vehículo',
            onSelect = function(args)
                local cPlayer, cDist = ESX.Game.GetClosestPlayer()
                if (cPlayer ~= -1 and cDist <= 3) then
                    TriggerServerEvent('bm_mafias:requestJoinVeh', GetPlayerServerId(cPlayer), playerData.name)
                end
            end
        },
        {
            title = 'Poner/quitar precintos',
            onSelect = function(args)
                local cPlayer, cDist = ESX.Game.GetClosestPlayer()
                if (cPlayer ~= -1 and cDist <= 3) then
                    TriggerServerEvent('bm_mafias:requestHandcuff', GetPlayerServerId(cPlayer), playerData.name)
                end
            end
        },
        {
            title = 'Poner bolsa en la cabeza',
            onSelect = function(args)
                ExecuteCommand('me saca una bolsa de su bolsillo y se la coloca en la cabeza')
                ExecuteCommand('do se vería al sujeto con una bolsa en la cabeza')
            end
        },
        {
            title = 'Quitar bolsa en la cabeza',
            onSelect = function(args)
                ExecuteCommand('me le quita la bolsa de la cabeza')
            end
        },
        {
            title = 'Escoltar/Soltar',
            onSelect = function(args)
                local cPlayer, cDist = ESX.Game.GetClosestPlayer()
                if (cPlayer ~= -1 and cDist <= 3) then
                    TriggerServerEvent('bm_mafias:requestDrag', GetPlayerServerId(cPlayer), playerData.name)
                end
            end
        },
    }
})

lib.registerContext({
    id = 'shops_menu',
    title = 'Tiendas',
    options = {
        {
            title = 'Balas',
            icon = 'fa-solid fa-money-bill',
            iconColor = "#34eb55",
            description = '$2500',
            onSelect = function(args)
                TriggerServerEvent('bm_mafias:buy', 'weaclip', 2500)
            end
        }
    }
})

lib.registerContext({
    id = 'accesories_menu',
    title = 'Menú de accesorios',
    options = {
        {
            title = 'Silenciador',
            onSelect = function(args)
                GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())]["suppressor"])  
                ESX.ShowNotification("Has puesto un silenciador a tu arma.")
            end
        },
        {
            title = 'Mira',
            onSelect = function(args)
                GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())]["sight"]) 
                ESX.ShowNotification("Has puesto un mira a tu arma.")
            end
        },
        {
            title = 'Linterna',
            onSelect = function(args)
                GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())]["flashlight"])
                ESX.ShowNotification("Has puesto un linterna a tu arma.")
            end
        },
        {
            title = 'Grip',
            onSelect = function(args)
                ESX.ShowNotification("Has puesto un grip a tu arma.")
                GiveWeaponComponentToPed(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())]["grip"])
            end
        }
    }
})

RegisterNetEvent('bm_mafia:requestMafiaInfo', function(playerId)
    TriggerServerEvent('bm_mafia:giveInfo', playerData, playerId)
end)

AddEventHandler('onResourceStart', function(res)
    if (res == GetCurrentResourceName()) then
        TriggerServerEvent('bm_mafias:requestSync')
    end
end)

-- @sellers
function openWeaponMenu()
    ESX.TriggerServerCallback('bm_mafias:getWeaponsInStock', function(myTable)
        local elements = {}

        table.insert(elements, {
            title = "Micro-SMG",
            description = (myTable.carabina > 0 and "En stock: "..myTable.carabina or "Sin stock"),
            metadata = {"Precio: $200000"},
            onSelect = function()
                TriggerServerEvent('bm_mafias:buyWeapon', 'weapon_microsmg', 200000, 'carabina')
            end
        })
        table.insert(elements, {
            title = "Pistola 9MM",
            description = (myTable.carabina > 0 and "En stock: "..myTable.carabina or "Sin stock"),
            metadata = {"Precio: $200000"},
            onSelect = function()
                TriggerServerEvent('bm_mafias:buyWeapon', 'weapon_pistol', 200000, 'carabina')
            end
        })
        table.insert(elements, {
            title = "Silenciador",
            description = (myTable.carabina > 0 and "En stock: "..myTable.carabina or "Sin stock"),
            metadata = {"Precio: $50000"},
            onSelect = function()
                TriggerServerEvent('bm_mafias:buyWeapon', 'at_suppressor_light', 50000, 'suppressor')
            end
        })


        lib.registerContext({
            id = 'mafias_weapon_shop_menu',
            title = 'Tienda de armas',
            menu = "mafias_context_menu",
            options = elements
        })

        lib.showContext("mafias_weapon_shop_menu")
    end)
end

function openBulletsMenu()
    ESX.TriggerServerCallback('bm_mafias:getWeaponsInStock', function(myTable)
        local elements = {}

        table.insert(elements, {
            title = "Balas 9mm",
            description = (myTable.smgbullets > 0 and "En stock: "..myTable.smgbullets or "Sin stock"),
            metadata = {"Precio: $100 x1"},
            quantity = 1,
            onSelect = function()
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'buy_bullets', {
                    title = "Cantidad de balas"
                }, function(data, menu)
                    TriggerServerEvent('bm_mafias:buyBullets', tonumber(data.value))
                    menu.close()
                end, function(data, menu)
                    menu.close()
                end)
            end
        })

        table.insert(elements, {
            title = "Balas ammo-45",
            description = (myTable.smgbullets > 0 and "En stock: "..myTable.smgbullets or "Sin stock"),
            metadata = {"Precio: $150 x1"},
            quantity = 1,
            onSelect = function()
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'buy_bullets', {
                    title = "Cantidad de balas"
                }, function(data, menu)
                    TriggerServerEvent('bm_mafias:buyammo45', tonumber(data.value))
                    menu.close()
                end, function(data, menu)
                    menu.close()
                end)
            end
        })

        lib.registerContext({
            id = 'buy_bullets',
            title = 'Tienda de balas',
            menu = "mafias_context_menu",
            options = elements
        })

        lib.showContext("buy_bullets")
    end)
end


function openWashMenu()
    TriggerServerEvent('bm_mafias:washMoney')
end

function openBproofMenu()
    ESX.TriggerServerCallback('bm_mafias:getWeaponsInStock', function(myTable)
        local elements = {}

        table.insert(elements, {
            title = "Chaleco antibalas",
            description = (myTable.bproof > 0 and "En stock: "..myTable.bproof or "Sin stock"),
            metadata = {"Precio: $50000"},
            onSelect = function()
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'buy_bproof', {
                    title = "Cantidad de chalecos"
                }, function(data, menu)
                    TriggerServerEvent('bm_mafias:buyBproof', tonumber(data.value))
                    menu.close()
                end, function(data, menu)
                    menu.close()
                end)
            end
        })

        lib.registerContext({
            id = 'bproof_menu',
            title = 'Tienda de chalecos antibalas',
            menu = "mafias_context_menu",
            options = elements
        })

        lib.showContext("bproof_menu")
    end)
end

function openContextMenu()
    lib.registerContext({
        id = 'mafias_context_menu',
        title = 'Mafias',
        options = {
            {
                title = 'Tienda de armas',
                onSelect = function()
                    openWeaponMenu()
                end
            },
            {
               title = 'Tienda de balas',
                onSelect = function()
                    openBulletsMenu()
                end
            },
            {
                title = 'Lavar dinero',
              onSelect = function()
                   openWashMenu()
               end
            },
            {
                title = 'Tienda de chalecos antibalas',
                onSelect = function()
                    openBproofMenu()
                end
            }
        }
    })

    lib.showContext("mafias_context_menu")
end

local npcs = {
    {coords = vec4(1253.221924, -2565.942871, 41.709106, 286.299194), model = 'a_m_m_socenlat_01', func = openContextMenu},
}


local npcs2 = {
    {coords = vec4(837.5227, -934.9229, 31.3927, 11.7338), model = 'a_m_m_socenlat_01', func = openContextMenu},
}

local npcs3 = {
    {coords = vec4(92.9505, -1292.4277, 28.2635, 286.9451), model = 'a_m_m_socenlat_01', func = openContextMenu},
}

local npcs4 = {
    {coords = vec4(84.540665, -1966.945068, 19.737061, 212.598419), model = 'a_m_m_socenlat_01', func = openContextMenu},
}



CreateThread(function() -- @ wash / weapon dealer / bulletproof seller
    for i,v in pairs(npcs) do
        createNPC(v.model, v.coords)
    end
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if (playerData.name) then
            for i,v in pairs(npcs) do
                if #(playerCoords - vec3(v.coords.x, v.coords.y, v.coords.z)) < 3 then
                    ESX.ShowFloatingHelpNotification("~r~[E]~w~ Tienda ilegal", vec3(1253.221924, -2565.942871, 43.709106))
                    msec = 0
                    create3D(vec3(v.coords.x, v.coords.y, v.coords.z+2), v.label)
                    if (IsControlJustPressed(0, 38)) then
                        v.func()
                    end
                end
            end
        end

        Wait(msec)
    end
end)

CreateThread(function() -- @ wash / weapon dealer / bulletproof seller
    for i,v in pairs(npcs2) do
        createNPC(v.model, v.coords)
    end
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if (playerData.name) then
            for i,v in pairs(npcs2) do
                if #(playerCoords - vec3(v.coords.x, v.coords.y, v.coords.z)) < 3 then
                    ESX.ShowFloatingHelpNotification("~r~[E]~w~ Lavar dinero", vec3(837.5227, -934.9229, 33.3927))
                    msec = 0
                    create3D(vec3(v.coords.x, v.coords.y, v.coords.z+2), v.label)
                    if (IsControlJustPressed(0, 38)) then
                        openWashMenu()
                    end
                end
            end
        end

        Wait(msec)
    end
end)

CreateThread(function() -- @ wash / weapon dealer / bulletproof seller
    for i,v in pairs(npcs3) do
        createNPC(v.model, v.coords)
    end
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if (playerData.name) then
            for i,v in pairs(npcs3) do
                if #(playerCoords - vec3(v.coords.x, v.coords.y, v.coords.z)) < 3 then
                    ESX.ShowFloatingHelpNotification("~r~[E]~w~ Lavar dinero", vec3(92.9505, -1292.4277, 30.2635))
                    msec = 0
                    create3D(vec3(v.coords.x, v.coords.y, v.coords.z+2), v.label)
                    if (IsControlJustPressed(0, 38)) then
                        openWashMenu()
                    end
                end
            end
        end

        Wait(msec)
    end
end)

CreateThread(function() -- @ wash / weapon dealer / bulletproof seller
    for i,v in pairs(npcs4) do
        createNPC(v.model, v.coords)
    end
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if (playerData.name) then
            for i,v in pairs(npcs4) do
                if #(playerCoords - vec3(v.coords.x, v.coords.y, v.coords.z)) < 3 then
                    ESX.ShowFloatingHelpNotification("~r~[E]~w~ Tienda ilegal", vec3(1253.841797, -2565.613281, 42.709106))
                    msec = 0
                    create3D(vec3(v.coords.x, v.coords.y, v.coords.z+2), v.label)
                    if (IsControlJustPressed(0, 38)) then
                        v.func()
                    end
                end
            end
        end

        Wait(msec)
    end
end)