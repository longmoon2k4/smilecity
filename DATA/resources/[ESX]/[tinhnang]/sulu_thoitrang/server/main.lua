
Citizen.CreateThread(function()
	for k,v in pairs(Config.item) do
		ESX.RegisterUsableItem(v.itemname, function(source, item)
			TriggerClientEvent('sulu_thoitrang:SPAWN', source, v)
		end)
	end
end)
