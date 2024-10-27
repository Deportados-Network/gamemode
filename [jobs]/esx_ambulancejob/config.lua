Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).
Config.Debug                      = ESX.GetConfig().EnableDebug
Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 20000  -- Revive reward, set to 0 if you don't want it enabled
Config.SaveDeathStatus              = true -- Save Death Status?
Config.LoadIpl                    = true -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale = GetConvar('esx:locale', 'es')

Config.DistressBlip = {
	Sprite = 310,
	Color = 48,
	Scale = 0.7
}

Config.EarlyRespawnTimer          = 30000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = false -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.OxInventory                = ESX.GetConfig().OxInventory
Config.RespawnPoints = {
	{coords = vec3(296.81, -575.04, 43.15), heading = 48.5}, -- Central Los Santos
	{coords = vec3(1840.6245, 3670.3159, 33.6800), heading = 48.5}, -- Central Sandy
}

Config.PharmacyItems = {
	{
		title = "Botiquín",
		item = "medikit"
	},
	{
		title = "Vendas",
		item = "bandage"
	},
}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vec3(308.82, -595.81, 43.28),
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vec3(2525.14, -2525.32, 2552.28)
		},

		Pharmacies = {
			vec3(2525.79, -2525.79, 2555.28)
		},

		Vehicles = {
			{
				Spawner = vec3(296.1, -604.19, 43.22),
				SpawnCoords = vec3(296.1, -604.19, 43.22),
				VehicleList = {
					{label = "Patrulla #1", car = "ghispo2"},
					{label = "Camioneta #2", car = "rangerems"},
				}
			},
			{
				Spawner = vec3(352.27, -587.26, 74.16),
				SpawnCoords = vec4(352.27, -587.26, 74.16, 159.95),
				VehicleList = {
					{label = "Helicoptero Rescate #1", car = "seasparrow"},
				}
			}
		},

		FastTravels = {

		},

		FastTravelsPrompt = {
			{
				From = vec3(332.33, -595.64, 42.28),
				To = {coords = vec3(339.02, -584.01, 74.16), heading = 248.99},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para subir a la azotea"
			},
			{
				From = vec3(339.3, -584.1, 73.16),
				To = {coords = vec3(332.33, -595.64, 43.28), heading = 248.99},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para bajar a la planta 1"
			},
			{
				From = vec3(340.04, -584.82, 28.8),
				To = {coords = vec3(341.04, -580.85, 28.8), heading = 65.41},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para bajar al parking"
			},
			{
				From = vec3(341.04, -580.85, 28.8),
				To = {coords = vec3(340.04, -584.82, 28.8), heading = 248.99},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para subir a la planta 1"
			},
		}

	},

	CentralSandy = {

		Blip = {
			coords = vec3(1838.3759, 3673.3440, 34.2766),
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vec3(2525.14, -2525.32, 2552.28)
		},

		Pharmacies = {
			vec3(2525.79, -2525.79, 2555.28)
		},

		Vehicles = {
			{
				Spawner = vec3(296.1, -604.19, 43.22),
				SpawnCoords = vec3(296.1, -604.19, 43.22),
				VehicleList = {
					{label = "Patrulla #1", car = "ghispo2"},
					{label = "Camioneta #2", car = "rangerems"},
				}
			},
			{
				Spawner = vec3(352.27, -587.26, 74.16),
				SpawnCoords = vec4(352.27, -587.26, 74.16, 159.95),
				VehicleList = {
					{label = "Helicoptero Rescate #1", car = "seasparrow"},
				}
			}
		},

		FastTravels = {

		},

		FastTravelsPrompt = {
			{
				From = vec3(332.33, -595.64, 42.28),
				To = {coords = vec3(339.02, -584.01, 74.16), heading = 248.99},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para subir a la azotea"
			},
			{
				From = vec3(339.3, -584.1, 73.16),
				To = {coords = vec3(332.33, -595.64, 43.28), heading = 248.99},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para bajar a la planta 1"
			},
			{
				From = vec3(340.04, -584.82, 28.8),
				To = {coords = vec3(341.04, -580.85, 28.8), heading = 65.41},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para bajar al parking"
			},
			{
				From = vec3(341.04, -580.85, 28.8),
				To = {coords = vec3(340.04, -584.82, 28.8), heading = 248.99},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = "Pulsa E para subir a la planta 1"
			},
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'ambulance', price = 5000}
		},

		doctor = {
			{model = 'ambulance', price = 4500}
		},

		chief_doctor = {
			{model = 'ambulance', price = 3000}
		},

		boss = {
			{model = 'ambulance', price = 2000}
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {
			{model = 'buzzard2', price = 150000}
		},

		chief_doctor = {
			{model = 'buzzard2', price = 150000},
			{model = 'seasparrow', price = 300000}
		},

		boss = {
			{model = 'buzzard2', price = 10000},
			{model = 'seasparrow', price = 250000}
		}
	}
}

