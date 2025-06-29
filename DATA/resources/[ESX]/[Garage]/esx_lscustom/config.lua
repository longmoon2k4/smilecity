local colors = {
{name = "Đen", colorindex = 0},{name = "Carbon Black", colorindex = 147},
{name = "Màu Than", colorindex = 1},{name = "Anhracite Black", colorindex = 11},
{name = "Màu đen thép", colorindex = 2},{name = "Dark Steel", colorindex = 3},
{name = "Màu bạc", colorindex = 4},{name = "Bluish Silver", colorindex = 5},
{name = "Rolled Steel", colorindex = 6},{name = "Shadow Silver", colorindex = 7},
{name = "Màu đá bạc", colorindex = 8},{name = "Midnight Silver", colorindex = 9},
{name = "Màu bạc cũ", colorindex = 10},{name = "Red", colorindex = 27},
{name = "Đỏ rửc lửa", colorindex = 28},{name = "Formula Red", colorindex = 29},
{name = "Đỉ dung nham", colorindex = 150},{name = "Blaze Red", colorindex = 30},
{name = "Đỏ đậm", colorindex = 31},{name = "Garnet Red", colorindex = 32},
{name = "Đỏ mặt trời", colorindex = 33},{name = "Cabernet Red", colorindex = 34},
{name = "Đỏ rượu vang", colorindex = 143},{name = "Candy Red", colorindex = 35},
{name = "Hồng đậm", colorindex = 135},{name = "Pfsiter Pink", colorindex = 137},
{name = "Hồng nhạt", colorindex = 136},{name = "Sunrise Orange", colorindex = 36},
{name = "Cam", colorindex = 38},{name = "Bright Orange", colorindex = 138},
{name = "Màu vàng thỏi", colorindex = 99},{name = "Bronze", colorindex = 90},
{name = "Vàng", colorindex = 88},{name = "Race Yellow", colorindex = 89},
{name = "Vàng sương", colorindex = 91},{name = "Dark Green", colorindex = 49},
{name = "Xanh racing", colorindex = 50},{name = "Sea Green", colorindex = 51},
{name = "Xanh ô liu", colorindex = 52},{name = "Bright Green", colorindex = 53},
{name = "Xanh đậm", colorindex = 54},{name = "Lime Green", colorindex = 92},
{name = "Xanh trời đêm", colorindex = 141},
{name = "Xanh vũ trụ", colorindex = 61},{name = "Dark Blue", colorindex = 62},
{name = "Xanh óng", colorindex = 63},{name = "Blue", colorindex = 64},
{name = "Xanh bóng", colorindex = 65},{name = "Harbor Blue", colorindex = 66},
{name = "Xanh kim cương", colorindex = 67},{name = "Surf Blue", colorindex = 68},
{name = "Xanh vừa mắt ", colorindex = 69},{name = "Racing Blue", colorindex = 73},
{name = "Xanh ultra", colorindex = 70},{name = "Light Blue", colorindex = 74},
{name = "Nâu socola", colorindex = 96},{name = "Bison Brown", colorindex = 101},
{name = "Nâu lông gấu", colorindex = 95},{name = "Feltzer Brown", colorindex = 94},
{name = "Nâu gỗ", colorindex = 97},{name = "Beechwood Brown", colorindex = 103},
{name = "Nâu đậm", colorindex = 104},{name = "Saddle Brown", colorindex = 98},
{name = "Nâu ngả vàng", colorindex = 100},{name = "Woodbeech Brown", colorindex = 102},
{name = "Nâu đen", colorindex = 99},{name = "Sandy Brown", colorindex = 105},
{name = "Nâu ngả vàng", colorindex = 106},{name = "Schafter Purple", colorindex = 71},
{name = "Tím bóng", colorindex = 72},{name = "Midnight Purple", colorindex = 142},
{name = "Tím sáng", colorindex = 145},{name = "Cream", colorindex = 107},
{name = "Đá trắng", colorindex = 111},{name = "Frost White", colorindex = 112}}
local metalcolors = {
{name = "Trắng inox",colorindex = 117},
{name = "Đen tuyền",colorindex = 118},
{name = "Trắng bóng",colorindex = 119},
{name = "Vàng nguyên khối",colorindex = 158},
{name = "Vàng bóng",colorindex = 159}
}
local mattecolors = {
{name = "Đen", colorindex = 12},
{name = "Tím", colorindex = 13},
{name = "Tím nhẹ", colorindex = 14},
{name = "Đá trắng", colorindex = 131},
{name = "Xanh da trời", colorindex = 83},
{name = "Xanh da trời đậm", colorindex = 82},
{name = "Xanh bóng đêm", colorindex = 84},
{name = "Tím bóng đêm", colorindex = 149},
{name = "Tím huyền ảo", colorindex = 148},
{name = "Đỏ", colorindex = 39},
{name = "Đỏ đậm", colorindex = 40},
{name = "Cam", colorindex = 41},
{name = "Vàng", colorindex = 42},
{name = "Xanh chanh", colorindex = 55},
{name = "Xanh", colorindex = 128},
{name = "Xanh đậm", colorindex = 151},
{name = "Xanh lá cây", colorindex = 155},
{name = "Màu lục vàng", colorindex = 152},
{name = "Đen tự nhiên", colorindex = 153},
{name = "Vàng nâu", colorindex = 154}
}



