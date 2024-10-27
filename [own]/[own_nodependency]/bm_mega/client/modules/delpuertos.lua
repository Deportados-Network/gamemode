--[[
	Borrar puertas [Central]
--]]
local coordsBank = vector3(244.55,218.59,106.29)
local DoorsBank = {
	list = {
		{ coords = vector3(258.46, 213.06, 106.29) , dist = 3.0 , hash = 'hei_prop_hei_bankdoor_new' },
		{ coords = vector3(259.67, 215.7, 106.29) , dist = 3.0 , hash = 'hei_prop_hei_bankdoor_new' },
		{ coords = vector3(258.28, 203.55, 106.28) , dist = 3.0 , hash = 'hei_prop_hei_bankdoor_new' },
		{ coords = vector3(260.21, 202.76, 106.28) , dist = 3.0 , hash = 'hei_prop_hei_bankdoor_new' },
		{ coords = vector3(232.36, 213.42, 106.29) , dist = 3.0 , hash = 'hei_prop_hei_bankdoor_new' },
		{ coords = vector3(230.81, 216.67, 106.29) , dist = 3.0 , hash = 'hei_prop_hei_bankdoor_new' },
		{ coords = vector3(256.84,220.31,106.29) , dist = 3.0 , hash = 'hei_v_ilev_bk_gate_pris' },
		{ coords = vector3(237.06,228.04,106.29) , dist = 3.0 , hash = 'v_ilev_bk_door' },
		{ coords = vector3(237.48,228.04,110.29) , dist = 3.0 , hash = 'v_ilev_bk_door' },
		{ coords = vector3(256.85,206.89,110.29) , dist = 3.0 , hash = 'v_ilev_bk_door' },
		{ coords = vector3(265.63,217.53,110.29) , dist = 3.0 , hash = 'v_ilev_bk_door' },

		{ coords = vector3(262.1981, 222.5188, 106.4296) , dist = 3.0 , hash = 'hei_v_ilev_bk_gate2_pris' },
		{ coords = vector3(251.8576, 221.0655, 101.8324) , dist = 3.0 , hash = 'hei_v_ilev_bk_safegate_pris' },

		{ coords = vector3(262.5366, 215.0576, 110.4328) , dist = 3.0 , hash = 'v_ilev_bk_door2' },
		{ coords = vector3(260.8578, 210.4453, 110.4328) , dist = 3.0 , hash = 'v_ilev_bk_door2' },

		{ coords = vector3(255.2283, 223.976, 102.3932) , dist = 3.0 , hash = 'v_ilev_bk_vaultdoor' },
		{ coords = vector3(238.2898, 224.5779, 109.7805) , dist = 70.0 , hash = 'prop_ld_balastrude' }, -- Las barreras de arriba 
		{ coords = vector3(253.56, 207.74, 105.29) , dist = 10.0 , hash = 'prop_off_chair_01' }, -- Sillas
		{ coords = vector3(244.15, 200.69, 105.28) , dist = 50.0 , hash = 'prop_plant_int_01a' }, -- Sillas
	}
}
--[[
	Borrar puertas [Joyeria]
--]]
local coordsJoyeria = vector3(-631.2, -237.41, 38.08)
local DoorsJoyeria = {
	list = {
		{ coords = vector3(-631.2, -237.41, 38.08) , dist = 3.0 , hash = 'p_jewel_door_l' },
		{ coords = vector3(-631.2, -237.41, 38.08) , dist = 3.0 , hash = 'p_jewel_door_r1' },
	}
}

--[[
	Borrar puertas [Joyeria]
--]]
local coordsFabrica = vector3(-589.5254, -1621.555, 33.16061)
local DoorsFabrica = {
	list = {
		{ coords = vector3(-589.5254, -1621.555, 33.16061) , dist = 50.0 , hash = 'v_ilev_rc_door1_st' },
	}
}

