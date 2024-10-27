pedtable = {}

function loadDatabase()
    local fileContent = LoadResourceFile(GetCurrentResourceName(), "save.json")
    
    if fileContent then
        local success, decodedFile = pcall(json.decode, fileContent)
        
        if success then
            pedtable = decodedFile
        else
            print("^1[Error] Error al decodificar el archivo JSON: " .. decodedFile)
        end
    else
        print("^1[Error] No se pudo cargar el archivo JSON.")
    end
end

function saveDatabase()
    SaveResourceFile(GetCurrentResourceName(), 'save.json', json.encode(pedtable), -1)
end

RegisterNetEvent('byk3_pedmenu:selectPed')
AddEventHandler('byk3_pedmenu:selectPed', function(pedModel)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    -- Elimina cualquier ped existente con el mismo nombre
    for i, pedData in ipairs(pedtable[identifier] or {}) do
        if pedData.model == pedModel then
            table.remove(pedtable[identifier], i)
            break  -- Termina el bucle una vez que se ha encontrado y eliminado un ped con el mismo nombre
        end
    end

    SetPlayerModel(source, pedModel)
    notify(source, 'Has establecido tu modelo de ped a ' .. pedModel)

    local data = {
        name = xPlayer.getName(),
        model = pedModel
    }

    if pedtable[identifier] == nil then
        pedtable[identifier] = {}
    end

    table.insert(pedtable[identifier], data)
    saveDatabase()
    print('^1[depo] ' .. xPlayer.getName() .. ' ha establecido su modelo a ' .. pedModel)
end)

RegisterCommand('resetmyped', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    if pedtable[identifier] ~= nil then
        local pedName = args[1]

        for i, pedData in ipairs(pedtable[identifier]) do
            if pedData.name == pedName then
                table.remove(pedtable[identifier], i)
                notify(source, 'Has reseteado tu ped personalizado: ' .. pedName)
                saveDatabase()
                return
            end
        end

        notify(source, 'No se encontró un ped con el nombre: ' .. pedName)
    else
        notify(source, 'No tienes peds guardados.')
    end
end, false)

RegisterCommand(Config.Command, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    local TargetID = tonumber(args[1])
    local pedModel = args[2]

    if Config.Permission[group] then
        if TargetID ~= nil and pedModel ~= nil then
            local xTarget = ESX.GetPlayerFromId(TargetID)
            local xPed = GetPlayerPed(TargetID)
            local identifier = xTarget.identifier

            if pedModel == 'reset' then
                if pedtable[identifier] ~= nil then
                    SetPlayerModel(TargetID, Config.defaultPed)
                    notify(source, 'You have reset ' .. xTarget.getName() .. '\'s model')
                    pedtable[identifier] = nil
                    saveDatabase()
                else
                    notify(source, xTarget.getName() .. ' does not have a custom model')
                end
            else
                SetPlayerModel(TargetID, pedModel)
                notify(source, '^1[depo] Les has seteado a ' .. xTarget.getName() .. '\'s el modelo de ped: ^9' .. pedModel)
                local data = {
                    ['name'] = xTarget.getName(),
                    ['model'] = pedModel
                }
                if pedtable[identifier] == nil then
                    pedtable[identifier] = {}
                end
                table.insert(pedtable[identifier], data)
                saveDatabase()
                print('^1[depo]^7 ' .. xPlayer.getName() .. ' le ha dado a ' .. xTarget.getName() .. '\'s el ped: ^9' .. pedModel)
            end
        else
            notify(source, 'Argumentos invalidos.')
        end
    else
        notify(source, 'No tienes permiso para usar este comando.')
    end
end, false)

-- Lado del servidor (server.lua)

RegisterCommand('mispeds', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        local identifier = xPlayer.identifier

        loadDatabase()  -- Cargar la base de datos antes de verificar peds

        if pedtable[identifier] and next(pedtable[identifier]) ~= nil then
            local pedList = {}  -- Lista para almacenar datos del ped

            for _, pedData in ipairs(pedtable[identifier]) do
                table.insert(pedList, {
                    name = pedData.name,
                    model = pedData.model
                })
            end

            TriggerClientEvent('byk3_pedmenu:openPedMenu', source, pedList)
        else
            notify(source, 'No tienes peds guardados.')
        end
    end
end, false)