LSC_Config = {}
LSC_Config.prices = {}

------Model Blacklist--------
--Does'nt allow specific vehicles to be upgraded
LSC_Config.ModelBlacklist = {
	
}

--Sets if garage will be locked if someone is inside it already
LSC_Config.lock = false

--Enable/disable old entering way
LSC_Config.oldenter = true



-------Prices---------
LSC_Config.prices = {

------Window tint------
	windowtint = {
		{ name = "Màu đen thuần", tint = 1, price = 1000},
		{ name = "Màu đen khói", tint = 2, price = 1000},
		{ name = "Màu trong suốt", tint = 3, price = 1000},
		{ name = "Limo", tint = 4, price = 1000},
		{ name = "Xanh", tint = 5, price = 1000},
	},

-------Respray--------
----Primary color---
	--Chrome 
	chrome = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 1000
	},
	--Classic 
	classic = {
		colors = colors,
		price = 200
	},
	--Matte 
	matte = {
		colors = mattecolors,
		price = 500
	},
	--Metallic 
	metallic = {
		colors = colors,
		price = 300
	},
	--Metals 
	metal = {
		colors = metalcolors,
		price = 300
	},

----Secondary color---
	--Chrome 
	chrome2 = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 1000
	},
	--Classic 
	classic2 = {
		colors = colors,
		price = 200
	},
	--Matte 
	matte2 = {
		colors = mattecolors,
		price = 500
	},
	--Metallic 
	metallic2 = {
		colors = colors,
		price = 300
	},
	--Metals 
	metal2 = {
		colors = metalcolors,
		price = 300
	},

------Neon layout------
	neonlayout = {
		{name = "Front,Back and Sides", price = 5000},
	},
	--Neon color
	neoncolor = {
		{ name = "Trắng", neon = {255,255,255}, price = 1000},
		{ name = "Xanh da trời", neon = {0,0,255}, price = 1000},
		{ name = "Xanh điện", neon = {0,150,255}, price = 1000},
		{ name = "Xanh mịn", neon = {50,255,155}, price = 1000},
		{ name = "Lime Green", neon = {0,255,0}, price = 1000},
		{ name = "Vàng", neon = {255,255,0}, price = 1000},
		{ name = "Golden Shower", neon = {204,204,0}, price = 1000},
		{ name = "Cam", neon = {255,128,0}, price = 1000},
		{ name = "Đỏ", neon = {255,0,0}, price = 1000},
		{ name = "Hồng nhạt", neon = {255,102,255}, price = 1000},
		{ name = "Hồng đậm",neon = {255,0,255}, price = 1000},
		{ name = "Tím", neon = {153,0,153}, price = 1000},
		{ name = "Nâu", neon = {139,69,19}, price = 1000},
	},
	
--------Plates---------
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 200},
		{ name = "Blue On White 2", plateindex = 3, price = 200},
		{ name = "Blue On White 3", plateindex = 4, price = 200},
		{ name = "Yellow on Blue", plateindex = 2, price = 300},
		{ name = "Yellow on Black", plateindex = 1, price = 600},
	},
	