--[[
	Borrar puertas [Life Invader]
--]]
local coordsLifeInvader = vector3(-1045.70, -230.71, 39.01)
local DoorsLifeInvader = {
	list = {
		{ coords = vector3(-1045.70, -230.71, 39.01) , dist = 2.0 , hash = 'v_ilev_fb_doorshortl' },
		{ coords = vector3(-1045.70, -230.71, 39.01) , dist = 2.0 , hash = 'v_ilev_fb_doorshortr' },
		{ coords = vector3(-1083.62, -260.4166, 38.1867) , dist = 2.0 , hash = 'v_ilev_fb_door01' },
		{ coords = vector3(-1080.974, -259.0203, 38.1867) , dist = 2.0 , hash = 'v_ilev_fb_door02' },
		{ coords = vector3(-1063.804, -240.8321, 39.88301) , dist = 2.0 , hash = 'v_ilev_door_orange' },
		{ coords = vector3(-1050.967, -236.6299, 39.88301) , dist = 2.0 , hash = 'v_ilev_door_orange' },
		{ coords = vector3(-1055.958, -236.4251, 44.171) , dist = 2.0 , hash = 'v_ilev_door_orangesolid' },

		{ coords = vector3(-1063.842, -240.6464, 43.021) , dist = 10.0 , hash = 'v_ilev_fb_sl_door01' }, -- Las puertas de sillones adentro

		{ coords = vector3(-1048.285, -236.8256, 44.19453) , dist = 10.0 , hash = 'v_ilev_fib_door2' },  
		{ coords = vector3(-1047.754, -237.8365, 44.08802) , dist = 10.0 , hash = 'v_9_partitions04' },  

		{ coords = vector3(-1045.896, -234.217, 43.02295) , dist = 50.0 , hash = 'prop_off_chair_01' },  -- Sillas del fondo
		{ coords = vector3(-1039.208, -235.6465, 43.0064) , dist = 50.0 , hash = 'prop_wait_bench_01' },  -- Sillones
		{ coords = vector3(-1037.822, -237.5716, 43.021) , dist = 50.0 , hash = 'prop_plant_int_03c' },  -- Florero
		{ coords = vector3(-1040.333, -232.9759, 43.021) , dist = 50.0 , hash = 'prop_plant_int_01b' },  -- Florero2


		{ coords = vector3(-1088.923, -260.2587, 36.75917) , dist = 2.0 , hash = 'prop_waiting_seat_01' }, -- Sillones
		{ coords = vector3(-1092.57, -258.5918, 36.75917) , dist = 2.0 , hash = 'prop_waiting_seat_01' }, -- Sillones
		{ coords = vector3(-1093.26, -258.0015, 36.76302) , dist = 2.0 , hash = 'prop_plant_int_03b' }, -- Jarron
		{ coords = vector3(-1093.26, -258.0015, 36.76302) , dist = 3.0 , hash = 'prop_plant_int_03b' }, -- Jarron

		{ coords = vector3(-1063.351, -243.149, 38.72897) , dist = 3.0 , hash = 'prop_vend_water_01' }, -- Maquina de Agua
		{ coords = vector3(-1062.962, -244.0246, 39.69569) , dist = 3.0 , hash = 'prop_vend_soda_01' }, -- Maquina de Coca
		{ coords = vector3(-1065, -239.9997, 39.64922) , dist = 3.0 , hash = 'prop_vend_snak_01' }, -- Maquina de Snak
		{ coords = vector3(-1079.667, -244.2563, 43.95742) , dist = 3.0 , hash = 'prop_arcade_01' }, -- Maquina de Snak
	}
}

--[[
	Borrar puertas [Humane]
--]]