Config.Uniforms = {
	practice = {
		male = {
			['tshirt_1'] = 1,  ['tshirt_2'] = 0,
			['torso_1'] = 12,   ['torso_2'] = 0,
			['arms'] = 49, ['arms_2'] = 1,
			['pants_1'] = 105,   ['pants_2'] = 2,
			['shoes_1'] = 151,   ['shoes_2'] = 3,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 340,   ['torso_2'] = 6,
			['arms'] = 0,
			['pants_1'] = 206,   ['pants_2'] = 3,
			['shoes_1'] = 143,   ['shoes_2'] = 3,
		}
	},

	doctor = {
		male = {
			['tshirt_1'] = 1,  ['tshirt_2'] = 0,
			['torso_1'] = 12,   ['torso_2'] = 6,
			['arms'] = 49, ['arms_2'] = 1,
			['pants_1'] = 105,   ['pants_2'] = 2,
			['shoes_1'] = 151,   ['shoes_2'] = 3,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 340,   ['torso_2'] = 1,
			['arms'] = 0,
			['pants_1'] = 206,   ['pants_2'] = 3,
			['shoes_1'] = 143,   ['shoes_2'] = 3,
		}
	},

	chief_doctor = {
		male = {
			['tshirt_1'] = 1,  ['tshirt_2'] = 0,
			['torso_1'] = 12,   ['torso_2'] = 6,
			['arms'] = 49, ['arms_2'] = 1,
			['pants_1'] = 105,   ['pants_2'] = 2,
			['shoes_1'] = 151,   ['shoes_2'] = 3,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 340,   ['torso_2'] = 1,
			['arms'] = 0,
			['pants_1'] = 206,   ['pants_2'] = 3,
			['shoes_1'] = 143,   ['shoes_2'] = 3,
		}
	},

	sanitario = {
		male = {
			['tshirt_1'] = 1,  ['tshirt_2'] = 0,
			['torso_1'] = 12,   ['torso_2'] = 6,
			['arms'] = 49, ['arms_2'] = 1,
			['pants_1'] = 105,   ['pants_2'] = 2,
			['shoes_1'] = 151,   ['shoes_2'] = 3,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 340,   ['torso_2'] = 1,
			['arms'] = 0,
			['pants_1'] = 206,   ['pants_2'] = 3,
			['shoes_1'] = 143,   ['shoes_2'] = 3,
		}
	},

	boss = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 52,   ['torso_2'] = 3,
			['arms'] = 15,
			['pants_1'] = 199,   ['pants_2'] = 3,
			['shoes_1'] = 151,   ['shoes_2'] = 3,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 340,   ['torso_2'] = 1,
			['arms'] = 0,
			['pants_1'] = 206,   ['pants_2'] = 3,
			['shoes_1'] = 143,   ['shoes_2'] = 3,
		}
	}
}