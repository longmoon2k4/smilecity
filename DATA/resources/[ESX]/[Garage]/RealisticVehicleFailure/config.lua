------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--


-- Configuration:

-- QUAN TRỌNG: Một số giá trị này PHẢI được đặt thành số dấu phẩy động. tức là 10,0 thay vì 10

cfg = {
	deformationMultiplier = -1,					-- Xe nên biến dạng trực quan bao nhiêu từ một vụ va chạm? Phạm vi từ 0,0 đến 10,0 Trong đó 0,0 không biến dạng và 10,0 là biến dạng 10 lần. -1 = không chạm vào. Thiệt hại trực quan không đồng bộ hóa tốt với người chơi khác.
	deformationExponent = 1.0,					-- Bao nhiêu cài đặt biến dạng tệp thao tác nên được nén về 1.0. (Làm nhiều xe tương tự). Giá trị 1 = không thay đổi. Giá trị thấp hơn sẽ nén nhiều hơn, giá trị trên 1 sẽ mở rộng. Không được đặt thành không hoặc âm.
	collisionDamageExponent = 1.0,				-- Bao nhiêu cài đặt biến dạng tệp thao tác nên được nén về 1.0. (Làm nhiều xe tương tự). Giá trị 1 = không thay đổi. Giá trị thấp hơn sẽ nén nhiều hơn, giá trị trên 1 sẽ mở rộng. Không được đặt thành không hoặc âm.

	damageFactorEngine = 10.0,					-- Giá trị là từ 1 đến 100. Giá trị cao hơn có nghĩa là thiệt hại xe nhiều hơn. Điểm khởi đầu tốt là 10
	damageFactorBody = 10.0,					    -- Giá trị là từ 1 đến 100. Giá trị cao hơn có nghĩa là thiệt hại xe nhiều hơn. Điểm khởi đầu tốt là 10
	damageFactorPetrolTank = 1.0,				-- Giá trị là từ 1 đến 200. Giá trị cao hơn có nghĩa là thiệt hại nhiều hơn cho chiếc xe. Điểm khởi đầu tốt là 64.
	engineDamageExponent = 0.7,					-- Bao nhiêu cài đặt thiệt hại công cụ thao tác tập tin nên được nén về 1.0. (Làm nhiều xe tương tự). Giá trị 1 = không thay đổi. Giá trị thấp hơn sẽ nén nhiều hơn, giá trị trên 1 sẽ mở rộng. Không được đặt thành không hoặc âm.
	weaponsDamageMultiplier = 0.05,	 			-- Xe phải chịu bao nhiêu thiệt hại từ tiếng súng. Phạm vi từ 0,0 đến 10,0, trong đó 0,0 không có sát thương và 10,0 là 10 lần sát thương. -1 = không chạm
	degradingHealthSpeedFactor = 0,			-- Tốc độ xuống cấp chậm của sức khỏe, nhưng không thất bại. Giá trị là 10 có nghĩa là sẽ mất khoảng 0,25 giây cho mỗi điểm toàn vẹn, do đó, việc xuống cấp từ 800 đến 305 sẽ mất khoảng 2 phút lái xe sạch. Giá trị cao hơn có nghĩa là xuống cấp nhanh hơn.
	cascadingFailureSpeedFactor = 8.0,			-- Giá trị là từ 1 đến 100. Khi sức khỏe của xe giảm xuống dưới một điểm nhất định, sự cố tầng thác sẽ xảy ra và sức khỏe giảm xuống nhanh chóng cho đến khi chiếc xe chết. Giá trị cao hơn có nghĩa là thất bại nhanh hơn. Điểm khởi đầu tốt là 8

	degradingFailureThreshold = 300.0,			-- Dưới đây, suy thoái sức khỏe chậm sẽ được
	cascadingFailureThreshold = 160.0,			-- Dưới giá trị này, lỗi tầng toàn vẹn sẽ được đặt thành
	engineSafeGuard = 100.0,					-- Giá trị cuối cùng của lỗi Đặt nó quá cao và xe sẽ không hút thuốc khi bị vô hiệu hóa. Đặt nó quá thấp và chiếc xe sẽ bắt lửa từ một viên đạn vào động cơ. Ở mức 100 máu, một chiếc xe thông thường có thể lấy 3-4 viên đạn vào động cơ trước khi bắt lửa.

	torqueMultiplierEnabled = true,				-- Giảm mô-men xoắn động cơ khi động cơ ngày càng bị hư hỏng

	limpMode = false,							-- Nếu đúng, động cơ không bao giờ bị hỏng hoàn toàn, vì vậy bạn sẽ luôn có thể tiếp cận với thợ máy trừ khi bạn quay xe lại và ngăn XeFlip không được đặt thành đúng.
	limpModeMultiplier = 0.15,					-- Hệ số mô-men xoắn để sử dụng khi xe đi khập khiễng. Giá trị từ 0,05 đến 0,25

	preventVehicleFlip = false,					-- Nếu true, bạn không thể lật xe

	sundayDriver = true,						-- Nếu đúng, phản ứng bướm ga có kích thước để cho phép lái xe chậm và dễ dàng. Nó sẽ không ngăn chặn toàn bộ ga. Không hoạt động với máy gia tốc nhị phân như bàn phím. Đặt thành false để tắt. Dừng lại mà không đảo ngược và giữ đèn phanh cũng hoạt động cho bàn phím.
	sundayDriverAcceleratorCurve = 7.5,			-- Đường cong phản ứng để áp dụng cho máy gia tốc. Phạm vi từ 0,0 đến 10,0. Giá trị cao hơn tạo điều kiện cho việc lái xe chậm hơn, có nghĩa là cần nhiều áp suất bướm ga hơn để tăng tốc. Không có gì cho trình điều khiển bàn phím
	sundayDriverBrakeCurve = 5.0,				-- Đường cong phản ứng để áp dụng cho phanh. Phạm vi từ 0,0 đến 10,0. Giá trị cao hơn cho phép phanh dễ dàng hơn, có nghĩa là cần nhiều áp lực bướm ga hơn để phanh cứng. Không có gì cho trình điều khiển bàn phím

	displayBlips = true,						-- Hiển thị blips cho các vị trí cơ khí

	compatibilityMode = false,					-- ngăn các tập lệnh khác sửa đổi tính toàn vẹn của bình nhiên liệu để tránh hỏng động cơ ngẫu nhiên với BVA 2.01 (nhược điểm là phòng chống nổ)

	randomTireBurstInterval = 0,				-- Số phút (theo thống kê, không chính xác) để lái xe trên 22 dặm / giờ trước khi nhận được một lốp xe phẳng. 0 = tính năng bị vô hiệu hóa


	-- Lớp nhân Damagefator
	-- Hệ số thiệt hại của động cơ, thân xe và Xăng dầu sẽ được nhân với giá trị này, tùy thuộc vào loại xe.
	-- Sử dụng nó để tăng hoặc giảm thiệt hại của mỗi lớp.

	classDamageMultiplier = {
		[0] = 	0.2,		--	0: Compacts
				0.2,		--	1: Sedans
				0.2,		--	2: SUVs
				0.2,		--	3: Coupes
				0.2,		--	4: Muscle
				0.2,		--	5: Sports Classics
				0.2,		--	6: Sports
				0.2,		--	7: Super
				0.1,		--	8: Motorcycles
				0.05,		--	9: Off-road
				0.1,		--	10: Industrial
				0.2,		--	11: Utility
				0.2,		--	12: Vans
				0.2,		--	13: Cycles
				0.1,		--	14: Boats
				0.2,		--	15: Helicopters
				0.2,		--	16: Planes
				0.2,		--	17: Service
				0.15,		--	18: Emergency
				0.15,		--	19: Military
				0.2,		--	20: Commercial
				0.2			--	21: Trains
	}
}



