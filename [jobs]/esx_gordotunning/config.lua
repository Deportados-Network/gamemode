Config                            = {}
Config.Locale                     = 'es'

--- MECHANIC TOOLS OPTIONS --
Config.HoistHash = 1742634574
Config.ToolboxHash = -573669520
Config.CarLiftHash = 1420515116
Config.MarkerType                 = {Cloakrooms = 20}

Config.DrawDistance               = 20.0 -- How close you need to be in order for the markers to be drawn (in GTA units).
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }

Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo',
	'sultan',
	'baller3'
}

Config.Zones = {

	GordoTunningActions = {
		Pos   = { x = 137.48, y = -1085.91, z = 29.19 },
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 255 },
		Type  = 36
	},

	-- Garage = {
	-- 	Pos   = { x = -195.66, y = -1336.25, z = 30.89 },
	-- 	Size  = { x = 1, y = 1, z = 1.0 },
	-- 	Color = { r = 255, g = 255, b = 255 },
	-- 	Type  = 1
	-- },

	--Craft = {
	--	Pos   = { x = -195.66, y = -1336.25, z = 30.89 },vec3(146.79, -1090.05, 29.4)
	--	Size  = { x = 1.5, y = 1.5, z = 1.0 },
	--	Color = { r = 204, g = 204, b = 0 },
	--	Type  = 1
	--},

	VehicleSpawnPoint = {
		Pos   = { x = 155.32, y = -1081.58, z = 29.19 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = { x = 155.32, y = -1081.58, z = 28.19 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 255, g = 255, b = 255 },
		Type  = 1
	},

	Cloakroom = {
		Pos   = { x = 116.54, y = -1094.64, z = 29.4 },
		Size  = { x = 0.6, y = 0.6, z = 0.6 },
		Color = { r = 255, g = 255, b = 255 },
		Type  = 21
	}

	-- VehicleDelivery = {
	-- 	Pos   = { x = -195.66, y = -1336.25, z = 30.89 },
	-- 	Size  = { x = 20.0, y = 20.0, z = 3.0 },
	-- 	Color = { r = 204, g = 204, b = 0 },
	-- 	Type  = -1
	-- }
}

Config.Towables = {
}

for k,v in ipairs(Config.Towables) do
	Config.Zones['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end