--------Wheels--------
----Wheel accessories----
	wheelaccessories = {
		{ name = "Stock Tires", price = 1000},
		{ name = "Custom Tires", price = 1250},
		-- { name = "Bulletproof Tires", price = 99999999},
		{ name = "White Tire Smoke",smokecolor = {254,254,254}, price = 3000},
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 3000},
		{ name = "BLue Tire Smoke", smokecolor = {0,150,255}, price = 3000},
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 3000},
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 3000},
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 3000},
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 3000},
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 3000},
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 3000},
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 3000},
	},

----Wheel color----
	wheelcolor = {
		colors = colors,
		price = 1000,
	},

----Front wheel (Bikes)----
	frontwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 1000},
		{name = "Speedway", wtype = 6, mod = 0, price = 1000},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 1000},
		{name = "Racer", wtype = 6, mod = 2, price = 1000},
		{name = "Trackstar", wtype = 6, mod = 3, price = 1000},
		{name = "Overlord", wtype = 6, mod = 4, price = 1000},
		{name = "Trident", wtype = 6, mod = 5, price = 1000},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 1000},
		{name = "Stilleto", wtype = 6, mod = 7, price = 1000},
		{name = "Wires", wtype = 6, mod = 8, price = 1000},
		{name = "Bobber", wtype = 6, mod = 9, price = 1000},
		{name = "Solidus", wtype = 6, mod = 10, price = 1000},
		{name = "Iceshield", wtype = 6, mod = 11, price = 1000},
		{name = "Loops", wtype = 6, mod = 12, price = 1000},
	},

----Back wheel (Bikes)-----
	backwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 1000},
		{name = "Speedway", wtype = 6, mod = 0, price = 1000},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 1000},
		{name = "Racer", wtype = 6, mod = 2, price = 1000},
		{name = "Trackstar", wtype = 6, mod = 3, price = 1000},
		{name = "Overlord", wtype = 6, mod = 4, price = 1000},
		{name = "Trident", wtype = 6, mod = 5, price = 1000},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 1000},
		{name = "Stilleto", wtype = 6, mod = 7, price = 1000},
		{name = "Wires", wtype = 6, mod = 8, price = 1000},
		{name = "Bobber", wtype = 6, mod = 9, price = 1000},
		{name = "Solidus", wtype = 6, mod = 10, price = 1000},
		{name = "Iceshield", wtype = 6, mod = 11, price = 1000},
		{name = "Loops", wtype = 6, mod = 12, price = 1000},
	},

----Sport wheels-----
	sportwheels = {
		{name = "Stock", wtype = 0, mod = -1, price = 1000},
		{name = "Inferno", wtype = 0, mod = 0, price = 1000},
		{name = "Deepfive", wtype = 0, mod = 1, price = 1000},
		{name = "Lozspeed", wtype = 0, mod = 2, price = 1000},
		{name = "Diamondcut", wtype = 0, mod = 3, price = 1000},
		{name = "Chrono", wtype = 0, mod = 4, price = 1000},
		{name = "Feroccirr", wtype = 0, mod = 5, price = 1000},
		{name = "Fiftynine", wtype = 0, mod = 6, price = 1000},
		{name = "Mercie", wtype = 0, mod = 7, price = 1000},
		{name = "Syntheticz", wtype = 0, mod = 8, price = 1000},
		{name = "Organictyped", wtype = 0, mod = 9, price = 1000},
		{name = "Endov1", wtype = 0, mod = 10, price = 1000},
		{name = "Duper7", wtype = 0, mod = 11, price = 1000},
		{name = "Uzer", wtype = 0, mod = 12, price = 1000},
		{name = "Groundride", wtype = 0, mod = 13, price = 1000},
		{name = "Spacer", wtype = 0, mod = 14, price = 1000},
		{name = "Venum", wtype = 0, mod = 15, price = 1000},
		{name = "Cosmo", wtype = 0, mod = 16, price = 1000},
		{name = "Dashvip", wtype = 0, mod = 17, price = 1000},
		{name = "Icekid", wtype = 0, mod = 18, price = 1000},
		{name = "Ruffeld", wtype = 0, mod = 19, price = 1000},
		{name = "Wangenmaster", wtype = 0, mod = 20, price = 1000},
		{name = "Superfive", wtype = 0, mod = 21, price = 1000},
		{name = "Endov2", wtype = 0, mod = 22, price = 1000},
		{name = "Slitsix", wtype = 0, mod = 23, price = 1000},
	},
