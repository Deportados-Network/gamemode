ESX = exports['es_extended']:getSharedObject()
Citizen.CreateThread(function()


	EnableBlips()
end)

local firstSpawn = true
AddEventHandler('esx:onPlayerSpawn', function()
    if firstSpawn then
        firstSpawn = false
        EnableBlips()
    end
end)

local isStaff = nil
local disPlayerNames = 5
local mpGamerTags = {}
local disPlayerCounter = 0


function GetPermissions()
	return true
end

function EnableBlips()
    Citizen.CreateThread(function()
        -- while isStaff == nil do
		-- 	disPlayerCounter = disPlayerCounter + 1
        --     isStaff = GetPermissions()
        --     Wait(600)
			
        --     if isStaff ~= nil and isStaff ~= false and isStaff ~= 0 then
        --         disPlayerNames = 500
        --     end
			
		-- 	if disPlayerCounter == 10 then
		-- 		isStaff = 0
		-- 		break
		-- 	end
        -- end
		
        while true do
            if IsPauseMenuActive() == false then
                for _, id in ipairs(GetActivePlayers()) do
					x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
					if GetPlayerPed(id) ~= PlayerPedId() then
						x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
						distance = math.floor(#(vector3(x1,  y1,  z1) - vector3(x2,  y2,  z2)))
						if distance <= disPlayerNames then
							if mpGamerTags[id] ~= nil and mpGamerTags[id].tag ~= nil then
								--if IsMpGamerTagActive(mpGamerTags[id].tag) == false then
									--mpGamerTags[id] = nil
								--end

								RequestPedVisibilityTracking(GetPlayerPed(id))
								if IsTrackedPedVisible(GetPlayerPed(id)) then
									SetMpGamerTagVisibility(mpGamerTags[id].tag, 0, true) -- GamerTagName
									SetMpGamerTagVisibility(mpGamerTags[id].tag, 2, true) -- Health/Armor bar.
									SetMpGamerTagHealthBarColor(mpGamerTags[id].tag, 019) -- Healt/Armor colour.
									SetMpGamerTagAlpha(mpGamerTags[id].tag, 2, 255) -- Health/Armor alpha.
									SetMpGamerTagName(mpGamerTags[id].tag, getPrefix(id, isStaff)) -- SetName
									SetMpGamerTagColour(mpGamerTags[id].tag, 0, 001)
								elseif IsTrackedPedVisible(GetPlayerPed(id)) == false and isStaff ~= nil and isStaff ~= false and isStaff == 0 then
									SetMpGamerTagVisibility(mpGamerTags[id].tag, 0, false) -- GamerTagName
									SetMpGamerTagVisibility(mpGamerTags[id].tag, 2, false) -- Health/Armor bar.
									SetMpGamerTagName(mpGamerTags[id].tag, "") -- SetName
								elseif IsTrackedPedVisible(GetPlayerPed(id)) == false and isStaff ~= nil and isStaff ~= false and isStaff > 0 then
									SetMpGamerTagVisibility(mpGamerTags[id].tag, 0, true) -- GamerTagName
									SetMpGamerTagVisibility(mpGamerTags[id].tag, 2, true) -- Health/Armor bar.
									SetMpGamerTagName(mpGamerTags[id].tag, getPrefix(id, isStaff)) -- SetName
								end

								if NetworkIsPlayerTalking(id) then
									DrawMarker(0, x2, y2, z2 + 1.35, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0, 130, 150, 255, 1, 0, 2, 1, nil, nil, 0)
									SetMpGamerTagColour(mpGamerTags[id].tag, 0, 010)
								end

							else
								mpGamerTags[id] = {
									tag = CreateFakeMpGamerTag(GetPlayerPed(id), '', false, false, '', 0),
									ped = GetPlayerPed(id)
								}
								SetMpGamerTagVisibility(mpGamerTags[id].tag, 0, true) -- GamerTagName
								SetMpGamerTagVisibility(mpGamerTags[id].tag, 2, true) -- Health/Armor bar.
								SetMpGamerTagHealthBarColor(mpGamerTags[id].tag, 019) -- Healt/Armor colour.
								SetMpGamerTagAlpha(mpGamerTags[id].tag, 2, 255) -- Health/Armor alpha.
								SetMpGamerTagName(mpGamerTags[id].tag, getPrefix(id, isStaff)) -- SetName
							end
						else
							if mpGamerTags[id] ~= nil and mpGamerTags[id].tag ~= nil then
								SetMpGamerTagVisibility(mpGamerTags[id].tag, 0, false) -- GamerTagName
								SetMpGamerTagVisibility(mpGamerTags[id].tag, 2, false) -- Health/Armor bar.
								SetMpGamerTagName(mpGamerTags[id].tag, "") -- SetName
								mpGamerTags[id] = nil
							end
						end
					end
                end
            else
                mpGamerTags = {}
                Citizen.Wait(1000)
            end
            
            Citizen.Wait(0)
        end
    end)
end

function getPrefix(id, perms)
    if perms ~= nil and perms ~= false and perms ~= 0 then
		return '#'..GetPlayerServerId(id)..' | '..GetPlayerName(id)
    else
        return '#'..GetPlayerServerId(id)
    end
end