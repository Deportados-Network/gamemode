Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        while true do
            TriggerClientEvent("wld:delallveh", -1)
            Citizen.Wait(9 * 550000)
        end
    end
end)