local coordsHumane = vector3(3620.83, 3751.52, 27.69)
local DoorsHumane = {
	list = {
        { coords = vector3(3620.83, 3751.52, 27.69) , dist = 2.0 , hash = 'v_ilev_bl_shutter2' },
        { coords = vector3(3627.71, 3746.71, 27.69) , dist = 2.0 , hash = 'v_ilev_bl_shutter2' },
        { coords = vector3(3599.869, 3719.375, 29.83962) , dist = 2.0 , hash = 'v_ilev_bl_door_l' },
        { coords = vector3(3602, 3717.884, 29.83962) , dist = 2.0 , hash = 'v_ilev_bl_door_r' },
        { coords = vector3(3584.159, 3700.947, 28.97144) , dist = 2.0 , hash = 'v_ilev_bl_door_l' },
        { coords = vector3(3598.511, 3688.977, 28.97162) , dist = 2.0 , hash = 'v_ilev_bl_door_r' },
        { coords = vector3(3596.381, 3690.469, 28.97162) , dist = 2.0 , hash = 'v_ilev_bl_door_l' },
        { coords = vector3(3568.709, 3693.309, 28.27155) , dist = 2.0 , hash = 'v_ilev_bl_door_r' },
        { coords = vector3(3569.161, 3695.87, 28.27155) , dist = 2.0 , hash = 'v_ilev_bl_door_l' },
        { coords = vector3(3567.635, 3684.289, 27.1214) , dist = 2.0 , hash = 'v_ilev_bl_doorsl_r' },
        { coords = vector3(3586.29, 3699.455, 28.97144) , dist = 2.0 , hash = 'v_ilev_bl_door_r' },
        { coords = vector3(3565.074, 3684.74, 27.1214) , dist = 2.0 , hash = 'v_ilev_bl_doorsl_l' },
        { coords = vector3(3555.746, 3681.54, 27.1214) , dist = 2.0 , hash = 'v_ilev_bl_doorsl_l' },
        { coords = vector3(3558.307, 3681.088, 27.1214) , dist = 2.0 , hash = 'v_ilev_bl_doorsl_r' },
        { coords = vector3(3557.553, 3669.194, 27.12158) , dist = 2.0 , hash = 'v_ilev_bl_doorsl_r' },
        { coords = vector3(3555.435, 3664.802, 27.1214) , dist = 2.0 , hash = 'v_ilev_bl_doorsl_r' },
        { coords = vector3(3552.874, 3665.254, 27.1214) , dist = 2.0 , hash = 'v_ilev_bl_doorsl_l' },
	}
}


--[[
	Borrar puertas [Michael]
--]]
local coordsMichael = vector3(-796.5657, 177.2214, 73.04045)
local DoorsMichael = {
	list = {
		{ coords = vector3(-796.5657, 177.2214, 73.04045) , dist = 20.0 , hash = 'prop_bh1_48_backdoor_l' },
		{ coords = vector3(-794.1853, 182.568, 73.04045) , dist = 20.0 , hash = 'prop_bh1_48_backdoor_r' },
		{ coords = vector3(-816.1068, 177.5109, 72.82738) , dist = 20.0 , hash = 'v_ilev_mm_doorm_r' },
		{ coords = vector3(-816.716, 179.098, 72.82738) , dist = 20.0 , hash = 'v_ilev_mm_doorm_l' },
		{ coords = vector3(-802.7333, 167.5041, 77.58243) , dist = 20.0 , hash = 'v_ilev_mm_windowwc' },
		{ coords = vector3(-804.9543, 171.8626, 76.89033) , dist = 20.0 , hash = 'v_ilev_mm_doorw' },
		{ coords = vector3(-806.7717, 174.0235, 76.89033) , dist = 20.0 , hash = 'v_ilev_mm_doorson' },
		{ coords = vector3(-802.7017, 176.1755, 76.89033) , dist = 20.0 , hash = 'v_ilev_mm_doordaughter' },
		{ coords = vector3(-806.2817, 186.0246, 72.62405) , dist = 20.0 , hash = 'v_ilev_mm_door' },

		{ coords = vector3(-814.4891, 186.2793, 74.50242) , dist = 20.0 , hash = 'prop_ld_garaged_01' }, -- Garage
	}
}

