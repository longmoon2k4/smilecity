Config = {}
Config.DropLocation = {						--Tọa độ drop
	vector3(-6.45, 742.85, 201.85),
}

Config.ThoiGianDrop = 15*60*1000 
--Config.ThoiGianDrop = 2*60*60*1000 -- Thời gian mỗi lần drop ( 3 tiếng)
Config.ThoiGianBienMat = 10*60*1000	-- Thời gian biến mất (5 phút)
-- Config.PhanThuong = {
-- 	tien = math.random(4000, 5000),
-- 	sung = {
-- 		'WEAPON_KNIFE',
-- 	},
-- 	item = {
-- 		'water',
-- 		'fixkit',
-- 		'bread'
		
-- 	},ChucBanMayMan = 'Chúc bạn may mắn lần sau',
-- }	

Config.PhanThuong ={
	items = {
        {name = "water", count = 5, percent = 20, type="money"},
		{name = "bread", count = 5, percent = 20, type="money"},
        {name = "badge1", count = 1, percent = 5, type ="item"},
        {name = "bosuasung", count = 2, percent = 10, type ="item"},
		{name = "hopkim", count = 1, percent = 20, type ="item"},
        {name = "vaicaocap", count = 2, percent = 20, type ="item"},
		{name = "gocaocap", count = 2, percent = 20, type ="item"},
		{name = "daucaocap", count = 2, percent = 20, type ="item"},
		{name = "gacaocap", count = 2, percent = 20, type ="item"},
		{name = "banthietkear", count = 1, percent = 5, type ="item"},
	}
}
	