-- @vars
--local coords = {
 --   {get = vec3(-1823.9387, -919.7727, 2.0605), spawn = vec4(-1841.4006, -931.5948, -0.0782, 119.8603)}
--}

--local coords2 = {
 --   {get = vec3(3823.52, -4671.15, 1.8), spawn = vec4(3817.88, -4669.83, 0.16, 68.26)}
--}

local yate = {
    {get = vec3(-1624.04, -1165.87, 2.15), spawn = vec4(-1630.65, -1170.12, 0.53, 120.31)}
}

local boatList = {
    {title = "Moto de agua #1", model = "seashark3", price = 1000},
    {title = "Moto de agua #2", model = "seashark2", price = 1000},
}

-- @threads
--CreateThread(function()
  --  for i,v in pairs(coords) do
     --   local blip = AddBlipForCoord(v.get)
    --    SetBlipSprite(blip, 404)
   --     SetBlipDisplay(blip, 4)
  --      SetBlipScale(blip, 0.8)
   ----     SetBlipColour(blip, 19)
    --    SetBlipAsShortRange(blip, true)
  ----      BeginTextCommandSetBlipName("STRING")
   --     AddTextComponentString("Alquiler de lanchas")
   --     EndTextCommandSetBlipName(blip)
   -- end
   -- while true do
    --    local msec = 1000

     --   local playerPed = PlayerPedId()
      --  local playerPos = GetEntityCoords(playerPed)
     ------   
       -- for i,v in pairs(coords) do
        --    if #(playerPos - v.get) < 10 then
       --         msec = 0
               -- DrawMarker(35, v.get, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 0, false)
        --        
        --        if #(playerPos - v.get) < 1 then
             --       ESX.ShowHelpNotification("Pulsa ~g~E~w~ para abrir el alquiler de lanchas")
--
               --     if (IsControlJustPressed(0, 38)) then
                     --   openBoatRent(v.spawn)
                --    end
              --  end
            --end
        --end
--
    --    Wait(msec)
   -- end
--end)

--CreateThread(function()
    --for i,v in pairs(coords2) do
    --    local blip = AddBlipForCoord(v.get)
      --  SetBlipSprite(blip, 404)
      -- SetBlipDisplay(blip, 4)
      --  SetBlipScale(blip, 0.8)
      -- SetBlipColour(blip, 19)
      --  SetBlipAsShortRange(blip, true)
      --  BeginTextCommandSetBlipName("STRING")
      --  AddTextComponentString("Alquiler de lanchas")
      --  EndTextCommandSetBlipName(blip)
    --end
    --while true do
     --   local msec = 1000
--
       -- local playerPed = PlayerPedId()
        --local playerPos = GetEntityCoords(playerPed)
        
        --for i,v in pairs(coords2) do
           -- if #(playerPos - v.get) < 10 then
              --  msec = 0
           --     DrawMarker(35, v.get, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 0, false)
                
         --       if #(playerPos - v.get) < 1 then
              --      ESX.ShowHelpNotification("Pulsa ~g~E~w~ para abrir el alquiler de lanchas")
----
       --             if (IsControlJustPressed(0, 38)) then
          --              openBoatRent(v.spawn)
      --              end
     --           end
    --        end
    --    end

  --      Wait(msec)
  --  end
--end)

CreateThread(function()
    for i,v in pairs(yate) do
        local blip = AddBlipForCoord(v.get)
        SetBlipSprite(blip, 404)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 19)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Alquiler de lanchas")
        EndTextCommandSetBlipName(blip)
    end
    while true do
        local msec = 1000

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        
        for i,v in pairs(yate) do
            if #(playerPos - v.get) < 10 then
                msec = 0
                DrawMarker(35, v.get, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 0, false)
                
                if #(playerPos - v.get) < 1 then
                    ESX.ShowHelpNotification("Pulsa ~g~E~w~ para abrir el alquiler de lanchas")

                    if (IsControlJustPressed(0, 38)) then
                        openBoatRent(v.spawn)
                    end
                end
            end
        end

        Wait(msec)
    end
end)

-- @funcs
function openBoatRent(spawn)
    local boats = {}

    for i,v in pairs(boatList) do
        table.insert(boats, {
            title = v.title,
            metadata = {"Precio: " .. v.price .. "$"},
            icon = "fas fa-ship",
            onSelect = function()
                ESX.TriggerServerCallback('bm_mega:hasMoney', function(has)
                    if (has) then
                        ESX.Game.SpawnVehicle(v.model, vec3(spawn.xyz), spawn.w, function(vehicle)
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            if (GetResourceState("LegacyFuel") == "started") then
                                exports['LegacyFuel']:SetFuel(vehicle, 100)
                            end
                            ESX.ShowNotification(("Has alquilado una %s por %s"):format(v.title, v.price))
                        end)
                    else
                        ESX.ShowNotification("No tienes suficiente dinero", "error")
                    end
                end, v.price)
            end
        })
    end

    ox:registerContext({
        id = "boat_rent",
        title = "Alquiler de lanchas",
        options = boats
    })

    ox:showContext("boat_rent")
end