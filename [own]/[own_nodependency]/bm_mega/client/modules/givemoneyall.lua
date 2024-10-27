ESX.RegisterCommand('giveaccountmoneyall', 'admin', function(xPlayer, args, showError)
    local players = ESX.GetPlayers()

    for _, playerId in ipairs(players) do
        local playerX = ESX.GetPlayerFromId(playerId)

        if playerX.getAccount(args.account) then
            playerX.addAccountMoney(args.account, args.amount, "Government Grant")
            local hora = os.date("%X, %d %b %Y" )
            local string = "**GIVEACCOUNTMONEYALL ADMIN:** " .. GetPlayerName(xPlayer.source) .. " le seteo " .. args.account .. " $" .. args.amount .. " a " .. GetPlayerName(playerX.source) .. "\n **Fecha:** " .. hora .. ""
            PerformHttpRequest("https://discord.com/api/webhooks/1299743540116455445/cdmqURbM-PCNgeCAbb7BhAN7BVTRTIMpbPqCtUZTrqAnSA05bCXcxwoQ51VRBwsbBXU-", function(err, text, headers) end, 'POST', json.encode({embeds = { { ["color"] = '64071', ["description"] = string } }}), { ['Content-Type'] = 'application/json' })
        end
    end
end, true, {help = TranslateCap('command_giveaccountmoneyall'), validate = true, arguments = {
    {name = 'account', help = TranslateCap('command_giveaccountmoney_account'), type = 'string'},
    {name = 'amount', help = TranslateCap('command_giveaccountmoney_amount'), type = 'number'}
}})
