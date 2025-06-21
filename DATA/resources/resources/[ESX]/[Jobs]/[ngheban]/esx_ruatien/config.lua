Config              = {}
Config.DrawDistance = 100.0
Config.MaxDelivery	= 7
Config.TruckPrice	= 20000
Config.Locale       = 'en'
Config.RequiredCops  = 3

Config.Trucks = {
	"burrito3",
	"boxville"	
}

Config.Cloakroom = {
	CloakRoom = {
			Pos   = vec3(-456.87, -2263.92,  8.52),-- {x = -456.87, y = -2263.92, z = 8.52},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27
		},
}
Config.Zones = {
	VehicleSpawner = {
			Pos   = vec3(-450.13, -2269.39, 7.61), --{x = -450.13, y = -2269.39, z = 7.61},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27
		},

	VehicleSpawnPoint = {
		Pos   = vec3(-437.44, -2269.39, 7.61), --{x = -437.44, y = -2269.39, z = 7.61},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1
		},
}

Config.Livraison = {
	Delivery1LS = {
			Pos   = vec3(121.0655, 1488.4984,  28.0) ,--{x = 121.0655, y = -1488.4984, z = 28.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- a cot� des flic
	--[[Delivery2LS = {
			Pos   = vec3(451.4836,  -899.0954,  27.5),
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},]]
	-- vers la plage
	Delivery3LS = {
			Pos   = vec3(-1129.4438, -1607.2420,  3.9),
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- studio 1
	Delivery4LS = {
			Pos   = vec3(-1064.7435,  -553.4235,  32.5), --{x = -1064.7435, y = -553.4235, z = 32.5},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- popular street et el rancho boulevard
	Delivery5LS = {
			Pos   = vec3(809.5350,  -2024.2238,  28.0),-- {x = 809.5350, y = -2024.2238, z = 28.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	--Alta street et las lagunas boulevard
	Delivery6LS = {
			Pos   = vec3(63.2668, -227.9965, 50.0),-- {x = 63.2668, y = -227.9965, z = 50.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	--Rockford Drive Noth et boulevard del perro
	Delivery7LS = {
			Pos   = vec3(-1338.6923,  -402.4188,  34.9),-- {x = -1338.6923, y = -402.4188, z = 34.9},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	--Rockford Drive Noth et boulevard del perro
	Delivery8LS = {
			Pos   = vec3(548.6097,  -206.3496,  52.5),--{x = 548.6097, y = -206.3496, z = 52.5},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	--New empire way (airport)
	Delivery9LS = {
			Pos   = vec3(-1141.9106,  -2699.9340, 13.0), --{x = -1141.9106, y = -2699.9340, z = 13.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	--Rockford drive south
	Delivery10LS = {
			Pos   = vec3(-640.0313,  -1224.9519,  10.5),-- {x = -640.0313, y = -1224.9519, z = 10.5},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
------------------------------------------- Blaine County
	-- panorama drive
	Delivery1BC = {
			Pos   = vec3(1999.5457,  3055.0686,  45.5),-- {x = 1999.5457, y = 3055.0686, z = 45.5},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- route 68
	Delivery2BC = {
			Pos   = vec3(555.4768,  2733.9533,  41.0),-- {x = 555.4768, y = 2733.9533, z = 41.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- Algonquin boulevard et cholla springs avenue
	Delivery3BC = {
			Pos   = vec3(1685.1549,  3752.0849,  33.0),-- {x =1685.1549, y = 3752.0849, z = 33.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- Joshua road
	Delivery4BC = {
			Pos   = vec3(182.7030,  2793.9829,  44.5),-- {x = 182.7030, y = 2793.9829, z = 44.5},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- East joshua road
	Delivery5BC = {
			Pos   = vec3(2710.6799,  4335.3168,  44.8),-- {x = 2710.6799, y = 4335.3168, z = 44.8},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- Seaview road
	Delivery6BC = {
			Pos   = vec3(1930.6518,  4637.5878,  39.3),-- {x = 1930.6518, y = 4637.5878, z = 39.3},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- Paleto boulevard
	Delivery7BC = {
			Pos   = vec3(-448.2438,  5993.8686,  30.3),--{x = -448.2438, y = 5993.8686, z = 30.3},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- Paleto boulevard et Procopio drive
	Delivery8BC = {
			Pos   = vec3(107.9181,  6605.9750,  30.8),-- {x = 107.9181, y = 6605.9750, z = 30.8},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- Marina drive et joshua road
	Delivery9BC = {
			Pos   = vec3(916.6915, 3568.7783, 32.7),-- {x = 916.6915, y = 3568.7783, z = 32.7},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	-- Pyrite Avenue
	Delivery10BC = {
			Pos   = vec3(-128.6733,  6344.5493,  31.0),-- {x = -128.6733, y = 6344.5493, z = 31.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	
	RetourCamion = {
			Pos   = vec3(917.99530029297, 62.024486541748,  80.764793395996),-- {x = 917.99530029297, y = 62.024486541748, z = 80.764793395996},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
	
	AnnulerMission = {
			Pos   = vec3(908.22473144531,  45.296188354492,  80.764785766602),-- {x = 908.22473144531, y = 45.296188354492, z = 80.764785766602},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 27,
			Paye = 30000
		},
}


