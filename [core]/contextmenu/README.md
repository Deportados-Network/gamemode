# guille_contextmenu (IF YOU RENAME THE SCRIPT WILL NOT WORK) https://discord.gg/eBpmkW6e5j 


Add in the cfg of your server -> ensure guille_contextmenu


## How to implement it

You can insert the data in many ways, this is an example:
```
    local data = {}
    table.insert(data, {text = "Open", toDo = [[ExecuteCommand("me Hello everyone")]]})
    table.insert(data, {text = "Close", toDo = [[TriggerEvent("esx_carlock:closecar", nearestcar)]]})
    table.insert(data, {text = "Delete", toDo = [[ExecuteCommand("car zentorno")]]})
    
    INSIDE [[]] THE CODE THAT THE BUTTON WIL EXECUTE
    
```
Use this event if you are using coords:
```
TriggerEvent("guille_cont:client:open", "Interaction menu" --[[Title of the menu]], data --[[Data of the script]], true, --[[Use coords = true, not using coords = false]] coords --[[The coords of the entity or place]])
```
If you are not using coords use this:
```
TriggerEvent("guille_cont:client:open", "Interaction menu" --[[Title of the menu]], data --[[Data of the script]], false, --[[Use coords = true, not using coords = false]])
```

[![N|Solid](https://media.discordapp.net/attachments/847529623293788210/856527333165629490/unknown.png)](https://discord.gg/eBpmkW6e5j)
