id = '1300892478844702720' 
--local image1 = 'https://cdn.discordapp.com/attachments/1297207518514384926/1300248203173826621/logo_dep.png?ex=67202601&is=671ed481&hm=52796b22e04132327498f92eefb1018edb816f10851d7678771ae22bb1657218&'
--local image2 = 'https://cdn.discordapp.com/attachments/1297207518514384926/1300248203173826621/logo_dep.png?ex=67202601&is=671ed481&hm=52796b22e04132327498f92eefb1018edb816f10851d7678771ae22bb1657218&'

local prevtime = GetGameTimer()
local prevframes = GetFrameCount()
local fps = -1

CreateThread(function()
  while not NetworkIsPlayerActive(PlayerId()) or not NetworkIsSessionStarted() do         
    Wait(500)
    prevframes = GetFrameCount()
    prevtime = GetGameTimer()            
  end

  while true do
    local curtime = GetGameTimer()
    local curframes = GetFrameCount()

    if (curtime - prevtime) > 1000 then
      fps = (curframes - prevframes) - 1
      prevtime = curtime
      prevframes = curframes
    end
    Wait(350)
  end    
end)

function playersCount()
  local count = 0
  for i = 0, 128 do  -- Cambiado de 62 a 128 para adaptarse a un servidor de 128 slots
    if NetworkIsPlayerActive(i) then
      count = count + 1
    end
  end
  return count
end

function SetRP()
  SetDiscordAppId(appid)
  SetDiscordRichPresenceAsset(image1)
  SetDiscordRichPresenceAssetSmall(image2)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5000)  -- Cambiado de 1 ms a 5000 ms (5 segundos) para reducir carga en el servidor

    SetRP()
    local onlinePlayers = playersCount()
    SetRichPresence("Online: [" .. onlinePlayers .. "] | ID: " .. GetPlayerServerId(PlayerId()))

    SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/deportados")
    SetDiscordRichPresenceAction(1, "Conectarse", "fivem://connect/deportados-rp.net")
  end
end)