--[[
	Borrar puertas [MiniBanco]
--]]
local coordsMiniBanco = vector3(-107.38, 6465.95, 31.63)
local DoorsMiniBanco = {
	list = {
		{ coords = vector3(-111.48, 6463.94, 31.98499) , dist = 2.0 , hash = 'v_ilev_bank4door02' },
		{ coords = vector3(-109.65, 6462.11, 31.98499) , dist = 2.0 , hash = 'v_ilev_bank4door01' },
		{ coords = vector3(-108.9147, 6469.104, 31.91028) , dist = 2.0 , hash = 'v_ilev_cbankcountdoor01' },
		{ coords = vector3(-104.8136, 6473.646, 31.9548) , dist = 2.0 , hash = 'v_ilev_cbankvaulgate01' },
		
	}
}

--[[
	Borrar puertas [Fleeca Ayuntamiento]
--]]
local coordsFleecaA = vector3(309.58, -279.38, 54.16)
local DoordsFleecaA = {
	list = {
		{ coords = vector3(316.3925, -276.4888, 54.5158) , dist = 2.0 , hash = 'v_ilev_genbankdoor2' },
		{ coords = vector3(313.9587, -275.5965, 54.51586) , dist = 2.0 , hash = 'v_ilev_genbankdoor1' },
		{ coords = vector3(309.7491, -280.1797, 54.43926) , dist = 2.0 , hash = 'v_ilev_gb_teldr' },
		{ coords = vector3(312.358, -282.7301, 54.30365) , dist = 2.0 , hash = 'v_ilev_gb_vauldr' },
		{ coords = vector3(314.6238, -285.9945, 54.46301) , dist = 2.0 , hash = 'v_ilev_gb_vaubar' },
		{ coords = vector3(309.3521, -274.5835, 53.16571) , dist = 2.0 , hash = 'prop_plant_int_01a' },

	}
}

--[[
	Borrar puertas [Fleeca ACA]
--]]
local coordsFleecaACA = vector3(-348.8109, -47.26213, 49.38759)
local DoordsFleecaACA = {
	list = {
		{ coords = vector3(-348.8109, -47.26213, 49.38759) , dist = 2.0 , hash = 'v_ilev_genbankdoor2' },
		{ coords = vector3(-351.2598, -46.41221, 49.38765) , dist = 2.0 , hash = 'v_ilev_genbankdoor1' },
		{ coords = vector3(-355.3892, -51.06769, 49.31105) , dist = 2.0 , hash = 'v_ilev_gb_teldr' },
		{ coords = vector3(-352.7365, -53.57248, 49.17543) , dist = 2.0 , hash = 'v_ilev_gb_vauldr' },
		{ coords = vector3(-350.4144, -56.79705, 49.3348) , dist = 2.0 , hash = 'v_ilev_gb_vaubar' },


		{ coords = vector3(-355.8815, -45.48265, 48.03672) , dist = 2.0 , hash = 'prop_plant_int_01a' }, --Planta

	}
}

--[[
	Borrar puertas [Fleeca Costa]
--]]
local coordsFleecaC = vector3(-2957.82, 481.48, 15.7)
local DoordsFleecaC = {
	list = {
		{ coords = vector3(-2965.71, 484.2195, 16.0481) , dist = 2.0 , hash = 'v_ilev_genbankdoor2' },
		{ coords = vector3(-2965.821, 481.6297, 16.04816) , dist = 2.0 , hash = 'v_ilev_genbankdoor1' },
		{ coords = vector3(-2960.176, 479.0105, 15.97156) , dist = 2.0 , hash = 'v_ilev_gb_teldr' },
		{ coords = vector3(-2958.538, 482.2705, 15.83594) , dist = 2.0 , hash = 'v_ilev_gb_vauldr' },
		{ coords = vector3(-2956.116, 485.4206, 15.99531) , dist = 2.0 , hash = 'v_ilev_gb_vaubar' },
		{ coords = vector3(-2965.385, 476.9357, 14.69766) , dist = 2.0 , hash = 'prop_plant_int_01a' }, -- Planta

		{ coords = vector3(-2958.539, 482.2706, 15.83594) , dist = 2.0 , hash = 'hei_prop_heist_sec_door' }, -- Fleeca de la Costa (Boveda)

	}
}

