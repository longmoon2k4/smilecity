Config                            = {}
Config.Locale                     = 'en'

Config.DrawDistance               = 20.0 -- How close you need to be in order for the markers to be drawn (in GTA units).
Config.MaxInService               = -1
Config.EnablePlayerManagement     = false -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 500, max = 2000 }

Config.Vehicles = {
	'adder',
	't20',
	'rs7c8',
	'towtruck'
}

Config.Zones = {

	MechanicActions = {
		Pos   = { x = -344.83, y = -139.63, z = 38.01 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},
	
	MechanicActions2 = {
		Pos   = { x = 1176.03, y =  2641.36, z = 36.75 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	Garage = {
		Pos   = { x = -97.5, y = 6496.1, z = 30.4 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	Craft = {
		Pos   = { x = -215.970, y = -1313.842, z = 33.599 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = { x = -374.6, y = -117.65, z =  36.7 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},
	
	VehicleSpawnPoint2 = {
		Pos   = { x = 1167.52, y = 2663.86, z = 36.96 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = {x = -374.6, y = -117.65, z =  37.7 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	VehicleDeleter2 = {
		Pos   = { x = 1167.52, y = 2663.86, z = 36.96 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	VehicleDelivery = {
		Pos   = { x = -152.215, y = -1303.748, z = 30.285 },
		Size  = { x = 20.0, y = 20.0, z = 3.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
}

Config.Towables = {
	vector3(-2480.9, -212.0, 17.4),
	vector3(-2723.4, 13.2, 15.1),
	vector3(-3169.6, 976.2, 15.0),
	vector3(-3139.8, 1078.7, 20.2),
	vector3(-1656.9, -246.2, 54.5),
	vector3(-1586.7, -647.6, 29.4),
	vector3(-1036.1, -491.1, 36.2),
	vector3(-1029.2, -475.5, 36.4),
	vector3(75.2, 164.9, 104.7),
	vector3(-534.6, -756.7, 31.6),
	vector3(487.2, -30.8, 88.9),
	vector3(-772.2, -1281.8, 4.6),
	vector3(-663.8, -1207.0, 10.2),
	vector3(719.1, -767.8, 24.9),
	vector3(-971.0, -2410.4, 13.3),
	vector3(-1067.5, -2571.4, 13.2),
	vector3(-619.2, -2207.3, 5.6),
	vector3(1192.1, -1336.9, 35.1),
	vector3(-432.8, -2166.1, 9.9),
	vector3(-451.8, -2269.3, 7.2),
	vector3(939.3, -2197.5, 30.5),
	vector3(-556.1, -1794.7, 22.0),
	vector3(591.7, -2628.2, 5.6),
	vector3(1654.5, -2535.8, 74.5),
	vector3(1642.6, -2413.3, 93.1),
	vector3(1371.3, -2549.5, 47.6),
	vector3(383.8, -1652.9, 37.3),
	vector3(27.2, -1030.9, 29.4),
	vector3(229.3, -365.9, 43.8),
	vector3(-85.8, -51.7, 61.1),
	vector3(-4.6, -670.3, 31.9),
	vector3(-111.9, 92.0, 71.1),
	vector3(-314.3, -698.2, 32.5),
	vector3(-366.9, 115.5, 65.6),
	vector3(-592.1, 138.2, 60.1),
	vector3(-1613.9, 18.8, 61.8),
	vector3(-1709.8, 55.1, 65.7),
	vector3(-521.9, -266.8, 34.9),
	vector3(-451.1, -333.5, 34.0),
	vector3(322.4, -1900.5, 25.8)
}

for k,v in ipairs(Config.Towables) do
	Config.Zones['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end

Config.Uniforms = {
	male = {
		tshirt_1 = 58,   tshirt_2 = 0,
		torso_1 = 66,    torso_2 = 0,
		arms = 17,
		pants_1 = 39,   pants_2 = 0,
		shoes_1 = 7,   shoes_2 = 0,
		bags_1 = 45, 	bags_2 = 0,
	},
	female = {
		tshirt_1 = 58,   tshirt_2 = 0,
		torso_1 = 66,    torso_2 = 0,
		arms = 17,
		pants_1 = 39,   pants_2 = 0,
		shoes_1 = 7,   shoes_2 = 0,
		bags_1 = 45, 	bags_2 = 0,
	},

}

Config.Vehicles = {
	xe1= {model = "cuuho", price = 10000, label = "Xe cưu hộ", grade = 0},
	xe2 ={model="buzzard2", price = 500000, label = "Trực thăng", grade = 1},
	
}

Config.PosBuyVehicles = {
	{pos= vec3(-356.79, -130.39, 39.43)}
}