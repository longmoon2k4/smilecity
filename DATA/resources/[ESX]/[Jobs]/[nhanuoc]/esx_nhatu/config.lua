Config = {}

Config.JailPositions = {
	--["Cell"] = { ["x"] = 1799.8345947266, ["y"] = 2489.1350097656, ["z"] = -119.02998352051, ["h"] = 179.03021240234 }
	["Cell"] = { ["x"] = 1712.24, ["y"] = 2566.16, ["z"] = 45.56, ["h"] =81.15771484375 }
}

Config.Cutscene = {
	["PhotoPosition"] = { ["x"] = 402.91567993164, ["y"] = -996.75970458984, ["z"] = -99.000259399414, ["h"] = 186.22499084473 },

	["CameraPos"] = { ["x"] = 402.88830566406, ["y"] = -1003.8851318359, ["z"] = -97.419647216797, ["rotationX"] = -15.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -0.31496068835258, ["cameraId"] = 0 },

	["PolicePosition"] = { ["x"] = 402.91702270508, ["y"] = -1000.6376953125, ["z"] = -99.004028320313, ["h"] = 356.88052368164 }
}

Config.PrisonWork = {
	["DeliverPackage"] = { ["x"] = 1027.2347412109, ["y"] = -3101.419921875, ["z"] = -38.999870300293, ["h"] = 267.89135742188 },

	["Packages"] = {
		[1] = { ["x"] = 1722.93, ["y"] = 2546.22, ["z"] = 45.56, ["state"] = true },
		[2] = { ["x"] = 1716.76, ["y"] = 2543.32, ["z"] = 45.56, ["state"] = true },
		[3] = { ["x"] = 1719.33, ["y"] = 2537.34, ["z"] = 45.56, ["state"] = true },
		[4] = { ["x"] = 1725.05, ["y"] = 2539.06, ["z"] = 45.56, ["state"] = true },
		[5] = { ["x"] = 1729.25, ["y"] = 2532.86, ["z"] = 45.56, ["state"] = true },
		[6] = { ["x"] = 1723.26, ["y"] = 2528.66, ["z"] = 45.56, ["state"] = true },
		-- [7] = { ["x"] = 1015.6422119141, ["y"] = -3091.7392578125, ["z"] = -38.999897003174, ["state"] = true },
		-- [8] = { ["x"] = 1010.7862548828, ["y"] = -3096.6135253906, ["z"] = -38.999897003174, ["state"] = true },
		-- [9] = { ["x"] = 1005.7819824219, ["y"] = -3096.8415527344, ["z"] = -38.999897003174, ["state"] = true },
		-- [10] = { ["x"] = 1003.4543457031, ["y"] = -3096.7048339844, ["z"] = -38.999897003174, ["state"] = true }
	}
}

Config.Teleports = {
	["Prison Work"] = { 
		["x"] = 1712.24, 
		["y"] = 2566.16, 
		["z"] = 45.56, 
		["h"] = 81.15771484375, 
		["goal"] = { 
			"Jail" 
		} 
	},

	["Boiling Broke"] = { 
		["x"] = 1845.6022949219, 
		["y"] = 2585.8029785156, 
		["z"] = 45.672061920166, 
		["h"] = 92.469093322754, 
		["goal"] = { 
			"Security" 
		} 
	},

	["Jail"] = { 
		["x"] = 1800.6979980469, 
		["y"] = 2483.0979003906, 
		["z"] = -122.68814849854, 
		["h"] = 271.75274658203, 
		["goal"] = { 
			"Prison Work", 
			"Security", 
			"Visitor" 
		} 
	},

	["Security"] = { 
		["x"] = 1706.7625732422,
		["y"] = 2581.0793457031, 
		["z"] = -69.407371520996, 
		["h"] = 267.72802734375, 
		["goal"] = { 
			"Jail",
			"Boiling Broke"
		} 
	},

	["Visitor"] = {
		["x"] = 1699.7196044922, 
		["y"] = 2574.5314941406, 
		["z"] = -69.403930664063, 
		["h"] = 169.65020751953, 
		["goal"] = { 
			"Jail" 
		} 
	}
}