-----Suv wheels------
	suvwheels = {
		{name = "Stock", wtype = 3, mod = -1, price = 1000},
		{name = "Vip", wtype = 3, mod = 0, price = 1000},
		{name = "Benefactor", wtype = 3, mod = 1, price = 1000},
		{name = "Cosmo", wtype = 3, mod = 2, price = 1000},
		{name = "Bippu", wtype = 3, mod = 3, price = 1000},
		{name = "Royalsix", wtype = 3, mod = 4, price = 1000},
		{name = "Fagorme", wtype = 3, mod = 5, price = 1000},
		{name = "Deluxe", wtype = 3, mod = 6, price = 1000},
		{name = "Icedout", wtype = 3, mod = 7, price = 1000},
		{name = "Cognscenti", wtype = 3, mod = 8, price = 1000},
		{name = "Lozspeedten", wtype = 3, mod = 9, price = 1000},
		{name = "Supernova", wtype = 3, mod = 10, price = 1000},
		{name = "Obeyrs", wtype = 3, mod = 11, price = 1000},
		{name = "Lozspeedballer", wtype = 3, mod = 12, price = 1000},
		{name = "Extra vaganzo", wtype = 3, mod = 13, price = 1000},
		{name = "Splitsix", wtype = 3, mod = 14, price = 1000},
		{name = "Empowered", wtype = 3, mod = 15, price = 1000},
		{name = "Sunrise", wtype = 3, mod = 16, price = 1000},
		{name = "Dashvip", wtype = 3, mod = 17, price = 1000},
		{name = "Cutter", wtype = 3, mod = 18, price = 1000},
	},
-----Offroad wheels-----
	offroadwheels = {
		{name = "Stock", wtype = 4, mod = -1, price = 1000},
		{name = "Raider", wtype = 4, mod = 0, price = 1000},
		{name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 1000},
		{name = "Nevis", wtype = 4, mod = 2, price = 1000},
		{name = "Cairngorm", wtype = 4, mod = 3, price = 1000},
		{name = "Amazon", wtype = 4, mod = 4, price = 1000},
		{name = "Challenger", wtype = 4, mod = 5, price = 1000},
		{name = "Dunebasher", wtype = 4, mod = 6, price = 1000},
		{name = "Fivestar", wtype = 4, mod = 7, price = 1000},
		{name = "Rockcrawler", wtype = 4, mod = 8, price = 1000},
		{name = "Milspecsteelie", wtype = 4, mod = 9, price = 1000},
	},
-----Tuner wheels------
	tunerwheels = {
		{name = "Stock", wtype = 5, mod = -1, price = 1000},
		{name = "Cosmo", wtype = 5, mod = 0, price = 1000},
		{name = "Supermesh", wtype = 5, mod = 1, price = 1000},
		{name = "Outsider", wtype = 5, mod = 2, price = 1000},
		{name = "Rollas", wtype = 5, mod = 3, price = 1000},
		{name = "Driffmeister", wtype = 5, mod = 4, price = 1000},
		{name = "Slicer", wtype = 5, mod = 5, price = 1000},
		{name = "Elquatro", wtype = 5, mod = 6, price = 1000},
		{name = "Dubbed", wtype = 5, mod = 7, price = 1000},
		{name = "Fivestar", wtype = 5, mod = 8, price = 1000},
		{name = "Slideways", wtype = 5, mod = 9, price = 1000},
		{name = "Apex", wtype = 5, mod = 10, price = 1000},
		{name = "Stancedeg", wtype = 5, mod = 11, price = 1000},
		{name = "Countersteer", wtype = 5, mod = 12, price = 1000},
		{name = "Endov1", wtype = 5, mod = 13, price = 1000},
		{name = "Endov2dish", wtype = 5, mod = 14, price = 1000},
		{name = "Guppez", wtype = 5, mod = 15, price = 1000},
		{name = "Chokadori", wtype = 5, mod = 16, price = 1000},
		{name = "Chicane", wtype = 5, mod = 17, price = 1000},
		{name = "Saisoku", wtype = 5, mod = 18, price = 1000},
		{name = "Dishedeight", wtype = 5, mod = 19, price = 1000},
		{name = "Fujiwara", wtype = 5, mod = 20, price = 1000},
		{name = "Zokusha", wtype = 5, mod = 21, price = 1000},
		{name = "Battlevill", wtype = 5, mod = 22, price = 1000},
		{name = "Rallymaster", wtype = 5, mod = 23, price = 1000},
	},
