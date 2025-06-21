
-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason,weapon,killerid)
	-- local xPlayer = ESX.GetPlayerFromId(killerid)
	if killer == "**Invalid**"  then
		reason = 3
	end
	if reason == 0 then
		sendDiscord("kill",  '***'..GetPlayerName(source)..' đã tự tử. ')
		TriggerClientEvent('esx:showNotification',source, 'Đời còn dài gái còn nhiều sao bạn tự tử thế')
	elseif reason == 1 then
		sendDiscord("kill",  killer .. " đã giết "..GetPlayerName(source).." với "..weapon..". ")
		TriggerClientEvent('esx:showNotification',source, killer..' đã bế bạn lên thiên đường với '..weapon)
	elseif reason == 3 then
		if killer == "**Invalid**"  then
		    sendDiscord("kill",  GetPlayerName(source).." đã chết không rõ lý do. ")
			TriggerClientEvent('esx:showNotification',source, 'Không biết sao chết luôn')
		else
			sendDiscord("kill",  GetPlayerName(source).." đã bị tông bởi  "..killer.."  ")
			TriggerClientEvent('esx:showNotification',source, killer..' đã tông bạn.')
		end
	end
end)


function sendDiscord(name, message)
	local content = {
		{
			["color"] = '2061822',
			["title"] = name,
			["description"] = message .. os.date ("%X") .." - ".. os.date ("%x") .."",
			["footer"] = {
			["text"] = "Log "..name.." By Sulu",
			},
		}
	}
	  PerformHttpRequest("https://discord.com/api/webhooks/tatwebhooks/1074742974208024727/X8hbf7UBCvysbPvBS2AHmPFyD0jnNsQMyLvQjjzBIoZiqn_O5HLWtqy77PoxtlRQbOXd", function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end
