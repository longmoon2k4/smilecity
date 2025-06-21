local playersProcessingCannabis = {}
local webhook1 = "https://discord.com/api/webhooks/tatwebhooks/1052065058949173298/xXGG3WRKrGZ4en1w8wCkwfcEUJqZkR1HqFBadiJ7AgKdj9hpJZreR_YnVl9nQVT7D7DO"
local webhook2 = "https://discord.com/api/webhooks/tatwebhooks/1052065124996886592/O6z297H0IjFUcUcred4M30LOM5g4TZYK7o-2KAClkXPhnZseuFOB4ZZj_eUCdGxn1Z-1"
--[[RegisterServerEvent('esx_illegal:pickedUpCannabis')
AddEventHandler('esx_illegal:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cannabis')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)
]]
-- local cop = 0
-- RegisterServerEvent('esx_scoreboard:cop')
-- AddEventHandler('esx_scoreboard:cop', function(player)
-- 	cop  = player
-- end)
RegisterServerEvent('esx_illegal:pickedUpCannabis')
AddEventHandler('esx_illegal:pickedUpCannabis', function()
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

	if cop >= Config.cahaican then 
		if exports.ox_inventory:CanCarryItem(_source, 'cannabis', 1) then
			--xPlayer.addInventoryItem('cannabis', 1)
			exports.ox_inventory:AddItem(_source, 'cannabis', 1)
			TriggerEvent('reward_event:additem', _source , 'cannabis', 1)
			sendDiscord(webhook1,"Cần sa",'***'..GetPlayerName(_source).. '*** đã hái 1 cần sa ')
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Túi đã đầy")
		end

	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaican.." công an")
	end

end)

RegisterServerEvent('esx_illegal:processCannabis')
AddEventHandler('esx_illegal:processCannabis', function()
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

	if cop >= Config.cachecan then
		if exports.ox_inventory:CanSwapItem(_source, "cannabis", 3, "marijuana", 1)  then 
			-- xPlayer.removeInventoryItem('cannabis', 1)
			-- xPlayer.addInventoryItem('marijuana', 1)
			exports.ox_inventory:AddItem(_source, 'marijuana', 1)
			exports.ox_inventory:RemoveItem(_source, 'cannabis', 3)
			sendDiscord(webhook2,"Cần sa",'***'..GetPlayerName(_source).. '*** đã chế 1 cần sa ')
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Túi đồ đầy hoặc không đủ nguyên liêu")
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaican.." công an")
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