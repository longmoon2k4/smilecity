Config = {

BlipSprite = 237,
BlipColor = 26,
BlipText = 'Workbench',

UseLimitSystem = false, -- Enable if your esx uses limit system

CraftingStopWithDistance = true, -- Crafting will stop when not near workbench

ExperiancePerCraft = 100, -- The amount of experiance added per craft (100 Experiance is 1 level)

HideWhenCantCraft = false, -- Instead of lowering the opacity it hides the item that is not craftable due to low level or wrong job

Categories = {

['item'] = {
	Label = 'Vật phẩm',
	Image = 'bitcoin',
	Jobs = {}
},
['weapons'] = {
	Label = 'Súng ống',
	Image = 'WEAPON_APPISTOL',
	Jobs = {}
},
},

MechCategories = {
['mechanic'] = {
	Label = 'MECHANICS',
	Image = 'advancedkit',
	Jobs = {}
}
},

GunCategories = {
['weapons'] = {
	Label = 'Súng ống',
	Image = 'WEAPON_APPISTOL',
	Jobs = {}
},
['attachments'] = {
	Label = 'ATTACHMENTS',
	Image = 'smg_scope',
	Jobs = {}
}
},


PermanentItems = { -- Items that dont get removed when crafting
	['wrench'] = true
},

Recipes = { -- Enter Item name and then the speed value! The higher the value the more torque

['WEAPON_ASSAULTRIFLE'] = {
	ItemName = 'AKM',
	Level = 0, -- From what level this item will be craftable
	Category = 'weapons', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, -- 100% you will recieve the item
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 10, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['bluesky'] = {count = 3, label="Blue Sky"}, -- item name and count, adding items that dont exist in database will crash the script
		['vaicaocap'] = {count = 3, label="Vải cao cấp"},
		['thuocsung'] = {count = 2, label="Thuốc súng"},
		['gocaocap'] = {count = 3, label="Gỗ cao cấp"},
		['thansungar'] = {count = 2, label="Thân súng AR"}, 
		['banthietkear'] = {count = 1, label="Bản thiết kế AR"}, 
	}
}, 

['WEAPON_COMPACTRIFLE'] = {
	ItemName = 'AK-cụt',
	Level = 0, 
	Category = 'weapons',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {},
	Amount = 1,
	SuccessRate = 100,
	requireBlueprint = false,
	Time = 10,
	Ingredients = {
		['thansungar'] = {count = 1, label="Thân súng AR"}, 
		['diamond'] = {count = 3, label="Kim cương"},
		['thuocsung'] = {count = 1, label="Thuốc súng"},
		['gocaocap'] = {count = 3, label="Gỗ cao cấp"},
		
	}
}, 

['WEAPON_KATANA'] = {
	ItemName = 'kATANA',
	Level = 0, 
	Category = 'weapons',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {},
	Amount = 1,
	SuccessRate = 100,
	requireBlueprint = false,
	Time = 10,
	Ingredients = {
		['badge1'] = {count = 3, label="Coin 1"}, 
		['diamond'] = {count = 3, label="Kim cương"},
	}
}, 

['WEAPON_BULLPUPRIFLE'] = {
	ItemName = 'Bullbup Rifle',
	Level = 0, 
	Category = 'weapons',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {},
	Amount = 1,
	SuccessRate = 100,
	requireBlueprint = false,
	Time = 10,
	Ingredients = {
		['thansungar'] = {count = 10, label="Thân súng AR"}, 
		['badge2'] = {count = 2, label="Coin 2"},
		['meth1g'] = {count = 20, label="Thảo dược"},
		['WEAPON_ASSAULTRIFLE'] = {count = 1, label="AKM"},
		
	}
}, 

['WEAPON_M4A4'] = {
	ItemName = 'M4A4',
	Level = 0, 
	Category = 'weapons',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {},
	Amount = 1,
	SuccessRate = 100,
	requireBlueprint = false,
	Time = 10,
	Ingredients = {
		['badge3'] = {count = 2, label="Coin 3"}, 
		['banthietkem4'] = {count = 1, label="Bản thiết kế m4a4"},
		['black_money'] = {count = 1500000, label="Tiền bẩn"},
		['WEAPON_BULLPUPRIFLE'] = {count = 1, label="Bullbup Rifle"},
		
	}
}, 

['WEAPON_ASSAULTSHOTGUN'] = {
	ItemName = 'Sóc lọ liên tục',
	Level = 0, 
	Category = 'weapons',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {},
	Amount = 1,
	SuccessRate = 100,
	requireBlueprint = false,
	Time = 10,
	Ingredients = {
		['badge3'] = {count = 1, label="Coin 3"}, 
		['black_money'] = {count = 2000000, label="Tiền bẩn"},
		['thanduoc'] = {count = 20, label="Thần dược"},
		['bluesky'] = {count = 10, label="Blue Sky"},
	}
}, 

-- ['bansungar'] = {
-- 	ItemName = 'Bán súng AR',
-- 	Level = 0, -- From what level this item will be craftable
-- 	Category = 'item', -- The category item will be put in
-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
-- 	Amount = 1, -- The amount that will be crafted
-- 	SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
-- 	Time = 5, -- Time in seconds it takes to craft this item
-- 	Ingredients = { -- Ingredients needed to craft this item
-- 		['loxo'] = {count = 5, label="Lo xo"}, -- item name and count, adding items that dont exist in database will crash the script
-- 		['copper'] = {count = 20, label="Đồng"},
-- 		['petrol_raffin'] = {count = 20, label="Dầu đã xử lý"},
-- 	}
-- },
-- ['homgiangsinh'] = {
-- 	ItemName = 'Hòm giáng sinh',
-- 	Level = 0, 
-- 	Category = 'item', 
-- 	isGun = false, 
-- 	Jobs = {}, 
-- 	JobGrades = {}, 
-- 	Amount = 1, 
-- 	SuccessRate = 100,
-- 	requireBlueprint = false, 
-- 	Time = 5, 
-- 	Ingredients = { 
-- 		['cainit'] = {count = 2, label="Cai nit"},
-- 		['quachau'] = {count = 2, label="Quả châu"},
-- 		['ngoisao'] = {count = 5, label="Ngôi sao"},
-- 		['gonoel'] = {count = 10, label="Gỗ Thông"},
-- 	}
-- },

-- ['quachau'] = {
-- 	ItemName = 'Quả châu',
-- 	Level = 0, 
-- 	Category = 'item', 
-- 	isGun = false, 
-- 	Jobs = {}, 
-- 	JobGrades = {}, 
-- 	Amount = 1, 
-- 	SuccessRate = 100,
-- 	requireBlueprint = false, 
-- 	Time = 5, 
-- 	Ingredients = { 
-- 		['gocaocap'] = {count = 1, label="Gỗ cao cấp"},
-- 		['gacaocap'] = {count = 1, label="KFC"},
-- 	}
-- },

['medlangbam'] = {
	ItemName = 'Lang băm',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['bandage'] = {count = 5, label="Bandage"},
		['fabric'] = {count = 10, label="Vải"},
		['cannabis'] = {count = 10, label="Cần sa"},
		['coca_leaf'] = {count = 10, label="Lá cocain"},
	}
},
['badge1'] = {
	ItemName = 'Coin 1',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['hopkim'] = {count = 1, label="Hợp kim"},
		['gocaocap'] = {count = 5, label="Gỗ cao cấp"},
		['vaicaocap'] = {count = 5, label="Vải cao cấp"},
		['daucaocap'] = {count = 5, label="Xăng 95"},
		['gacaocap'] = {count = 5, label="KFC"},
		['bluesky'] = {count = 2, label="Blue sky"},
	}
},

