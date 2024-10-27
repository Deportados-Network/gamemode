---wip types

---@class OxShop
---@field name string
---@field label? string
---@field blip? { id: number, colour: number, scale: number }
---@field inventory { name: string, price: number, count?: number, currency?: string }
---@field locations? vector3[]
---@field targets? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }[]
---@field groups? string | string[] | table<string, number> }
---@field model? number[]

return {
	General = {
		name = 'Tienda',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'phone', price = 5000 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			{ loc = vec3(25.06, -1347.32, 29.5), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.5, maxZ = 29.9, distance = 1.5 },
			{ loc = vec3(-3039.18, 585.13, 7.91), length = 0.6, width = 0.5, heading = 15.0, minZ = 7.91, maxZ = 8.31, distance = 1.5 },
			{ loc = vec3(-3242.2, 1000.58, 12.83), length = 0.6, width = 0.6, heading = 175.0, minZ = 12.83, maxZ = 13.23, distance = 1.5 },
			{ loc = vec3(1728.39, 6414.95, 35.04), length = 0.6, width = 0.6, heading = 65.0, minZ = 35.04, maxZ = 35.44, distance = 1.5 },
			{ loc = vec3(1698.37, 4923.43, 42.06), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 1.5 },
			{ loc = vec3(1960.54, 3740.28, 32.34), length = 0.6, width = 0.5, heading = 120.0, minZ = 32.34, maxZ = 32.74, distance = 1.5 },
			{ loc = vec3(548.5, 2671.25, 42.16), length = 0.6, width = 0.5, heading = 10.0, minZ = 42.16, maxZ = 42.56, distance = 1.5 },
			{ loc = vec3(2678.29, 3279.94, 55.24), length = 0.6, width = 0.5, heading = 330.0, minZ = 55.24, maxZ = 55.64, distance = 1.5 },
			{ loc = vec3(2557.19, 381.4, 108.62), length = 0.6, width = 0.5, heading = 0.0, minZ = 108.62, maxZ = 109.02, distance = 1.5 },
			{ loc = vec3(373.13, 326.29, 103.57), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 1.5 },
		}
	},

	
	Mafias = {
		name = 'Tienda (tier 3)',
		 inventory = {
			{ name = 'at_suppressor_light', price = 1000 },
			{ name = 'at_suppressor_heavy', price = 2000},
			{ name = 'armour', price = 1000},
			{ name = 'bandage', price = 500},
			{ name = 'ammo-9', price = 50},
			{ name = 'ammo-45', price = 50},
			{ name = 'weapon_molotov', price = 50},
		}, locations = {
			vec3(-97.6560, 988.0258, 234.0),
			vec3(-97.6560, 988.0258, 234.0),
			vec3(-1800.6619, 438.3376, 127.85999),
			vec3(-1312.4058, -940.4757, 10.0628),
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 20.0 }
		}
	},

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'lockpick', price = 10 }
		}, locations = {
			vec3(2748.0, 3473.0, 55.67),
			vec3(342.99, -1298.26, 32.51)
		}, targets = {
			{ loc = vec3(2746.8, 3473.13, 55.67), length = 0.6, width = 3.0, heading = 65.0, minZ = 55.0, maxZ = 56.8, distance = 3.0 }
		}
	},

	Ammunation = {
		name = 'Armeria',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'WEAPON_PISTOL', price = 35000, metadata = { registered = true } },
			{ name = 'WEAPON_KNIFE', price = 10000, metadata = { registered = true } },
			{ name = 'WEAPON_BAT', price = 15000, metadata = { registered = true } }
		}, locations = {
			vec3(22.2797, -1107.0187, 29.7970),
			vec3(22.3320, -1106.7990, 29.7970),
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
		}
	},

	PoliceArmoury = {
		name = 'Tienda faccionaria 👮',
		groups = shared.police,
		blip = {
			id = 110, colour = 1, scale = 1.0
		}, inventory = {
			{ name = 'ammo-9', price = 0, },
			{ name = 'ammo-rifle', price = 0, },
			{ name = 'ammo-45', price = 0, },
			{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			{ name = 'WEAPON_NIGHTSTICK', price = 0 },
			{ name = 'WEAPON_APPISTOL', price = 0 },
			{ name = 'WEAPON_PISTOL', price = 500000, metadata = { registered = true, serial = 'POL' }},
			{ name = 'WEAPON_ASSAULTSMG', price = 50000, metadata = { registered = true, serial = 'POL' }},
			{ name = 'WEAPON_BZGAS', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'WEAPON_SMG', price = 10000, metadata = { registered = true, serial = 'POL' }},
			{ name = 'bandage', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'at_suppressor_light', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'WEAPON_CARBINERIFLE', price = 1000000, metadata = { registered = true, serial = 'POL' }, grade = 3 },
			{ name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL'} }
		}, locations = {
			vec3(-1108.1224, -845.1084, 18.0),
		}, targets = {
			{ loc = vec3(-1108.1224, -845.1084, 19.3168), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 30 }
		}
	},

		GnaArmoury = {
		name = 'Tienda faccionaria 👮',
		blip = {
			id = 110, colour = 1, scale = 1.0
		}, inventory = {
			{ name = 'ammo-9', price = 0, },
			{ name = 'ammo-rifle', price = 0, },
			{ name = 'ammo-45', price = 0, },
			{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			{ name = 'WEAPON_NIGHTSTICK', price = 0 },
			{ name = 'WEAPON_APPISTOL', price = 0 },
			{ name = 'WEAPON_PISTOL', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'WEAPON_BZGAS', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'WEAPON_SMG', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'bandage', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'at_suppressor_light', price = 0, metadata = { registered = true, serial = 'POL' }},
			{ name = 'WEAPON_CARBINERIFLE', price = 1000000, metadata = { registered = true, serial = 'POL' }, grade = 3 },
			{ name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL'} }
		}, locations = {
			vec3(-448.0146, 6008.1909, 30.2100),
			vec3(1848.395630, 3690.224121, 33.250610)
		}, targets = {
			{ loc = vec3(1848.6108, 3690.1106, 32.7984), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 30 }
		}
	},

	Medicine = {
		name = 'Tienda de enfermeria 🚑',
		groups = {
			['ambulance'] = 0
		},
		blip = {
			id = 403, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'medikit', price = 26 },
			{ name = 'bandage', price = 5 }
		}, locations = {
			vec3(306.3687, -601.5139, 43.28406)
		}, targets = {

		}
	},

 VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	} 
}
