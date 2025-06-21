
AddEventHandler("DiscordBot:LogDiscord" , function (wh, message)

	if wh ~= nil and wh ~= false and message ~= "" and message ~= nil then 

		PerformHttpRequest(wh, function(err, text, headers) end, 'POST', json.encode({content = message.." `"..os.date("%H:%M:%S - %d/%m/%Y").."`"}), { ['Content-Type'] = 'application/json' })
	end
	
end)

AddEventHandler("DiscordBot:LogDiscord2" , function (wh, message)

	if wh ~= nil and wh ~= false and message ~= "" and message ~= nil then 

		PerformHttpRequest(wh, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
	
end)