--[[

	-- Alternate configuration values provided by ImDylan93 - Vehicles can take more damage before failure, and the balance between vehicles has been tweaked.
	-- To use: comment out the settings above, and uncomment this section.

cfg = {

	deformationMultiplier = -1,					-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch
	deformationExponent = 1.0,					-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	collisionDamageExponent = 1.0,				-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

	damageFactorEngine = 5.1,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorBody = 5.1,						-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorPetrolTank = 61.0,				-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 64
	engineDamageExponent = 1.0,					-- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	weaponsDamageMultiplier = 0.124,			-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
	degradingHealthSpeedFactor = 7.4,			-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
	cascadingFailureSpeedFactor = 1.5,			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

	degradingFailureThreshold = 677.0,			-- Below this value, slow health degradation will set in
	cascadingFailureThreshold = 310.0,			-- Below this value, health cascading failure will set in
	engineSafeGuard = 100.0,					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

	torqueMultiplierEnabled = true,				-- Decrease engine torge as engine gets more and more damaged

	limpMode = false,							-- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
	limpModeMultiplier = 0.15,					-- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25

	preventVehicleFlip = true,					-- If true, you can't turn over an upside down vehicle

	sundayDriver = true,						-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
	sundayDriverAcceleratorCurve = 7.5,			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
	sundayDriverBrakeCurve = 5.0,				-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

	displayBlips = true,						-- Show blips for mechanics locations

	classDamageMultiplier = {
		[0] = 	1.0,		--	0: Compacts
				1.0,		--	1: Sedans
				1.0,		--	2: SUVs
				0.95,		--	3: Coupes
				1.0,		--	4: Muscle
				0.95,		--	5: Sports Classics
				0.95,		--	6: Sports
				0.95,		--	7: Super
				0.27,		--	8: Motorcycles
				0.7,		--	9: Off-road
				0.25,		--	10: Industrial
				0.35,		--	11: Utility
				0.85,		--	12: Vans
				1.0,		--	13: Cycles
				0.4,		--	14: Boats
				0.7,		--	15: Helicopters
				0.7,		--	16: Planes
				0.75,		--	17: Service
				0.85,		--	18: Emergency
				0.67,		--	19: Military
				0.43,		--	20: Commercial
				1.0			--	21: Trains
	}
}

]]--





