-- NOTW4018


local appid = 'appid' 
local image1 = 'https://cdn.discordapp.com/attachments/1186833024709574736/1186835066601615360/nuevo_logo_depo_blanco.png?ex=6594b14a&is=65823c4a&hm=713eb89b1a4b8283b59d29b62f1323b436e8aebf2b37083786138052adb0e6d3&'
local image2 = 'https://cdn.discordapp.com/attachments/1186833024709574736/1186835066601615360/nuevo_logo_depo_blanco.png?ex=6594b14a&is=65823c4a&hm=713eb89b1a4b8283b59d29b62f1323b436e8aebf2b37083786138052adb0e6d3&'
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
    curtime = GetGameTimer()
      curframes = GetFrameCount()       
        
      if((curtime - prevtime) > 1000) then
          fps = (curframes - prevframes) - 1                
          prevtime = curtime
          prevframes = curframes
      end      
    Wait(350)
  end    
end)

function players()
  local players = {}

  for i = 0, 62 do
      if NetworkIsPlayerActive(i) then
          table.insert(players, i)
      end
  end

  return players
end

function SetRP()
  local name = GetPlayerName(PlayerId())
  local id = GetPlayerServerId(PlayerId())

  SetDiscordAppId(appid)
  SetDiscordRichPresenceAsset(image1)
  SetDiscordRichPresenceAssetSmall(image2)
end

Citizen.CreateThread(function()
  while true do

  Citizen.Wait(1)
    SetRP()
    SetDiscordRichPresenceAssetText('discord.gg/deporoleplay')
      players = {}
      for i = 0, 128 do
          if NetworkIsPlayerActive( i ) then
              table.insert( players, i )
          end
      end
    SetRichPresence("Online: [" ..players .. "] | ID: " ..GetPlayerServerId(PlayerId()) .. "")

    SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/deporoleplay")
    SetDiscordRichPresenceAction(1, "Conectarse", "fivem://connect/deporoleplay.com")
end
end)