-----Highend wheels------
	highendwheels = {
		{name = "Stock", wtype = 7, mod = -1, price = 1000},
		{name = "Shadow", wtype = 7, mod = 0, price = 1000},
		{name = "Hyper", wtype = 7, mod = 1, price = 1000},
		{name = "Blade", wtype = 7, mod = 2, price = 1000},
		{name = "Kim cương", wtype = 7, mod = 3, price = 1000},
		{name = "Supagee", wtype = 7, mod = 4, price = 1000},
		{name = "Chromaticz", wtype = 7, mod = 5, price = 1000},
		{name = "Merciechlip", wtype = 7, mod = 6, price = 1000},
		{name = "Obeyrs", wtype = 7, mod = 7, price = 1000},
		{name = "Gtchrome", wtype = 7, mod = 8, price = 1000},
		{name = "Cheetahr", wtype = 7, mod = 9, price = 1000},
		{name = "Lửa", wtype = 7, mod = 10, price = 1000},
		{name = "Splitten", wtype = 7, mod = 11, price = 1000},
		{name = "Dashvip", wtype = 7, mod = 12, price = 1000},
		{name = "Lozspeedten", wtype = 7, mod = 13, price = 1000},
		{name = "Carboninferno", wtype = 7, mod = 14, price = 1000},
		{name = "Carbonshadow", wtype = 7, mod = 15, price = 1000},
		{name = "Carbonz", wtype = 7, mod = 16, price = 1000},
		{name = "Carbonsolar", wtype = 7, mod = 17, price = 1000},
		{name = "Carboncheetahr", wtype = 7, mod = 18, price = 1000},
		{name = "Carbonsracer", wtype = 7, mod = 19, price = 1000},
	},
-----Lowrider wheels------
	lowriderwheels = {
		{name = "Stock", wtype = 2, mod = -1, price = 1000},
		{name = "Flare", wtype = 2, mod = 0, price = 1000},
		{name = "Wired", wtype = 2, mod = 1, price = 1000},
		{name = "Triplegolds", wtype = 2, mod = 2, price = 1000},
		{name = "Bigworm", wtype = 2, mod = 3, price = 1000},
		{name = "Sevenfives", wtype = 2, mod = 4, price = 1000},
		{name = "Splitsix", wtype = 2, mod = 5, price = 1000},
		{name = "Freshmesh", wtype = 2, mod = 6, price = 1000},
		{name = "Leadsled", wtype = 2, mod = 7, price = 1000},
		{name = "Turbine", wtype = 2, mod = 8, price = 1000},
		{name = "Superfin", wtype = 2, mod = 9, price = 1000},
		{name = "Classicrod", wtype = 2, mod = 10, price = 1000},
		{name = "Dollar", wtype = 2, mod = 11, price = 1000},
		{name = "Dukes", wtype = 2, mod = 12, price = 1000},
		{name = "Lowfive", wtype = 2, mod = 13, price = 1000},
		{name = "Gooch", wtype = 2, mod = 14, price = 1000},
	},
