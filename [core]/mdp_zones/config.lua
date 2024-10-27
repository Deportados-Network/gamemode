Zones = {
    [1] = { --
        ['zone'] = {
            ['type'] = 'sphere',
            ['thickness'] = 2,
            ['debug'] = false,
            ['radius'] = 70.0,
            ['size'] = vec3(1, 1, 1),
            ['rotation'] = 45.0,
            ['coords'] = {
                vec3(-348.789551, -874.373169, 31.318018),
            },
            ['action'] = {
                inside = function(self)
                    InsideSafeZone(self)
                end,
                onExit = function(self)
                    ExitSafezone(self)
                end,
            },
        },
        ['blip'] = {
            ['blip_radius'] = {
                ['enabled'] = true,
                ['coords'] = {
                    ['X'] = -348.789551,
                    ['Y'] = -874.373169,
                    ['Z'] = 31.318018,
                },
                ['color'] = 80,
                ['radius'] = 70.0,
                ['alpha'] = 70,
            },
            ['blip_marker'] = {
                ['enabled'] = false,
                ['coords'] = {
                    ['X'] = 255.250198,
                    ['Y'] = 226.070358,
                    ['Z'] = 101.882225,
                },
                ['color'] = 0,
                ['scale'] = 1.0,
                ['display'] = 1,
                ['sprite'] = 108,
                ['text'] = 'Safezone',
            },
        },
    },
    -- creacion de personaje
    [3] = { --
    ['zone'] = {
        ['type'] = 'sphere',
        ['thickness'] = 2,
        ['debug'] = false,
        ['radius'] = 70.0,
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-257.7676, -970.8049, 31.2199),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -257.7676,
                ['Y'] = -970.8049,
                ['Z'] = 31.2199,
            },
            ['color'] = 80,
            ['radius'] = 70.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = -257.7676,
                ['Y'] = -970.8049,
                ['Z'] = 31.2199,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- GC CUBO
    [3] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 90.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(240.553848, -760.074707, 34.638062),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 240.5538,
                ['Y'] = -760.074,
                ['Z'] = 34.6380,
            },
            ['color'] = 80,
            ['radius'] = 90.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 222.97586,
                ['Y'] = -792.879,
                ['Z'] = 30.7120,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},


    -- COMISARIA
    [4] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 90.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-1122.7473, -836.2123, 19.3162),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -1122.7473,
                ['Y'] = -836.2123,
                ['Z'] =  19.3162,
            },
            ['color'] = 80,
            ['radius'] = 90.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 255.250198,
                ['Y'] = 226.070358,
                ['Z'] = 101.882225,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- ARMERIA GC CUBO
    [5] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 60.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(19.5752, -1111.1910, 29.8034),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 19.5752,
                ['Y'] = -1111.1910,
                ['Z'] =  29.8034,
            },
            ['color'] = 80,
            ['radius'] = 60.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 255.250198,
                ['Y'] = 226.070358,
                ['Z'] = 101.882225,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- HOSPITAL CIUDAD
    [6] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 90.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(305.8883, -588.6730, 43.2841),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 305.8883,
                ['Y'] = -588.6730,
                ['Z'] =  43.2841,
            },
            ['color'] = 80,
            ['radius'] = 90.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 255.250198,
                ['Y'] = 226.070358,
                ['Z'] = 101.882225,
            },
            ['color'] = 1,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- HOSPITAL CIUDAD
    [7] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 90.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(1854.725220, 3682.589111, 34.28430),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {   
                ['X'] = 1854.725220,
                ['Y'] = 3682.589111,
                ['Z'] =  34.28430
            },
            ['color'] = 80,
            ['radius'] = 90.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 1854.725220,
                ['Y'] = 3682.589111,
                ['Z'] =  34.28430
            },
            ['color'] = 1,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},


    

    -- SULFU
    [9] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 300.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-1360.0039, -1585.0536, 2.0768),
        },
        ['action'] = {
            inside = function(self)
                InsideRojaZone(self)
            end,
            onExit = function(self)
                ExitRojaZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -1360.0039,
                ['Y'] = -1585.0536,
                ['Z'] =  2.0768,
            },
            ['color'] = 1,
            ['radius'] = 300.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

