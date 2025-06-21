function buy()
    ESX.UI.Menu.CloseAll()
    local elements = {}
	ESX.TriggerServerCallback("sulu_bando:getData", function(data1)
		for k,v in pairs(data1) do
			table.insert(elements, {
				--label = v.label,
				label = ('%s - <span style="color:green;">$%s</span>'):format(v.label,  ESX.Math.GroupDigits(v.price)),
				name = v.name,
			})
		end
	
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy', {
		title    = "Bán đồ",
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
        menu.close()
		-- exports["WaveShield"]:TriggerServerEvent("sulu:bando",data.current.name)
		TriggerServerEvent('sulu:bando', data.current.name)
	end, function(data, menu)
		menu.close()
	end)
end)
end
  
Citizen.CreateThread(function() 
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
			if #(coords - vec3( -50.492306,-802.074707,44.208740)) < 20 then
				time = 1
				DrawMarker(20,vec3( -50.492306,-802.074707,44.208740), 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
            end
            if #(coords - vec3( -50.492306,-802.074707,44.208740)) < 1.1 then
				ESX.ShowHelpNotification("Nhấn [E] để bán đồ.")
				if IsControlJustReleased(1, 51) then
                    buy()
				end
			end			
		  Citizen.Wait(time)
	  end	
end)

Citizen.CreateThread(function() 
	local blip = AddBlipForCoord(-50.492306,-802.074707,44.208740)
	SetBlipSprite(blip, 500)
	SetBlipScale(blip, 1.55)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('CUSTOM_STRING')
	AddTextComponentSubstringPlayerName("<FONT FACE='arial font'>Chợ Đầu Mối")
	EndTextCommandSetBlipName(blip)
end)