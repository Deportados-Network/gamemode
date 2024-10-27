-- @vars
local coords = vec4(-266.92, -966.75, 30.22, 299.18)

-- @threads
CreateThread(function()
    local jobListing = createNPC("a_m_y_busicas_01", coords)
    

    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        if (#(playerPos - coords.xyz)) < 3 then
            msec = 0
            createText("~g~E~w~ - Hablar", nil, jobListing)
            if (IsControlJustPressed(0, 38)) then
                openSelection()
            end
        end

        Wait(msec)
    end
end)

-- @funcs
function openSelection()
    ox:registerContext({
        id = "selection_opt",
        title = "Selecciona una opción",
        options = {
            {title = "Vehiculo inicial", icon = "fas fa-box", onSelect = function()
                ESX.TriggerServerCallback('bm_mega:initialveh:claim', function(done)
                    if (done) then
                        TriggerEvent('chat:addMessage', {
                            template = '<span class="badge badge-vip"><i class="fas fa-star"></i></i> {0}</span> Bienvenid@ a <span class="badge badge-gray">depo Roleplay #BETA</span>, disfruta de tu kit inicial',
                            args = {"Recompensa"}
                        })
                        CREATE_VEH("bf400", vec4(-235.25, -989.16, 29.21, 156.98))
                    else
                        ESX.ShowNotification("Ya has reclamado el vehiculo inicial.", "error")
                    end
                end)
            end}
        }
    })
    
    ox:showContext("selection_opt")
end

function openJoblisting()
    ox:registerContext({
        id = "joblisting",
        title = "Oficina de empleo",
        options = {
            {title = "Desempleado", icon = "fas fa-user", onSelect = function()
                TriggerServerEvent('bm_mega:joblisting:apply', "unemployed")
            end},
            {title = "Repartidor", icon = "fas fa-bicycle", onSelect = function()
                TriggerServerEvent('bm_mega:joblisting:apply', "delivery")
            end},
            {title = "Cartero", icon = "fas fa-envelope", onSelect = function()
                TriggerServerEvent('bm_mega:joblisting:apply', "courier")
            end},
            {title = "Agricultor", icon = "fas fa-tractor", onSelect = function()
                TriggerServerEvent('bm_mega:joblisting:apply', "farmer")
            end},
        }
    })

    ox:showContext("joblisting")
end

function createNPC(model, coords)
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    local npc = CreatePed(5, hash, coords, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    return npc
end

function CREATE_VEH(model, spawnpoint)
    local hash = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    local vehicle = CreateVehicle(hash, spawnpoint, true, false)
    SetVehicleOnGroundProperly(vehicle)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    ESX.ShowNotification("Has reclamado el vehículo inicial")

    exports['bm_security']:call('bm_mega:initialveh:claim', true, GetVehicleNumberPlateText(vehicle), ESX.Game.GetVehicleProperties(vehicle), model)
end