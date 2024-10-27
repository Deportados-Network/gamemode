-- @vars
local doctors = {
    vec4(308.42, -595.4, 42.28, 66.78),
    vec4(1837.94, 3673.07, 33.28, 209.91),
    vec4(-248.15, 6331.4, 31.43, 230.76)
}

-- @threads
CreateThread(function()
    for i,v in pairs(doctors) do
        createNPC("s_m_m_doctor_01", v)

        -- local blip = AddBlipForCoord(v.xyz)
        -- SetBlipSprite(blip, 51)
        -- SetBlipDisplay(blip, 4)
        -- SetBlipScale(blip, 0.8)
        -- SetBlipColour(blip, 2)
        -- SetBlipAsShortRange(blip, true)
        -- BeginTextCommandSetBlipName("STRING")
        -- AddTextComponentString("Doctor")
        -- EndTextCommandSetBlipName(blip)
    end

    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)

        for i,v in pairs(doctors) do
            if #(playerPos  - v.xyz) < 3.0 then
                msec = 0
                createText("~g~E~w~ - Hablar", vec3(v.xy, v.z+2), nil)
                if (IsControlJustPressed(0, 38)) then
                    openDoctorMenu()
                end
            end
        end

        Wait(msec)
    end
end)

-- @funcs
function openDoctorMenu()
    ox:registerContext({
        id = "doctor",
        title = "Doctor",
        options = {
            {
                title = "Curarse",
                icon = "fas fa-heartbeat",
                onSelect = function()
                    TriggerServerEvent("bm_mega:doctor:heal", "heal")
                end,
                metadata = {"Precio: 8000$"}
            },
            {
                title = "Revivir",
                icon = "fas fa-heartbeat",
                onSelect = function()
                    TriggerServerEvent("bm_mega:doctor:heal", "revive")
                end,
                metadata = {"Precio: 25000$"}
            },
            {
                title = "Comprar vendas",
                icon = "fas fa-medkit",
                onSelect = function()
                    TriggerServerEvent("bm_mega:doctor:buy", "bandage")
                end,
                metadata = {"Precio: 1500$"}
            }
        }
    })

    ox:showContext("doctor")
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

-- @events
RegisterNetEvent('bm_mega:doctor:heal', function()
    local playerPed = PlayerPedId()
    SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)