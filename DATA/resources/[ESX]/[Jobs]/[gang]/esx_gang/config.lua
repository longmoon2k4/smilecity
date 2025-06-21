Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 21
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnableArmoryManagement     = false
Config.Locale                     = 'pl'

Config.LogLay = {
    ['gangtest'] = 'https://discord.com/api/webhooks/tatwebhooks/1160523260044247060/LAhHvlkgaDZP-pUaOgholwEnaA7h6e280am38YmXU6y6SkfoOeaK9CasJaYjjHEJvrxh'
}
Config.LogCat = {
    ['gangtest'] = 'https://discord.com/api/webhooks/tatwebhooks/1160523260044247060/LAhHvlkgaDZP-pUaOgholwEnaA7h6e280am38YmXU6y6SkfoOeaK9CasJaYjjHEJvrxh'
}
Config.Swap = {
    ['gangtest'] = 'https://discord.com/api/webhooks/tatwebhooks/1160523260044247060/LAhHvlkgaDZP-pUaOgholwEnaA7h6e280am38YmXU6y6SkfoOeaK9CasJaYjjHEJvrxh',
}

Config.Gangs = {
	
	gangma = {
		JobName = "gangma",
		Blip = {
		  Pos     = { x = 965.380249, y=-119.248352, z=74.353149},  
		  Sprite  = 484,
		  Display = 4,
		  Scale   = 1.0,
		  Colour  = 48,
		  Name = "Gang Magic",
		},		
		Cloakrooms = {
			--{x = 8.3064603805542, y = 528.15197753906, z = 170.63502502441}, 
		},
		Armories = { 
			{x = 965.380249, y=-119.248352, z=74.353149}, 
		},
	   Weight = 20000000,
	   gang = true,
	},

	gangdv = {
		JobName = "gangdv",
		Blip = {
		  Pos     = { x = -1366.668091, y=-144.224182, z=48.657104},  
		  Sprite  = 89,
		  Display = 4,
		  Scale   = 1.0,
		  Colour  = 0,
		  Name = "Crew Devil",
		},		
		Cloakrooms = {
			--{x = 8.3064603805542, y = 528.15197753906, z = 170.63502502441}, 
		},
		Armories = { 
			{ x = -1366.668091, y=-144.224182, z=48.657104}, 
		},
	   Weight = 10000000,
	   gang = false,
	},


}

Config.AuthorizedWeapons = {
	-- gang4 = {
    --   {  label = 'Súng Microsmg', weapon = 'weapon_microsmg', price = 30000000000 },
	-- },
	-- gang3 = {
    --   {  label = 'Súng Microsmg', weapon = 'weapon_microsmg', price = 30000000000 },
	-- },
	-- yhm = {
    --   {  label = 'Súng Microsmg', weapon = 'weapon_microsmg', price = 30000000000 },
	-- },
	-- gang2 = {
    --   {  label = 'Súng Microsmg', weapon = 'weapon_microsmg', price = 30000 },
	-- },
	-- g0612 = {
    --   {  label = 'Súng Microsmg', weapon = 'weapon_microsmg', price = 30000 },
	-- },
	-- gang1 = {
    --   {  label = 'Súng Microsmg', weapon = 'weapon_microsmg', price = 30000 },
	-- },
	-- gang5 = {
    --   {  label = 'Súng Microsmg', weapon = 'weapon_microsmg', price = 30000 },
	-- },
}

Config.Uniforms = {
	gang4 = {
		male = {
			['tshirt_1'] = 31,  ['tshirt_2'] = 2,
			['torso_1'] = 78,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 28,   ['pants_2'] = 8,
			['shoes_1'] = 10,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},
	gang3 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 66,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 19,
			['pants_1'] = 38,   ['pants_2'] = 0,
			['shoes_1'] = 66,   ['shoes_2'] = 6,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},
	draken = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 0,   ['pants_2'] = 0,
			['shoes_1'] = 1,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},
	gang2 = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},
	-- g0612 = {
	-- 	male = {
	-- 		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 55,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 41,
	-- 		['pants_1'] = 25,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0
	-- 	},
	-- 	female = {
	-- 		['tshirt_1'] = 35,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 48,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 44,
	-- 		['pants_1'] = 34,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 27,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0
	-- 	}
	-- },
	-- gang1 = {
	-- 	male = {
	-- 		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 55,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 41,
	-- 		['pants_1'] = 25,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0
	-- 	},
	-- 	female = {
	-- 		['tshirt_1'] = 35,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 48,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 44,
	-- 		['pants_1'] = 34,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 27,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0
	-- 	}
	-- },
	-- gang5 = {
	-- 	male = {
	-- 		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 55,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 41,
	-- 		['pants_1'] = 25,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0
	-- 	},
	-- 	female = {
	-- 		['tshirt_1'] = 35,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 48,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 44,
	-- 		['pants_1'] = 34,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 27,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0
	-- 	}
	-- },

}