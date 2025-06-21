Config = {}

-- Config.Zone = {
-- 	Pos = {
-- 		x = 2961.83,
-- 		y = 2790.36,
-- 		z = 40.3
-- 	},
-- 	Blips = {
-- 		Id = 318,
-- 		Color = 5,
-- 		Size = 1.0,
-- 		Text = "Mỏ Đá"
-- 	}
-- }

-- Config.Zones = {
-- 	process = {
-- 		coords = vector3(2941.508, 2802.192, 42.11399)
-- 	}
-- }

Config.ItemBonus = {
	{
		ItemName = "lsrp_gold",
		ItemCount = 2,
		Percent = 4
	},
	{
		ItemName = "lsrp_steel",
		ItemCount = 2,
		Percent = 5
	},
	{
		ItemName = "lsrp_copper",
		ItemCount = 2,
		Percent = 5
	},
	{
		ItemName = "lsrp_diamond",
		ItemCount = 1,
		Percent = 2
	}
}

Config.ItemCount = {1, 3}
Config.ItemName = "lsrp_stone" -- ไอเทมที่ดรอป
Config.deleteobject = 1 -- % = 1 = 100%, 2 = 50%, 3 = 33%, 4 = 25%, 5 = 20%


Config.object = 'prop_rock_1_i' -- ออฟเจ็คบนพื้น

-- ท่าทาง ตอนเก็บ
Config.RequestAnimDict = 'melee@large_wpn@streamed_core' -- ประเภท
Config.TaskPlayAnim = 'ground_attack_on_spot' -- จำพวก

-- ท่าทางตอนถือพร๊อพ
Config.RequestAnimDict2 = 'missfinale_c2mcs_1' -- ประเภท
Config.TaskPlayAnim2 = 'fin_c2_mcs_1_camman' -- จำพวก

-- ท่าทางตอนถือพร๊อพ
Config.RequestAnimDictLSRP = 'mini@repair' -- ประเภท
Config.TaskPlayAnimLSRP = 'fixing_a_ped' -- จำพวก

Config.WashingX = -1533.13
Config.WashingY = 4348.25
Config.WashingZ = 0.76

Config.RemeltingX = 1109.03
Config.RemeltingY = -2007.61
Config.RemeltingZ = 30.94

Config.SellX = -588.48
Config.SellY = -135.6
Config.SellZ = 38.91

Config.DiamondPrice = 10000  -- 1 kim cương
Config.GoldPrice = 1500  -- 1 vàng
Config.IronPrice = 600  -- 1 sắt
Config.CopperPrice = 200  -- 1 Đồng
Config.time1 = 7000
Config.time2 = 5000
Config.time3 = 4000
Config.vip = {
    -- 'steam:11000013e621c8b',
}

Config.Zones = {
    Tabacchi = {
      Items = {},
        Pos = {
        --{nome = "[~y~Thợ Mộc~s~] Nơi làm việc", x = -552.3,   y = 5348.43,  z = 74.74},  
        --[[ {nome = 'Phương tiện', x = 1194.62,  y = -1286.95,  z = 34.12},
        {nome = 'bãi đậu xe', x = 1216.89,  y = -1229.23,  z = 34.40},  ]]
        {nome = "[~y~Thợ Mỏ~s~] Đá", x = 2954.24,  y = 2818.71,  z = 42.42}, 
        {nome = "[~y~Thợ Mỏ~s~] Rửa đá", x = 1902.3,  y = 386.2,  z = 161.77}, 
        {nome = "[~y~Thợ Mỏ~s~] Nung đá", x = 1109.03,  y = -2007.61,  z = 30.94}
 --       {nome = 'Bán Gỗ', x = -625.24780273438, y = -131.76351928711, z = 39.008560180664} 
        }
      }
  }
