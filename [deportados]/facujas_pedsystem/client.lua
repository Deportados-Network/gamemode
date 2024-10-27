local firstspawn = true

AddEventHandler('playerSpawned', function()
    if firstspawn then
        TriggerServerEvent('byk3_save:server:load')
        firstspawn = false
    end
end)

RegisterKeyMapping('abrir_menu_ped', 'Abrir Menú de Selección de Ped', 'keyboard', 'F5')
RegisterCommand('menu_ped', function()
    TriggerEvent('byk3_pedmenu:openMenu')
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 166) then -- F5 key code
            TriggerEvent('menu_ped') -- This event should trigger the menu on F5 press
        end
    end
end)




-- ... (código previo)

RegisterNetEvent('byk3_pedmenu:openPedMenu')
AddEventHandler('byk3_pedmenu:openPedMenu', function(pedList)
    local elements = {}

    for _, pedData in ipairs(pedList) do
        table.insert(elements, {label = pedData.name .. ' (' .. pedData.model .. ')', value = pedData.model})
    end

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'ped_menu',  -- Asegúrate de que el nombre del menú ('ped_menu') coincida
        {
            title    = 'Selecciona tus peds',
            align    = 'right',
            elements = elements
        },
        function(data, menu)
            if data.current and data.current.value then
                TriggerServerEvent('byk3_pedmenu:selectPed', data.current.value)
            end
            ESX.UI.Menu.CloseAll()
        end,
        function(data, menu)
            menu.close()
        end
    )
end)
