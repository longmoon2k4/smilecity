Config = {}

Config.Locale = 'vn'

Config.DrawDistance    = 100.0

Config.Delays = {
	WeedProcessing = 0 * 10,
	MethProcessing = 0 * 10,
	CokeProcessing = 0 * 10,
	HeroinProcessing = 0 * 10,
	thionylchlorideProcessing = 0 * 10,
}

Config.DrugDealerItems = {
	heroin = 800 ,
	marijuana = 900 ,
	meth1g = 1600,
	coke1g = 1000 ,
	jewels = 5000,
	--shark = 100000,
	--turtle = 10000,
}

Config.DrugDealerItemsEngough = {
	heroin = 1200 ,
	marijuana = 1300 ,
	meth1g = 2100,
	coke1g = 1400 ,
	jewels = 10000 ,
	--shark = 100000,
	--turtle = 10000,
}

Config.Zones = {

	heroin = {
		Pos   = {x = 2194.55, y = 5594.86, z = 52.8},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 128, b = 255}, 
		Type  = 27
	},


	cansa = {
		Pos   = {x = 2329.12, y = 2571.86, z = 45.8},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 128, b = 255},
		Type  = 27
	},

	-- sanho = {
	-- 	Pos   = {x = 1390.33, y = 3608.5, z = 38.05},
	-- 	Size  = {x = 1.5, y = 1.5, z = 1.0},
	-- 	Color = {r = 0, g = 128, b = 255},
	-- 	Type  = 27
	-- },

	coke = {
		Pos   = {x = -2916.28, y = 3468.07, z = 9.15},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 128, b = 255},
		Type  = 27
	},

	dealer = {
		Pos   = {x = -1174.483521, y = -1573.002197, z = 4.359009},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 128, b = 255},
		Type  = 27
	},

}

--Config.XpWeedNeed = 0
--Config.XpCokeNeed = 0
--Config.XpHeroinNeed = 0

----Cảnh Sát Online----
Config.cahaicoke = 3  -- Hái coke
Config.cachecoke = 3 -- Chế coke

Config.cahaiheroin = 3 -- Hái heroin
Config.cacheheroin = 3  -- Chế heroin

Config.cahaimeth = 3-- Hái San Hô
Config.cachemeth = 3  -- Chế San Hô

Config.cahaican = 3-- Hái cần
Config.cachecan = 3 -- Chế cần

Config.cahaisanso = 5 -- Bán đồ

Config.cabando = 3 -- Bán đồ

Config.vip = {
    -- 'steam:11000013e621c8b',
}

-----------------------

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	--Weed
	WeedField1 = {coords = vec3(300.63, 4312.78, 46.9), name = _U('blip_WeedFarm'), color = 75, sprite = 496, radius = 80.0},
	WeedField = {coords = vector3(300.63, 4312.78, 46.9), name = _U('blip_WeedFarm'), color = 75, sprite = 496, radius = 80.0},
	WeedProcessing = {coords = vec3(1543.147217, 6334.443848, 24.073242), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 80.0},
	
	--meth
	MethProcessing = {coords = vec3(1390.33, 3608.5, 38.94), name = _U('blip_methprocessing'), color = 64, sprite = 499, radius = 80.0},
	HydrochloricAcidFarm = {coords = vec3(4822.36328125, -4565.9423828125, 21.611396789551), name = _U('blip_HydrochloricAcidFarm'), color = 75, sprite = 499, radius = 80.0},
	--SulfuricAcidFarm = {coords = vector3(3333.34, 5160.22, 18.31), name = _U('blip_SulfuricAcidFarm'), color = 64, sprite = 499, radius = 80.0},
	--SodiumHydroxideFarm = {coords = vector3(3464.55, 3682.54, 33.17), name = _U('blip_SodiumHydroxideFarm'), color = 64, sprite = 499, radius = 80.0},
	
	--Chemicals
	--ChemicalsField = {coords = vector3(817.46, -3192.84, 5.9), name = _U('blip_ChemicalsFarm'), color = 25, sprite = 496, radius = 80.0},
	--ChemicalsConvertionMenu = {coords = vector3(3718.8, 4533.45, 21.67), name = _U('blip_ChemicalsProcessing'), color = 25, sprite = 496, radius = 0.0},
	
	--Coke
	CokeField = {coords =vector3(1498.496704, -2342.399902, 74.403687), name = _U('blip_CokeFarm'), color = 75, sprite = 626, radius = 80.0},
	CokeField1 = {coords = vec3(1498.496704, -2342.399902, 74.403687), name = _U('blip_CokeFarm'), color = 75, sprite = 626, radius = 80.0},
	CokeProcessing = {coords = vec3(968.030762, -2185.292236, 29.987549), name = _U('blip_Cokeprocessing'),color = 41, sprite = 626, radius = 80.0},

		--san ho
		SanhoField = {coords =vector3(383.406586, 7157.657227, -10.502563), name = _U('blip_CokeFarm'), color = 75, sprite = 626, radius = 80.0},
		SanhoField1 = {coords = vec3(383.406586, 7157.657227, -10.502563), name = _U('blip_CokeFarm'), color = 75, sprite = 626, radius = 80.0},
		SanhoProcessing = {coords = vec3(968.030762, -2185.292236, 29.987549), name = _U('blip_Cokeprocessing'),color = 41, sprite = 626, radius = 80.0},
		
	
	--LSD
	--lsdProcessing = {coords = vector3(91.26, 3749.31, 40.77), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	--thionylchlorideProcessing = {coords = vector3(1903.98, 4922.70, 48.16), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	
	--Heroin
	HeroinField = {coords = vector3(3657.639648, 4550.861328, 27.729614), name = _U('blip_heroinfield'), color = 75, sprite = 514, radius = 80.0},
	HeroinField1 = {coords = vec3(3657.639648, 4550.861328, 27.729614), name = _U('blip_heroinfield'), color = 75, sprite = 514, radius = 80.0},
	HeroinProcessing = {coords =  vec3(2194.153809, 5595.099121, 53.745850), name = _U('blip_heroinprocessing'), color = 3, sprite = 514, radius = 100.0}, 

	--DrugDealer
	DrugDealer = {coords = vec(-1174.483521, -1573.002197, 4.359009), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 80.0},
	
	--License
	--LicenseShop = {coords = vector3(707.17, -962.5, 30.4), name = _U('blip_lsdprocessing'),color = 25, sprite = 496, radius = 20.0},
	
	--MoneyWash
	--MoneyWash = {coords = vector3(8.84, -1103.8, -29.8), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}