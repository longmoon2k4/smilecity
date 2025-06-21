function buy()
    ESX.UI.Menu.CloseAll()
    local elements = {}
    for k,v in pairs(Config.DrugDealerItems) do
        table.insert(elements, {
			label = ('%s - <span style="color:red;">$%s</span>'):format(v.label,  ESX.Math.GroupDigits(v.price)),
            name = v.name,
        })
    end
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy', {
		title    = "Bán đồ",
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
        menu.close()
		if lib.progressBar({
			duration = 15000,
			label = "đang mua đồ",
			useWhileDead = false,
			canCancel = true,
			disable = {
				car = true,
				move = true,
				combat = true,
				mouse = false,
			},
			anim = {
				dict = 'amb@prop_human_bum_bin@idle_a',
				clip = 'idle_a',
				flag = 1
			},
		}) then 
			-- exports["WaveShield"]:TriggerServerEvent("sulu:muadoban",data.current.name)
			TriggerServerEvent('sulu:muadoban', data.current.name)
		end
	end, function(data, menu)
		menu.close()
	end)
end
  
Citizen.CreateThread(function() 
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
			if #(coords - vec3( 1600.931885, -1708.654907, 88.119385)) < 20 then
				time = 1
				DrawMarker(20,vec3( 1600.931885, -1708.654907, 88.119385), 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
            end
            if #(coords - vec3( 1600.931885, -1708.654907, 88.119385)) < 1.1 then
				ESX.ShowHelpNotification("Nhấn [E] để mua đồ.")
				if IsControlJustReleased(1, 51) then
                    buy()
				end
			end			
		  Citizen.Wait(time)
	  end	
end)