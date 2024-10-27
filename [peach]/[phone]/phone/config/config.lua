Config = {}
Config.DebugMode = false

-- Framework Features
Config.UsingESX = true -- support for esx framework
Config.UsingQB = false -- support for qbcore framework
Config.RequireItem = true -- checks if player has `phone` item
Config.MultiCharacterSupport = false -- esx-multicharacter/qb-multicharacter

-- Main
Config.OpenKey = "f1" -- open key (gta keybind)
Config.AnswerCallKey = "f5" -- answer call key (gta keybind)
Config.StopCallKey = "f6" -- stop call key (gta keybind)
Config.WalkWhenOpen = true -- allows the player to walk when the phone is open
Config.PhoneModel = "prop_npc_phone" -- change the phone prop the player holds
Config.OpenPhoneWhilstDead = true -- allows the player to open phone whilst dead
Config.VOIP = "pma-voice" -- supported: pma-voice/mumblevoip/saltychat | default: "pma-voice"
Config.StartingDigits = "111" -- the starting digits for phone number (max 4) (example: 111234421) | default: "111"
Config.SaveInterval = 10 -- how often should the phone save data to database (minutes) | default: 10
Config.MaxAccountsPerApp = 2 -- how many accounts can the user create per app, put 0 for unlimited | default: 2

-- Camera (Get an API Key from https://api.imgbb.com/)
-- for devs: head over to web/src/lib/cam.js to create your own logic
Config.ImgBBProviderKey = "493cf42f623809863db6fd718c6f910c"

-- Default Contacts (players cannot remove/edit)
-- name = Label
-- number = QB/ESX Job Name
-- connectToDispath = connect to dispatch app
Config.DefaultContacts = {
  { name = "Police", number = "police", connectToDispatch = false },
  { name = "Medic", number = "medic", connectToDispatch = false }
}

-- Ringtones
-- Add ringtones in dist/sounds/ringtones & public/sounds/ringtones
-- id = Unique ID
-- file = Ringtone file
-- label
Config.Ringtones = {
  { id = "default", file = "ringtones/rick.mp3", label = "Rick" },
  { id = "boujee", file = "ringtones/boujee.mp3", label = "Boujee" },
  { id = "discord", file = "ringtones/discord.mp3", label = "Discord" },
}

-- Default Backgrounds
-- Add backgrounds in dist/backgrounds & public/backgrounds
Config.DefaultBackgrounds = { "default.jpg", "city.gif" }

-- Saving (server cache)
Config.SaveAds = false
Config.SaveTweets = false -- saves last 30 tweets
Config.SaveTor = true
