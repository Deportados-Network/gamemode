-- EXAMPLE WITH NOT COORDS

RegisterCommand("s", function(source, args)
    local data = {}
    table.insert(data, {text = "Open", toDo = [[ExecuteCommand("me Hello everyone")]]})
    table.insert(data, {text = "Close", toDo = [[TriggerEvent("esx_carlock:closecar", nearestcar)]]})
    table.insert(data, {text = "Delete", toDo = [[ExecuteCommand("car zentorno")]]})
    TriggerEvent("contextmenu:client:open", "Interaction menu" --[[Title of the menu]], data --[[Data of the script]], false, --[[Use coords = true, not using coords = false]] coords --[[The coords of the entity or place]])
end, false)

-- EXAMPLE WITH COORDS

RegisterCommand("su", function(source, args)
    local data = {}
    table.insert(data, {text = "Open", toDo = [[ExecuteCommand("me Hello everyone")]]})
    table.insert(data, {text = "Close", toDo = [[TriggerEvent("esx_carlock:closecar", nearestcar)]]})
    table.insert(data, {text = "Delete", toDo = [[ExecuteCommand("car zentorno")]]})
    local hash = GetHashKey("zentorno")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(1)
    end
    veh = CreateVehicle(hash, GetEntityCoords(PlayerPedId()) + vector3(0, 1, 0), 100.00, false, false)
    local coords = GetEntityCoords(veh)
    TriggerEvent("contextmenu:client:open", "Interaction menu" --[[Title of the menu]], data --[[Data of the script]], true, --[[Use coords = true, not using coords = false]] coords --[[The coords of the entity or place]])
end, false)


TriggerEvent("contextmenu:client:open", "Title of the menu", data --[[Data of the script]], true, --[[Use coords = true, not using coords = false]] coords --[[The coords of the entity or place]])