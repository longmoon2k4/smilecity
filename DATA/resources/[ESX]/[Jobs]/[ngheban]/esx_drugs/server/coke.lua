local playersProcessingCocaLeaf = {}
local webhook1 = "https://discord.com/api/webhooks/tatwebhooks/1052064626323492906/hSyU_ibXsR1S80UrvqTkNLoVUD2CIKdcNl02ubyLUpxZJkmbdoevnpcFyGMQen2w_Q2o"
local webhook2 = "https://discord.com/api/webhooks/tatwebhooks/1052064693738541127/25K643urnI5wmokcbqDxuzHqkjqa-OUOTe1fAfl5ZzfxCZZL_9uPf3zsrV0qQuxMa53z"
--[[RegisterServerEvent('esx_illegal:pickedUpCocaLeaf')
AddEventHandler('esx_illegal:pickedUpCocaLeaf', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('coca_leaf')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('coca_leaf_inventoryfull'))
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
RegisterServerEvent('esx_illegal:pickedUpCocaLeaf')
AddEventHandler('esx_illegal:pickedUpCocaLeaf', function()
	local _source = source
	--local xPlayer  = ESX.GetPlayerFromId(_source)
	--local xPlayers = ESX.GetPlayers()

	-- local cops = 0
	-- 	for i=1, #xPlayers, 1 do
	-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	-- 		if xPlayer.job.name == 'police' then
	-- 			cops = cops + 1
	-- 		end
	-- 	end

	if cop >= Config.cahaicoke then 
		if exports.ox_inventory:CanCarryItem(_source, 'coca_leaf', 1) then
			--xPlayer.addInventoryItem('coca_leaf', 1)
			exports.ox_inventory:AddItem(_source, 'coca_leaf', 1)
			TriggerEvent('reward_event:additem', _source , 'coca', 1)
			sendDiscord(webhook1,"Cacain", '***'..GetPlayerName(_source).. '*** đã hái 1 cocain ' )		
			--TriggerEvent("DiscordBot:LogDiscord",webhook1, '***'..GetPlayerName(_source).. '*** đã hái 1 cocain')
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Túi đã đầy")
		end

	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaicoke.." công an")
	end

end)


RegisterServerEvent('esx_illegal:processCocaLeaf')
AddEventHandler('esx_illegal:processCocaLeaf', function()
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

			if cop >= Config.cachecoke then
				if exports.ox_inventory:CanSwapItem(_source, "coca_leaf", 3, "coke1g", 1)  then 
					-- xPlayer.removeInventoryItem('coca_leaf', 2)
					-- xPlayer.addInventoryItem('coke1g', 1)
					exports.ox_inventory:AddItem(_source, 'coke1g', 1)
			        exports.ox_inventory:RemoveItem(_source, 'coca_leaf', 3)
					sendDiscord(webhook2,"Cacain", '***'..GetPlayerName(_source).. '*** đã chế 1 cocain ' )	
					--TriggerEvent("DiscordBot:LogDiscord",webhook2, '***'..GetPlayerName(_source).. '*** đã chế 1 cocain')
				else
					TriggerClientEvent('esx:showNotification', _source, "~r~Túi đồ đầy hoặc không đủ nguyên liêu")
				end
			else
				TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaicoke.." công an")
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