--[[
	Borrar puertas [Fleeca Sandy]
--]]
local coordsFleecaS = vector3(1176.19, 2711.69, 38.09)
local DoordsFleecaS = {
	list = {
		{ coords = vector3(1173.903, 2703.613, 38.43904) , dist = 2.0 , hash = 'v_ilev_genbankdoor2' },
		{ coords = vector3(1176.495, 2703.613, 38.43911) , dist = 2.0 , hash = 'v_ilev_genbankdoor1' },
		{ coords = vector3(1178.87, 2709.365, 38.36251) , dist = 2.0 , hash = 'v_ilev_gb_teldr' },
		{ coords = vector3(1175.542, 2710.861, 38.22689) , dist = 2.0 , hash = 'v_ilev_gb_vauldr' },
		{ coords = vector3(1172.291, 2713.146, 38.38625) , dist = 2.0 , hash = 'v_ilev_gb_vaubar' },
		{ coords = vector3(1173.903, 2703.613, 38.43904) , dist = 2.0 , hash = 'v_ilev_ss_door04' },
		{ coords = vector3(1188.995, 2652.316, 37.19326) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(1189.465, 2652.42, 37.19326) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(1112.701, 2625.333, 36.98785) , dist = 2.0 , hash = 'prop_gas_tank_01a' },
		{ coords = vector3(1173.179, 2699.196, 36.95933) , dist = 2.0 , hash = 'prop_bollard_02c' },
		{ coords = vector3(1174.202, 2699.062, 37.00983) , dist = 2.0 , hash = 'prop_bollard_02a' },
		{ coords = vector3(1177.34, 2699.049, 37.00835) , dist = 2.0 , hash = 'prop_bollard_02a' },
		{ coords = vector3(1173.182, 2702.865, 37.1464) , dist = 2.0 , hash = 'prop_bin_02a' },

	}
}

--[[
	Borrar puertas [Cerveceria PSG]
--]]
local coordsCerveceriaPSG = vector3(1392.44, 3604.9, 34.98)
local DoordsCerveceriaPSG = {
	list = {
		{ coords = vector3(1388.139, 3605.707, 35.14375) , dist = 2.0 , hash = 'v_ilev_mldoor02' },
		{ coords = vector3(1388.499, 3614.828, 39.09187) , dist = 2.0 , hash = 'v_ilev_ss_doorext' },
		{ coords = vector3(1399.7, 3607.763, 39.09187) , dist = 2.0 , hash = 'v_ilev_ss_doorext' },
		{ coords = vector3(1392.74, 3611.367, 39.09187) , dist = 2.0 , hash = 'v_ilev_methdoorscuff' },
		{ coords = vector3(1390.767, 3606.963, 38.30414) , dist = 2.0 , hash = 'prop_gascyl_01a' }, -- Tanques de nafta
		{ coords = vector3(1391.344, 3606.271, 38.15295) , dist = 2.0 , hash = 'prop_oilcan_01a' }, -- Tanques de nafta
		{ coords = vector3(1393.238, 3611.96, 38.30414) , dist = 2.0 , hash = 'prop_gascyl_01a' }, -- Tanques de nafta
		{ coords = vector3(1382.986, 3610.022, 33.89798) , dist = 2.0 , hash = 'prop_gas_tank_01a' }, -- Tanques de nafta
	}
}

--[[
	Borrar puertas [Cerveceria Jellow Jack]
--]]
local coordsCerveceriaPSG2 = vector3(1992.67, 3053.42, 47.21)
local DoordsCerveceriaPSG2 = {
	list = {
		{ coords = vector3(1991.106, 3053.105, 47.36528) , dist = 2.0 , hash = 'v_corp_hicksdoor' },
		{ coords = vector3(1988.353, 3054.411, 47.32039) , dist = 2.0 , hash = 'v_ilev_fh_door4' },
		{ coords = vector3(1975.287, 3049.166, 46.2095) , dist = 2.0 , hash = 'prop_gas_tank_02a' },
		{ coords = vector3(1997.734, 3045.201, 47.35933) , dist = 2.0 , hash = 'v_ilev_losttoiletdoor' }, -- Saca las 3 puertas que estan al lado de mesa de pool 
		{ coords = vector3(1998.002, 3040.343, 48.29903) , dist = 2.0 , hash = 'prop_cs4_10_tr_gd_01' },
		{ coords = vector3(1994.532, 3044.744, 47.01987) , dist = 2.0 , hash = 'prop_elec_heater_01' }, -- Coso de electricidad que te saca vida
 
	}
}

