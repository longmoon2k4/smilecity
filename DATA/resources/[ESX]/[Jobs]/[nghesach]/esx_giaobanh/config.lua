Config = {}

--visit my discord: https://discord.gg/wsyryrC  CREATE BY Stark#5844 DO NOT REMOVE CREDITS
--visit my discord: https://discord.gg/wsyryrC  CREATE BY Stark#5844 DO NOT REMOVE CREDITS
--visit my discord: https://discord.gg/wsyryrC  CREATE BY Stark#5844 DO NOT REMOVE CREDITS

Config.FrameWork = 'ESX'

Config.Locales = {
	['EndJob'] = 'Bạn đã trả lại xe và nhận lại ~g~10000$~s~ tiền cọc',
	['NotVehicle'] = 'Đây không phải xe giao bánh của ~b~Công Ty',
	['Payment'] = 'Bạn được trả : ~g~ ',
	['NextLocation'] = 'Localizando uma nova entrega...',
	['ReturnCompany'] = 'Quay trở lại công ty đơn hàng bạn đã hết',
	['DeliverClient'] = 'Nhấn [~g~E~s~] để đưa bánh',
	['ReturnVehicle'] = "Bạn không nhận được gói hàng hãy quay xe lại để nhận.",
	['MissionText'] = 'Giao bánh cho ~y~khách hàng~s~',
	['GetDeliver'] = 'Nhấn [~g~E~s~] để lấy bánh',
	['ExitVehicle'] = 'Xuống xe vào ~g~giao bánh~s~ cho ~b~khách hàng~s~',
	['DeliverFound'] = 'Hãy đi đến điểm ~g~giao bánh~s~ trên ~y~bản đồ ( Mini Map )~s~',
	['EnterVehicle'] = 'Bạn đã cọc ~g~5000$~s~ để lấy chiếc xe giao bánh ~b~Faggio~s~',
	['NotFoundLocation'] = 'Não foi encontrado localização ~b~segura~w~ para sua moto, tente novamente',
	['SearchLocation'] = 'Đang tìm vị trí giao bánh...',
	['LoadingVehicle'] = 'Carregando veículo...',
	['PressEndJob'] = 'Nhấn [~g~E~s~] để trả lại xe',
	['StartJob'] = 'Nhấn [~g~E~s~] để bắt đầu giao bánh',
	['IsWorking'] = 'Bạn đang có một ~y~Công Việc',
}



Config.Zones_food = {
	
	PegarJob_food = {
		Pos = vec3(188.58563232422, -850.32556152344, 31.166664123535)
	},

	EndJob_food = {
		Pos = vec3(175.80964660645, -857.14721679688, 30.708854675293)
	},

	Blip = {
		Pos = vec3(188.58563232422, -850.32556152344, 31.166664123535),
		Sprite = 616,
		Display = 4,
		Scale = 0.65,
		Color = 5,
		Label = "[~y~Giao Bánh~s~] Nơi làm việc",
	}
}


Config.VehicleSpawnLocation = {
	{Pos = vec3(197.97326660156, -843.93988037109, 30.677396774292), Heading = 245.07299804688},
	{Pos = vec3(205.20713806152, -846.53460693359, 30.495185852051), Heading = 251.62699890137},
	{Pos = vec3(210.71148681641, -848.55096435547, 30.35671043396), Heading = 247.5885925293},
	{Pos = vec3(216.63293457031, -850.78802490234, 30.206609725952), Heading = 250.15547180176},
	{Pos = vec3(221.97067260742, -852.68713378906, 30.072645187378), Heading = 250.45056152344},
	{Pos = vec3(227.89419555664, -854.89233398438, 29.922969818115), Heading = 250.31610107422},
}


