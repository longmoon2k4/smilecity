Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34, BuyArmor = 20}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}
Config.DrawDistance2 = 20
Config.EnablePlayerManagement     = false -- Enable if you want society managing.
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How much people can be in service at once?

Config.Locale                     = 'en'
Config.ArmorPrice = 1000
Config.BandagePrice = 1000
Config.PoliceStations = {

	LSPD = {

		-- Blip = {
		-- 	Coords  = vector3(425.1, -979.5, 30.7),
		-- 	Sprite  = 60,
		-- 	Display = 4,
		-- 	Scale   = 1.2,
		-- 	Colour  = 29
		-- },

		Cloakrooms = {
			--vector3(-2321.6370, 3260.8362, 33.0814),
			vector3(1760.571411, 3648.778076, 35.632202),
		},

		Armories = {
			vector3(452.202209, -973.239563, 30.678345),
			vector3(1763.182373, 3643.028564, 34.632202),
		},
		BuyArmor = {
			vector3(436.68, -986.36, 30.69),
			vector3(1777.753906, 3647.736328, 35.632202),
		},
		BuyVehicles = {
			vector3(423.6, -979.19, 30.71),
			--vector3(1850.89, 3683.27, 34.27),
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6),
			vector3(1760.571411, 3648.778076, 35.632202)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {

		{weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{weapon = 'WEAPON_STUNGUN', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	officer = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{weapon = 'WEAPON_STUNGUN', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	sergeant = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{weapon = 'WEAPON_STUNGUN', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	sergeant1 = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{weapon = 'WEAPON_STUNGUN', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	lieutenant = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{weapon = 'WEAPON_STUNGUN', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	boss = {
		{weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{weapon = 'WEAPON_STUNGUN', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	}
}

Config.AuthorizedVehicles = {
	car = {
		recruit = {
			--{model = 'pbike', price = 50000},
			{model = 'police', price = 20000},
			{model = 'police2', price = 20000},
			--{model = 'lp770cop', label = 'Lamborghini Aventador', price = 2000000},
			{model = 'segway', price = 500000},
			{model = 'G63AMG6x6cop', label = 'G63 AMG 6x6', price = 500000},
			--{model = 'riot', price = 64000},
			--{model = 'rmodfordpolice', label = 'Ford Mustang', price = 4000000},
			{model = 'rfw_ninja', label = 'Nagasaki Ninja', price = 300000},
			--{model = 'f150minigun', label = 'Xe bọc thép có súng', price = 2000000},
		},

		officer = {
			--{model = 'pbike', price = 50000},
			{model = 'police', price = 20000},
			{model = 'police2', price = 20000},
			--{model = 'lp770cop', label = 'Lamborghini Aventador', price = 2000000},
			{model = 'segway', price = 500000},
			{model = 'G63AMG6x6cop', label = 'G63 AMG 6x6', price = 500000},
			{model = 'riot', price = 64000},
			--{model = 'rmodfordpolice', label = 'Ford Mustang', price = 4000000},
			{model = 'rfw_ninja', label = 'Nagasaki Ninja', price = 300000},
			--{model = 'f150minigun', label = 'Xe bọc thép có súng', price = 2000000},
		},

		sergeant = {
			--{model = 'pbike', price = 50000},
			{model = 'police', price = 20000},
			{model = 'police2', price = 20000},
			{model = 'lp770cop', label = 'Lamborghini Aventador', price = 2000000},
			{model = 'segway', price = 500000},
			{model = 'G63AMG6x6cop', label = 'G63 AMG 6x6', price = 500000},
			{model = 'riot', price = 64000},
			{model = 'rmodfordpolice', label = 'Ford Mustang', price = 4000000},
			{model = 'rfw_ninja', label = 'Nagasaki Ninja', price = 300000},
			--{model = 'f150minigun', label = 'Xe bọc thép có súng', price = 2000000},
		},

		-- sergeant1 = {
		-- 	{model = 'police4', price = 18500}
		-- },

		lieutenant = {
			--{model = 'pbike', price = 50000},
			{model = 'police', price = 20000},
			{model = 'police2', price = 20000},
			{model = 'lp770cop', label = 'Lamborghini Aventador', price = 2000000},
			{model = 'segway', price = 500000},
			{model = 'G63AMG6x6cop', label = 'G63 AMG 6x6', price = 500000},
			{model = 'riot', price = 64000},
			{model = 'rmodfordpolice', label = 'Ford Mustang', price = 4000000},
			{model = 'rfw_ninja', label = 'Nagasaki Ninja', price = 300000},
			{model = 'f150minigun', label = 'Xe bọc thép có súng', price = 2000000},
		},

		phogiamdoc = {
			--{model = 'pbike', price = 50000},
			{model = 'police', price = 20000},
			{model = 'police2', price = 20000},
			{model = 'lp770cop', label = 'Lamborghini Aventador', price = 2000000},
			{model = 'segway', price = 500000},
			{model = 'G63AMG6x6cop', label = 'G63 AMG 6x6', price = 500000},
			{model = 'riot', price = 64000},
			{model = 'rmodfordpolice', label = 'Ford Mustang', price = 4000000},
			{model = 'rfw_ninja', label = 'Nagasaki Ninja', price = 300000},
			{model = 'f150minigun', label = 'Xe bọc thép có súng', price = 2000000},
		},

		boss = {
			{model = 'pbike', price = 50000},
			{model = 'police', price = 20000},
			{model = 'police2', price = 20000},
			{model = 'lp770cop', label = 'Lamborghini Aventador', price = 2000000},
			{model = 'segway', price = 500000},
			{model = 'G63AMG6x6cop', label = 'G63 AMG 6x6', price = 500000},
			{model = 'riot', price = 64000},
			{model = 'rmodfordpolice', label = 'Ford Mustang', price = 4000000},
			{model = 'rfw_ninja', label = 'Nagasaki Ninja', price = 300000},
			{model = 'f150minigun', label = 'Xe bọc thép có súng', price = 2000000},
		}
	},

	helicopter = {
		recruit = {
			{model = 'polmav', props = {modLivery = 0}, price = 1000000}
		},

		officer = {
			{model = 'polmav', props = {modLivery = 0}, price = 1000000}
		},

		sergeant = {
			{model = 'polmav', props = {modLivery = 0}, price = 1000000}
		},

		lieutenant = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		phogiamdoc = {
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

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	recruit = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 46,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	officer = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sergeant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 1,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sergeant1 = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 1,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	lieutenant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 2,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	boss = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}


Config.Zones = {
	
	MechanicActions = {
		Pos   = { x = 452.36, y = -1018.98, z =27.44 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	MechanicActions2 = {
		Pos   = { x =1871.42, y =  3684.85, z = 32.64 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	-- Garage = {
	-- 	Pos   = { x = -97.5, y = 6496.1, z = 30.4 },
	-- 	Size  = { x = 1.5, y = 1.5, z = 1.0 },
	-- 	Color = { r = 204, g = 204, b = 0 },
	-- 	Type  = 1
	-- },

	-- Craft = {
	-- 	Pos   = { x = -215.970, y = -1313.842, z = 33.599 },
	-- 	Size  = { x = 1.5, y = 1.5, z = 1.0 },
	-- 	Color = { r = 204, g = 204, b = 0 },
	-- 	Type  = 1
	-- },

	VehicleSpawnPoint = {
		Pos   = { x = 435.22, y = -1020.27, z = 26.79 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	VehicleSpawnPoint2 = {
		Pos   = { x = 1864.09, y = 3668.42, z = 31.92 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = { x = 435.22, y = -1020.27, z = 27.79 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	VehicleDeleter2 = {
		Pos   = { x = 1864.09, y = 3668.42, z = 32.92 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	-- VehicleDelivery = {
	-- 	Pos   = { x = -152.215, y = -1303.748, z = 30.285 },
	-- 	Size  = { x = 20.0, y = 20.0, z = 3.0 },
	-- 	Color = { r = 204, g = 204, b = 0 },
	-- 	Type  = -1
	-- }
}

Config.Zones1 ={
	Pos   =vector3(408.32, -984.08, 28.27),
}

Config.Vehicles = {
	xe1 ={model="sjcop1", price = 10000, label = "Xe lo?", grade = 0},
	xe2 ={model="aripolice", price = 800000, label = "May bay", grade = 1},
	-- xe4 ={model="m3a3", price = 10000000, label = "Xe chống đạn có súng", grade = 3},
}

Config.Weapon = {
	sung1 ={model="WEAPON_CARBINERIFLE", price = 10000, label = "CARBINE RIFLE", grade = 0},
	-- sung2 ={model="WEAPON_SPECIALCARBINE", price = 400000, label = "SPECIALCARBINE", grade = 6},
	-- sung3 ={model="WEAPON_SPECIALCARBINE_MK2", price = 1000000, label = "SPECIALCARBINE_MK2", grade = 6},
	-- sung4 ={model="WEAPON_SVD", price = 5000000, label = "SVD", grade = 8},
}