-- Kết thúc cấu hình chính

-- Cấu hình hệ thống sửa chữa

-- id = 446 cho biểu tượng cờ lê, id = 72 cho biểu tượng phun

repairCfg = {
	mechanics = {
		--{name="Sua Xe", id=446, r=25.0, x=-337.0,  y=-135.0,  z=39.0},	-- LSC Burton
		--{name="Sua Xe", id=446, r=25.0, x=-1155.0, y=-2007.0, z=13.0},	-- LSC by airport
		--{name="Sua Xe", id=446, r=25.0, x=734.0,   y=-1085.0, z=22.0},	-- LSC La Mesa
		--{name="Sua Xe", id=446, r=25.0, x=1177.0,  y=2640.0,  z=37.0},	-- LSC Harmony
		--{name="Sua Xe", id=446, r=25.0, x=108.0,   y=6624.0,  z=31.0},	-- LSC Paleto Bay
		--{name="Sua Xe", id=446, r=18.0, x=538.0,   y=-183.0,  z=54.0},	-- Mechanic Hawic
		--{name="Sua Xe", id=446, r=15.0, x=1774.0,  y=3333.0,  z=41.0},	-- Mechanic Sandy Shores Airfield
		--{name="Sua Xe", id=446, r=15.0, x=1143.0,  y=-776.0,  z=57.0},	-- Mechanic Mirror Park
		--{name="Sua Xe", id=446, r=30.0, x=2508.0,  y=4103.0,  z=38.0},	-- Mechanic East Joshua Rd.
		--{name="Sua Xe", id=446, r=16.0, x=2006.0,  y=3792.0,  z=32.0},	-- Mechanic Sandy Shores gas station
		--{name="Sua Xe", id=446, r=25.0, x=484.0,   y=-1316.0, z=29.0},	-- Hayes Auto, Little Bighorn Ave.
		--{name="Sua Xe", id=446, r=33.0, x=-1419.0, y=-450.0,  z=36.0},	-- Hayes Auto Body Shop, Del Perro
		--{name="Sua Xe", id=446, r=33.0, x=268.0,   y=-1810.0, z=27.0},	-- Hayes Auto Body Shop, Davis
	--	{name="Mechanic", id=446, r=24.0, x=288.0,   y=-1730.0, z=29.0},	-- Hayes Auto, Rancho (Disabled, looks like a warehouse for the Davis branch)
		--{name="Sua Xe", id=446, r=27.0, x=1915.0,  y=3729.0,  z=32.0},	-- Otto's Auto Parts, Sandy Shores
		--{name="Sua Xe", id=446, r=45.0, x=-29.0,   y=-1665.0, z=29.0},	-- Mosley Auto Service, Strawberry
		--{name="Sua Xe", id=446, r=44.0, x=-212.0,  y=-1378.0, z=31.0},	-- Glass Heroes, Strawberry
		--{name="Sua Xe", id=446, r=33.0, x=258.0,   y=2594.0,  z=44.0},	-- Mechanic Harmony
		--{name="Sua Xe", id=446, r=18.0, x=-32.0,   y=-1090.0, z=26.0},	-- Simeons
		--{name="Sua Xe", id=446, r=25.0, x=-211.0,  y=-1325.0, z=31.0},	-- Bennys
		--{name="Sua Xe", id=446, r=25.0, x=903.0,   y=3563.0,  z=34.0},	-- Auto Repair, Grand Senora Desert
		--{name="Sua Xe", id=446, r=25.0, x=437.0,   y=3568.0,  z=38.0}		-- Auto Shop, Grand Senora Desert
	},

	fixMessages = {
		"Ban dat cac stopper dau tro lai",
		"Ban da ngung tran dau bang cach su dung keo cao su",
		"Ban sua chua cac ong dau voi bang keo",
		"Ban ep vit cua chao dau va ngung nho giot",
		"Ban khoi dong co va ky dieu tro lai voi cuoc song",
		"Ban loai bo mot so gi tu ong tia lua",
		"Ban het vao chiec xe cua ban va bang cach nao do da co hieu luc"
	},
	fixMessageCount = 7,

	noFixMessages = {
		"Ban da kiem tra cac stopper dau",
		"Ban nhin dong co cua ban, no trong on",
		"Ban da chac chan rang cac bang keo da duoc van giu dong co",
		"Ban da tang am luong dai phat thanh. Chi can bi bop nghet nhung tieng on la cua dong co",
		"Ban da them mot rs set vao ong tia lua. No lam khong co su khac biet",
		"Khong bao gio sua chua mot cai gi do ma khong bi hong, ho noi. Anh khong nghe. It nhat no da khong nhan toi te hon"
	},
	noFixMessageCount = 6
}

RepairEveryoneWhitelisted = true
RepairWhitelist =
{
	"steam:110000110912380",
	"steam:11000011484d408",
	"steam:1100001345d1349"
}