--- ZONAS PERIMETRO

    -- HUMANE
    [12] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        ['radius'] = 90.0,
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(3592.4016, 3758.4377, 29.9200),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 3592.4016,
                ['Y'] = 3758.4377,
                ['Z'] =  29.9200,
            },
            ['color'] = 0,
            ['radius'] = 90.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- BANCO CENTRAL
    [13] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 120.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(256.5712, 229.6574, 109.4786),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 256.5712,
                ['Y'] = 229.6574,
                ['Z'] =  109.4786,
            },
            ['color'] = 0,
            ['radius'] = 120.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- chicken
    [13] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-70.259338, 6241.437500, 31.065918),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = { 
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -70.259338,
                ['Y'] = 6241.4375,
                ['Z'] =  31.065916,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = -70.259338,
                ['Y'] = 6241.4375,
                ['Z'] =  31.065916,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},



    -- MAZE BANK
    [23] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-1302.514282, -824.413208, 17.147949),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -1302.514282,
                ['Y'] = -824.413208,
                ['Z'] =  17.147949,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- SUBTE LIFE
    [14] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-845.2667, -127.9063, 37.5798),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -845.2667,
                ['Y'] = -127.9063,
                ['Z'] =  37.5798,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- LIFE INVADER
    [15] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-1051.9111, -232.7007, 45.2956),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -1051.9111,
                ['Y'] = -232.7007,
                ['Z'] =  45.2956,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- YATE
    [16] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-2090.1274, -1016.7029, 13.5505),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -2090.1274,
                ['Y'] = -1016.7029,
                ['Z'] =  13.5505,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- FLECA AYUNTA
    [17] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(314.4666, -277.2704, 54.1745),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 314.4666,
                ['Y'] = -277.2704,
                ['Z'] =  54.1745,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- zonas secuestro, antena
    [18] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(736.905518, 1285.529663, 360.29443),
        },
        ['action'] = {
            inside = function(self)
                InsideSecuestroZone(self)
            end,
            onExit = function(self)
                ExitSecuestroZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 736.90,
                ['Y'] = 1285.524,
                ['Z'] =  360.29445,
            },
            ['color'] = 7,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 57,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- FLECCA COSTA
    [19] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-2957.67, 480.22, 15.69),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -2957.67,
                ['Y'] = 480.22,
                ['Z'] = 15.69,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- PORTA AVIONES
    [19] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 145.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(3081.705566, -4704.856934, 27.257935),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 3081.705566,
                ['Y'] = -4704.856934,
                ['Z'] = 27.257935,
            },
            ['color'] = 0,
            ['radius'] = 145.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- FLECCA SANDY
    [20] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(1177.53, 2711.75, 38.1),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 1177.53,
                ['Y'] = 2711.75,
                ['Z'] = 38.1,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- BANCO PALETO
    [21] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-106.984619, 6474.672363, 31.621948),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -106.984619,
                ['Y'] = 6474.672363,
                ['Z'] = 31.621948,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- FLEECA ACA
    [22] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-352.2514, -48.9879, 49.0411),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -352.2514,
                ['Y'] = -48.9879,
                ['Z'] =  49.0411,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = 235.3648,
                ['Y'] = -690.6326,
                ['Z'] =  36.7130,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

    -- CASA MICHAEL
    [25] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 80.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = { 
            vec3(-813.217590, 179.340668, 82.643188),
        },
        ['action'] = {
            inside = function(self)
                InsideRoboZone(self)
            end,
            onExit = function(self)
                ExitRoboZone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = { 
                ['X'] = -813.217590,
                ['Y'] = 179.340669,
                ['Z'] =  82.64311,
            },
            ['color'] = 0,
            ['radius'] = 80.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = -813.217590,
                ['Y'] = 179.340669,
                ['Z'] =  82.64311,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

-- CASINO
    [26] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 120.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(927.36, 44.87, 81.11),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 927.36,
                ['Y'] = 44.87,
                ['Z'] = 81.11,
            },
            ['color'] = 80,
            ['radius'] = 120.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = -257.7676,
                ['Y'] = -970.8049,
                ['Z'] = 31.2199,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

-- MECANICO
    [27] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 60.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(-205.58, -1322.71, 30.9),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = -205.58,
                ['Y'] = -1322.71,
                ['Z'] = 30.9,
            },
            ['color'] = 80,
            ['radius'] = 60.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = -257.7676,
                ['Y'] = -970.8049,
                ['Z'] = 31.2199,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

-- GC SANDY
    [28] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 50.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(1723.7698, 3715.0652, 34.1770),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 1723.7698,
                ['Y'] = 3715.0652,
                ['Z'] = 34.1770,
            },
            ['color'] = 80,
            ['radius'] = 50.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = -257.7676,
                ['Y'] = -970.8049,
                ['Z'] = 31.2199,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

-- MECA GORDO TUNNING
    [29] = { --
    ['zone'] = {
        ['type'] = 'sphere', 
        ['thickness'] = 2,
        ['debug'] = false,
        
        ['radius'] = 50.0,
        
        ['size'] = vec3(1, 1, 1),
        ['rotation'] = 45.0,
        ['coords'] = {
            vec3(141.92, -1093.21, 29.4),
        },
        ['action'] = {
            inside = function(self)
                InsideSafeZone(self)
            end,
            onExit = function(self)
                ExitSafezone(self)
            end,
        },
    },
    ['blip'] = {
        ['blip_radius'] = {
            ['enabled'] = true,
            ['coords'] = {
                ['X'] = 141.92,
                ['Y'] = -1093.21,
                ['Z'] = 29.4,
            },
            ['color'] = 80,
            ['radius'] = 50.0,
            ['alpha'] = 70,
        },
        ['blip_marker'] = {
            ['enabled'] = false,
            ['coords'] = {
                ['X'] = -257.7676,
                ['Y'] = -970.8049,
                ['Z'] = 31.2199,
            },
            ['color'] = 0,
            ['scale'] = 1.0,
            ['display'] = 1,
            ['sprite'] = 108,
            ['text'] = 'Safezone',
        },
    },
},

}