-----Muscle wheels-----
	musclewheels = {
		{name = "Stock", wtype = 1, mod = -1, price = 1000},
		{name = "Lốp cổ điển", wtype = 1, mod = 0, price = 1000},
		{name = "Dukes", wtype = 1, mod = 1, price = 1000},
		{name = "Musclefreak", wtype = 1, mod = 2, price = 1000},
		{name = "Kracka", wtype = 1, mod = 3, price = 1000},
		{name = "Azrea", wtype = 1, mod = 4, price = 1000},
		{name = "Mecha", wtype = 1, mod = 5, price = 1000},
		{name = "Blacktop", wtype = 1, mod = 6, price = 1000},
		{name = "Dragspl", wtype = 1, mod = 7, price = 1000},
		{name = "Revolver", wtype = 1, mod = 8, price = 1000},
		{name = "Classicrod", wtype = 1, mod = 9, price = 1000},
		{name = "Spooner", wtype = 1, mod = 10, price = 1000},
		{name = "Ngôi sao năm cánh", wtype = 1, mod = 11, price = 1000},
		{name = "Oldschool", wtype = 1, mod = 12, price = 1000},
		{name = "Eljefe", wtype = 1, mod = 13, price = 1000},
		{name = "Dodman", wtype = 1, mod = 14, price = 1000},
		{name = "Sixgun", wtype = 1, mod = 15, price = 1000},
		{name = "Mercenary", wtype = 1, mod = 16, price = 1000},
	},
	
---------Trim color--------
	trim = {
		colors = colors,
		price = 1000
	},
	
----------Mods-----------
	mods = {
	
----------Liveries--------
	[48] = {
		startprice = 15000,
		increaseby = 2500
	},
	
----------Windows--------
	[46] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Tank--------
	[45] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Trim--------
	[44] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Aerials--------
	[43] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Arch cover--------
	[42] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Struts--------
	[41] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Air filter--------
	[40] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Engine block--------
	[39] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Hydraulics--------
	[38] = {
		startprice = 15000,
		increaseby = 2500
	},
	
----------Trunk--------
	[37] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Speakers--------
	[36] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Plaques--------
	[35] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Seats--------
	[32] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Door speaker--------
	[31] = {
		startprice = 5000,
		increaseby = 1250
	},

----------Dial--------
	[30] = {
		startprice = 5000,
		increaseby = 1250
	},
----------Dashboard--------
	[29] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Ornaments--------
	[28] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Trim--------
	[27] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 5000,
		increaseby = 1250
	},
	
----------Plate holder--------
	[25] = {
		startprice = 5000,
		increaseby = 1250
	},
	
---------Headlights---------
	[22] = {
		{name = "Stock Lights", mod = 0, price = 0},
		{name = "Xenon Lights", mod = 1, price = 1625},
	},
	
----------Turbo---------
	[18] = {
		{ name = "None", mod = 0, price = 0},
		{ name = "Turbo Tuning", mod = 1, price = 10000},
	},
	
-----------Armor-------------
	[16] = {
		{name = "Armor Upgrade 20%",modtype = 16, mod = 0, price = 10000},
		{name = "Armor Upgrade 40%",modtype = 16, mod = 1, price = 20000},
		{name = "Armor Upgrade 60%",modtype = 16, mod = 2, price = 30000},
		{name = "Armor Upgrade 80%",modtype = 16, mod = 3, price = 40000},
		{name = "Armor Upgrade 100%",modtype = 16, mod = 4, price = 60000},
	},

---------Suspension-----------
	[15] = {
		{name = "Lowered Suspension",mod = 0, price = 10000},
		{name = "Street Suspension",mod = 1, price = 20000},
		{name = "Sport Suspension",mod = 2, price = 30000},
		{name = "Competition Suspension",mod = 3, price = 50000},
	},