Config.NpcModels = {
	
	[1] = {NpcModel = "csb_anita", NpcHash = 0x0703F106},
	[2] = {NpcModel = "a_m_y_beachvesp_01", NpcHash = 0x7E0961B8},
	[3] = {NpcModel = "s_m_y_autopsy_01", NpcHash = 0xB2273D4E},
	[4] = {NpcModel = "ig_money", NpcHash = 0x37FACDA6},
	[5] = {NpcModel = "u_m_y_baygor", NpcHash = 0x5244247D},
	[6] = {NpcModel = "ig_beverly", NpcHash = 0xBDA21E5C},
	[7] = {NpcModel = "a_f_y_bevhills_01", NpcHash = 0x445AC854},
	[8] = {NpcModel = "a_f_m_bevhills_01", NpcHash = 0xBE086EFD},
	[9] = {NpcModel = "a_m_y_breakdance_01", NpcHash = 0x379F9596},
	[10] = {NpcModel = "a_m_y_business_02", NpcHash = 0xB3B3F5E6},
}


Config.FoodLocationn = {

	[1] = { Pos = vec3(-577.03204345703,-998.51940917969,22.178113937378), Pos2 = vec3(-581.67736816406,-985.07745361328,25.985725402832), Pos3 = {x = -581.67736816406, y = -985.07745361328, z = 25.985725402832-1, h =275.77 }},
	[2] = { Pos = vec3(-531.51733398438,-848.11199951172,29.596506118774), Pos2 = vec3(-531.23059082031,-854.25891113281,29.775438308716), Pos3 = {x = -531.23059082031, y = -854.25891113281, z = 29.775438308716-1, h =5.46}},
	[3] = {	Pos = vec3(-654.38470458984,-819.07110595703,24.570932388306), Pos2 = vec3(-658.77978515625,-814.40478515625,24.545694351196), Pos3 = {x = -658.77978515625, y = -814.40478515625, z = 24.545694351196-1, h =249.72 }},
	[4] = {	Pos = vec3(-657.48791503906,-330.5007019043,34.703899383545), Pos2 = vec3(-666.55975341797,-328.88293457031,35.200366973877), Pos3 = {x = -666.55975341797, y = -328.88293457031, z = 35.200366973877-1, h =294.85 }},
	[5] = {	Pos = vec3(-582.75555419922,-322.46435546875,34.865264892578), Pos2 = vec3(-582.71630859375,-330.79034423828,34.966209411621), Pos3 = {x = -582.71630859375, y = -330.79034423828, z = 34.966209411621-1, h =33.86 }},
	[6] = {	Pos = vec3(-306.732421875,-215.31886291504,37.299095153809), Pos2 = vec3(-316.57696533203,-225.68492126465,36.846473693848), Pos3 = {x = -316.57696533203, y= -225.68492126465, z = 36.846473693848-1, h =320.54 }},
    [7] = {	Pos = vec3(-204.92024230957,-50.712905883789,50.429637908936), Pos2 = vec3(-202.94230651855,-44.796981811523,50.609409332275), Pos3 = {x = -202.94230651855, y = -44.796981811523, z = 50.609409332275-1, h =169.67 }},
    [8] = {	Pos = vec3(-55.968070983887,13.067268371582,72.041679382324), Pos2 = vec3(-60.257991790771,25.078115463257,72.224143981934), Pos3 = {x = -60.257991790771, y = 25.078115463257,z = 72.224143981934-1, h =279.06}},
    [9] = {	Pos = vec3(169.31440734863,-32.486576080322,67.900573730469), Pos2 = vec3(172.97348022461,-26.356830596924,68.346611022949), Pos3 = {x = 172.97348022461, y = -26.356830596924, z =68.346611022949-1, h =157.91 }},
    [10] = { Pos = vec3(180.98413085938,-189.45819091797,54.014610290527), Pos2 = vec3(185.16754150391,-176.12313842773,54.146728515625), Pos3 = {x = 185.16754150391, y = -176.12313842773, z= 54.146728515625-1, h =160.37 }},
    [11] = { Pos = vec3(217.87658691406,-277.83654785156,49.555637359619), Pos2 = vec3(227.09269714355,-283.87014770508,49.626518249512), Pos3 = {x = 227.09269714355, y = -283.87014770508, z = 49.626518249512-1, h =69.65 }},
}


Config.MaxEntregas = 5
Config.Pagamento = 2000

Config.VehicleName = 'xepiza'