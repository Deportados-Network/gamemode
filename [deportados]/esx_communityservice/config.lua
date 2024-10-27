Config = {}

-- # Locale to be used. You can create your own by simple copying the 'en' and translating the values.
Config.Locale       				= 'en'

-- # By how many services a player's community service gets extended if he tries to escape
Config.ServiceExtensionOnEscape		= 8

-- # Don't change this unless you know what you are doing.
Config.ServiceLocation 				= {x = 780.013184, y = 570.725281, z = 127.514282}

-- # Don't change this unless you know what you are doing.
Config.ReleaseLocation				= {x = 195.243958, y = -933.916504, z = 30.678345}


-- # Don't change this unless you know what you are doing.
Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(750.079102, 597.164856, 125.913574) },
	{ type = "cleaning", coords = vector3(759.164856, 593.789001, 125.913574) },
	{ type = "cleaning", coords = vector3(770.610962, 589.767029, 125.913574) },
	{ type = "cleaning", coords = vector3(782.347229, 582.619812, 125.913574) },
	{ type = "cleaning", coords = vector3(793.318665, 572.268127, 125.913574) },
	{ type = "cleaning", coords = vector3(790.681335, 581.696716, 125.964111) },
	{ type = "cleaning", coords = vector3(769.252747, 583.292297, 126.014648) },
	{ type = "cleaning", coords = vector3(759.296692, 587.024170, 126.014648) },
	{ type = "gardening", coords = vector3(764.307678, 597.296692, 125.964111) },
	{ type = "gardening", coords = vector3(753.204407, 601.292297, 125.964111) },
}



Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 1, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 19, ['pants_1']  = 0,
			['pants_2']  = 3,   ['shoes_1']  = 7,
			['shoes_2']  = 43,  ['chain_1']  = 1,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 120,  ['pants_1'] = 3,
			['pants_2']  = 15,  ['shoes_1']  = 66,
			['shoes_2']  = 5,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
}