-----------Horn----------
	[14] = {
		{name = "Truck Horn", mod = 0, price = 1625},
		{name = "Police Horn", mod = 1, price = 4062},
		{name = "Clown Horn", mod = 2, price = 6500},
		{name = "Musical Horn 1", mod = 3, price = 11375},
		{name = "Musical Horn 2", mod = 4, price = 11375},
		{name = "Musical Horn 3", mod = 5, price = 11375},
		{name = "Musical Horn 4", mod = 6, price = 11375},
		{name = "Musical Horn 5", mod = 7, price = 11375},
		{name = "Sadtrombone Horn", mod = 8, price = 11375},
		{name = "Calssical Horn 1", mod = 9, price = 11375},
		{name = "Calssical Horn 2", mod = 10, price = 11375},
		{name = "Calssical Horn 3", mod = 11, price = 11375},
		{name = "Calssical Horn 4", mod = 12, price = 11375},
		{name = "Calssical Horn 5", mod = 13, price = 11375},
		{name = "Calssical Horn 6", mod = 14, price = 11375},
		{name = "Calssical Horn 7", mod = 15, price = 11375},
		{name = "Scaledo Horn", mod = 16, price = 11375},
		{name = "Scalere Horn", mod = 17, price = 11375},
		{name = "Scalemi Horn", mod = 18, price = 11375},
		{name = "Scalefa Horn", mod = 19, price = 11375},
		{name = "Scalesol Horn", mod = 20, price = 11375},
		{name = "Scalela Horn", mod = 21, price = 11375},
		{name = "Scaleti Horn", mod = 22, price = 11375},
		{name = "Scaledo Horn High", mod = 23, price = 11375},
		{name = "Jazz Horn 1", mod = 25, price = 11375},
		{name = "Jazz Horn 2", mod = 26, price = 11375},
		{name = "Jazz Horn 3", mod = 27, price = 11375},
		{name = "Jazzloop Horn", mod = 28, price = 11375},
		{name = "Starspangban Horn 1", mod = 29, price = 11375},
		{name = "Starspangban Horn 2", mod = 30, price = 11375},
		{name = "Starspangban Horn 3", mod = 31, price = 11375},
		{name = "Starspangban Horn 4", mod = 32, price = 11375},
		{name = "Classicalloop Horn 1", mod = 33, price = 11375},
		{name = "Classicalloop Horn 2", mod = 34, price = 11375},
		{name = "Classicalloop Horn 3", mod = 35, price = 11375},
	},

----------Transmission---------
	[13] = {
		{name = "Street Transmission", mod = 0, price = 5000},
		{name = "Sports Transmission", mod = 1, price = 10000},
		{name = "Race Transmission", mod = 2, price = 15000},
	},
	
-----------Brakes-------------
	[12] = {
		{name = "Street Brakes", mod = 0, price = 5000},
		{name = "Sport Brakes", mod = 1, price = 10000},
		{name = "Race Brakes", mod = 2, price = 15000},
	},
	
------------Engine----------
	[11] = {
		{name = "EMS Upgrade, Level 1", mod = 0, price = 10000},
		{name = "EMS Upgrade, Level 2", mod = 1, price = 20000},
		{name = "EMS Upgrade, Level 3", mod = 2, price = 30000},
		{name = "EMS Upgrade, Level 4", mod = 3, price = 50000},
	},
	
-------------Roof----------
	[10] = {
		startprice = 1250,
		increaseby = 400
	},
	
------------Fenders---------
	[8] = {
		startprice = 1500,
		increaseby = 400
	},
	
------------Hood----------
	[7] = {
		startprice = 1500,
		increaseby = 400
	},
	
----------Grille----------
	[6] = {
		startprice = 1250,
		increaseby = 400
	},
	
----------Roll cage----------
	[5] = {
		startprice = 1250,
		increaseby = 400
	},
	
----------Exhaust----------
	[4] = {
		startprice = 1000,
		increaseby = 400
	},
	
----------Skirts----------
	[3] = {
		startprice = 1250,
		increaseby = 400
	},
	
-----------Rear bumpers----------
	[2] = {
		startprice = 2500,
		increaseby = 500
	},
	
----------Front bumpers----------
	[1] = {
		startprice = 2500,
		increaseby = 500
	},
	
----------Spoiler----------
	[0] = {
		startprice = 2500,
		increaseby = 400
	},
	}
	
}


--Menu settings
LSC_Config.menu = {

-------Controls--------
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},

-------Menu position-----
	--Possible positions:
	--Left
	--Right
	--Custom position, example: position = {x = 0.2, y = 0.2}
	position = "right",

-------Menu theme--------
	--Possible themes: light, darkred, bluish, greenish
	--Custom example:
	--[[theme = {
		text_color = { r = 255,g = 255, b = 255, a = 255},
		bg_color = { r = 0,g = 0, b = 0, a = 155},
		--Colors when button is selected
		stext_color = { r = 0,g = 0, b = 0, a = 255},
		sbg_color = { r = 255,g = 255, b = 0, a = 200},
	},]]
	theme = "light",
	
--------Max buttons------
	--Default: 10
	maxbuttons = 10,

-------Size---------
	--[[
	Default:
	width = 0.24
	height = 0.36
	]]
	width = 0.24,
	height = 0.36

}
