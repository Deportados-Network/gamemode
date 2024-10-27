ESX = exports["es_extended"]:getSharedObject()

local vips = {}

function updateVipsFile()
    SaveResourceFile(GetCurrentResourceName(),"vips.json",json.encode(vips),-1)
end

function isVip(identifier)
    for k,v in pairs(vips) do
        if v == identifier then
            return k
        end
    end

    return false
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    vips = json.decode(LoadResourceFile(resourceName, "vips.json"))

    if vips == nil then
        vips = {}
        updateVipsFile()
    end
end)


RegisterCommand("agregarvip",function(source, args)
    local target = args[1]
    local identifier = GetPlayerIdentifier(args[1],1)

    if GetPlayerName(target) == nil then 
        TriggerClientEvent('chat:addMessage', source,{ args = {"^1[depo]", "El jugador no se encuentra en el servidor"}})
        return
    end

    if isVip(identifier) ~= false then
        TriggerClientEvent('chat:addMessage', source,{ args = {"^1[depo]", "El usuario que intentas agregar ya es ^9VIP"}})
        return
    end

    TriggerClientEvent('chat:addMessage', -1,{ args = {"^1[depo]", "^7El usuario ^3@".. GetPlayerName(target).."^7 ahora es ^9VIP^7. Felicitaciones!"}})
    
    table.insert(vips,split(identifier,":")[2])
    updateVipsFile()
    
end,true)

RegisterCommand("quitarvip",function(source, args)
    local identifier = args[1]

    if isVip(identifier) == false then
        TriggerClientEvent('chat:addMessage', source,{ args = {"^1[depo]", "El usuario que intentas sacar no es VIP"}})
        return
    end
    
    table.remove(vips,isVip(identifier))
    updateVipsFile()
    TriggerClientEvent('chat:addMessage', source,{ args = {"^1[depo]", "^7Usuario ^9VIP ^7eliminado con exito."}})
    
end,true)


function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

CreateThread(function()
    local xPlayer
    
    while(true) do
        Citizen.Wait(Config.MinutesUntilDrop * 60 * 1000)
        for _, identifier in pairs(vips) do 
            xPlayer = ESX.GetPlayerFromIdentifier("license:"..identifier)
            if xPlayer then
                xPlayer.triggerEvent("chat:addMessage",{ args = {"^1[depo]", "^7Has recibido $".. ESX.Math.GroupDigits(Config.Bank) .. " por ser ^9VIP"}})
                xPlayer.addAccountMoney('bank', Config.Bank)
            end
        end
    end

end)