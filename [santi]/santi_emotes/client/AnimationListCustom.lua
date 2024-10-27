-- Emotes you add in the file will automatically be added to AnimationList.lua
-- If you have multiple custom list files they MUST be added between AnimationList.lua and Emote.lua in fxmanifest.lua!
-- Don't change 'Custodepo' it is local to this file!

local Custodepo = {}

Custodepo.Expressions = {}
Custodepo.Walks = {}
Custodepo.Shared = {}
Custodepo.Dances = {}
Custodepo.AnimalEmotes = {}
Custodepo.Exits = {}
Custodepo.Emotes = {}
Custodepo.PropEmotes = {}

-----------------------------------------------------------------------------------------
--| I don't think you should change the code below unless you know what you are doing |--
-----------------------------------------------------------------------------------------

-- Add the custom emotes to RPEmotes main array
for arrayName, array in pairs(Custodepo) do
    if RP[arrayName] then
        for emoteName, emoteData in pairs(array) do
            RP[arrayName][emoteName] = emoteData
        end
    end
    -- Free memory
    Custodepo[arrayName] = nil
end
-- Free memory
Custodepo = nil