['badge2'] = {
	ItemName = 'Coin 2',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['badge1'] = {count = 5, label="Coin 1"},
		['black_money'] = {count = 200000, label="Tiền bẩn"},
		['diamond'] = {count = 5, label="Kim cương"},
		['bluesky'] = {count = 1, label="Blue sky"},
	}
},

['badge3'] = {
	ItemName = 'Coin 3',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['badge2'] = {count = 5, label="Coin 2"},
		['black_money'] = {count = 200000, label="Tiền bẩn"},
		['thanduoc'] = {count = 2, label="Thần dược"},
	}
},

['thanduoc'] = {
	ItemName = 'Thần dược',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5,   
	Ingredients = { 
		['meth1g'] = {count = 10, label="Thảo dược"},
		['coca_leaf'] = {count = 5, label="Lá Cocain"},
		['cannabis'] = {count = 5, label="Lá cần sa"},
	}
},

['banthietkem4'] = {
	ItemName = 'Bản thiết kế m4a4',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5,   
	Ingredients = { 
		['thanduoc'] = {count = 20, label="Thần dược"},
		['jewels'] = {count = 50, label="Trang sức"},
		['badge2'] = {count = 2, label="Coin 2"},
	}
},

['balo'] = {
	ItemName = 'Balo',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['badge2'] = {count = 3, label="Coin 2"},
		-- ['garbage'] = {count = 50, label="Rác thải"},
	}
},