--[[
	Borrar puertas [Chicken]
--]]
local coordsChickenPSG = vector3(-102.7753, 6198.007, 31.17485)
local DoordsChickenPSG = {
	list = {
		{ coords = vector3(-102.7753, 6198.007, 31.17485) , dist = 2.0 , hash = 'v_ilev_staffdoor' },
		{ coords = vector3(-100.9329, 6199.843, 31.17485) , dist = 2.0 , hash = 'v_ilev_staffdoor' },
		{ coords = vector3(-70.3437, 6241.089, 31.61165) , dist = 2.0 , hash = 'v_34_strips003' },
		{ coords = vector3(-91.70095, 6213.187, 31.63407) , dist = 2.0 , hash = 'v_34_strips' },
		{ coords = vector3(-78.36523, 6235.9, 31.64327) , dist = 2.0 , hash = 'v_34_strips002' },
		{ coords = vector3(-82.79638, 6218.072, 31.67706) , dist = 2.0 , hash = 'v_34_strips001' },
	}
}

--[[
	Borrar puertas [Central PSG]
--]]
local coordsCentralPSG = vector3(2559.61, -325.55, 94.12)
local DoordsCentralPSG = {
	list = {
		{ coords = vector3(2559.614, -325.5558, 94.12363) , dist = 2.0 , hash = 'prop_facgate_05_r' },
		{ coords = vector3(2569.221, -325.5664, 94.12363) , dist = 2.0 , hash = 'prop_facgate_05_r' },
		{ coords = vector3(2562.322, -600.1516, 64.95991) , dist = 2.0 , hash = 'prop_sec_barrier_ld_02a' },
		{ coords = vector3(2555.614, -598.545, 64.70138) , dist = 2.0 , hash = 'prop_sec_barrier_ld_02a' },
		{ coords = vector3(2575.3, -282.4543, 92.75156) , dist = 2.0 , hash = 'prop_sec_barrier_ld_02a' },
		{ coords = vector3(2575.3, -288.4294, 92.75156) , dist = 2.0 , hash = 'prop_sec_barrier_ld_02a' },
		{ coords = vector3(2567.519, -325.9502, 91.92173) , dist = 2.0 , hash = 'prop_gate_military_01' },

	}
}

local coordsBasePaletoPSG = vector3(-387.647, 6131.82, 41.21)
local DoordsBasePaletoPSG = {
	list = {
		{ coords = vector3(-387.6479, 6131.829, 41.21121) , dist = 2.0 , hash = 'prop_flag_lsfd' },
	}
}



