Config = {}

Config.Locale = 'en'



Config.Marker = {

	r = 250, g = 0, b = 0, a = 100,  

	x = 1.0, y = 1.0, z = 1.5,  

	DrawDistance = 15.0, Type = 1   

}



Config.PoliceNumberRequired = 8

Config.TimerBeforeNewRob    = 3600



Config.MaxDistance    = 10

Config.GiveBlackMoney = true



Stores = {



	["tiemvang"] = {
		pos = vec3(-629.99, -236.542, 38.05),

		position = { x = -629.99, y=-236.542, z=38.05 },

		--reward = math.random(200000, 250000),
		reward = 100000,
		nameOfStore = "Tiệm vàng",

		secondsRemaining = 600, 

		lastRobbed = 0,

		team = {

			total = 0,

			members = {},

		},

	},



}

