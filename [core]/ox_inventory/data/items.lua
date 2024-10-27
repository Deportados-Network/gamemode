return {
	--[[ ['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	}, ]]

	['bandage'] = {
		label = 'Venda',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dinero sucio',
	},

	['burger'] = {
		label = 'Hamburguesa',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'Te has comido una hamburguesa'
		},
	},

	['bread'] = {
		label = 'Pan',
		weight = 220,
		client = {
			status = { hunger = 100000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'Te has comido un pan'
		},
	},

	['sandwich'] = {
		label = 'Sandwich',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'Te has comido un sandwich'
		},
	},

	['chipsribs'] = {
		label = 'Patatas Fritas',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'chips',
			usetime = 2500,
			notification = 'Te has comido unas patatas fritas'
		},
	},

	['water'] = {
		label = 'Agua',
		weight = 350,
		client = {
			status = { thirst = 250000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Te has bebido una botella de agua'
		}
	},

	['sprite'] = {
		label = 'Sprite',
		weight = 350,
		client = {
			status = { thirst = 250000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `v_res_tt_can03`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Te has bebido una lata de spirte'
		}
	},

	['fanta'] = {
		label = 'Fanta',
		weight = 350,
		client = {
			status = { thirst = 250000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Te has bebido una lata de fanta'
		}
	},

	['monster'] = {
		label = 'Monster',
		weight = 350,
		client = {
			status = { thirst = 250000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `v_res_tt_can02`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Te has bebido una lata de monster'
		}
	},

	['redbull'] = {
		label = 'Red bull',
		weight = 350,
		client = {
			status = { thirst = 250000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `v_res_tt_can01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Te has bebido una lata de red bull'
		}
	},

	['cola'] = {
		label = 'Cocacola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Te has bebido una cocacola'
		}
	},

	['parachute'] = {
		label = 'Paracaidas',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Basura',
	},

	['paperbag'] = {
		label = 'Bolsa de papel',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'DNI',
	},

	['panties'] = {
		label = 'Bragas',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Ganzúa',
		weight = 160,
	},

	['cigarette'] = {
		label = 'Cigarro',
		weight = 160
	},

	['ariete'] = {
		label = 'Ariete',
		weight = 160
	},

	['shovel'] = {
		label = 'Pala',
		weight = 160
	},
	
	['weed'] = {
		label = 'Marihuana',
		weight = 160
	},
	
	['porro'] = {
		label = 'Porro',
		weight = 160
	},

	['radio'] = {
		label = 'Radio',
		weight = 160
	},

	['beer'] = {
		label = 'Cerveza',
		weight = 160
	},

	['tequila'] = {
		label = 'Tequila',
		weight = 160
	},

	['ginebra'] = {
		label = 'Ginebra',
		weight = 160
	},

	['vodka'] = {
		label = 'Vodka',
		weight = 160
	},

	['boombox'] = {
		label = 'Altavoz',
		weight = 160
	},
	
	['aditives'] = {
		label = 'Aditivos',
		weight = 160
	},

	['nevadito'] = {
		label = 'Nevaditos',
		weight = 160
	},

	['heroin'] = {
		label = 'Heroina',
		weight = 160
	},

	['amapolas'] = {
		label = 'Amapolas',
		weight = 160
	},

	['phone'] = {
		label = 'Telefono',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Efectivo',
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Chaleco antibalas',
		weight = 3000,
		stack = true,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Ropa',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Mastercard',
		stack = false,
		weight = 10,
	},

	["blowpipe"] = {
		label = "Soplete",
		weight = 2,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Kit de carrocería",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Herramientas",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Tela",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Kit de reparación",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Herramientas de reparación",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Botella de gas",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Botiquín",
		weight = 2,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Aceite",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marihuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["repairkit"] = {
		label = "Repairkit",
		weight = 3,
		stack = true,
		close = true,
	},

	["bcsd_badge"] = {
		label = "Sheriff badge",
		weight = 0,
		stack = true,
		close = true,
	},

	["black_phone"] = {
		label = "Black Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["blue_phone"] = {
		label = "Blue Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["classic_phone"] = {
		label = "Classic Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["empty_weed_bag"] = {
		label = "Empty Bag",
		weight = 1,
		stack = true,
		close = true,
	},

	["evidence_a"] = {
		label = "Evidence of",
		weight = 0,
		stack = true,
		close = true,
	},

	["evidence_az"] = {
		label = "Evidence",
		weight = 0,
		stack = true,
		close = true,
	},

	["evidence_b"] = {
		label = "Vehicle evidence",
		weight = 0,
		stack = true,
		close = true,
	},

	["evidence_n"] = {
		label = "Impact evidence",
		weight = 0,
		stack = true,
		close = true,
	},

	["evidence_ne"] = {
		label = "Footprint evidence",
		weight = 0,
		stack = true,
		close = true,
	},

	["evidence_r"] = {
		label = "Blood evidence",
		weight = 0,
		stack = true,
		close = true,
	},

	["evidence_ro"] = {
		label = "Evidence",
		weight = 0,
		stack = true,
		close = true,
	},

	["evidence_v"] = {
		label = "Drug evidence",
		weight = 0,
		stack = true,
		close = true,
	},

	["gold_phone"] = {
		label = "Gold Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["green_phone"] = {
		label = "Green Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["greenlight_phone"] = {
		label = "Green Light Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["instant_camera"] = {
		label = "Instant camera",
		weight = 0,
		stack = true,
		close = true,
	},

	["k9"] = {
		label = "K9 whistle",
		weight = 0,
		stack = true,
		close = true,
	},

	["lspd_badge"] = {
		label = "Police badge",
		weight = 0,
		stack = true,
		close = true,
	},

	["phone_hack"] = {
		label = "Phone Hack",
		weight = 10,
		stack = true,
		close = true,
	},

	["phone_module"] = {
		label = "Phone Module",
		weight = 10,
		stack = true,
		close = true,
	},

	["photo"] = {
		label = "Photo",
		weight = 0,
		stack = true,
		close = true,
	},

	["pink_phone"] = {
		label = "Pink Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["police_cad"] = {
		label = "Police tablet",
		weight = 0,
		stack = true,
		close = true,
	},

	["powerbank"] = {
		label = "Power Bank",
		weight = 10,
		stack = true,
		close = true,
	},

	["red_phone"] = {
		label = "Red Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["report_evidence"] = {
		label = "Evidence report",
		weight = 0,
		stack = true,
		close = true,
	},

	["weed_ak47"] = {
		label = "Ak74",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_ak47_seed"] = {
		label = "ak47 Seed",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_amnesia"] = {
		label = "Amnesia",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_amnesia_seed"] = {
		label = "Amnesia Seed",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_nutrition"] = {
		label = "Weed Nutrition",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_og-kush"] = {
		label = "OG Kush",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_og-kush_seed"] = {
		label = "OG Kush Seed",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_purple-haze"] = {
		label = "Purple Haze",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_purple-haze_seed"] = {
		label = "Purple Haze Seed",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_skunk"] = {
		label = "Skunk",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_skunk_seed"] = {
		label = "Skunk Seed",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_white-widow"] = {
		label = "White Widow",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_white-widow_seed"] = {
		label = "White Widow Seed",
		weight = 1,
		stack = true,
		close = true,
	},

	["wet_black_phone"] = {
		label = "Wet Black Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_blue_phone"] = {
		label = "Wet Blue Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_classic_phone"] = {
		label = "Wet Classic Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_gold_phone"] = {
		label = "Wet Gold Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_green_phone"] = {
		label = "Wet Green Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_greenlight_phone"] = {
		label = "Wet Green Light Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_phone"] = {
		label = "Wet Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_pink_phone"] = {
		label = "Wet Pink Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_red_phone"] = {
		label = "Wet Red Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["wet_white_phone"] = {
		label = "Wet White Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["white_phone"] = {
		label = "White Phone",
		weight = 10,
		stack = true,
		close = true,
	},

	["casino_beer"] = {
		label = "Casino Beer",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_burger"] = {
		label = "Casino Burger",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_chips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_coffee"] = {
		label = "Casino Coffee",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_coke"] = {
		label = "Casino Kofola",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_donut"] = {
		label = "Casino Donut",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_ego_chaser"] = {
		label = "Casino Ego Chaser",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_luckypotion"] = {
		label = "Casino Lucky Potion",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_psqs"] = {
		label = "Casino Ps & Qs",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_sandwitch"] = {
		label = "Casino Sandwitch",
		weight = 0,
		stack = true,
		close = true,
	},

	["casino_sprite"] = {
		label = "Casino Sprite",
		weight = 0,
		stack = true,
		close = true,
	},

	["lootbox1"] = {
		label = "lootbox1",
		weight = 1,
		stack = true,
		close = true,
	},

	["sim_card"] = {
		label = "Sim Card",
		weight = 1,
		stack = true,
		close = true,
	},
}