--[[
	Borrar puertas [Rancho]
--]]
local coordsRanchoPSG = vector3(2457.69, 4968.14, 47.02)
local DoordsRanchoPSG = {
	list = {
		{ coords = vector3(2487.042, 4952.005, 44.46195) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2486.22, 4952.478, 44.80429) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2486.636, 4952.418, 44.80429) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2479.612, 4958.407, 44.16655) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2480.014, 4958.845, 44.30183) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2480.494, 4958.855, 44.30183) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2498.402, 4966.137, 44.01082) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2498.566, 4965.581, 44.49153) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2498.906, 4965.333, 44.49153) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2519.85, 4952.766, 44.58057) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2519.51, 4953.014, 44.58957) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2519.109, 4953.228, 44.16788) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2522.923, 4961.421, 44.17989) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2523.087, 4960.864, 44.66061) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2523.427, 4960.616, 44.66061) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2530.479, 4980.292, 44.74883) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2530.827, 4979.907, 44.73678) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2531.345, 4980.196, 44.73832) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2533.71, 4983.384, 44.14397) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2535.418, 4984.411, 44.31657) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2535.141, 4984.876, 44.31657) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2531.863, 4985.813, 44.36446) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2527.958, 4988.078, 44.31657) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2527.754, 4988.579, 44.69276) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2453.184, 4969.372, 46.90218) , dist = 2.0 , hash = 'v_ilev_fh_frntdoor' },
		{ coords = vector3(2448.641, 4988.778, 46.90218) , dist = 2.0 , hash = 'v_ilev_fh_frntdoor' },
		{ coords = vector3(2435.429, 4975.025, 46.90218) , dist = 2.0 , hash = 'v_ilev_fh_frntdoor' },
		{ coords = vector3(2442.242, 4980.021, 46.9029) , dist = 2.0 , hash = 'prop_ret_door_02' },
		{ coords = vector3(2440.04, 4973.29, 46.9029) , dist = 2.0 , hash = 'prop_ret_door_02' },
		{ coords = vector3(2442.188, 4966.004, 46.9029) , dist = 2.0 , hash = 'prop_ret_door_02' },
		{ coords = vector3(2448.034, 4974.67, 51.65736) , dist = 2.0 , hash = 'prop_ret_door_02' },
		{ coords = vector3(2450.959, 4976.352, 51.65736) , dist = 2.0 , hash = 'prop_ret_door_02' },
		{ coords = vector3(2444.207, 4978.464, 51.65736) , dist = 2.0 , hash = 'prop_ret_door_02' },
		{ coords = vector3(2429.875, 4966.574, 44.16233) , dist = 2.0 , hash = 'v_8_cloth002' },
		{ coords = vector3(2441.01, 4981.73, 46.90218) , dist = 2.0 , hash = 'v_ilev_fh_frntdoor' },
		{ coords = vector3(2443.061, 4979.706, 51.8163) , dist = 2.0 , hash = 'v_ilev_fh_door03' },
		{ coords = vector3(2441.465, 4981.301, 51.8163) , dist = 2.0 , hash = 'v_ilev_fh_door03' },
		{ coords = vector3(2455.443, 4986.106, 46.9029) , dist = 2.0 , hash = 'prop_ret_door_02' },
		{ coords = vector3(2438.635, 4967.682, 46.90218) , dist = 2.0 , hash = 'v_ilev_fh_door4' },
		{ coords = vector3(2436.798, 4969.516, 46.90218) , dist = 2.0 , hash = 'v_ilev_fh_door4' },
		{ coords = vector3(2428.859, 4992.354, 45.88771) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2428.392, 4992.19, 45.88789) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2413.449, 5045.722, 45.79817) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2328.044, 4888.855, 40.80635) , dist = 2.0 , hash = 'prop_gas_tank_02a' },
		{ coords = vector3(2334.168, 4882.68, 40.80635) , dist = 2.0 , hash = 'prop_gas_tank_02a' },
		{ coords = vector3(2330.588, 4888.28, 41.18613) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2330.965, 4887.542, 41.18806) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2321.147, 4894.49, 41.59708) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2344.258, 4877.575, 41.60485) , dist = 2.0 , hash = 'prop_gascyl_04a' },
		{ coords = vector3(2344.04, 4876.29, 41.17097) , dist = 2.0 , hash = 'prop_gascyl_01a' },
		{ coords = vector3(2344.18, 4875.808, 41.17097) , dist = 2.0 , hash = 'prop_gascyl_01a' },
	}
}

