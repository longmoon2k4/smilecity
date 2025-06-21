
local webhook1 = "https://discord.com/api/webhooks/tatwebhooks/1107682291603476490/RPybQwFleUbUMQMwiAMT-_Bw08h-3wEnZzmBmulFrKDshAJKuoZR5BSyM35K7UooXaPU"
local webhook2 = "https://discord.com/api/webhooks/tatwebhooks/1052065906479595550/mx6Lyx2DZ7ofl5pBB9w7sleu1EEYqzxEjqZ1dX0WnXzygdpO2Jtc21JjVWuU-OkI1-CQ"
-- local cop = 0
-- RegisterServerEvent('esx_scoreboard:cop')
-- AddEventHandler('esx_scoreboard:cop', function(player)
-- 	cop  = player
	
-- end)
RegisterServerEvent('esx_illegal:Pickupsanhoo')
AddEventHandler('esx_illegal:Pickupsanhoo', function()
	local _source = source
	-- local xPlayer  = ESX.GetPlayerFromId(_source)
	-- local xPlayers = ESX.GetPlayers()

	-- local cops = 0
	-- 	for i=1, #xPlayers, 1 do
	-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	-- 		if xPlayer.job.name == 'police' then
	-- 			cops = cops + 1
	-- 		end
	-- 	end

	if cop >= Config.cahaisanso then 
		if exports.ox_inventory:CanCarryItem(_source, 'sanho', 1) then
			--xPlayer.addInventoryItem('poppyresin', 1)
			exports.ox_inventory:AddItem(_source, 'sanho', 1)
			sendDiscord(webhook1,"heroin",  '***'..GetPlayerName(_source).. '*** đã hái 1 heroin ')
			
								
		--	TriggerEvent("DiscordBot:LogDiscord",webhook1, '***'..GetPlayerName(_source).. '*** đã hái 1 heroin')
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Túi đã đầy")
		end

	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaiheroin.." công an")
	end


end)

RegisterServerEvent('esx_illegal:sanho')
AddEventHandler('esx_illegal:sanho', function()
	local _source = source
	-- local xPlayer  = ESX.GetPlayerFromId(_source)
	-- local xPlayers = ESX.GetPlayers()
	-- local cops = 0
	-- for i=1, #xPlayers, 1 do
	-- 	local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	-- 		if xPlayer.job.name == 'police' then
	-- 			cops = cops + 1
	-- 		end
	-- end

	if cop >= Config.cacheheroin then
		if exports.ox_inventory:CanSwapItem(_source, "poppyresin", 2, "heroin", 1)  then 
			exports.ox_inventory:AddItem(_source, 'heroin', 1)
			exports.ox_inventory:RemoveItem(_source, 'poppyresin', 2)
			-- xPlayer.removeInventoryItem('poppyresin', 3)
			-- xPlayer.addInventoryItem('heroin', 1)
			sendDiscord(webhook2,"heroin", '***'..GetPlayerName(_source).. '*** đã chế 1 heroin ')
			
			--TriggerEvent("DiscordBot:LogDiscord",webhook2, '***'..GetPlayerName(_source).. '*** đã chế 1 heroin')
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Túi đồ đầy hoặc không đủ nguyên liêu")
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaiheroin.." công an")
	end
end)

function sendDiscord(webhookurl,name, message)
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
	  PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
	  --PerformHttpRequest(webhookurl2, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end