['hopkim'] = {
	ItemName = 'Hợp kim',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['copper'] = {count = 100, label="Đồng"},
		['iron'] = {count = 75, label="Sắt"},
		['gold'] = {count = 50, label="Vàng"},
	}
},

['gocaocap'] = {
	ItemName = 'Gỗ cao cấp',
	Level = 0, 
	Category = 'item', 
	isGun = false,
	Jobs = {}, 
	JobGrades = {},
	Amount = 1, 
	SuccessRate = 100, 
	requireBlueprint = false, 
	Time = 5,
	Ingredients = { 
		['packaged_plank'] = {count = 20, label="Gỗ bước 3"}, 
	}
},

['vaicaocap'] = {
	ItemName = 'Vải cao cấp',
	Level = 0,
	Category = 'item',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1,
	SuccessRate = 100, 
	requireBlueprint = false, 
		Time = 5, 
	Ingredients = { 
		['clothe'] = {count = 20, label="Quần áo"}, 
	}
},

['daucaocap'] = {
	ItemName = 'Xăng 95',
	Level = 0,
	Category = 'item',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1,
	SuccessRate = 100, 
	requireBlueprint = false, 
		Time = 5, 
	Ingredients = { 
		['essence'] = {count = 20, label="Xăng"}, 
	}
},

['gacaocap'] = {
	ItemName = 'KFC',
	Level = 0,
	Category = 'item',
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1,
	SuccessRate = 100, 
	requireBlueprint = false, 
		Time = 5, 
	Ingredients = { 
		['packaged_chicken'] = {count = 20, label="Gà Đóng Gói"}, 
	}
},

['bluesky'] = {
	ItemName = 'Blue Sky',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['marijuana'] = {count = 10, label="Lọ Cần Sa"},
		['heroin'] = {count = 10, label="Heroin"},
		['coke1g'] = {count = 10, label="Hộp Coke"},
	}
},

['bosuasung'] = {
	ItemName = 'Bộ sửa súng',
	Level = 0, 
	Category = 'item', 
	isGun = false, 
	Jobs = {}, 
	JobGrades = {}, 
	Amount = 1, 
	SuccessRate = 100,
	requireBlueprint = false, 
	Time = 5, 
	Ingredients = { 
		['copper'] = {count = 40, label="Đồng"},
		['iron'] = {count = 20, label="Sắt"},
		['gold'] = {count = 10, label="Vàng"},
	}
},


['banthietkear'] = {
	ItemName = 'Bản thiết kế AR',
	Level = 0, -- From what level this item will be craftable
	Category = 'item', -- The category item will be put in
	isGun = false, -- Specify if this is a gun so it will be added to the loadout
	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
	Amount = 1, -- The amount that will be crafted
	SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
	Time = 5, -- Time in seconds it takes to craft this item
	Ingredients = { -- Ingredients needed to craft this item
		['money'] = {count = 100000, label="Tiền sạch"}, -- item name and count, adding items that dont exist in database will crash the script
		['black_money'] = {count = 100000, label="Tiền bẩn"},
	}
},

-- ['thansungar'] = {
-- 	ItemName = 'Thân súng AR',
-- 	Level = 0, -- From what level this item will be craftable
-- 	Category = 'item', -- The category item will be put in
-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
-- 	Amount = 1, -- The amount that will be crafted
-- 	SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
-- 	Time = 5, -- Time in seconds it takes to craft this item
-- 	Ingredients = { -- Ingredients needed to craft this item
-- 		['diamond'] = {count = 2, label="Kim cương"}, -- item name and count, adding items that dont exist in database will crash the script
-- 		['ruby'] = {count = 1, label="Ruby"},
-- 		['saphia'] = {count = 2, label="Saphia"},
-- 		['emerald'] = {count = 1, label="Emerald"},
-- 	}
-- },

-- ['nongsungar'] = {
-- 	ItemName = 'Nòng súng AR',
-- 	Level = 0, -- From what level this item will be craftable
-- 	Category = 'item', -- The category item will be put in
-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
-- 	Amount = 1, -- The amount that will be crafted
-- 	SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
-- 	Time = 5, -- Time in seconds it takes to craft this item
-- 	Ingredients = { -- Ingredients needed to craft this item
-- 		['loxo'] = {count = 2, label="Lò xo"}, -- item name and count, adding items that dont exist in database will crash the script
-- 		['petrol_raffin'] = {count = 10, label="Dầu đã xử lý"},
-- 		['diamond'] = {count = 2, label="Kim cương"},
-- 		['ruby'] = {count = 1, label="Ruby"},
-- 	}
-- },