--[[
	Borrar puertas [Rancho Casa Blanca PSG]
--]]
local coordsFuenteBlanca = vector3(1397.95, 1157.56, 114.48)
local FuenteBlanca = {
	list = {
		{ coords = vector3(1397.95, 1157.56, 114.48) , dist = 2.0 , hash = 'v_ilev_ra_door2' }, -- BANO
		
		{ coords = vector3(1408.16, 1165.83, 114.48) , dist = 2.0 , hash = 'v_ilev_ra_door1_r' }, -- Puertas de entrada arriba
		{ coords = vector3(1408.16, 1165.83, 114.48) , dist = 2.0 , hash = 'v_ilev_ra_door1_l' }, -- Puertas de entrada arriba

		{ coords = vector3(1390.41, 1161.24, 114.48) , dist = 2.0 , hash = 'v_ilev_ra_door1_r' }, -- Puertas de entrada arriba
		{ coords = vector3(1390.41, 1161.24, 114.48) , dist = 2.0 , hash = 'v_ilev_ra_door1_l' }, -- Puertas de entrada arriba

		{ coords = vector3(1401.58, 1128.31, 114.48) , dist = 0.5 , hash = 'v_ilev_ra_door1_r' }, -- Puertas de arriba
		{ coords = vector3(1401.59, 1128.31, 114.48) , dist = 0.5 , hash = 'v_ilev_ra_door1_l' }, -- Puertas de arriba
		
		{ coords = vector3(1394.46, 1128.96, 113.71) , dist = 2.0 , hash = 'v_ret_chair' }, -- Sillas
		{ coords = vector3(1394.46, 1128.96, 113.71) , dist = 2.0 , hash = 'v_ret_chair_white' }, -- Sillas

		{ coords = vector3(1407.547, 1128.329, 114.48) , dist = 2.0 , hash = 'v_ilev_ra_door4r' }, -- Puerta entrada abajo

		{ coords = vector3(1400.05, 1134.62, 109.89) , dist = 2.0 , hash = 'v_ilev_rc_door2' }, -- Puertas abajo

		{ coords = vector3(1402.35, 1131.45, 109.56) , dist = 2.0 , hash = 'prop_gascyl_04a' }, -- Extintor
	}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1800)

		if GetDistanceBetweenCoords(coordsBank, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoorsBank['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsJoyeria, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoorsJoyeria['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsLifeInvader, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoorsLifeInvader['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsFabrica, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoorsFabrica['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsHumane, GetEntityCoords(PlayerPedId())) < 500.0 then
			for k, doors in ipairs(DoorsHumane['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsMichael, GetEntityCoords(PlayerPedId())) < 500.0 then
			for k, doors in ipairs(DoorsMichael['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsMiniBanco, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoorsMiniBanco['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsFleecaA, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoordsFleecaA['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsFleecaC, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoordsFleecaC['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsFleecaS, GetEntityCoords(PlayerPedId())) < 500.0 then
			for k, doors in ipairs(DoordsFleecaS['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsFleecaACA, GetEntityCoords(PlayerPedId())) < 500.0 then
			for k, doors in ipairs(DoordsFleecaACA['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end
		
		if GetDistanceBetweenCoords(coordsCerveceriaPSG, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoordsCerveceriaPSG['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end
		
		if GetDistanceBetweenCoords(coordsCerveceriaPSG2, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoordsCerveceriaPSG2['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end
		
		if GetDistanceBetweenCoords(coordsChickenPSG, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoordsChickenPSG['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsRanchoPSG, GetEntityCoords(PlayerPedId())) < 500.0 then
			for k, doors in ipairs(DoordsRanchoPSG['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsBasePaletoPSG, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoordsBasePaletoPSG['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsCentralPSG, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(DoordsCentralPSG['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end

		if GetDistanceBetweenCoords(coordsFuenteBlanca, GetEntityCoords(PlayerPedId())) < 300.0 then
			for k, doors in ipairs(FuenteBlanca['list']) do
				local object = GetClosestObjectOfType(doors.coords, doors.dist, GetHashKey(doors.hash), false, false, false)
				deleteObject(object)
			end
		end
	end
end)

function deleteObject(object)
	if DoesEntityExist(object) then
		SetEntityVisible(object,false,0)

		SetEntityAsMissionEntity(object) 
		DeleteEntity(object)
	end
end