-- ['medlangbam'] = {
-- 	ItemName = 'lang Bam',
-- 	Level = 0, -- From what level this item will be craftable
-- 	Category = 'item', -- The category item will be put in
-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
-- 	Amount = 1, -- The amount that will be crafted
-- 	SuccessRate = 100, -- 90% That the craft will succeed! If it does not you will lose your ingredients
-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
-- 	Time = 5, -- Time in seconds it takes to craft this item
-- 	Ingredients = { -- Ingredients needed to craft this item
-- 		['cannabis'] = {count = 2, label="Cần Sa"}, -- item name and count, adding items that dont exist in database will crash the script
-- 		['heroin'] = {count = 1, label="Heroin"},
-- 		['bandage'] = {count = 5, label="Bandage"},
-- 		['fabric'] = {count = 2, label="Vải"},
-- 	}

-- -- // ATTACHMENTS Craft stuff


-- ['weapon_pistol'] = {
-- 	ItemName = 'Colt 1911',
-- 	Level = 0, -- From what level this item will be craftable
-- 	Category = 'weapons', -- The category item will be put in
-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
-- 	Amount = 1, -- The amount that will be crafted
-- 	SuccessRate = 100, --  100% you will recieve the item
-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
-- 	Time = 20, -- Time in seconds it takes to craft this item
-- 	Ingredients = { -- Ingredients needed to craft this item
-- 	['clothe'] = {count = 1, label="quần áo"}, -- item name and count, adding items that dont exist in database will crash the script
-- 	['wood'] = {count = 1, label="gỗ"},
	
-- 	}
-- },
-- ['weapon_revolver_mk2'] = {
-- 	ItemName = 'Revolver MK2',
-- 	Level = 3, -- From what level this item will be craftable
-- 	Category = 'weapons', -- The category item will be put in
-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
-- 	Amount = 1, -- The amount that will be crafted
-- 	SuccessRate = 100, --  100% you will recieve the item
-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
-- 	Time = 20, -- Time in seconds it takes to craft this item
-- 	Ingredients = { -- Ingredients needed to craft this item
-- 		['clothe'] = {count = 1, label="quần áo"}, -- item name and count, adding items that dont exist in database will crash the script
-- 		['iron'] = {count = 1, label="sắt"},
	
-- 	}
-- },
-- ['weapon_microsmg'] = {
-- 	ItemName = 'Micro SMG',
-- 	Level = 3, -- From what level this item will be craftable
-- 	Category = 'weapons', -- The category item will be put in
-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
-- 	Amount = 1, -- The amount that will be crafted
-- 	SuccessRate = 100, --  100% you will recieve the item
-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
-- 	Time = 20, -- Time in seconds it takes to craft this item
-- 	Ingredients = { -- Ingredients needed to craft this item
-- 		['clothe'] = {count = 1, label="quần áo"}, -- item name and count, adding items that dont exist in database will crash the script
-- 		['iron'] = {count = 1, label="sắt"},
	
-- 	}
-- },



},
Workbenches = { -- Every workbench location, leave {} for jobs if you want everybody to access
		
		{coords = vector3(-196.3735,-1318.485,32.08951), jobs = 'mechanic', Categories = 'MechCategories', blip = false, recipes = {}, radius = 3.0 },       					--bennys 1 
		{coords = vector3(101.26113891602,6615.810546875,33.58126831054), jobs = 'mechanic', Categories = 'MechCategories', blip = false, recipes = {}, radius = 3.0 },      	--North LS customs
		{coords = vector3(93.52, 3754.21, 41.57), jobs = {}, Categories = 'GunCategories', blip = false, recipes = {}, radius = 3.0 }, --Gun crafting 1 
		{coords = vector3(164.9575,-1323.114,26.81208), jobs = {}, Categories = 'GunCategories', blip = false, recipes = {}, radius = 3.0} --Gun crafting 2 

},
 

Text = {

    ['not_enough_ingredients'] = 'Bạn không có đủ nguyên liệu',
    ['you_cant_hold_item'] = 'Bạn không thể giữ vật phẩm',
    ['item_crafted'] = 'Chế tạo thành cong!',
    ['wrong_job'] = 'Bạn không thể mở bàn làm việc này',
    ['workbench_hologram'] = '[~b~E~w~] Bàn làm việc',
    ['wrong_usage'] = 'Sử dụng lệnh sai',
    ['inv_limit_exceed'] = 'Đã vượt quá giới hạn kho đồ! Dọn dẹp trước khi bạn mất nhiều hơn',
    ['crafting_failed'] = 'Hụt con mẹ nó rồi!'

}

}



function SendTextMessage(msg)

        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)

        --EXAMPLE USED IN VIDEO
        --exports['mythic_notify']:SendAlert('inform', msg)

end
