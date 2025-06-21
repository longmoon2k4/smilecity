-- ESX = nil
local webhook1 = "https://discord.com/api/webhooks/tatwebhooks/1107683310567694436/3n7hxWYj-GbAsmtO0zs5kXaJ2GruuOcrvTmCapKaP6dXbgqt7r_SAEbB4z7igLimQOXN"
local webhook2 = "https://discord.com/api/webhooks/tatwebhooks/1107683355908116550/AcjDXtvlIKS3GYymc7XkloAqTlQZcffMN_mgOU6-SStMtCo-D8p1Nrr0ADuR1_PWFVFn"
-- local cop = 0
-- RegisterServerEvent('esx_scoreboard:cop')
-- AddEventHandler('esx_scoreboard:cop', function(player)
-- 	cop  = player
	
-- end)

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_illegal:pickedUpHydrochloricAcid')
AddEventHandler('esx_illegal:pickedUpHydrochloricAcid', function()
	local _source = source
	--local xPlayer  = ESX.GetPlayerFromId(_source)
	-- local xPlayers = ESX.GetPlayers()

	-- local cops = 0
	-- 	for i=1, #xPlayers, 1 do
	-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	-- 		if xPlayer.job.name == 'police' then
	-- 			cops = cops + 1
	-- 		end
	-- 	end

	if cop >= Config.cahaimeth then
		if exports.ox_inventory:CanCarryItem(_source, 'hydrochloric_acid', 1) then
			exports.ox_inventory:AddItem(_source, 'hydrochloric_acid', 1)
			sendDiscord(webhook1,"thaoduoc",  '***'..GetPlayerName(_source).. '*** đã hái 1 thảo dược ')
			TriggerEvent('sulu_dui:update','drug',1, _source,nil )		
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Túi đã đầy")
		end

	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaimeth.." công an")
	end

end)

RegisterServerEvent('esx_illegal:processMeth')
AddEventHandler('esx_illegal:processMeth', function()
	
	local _source = source

	if cop >= Config.cahaimeth then
		if exports.ox_inventory:CanSwapItem(_source, "hydrochloric_acid", 2, "meth1g", 1)  then 
			exports.ox_inventory:AddItem(_source, 'meth1g', 1)
			exports.ox_inventory:RemoveItem(_source, 'hydrochloric_acid', 2)
			-- xPlayer.removeInventoryItem('poppyresin', 3)
			-- xPlayer.addInventoryItem('heroin', 1)
			sendDiscord(webhook2,"thaoduoc", '***'..GetPlayerName(_source).. '*** đã chế 1 thảo dược ')
			TriggerEvent('sulu_dui:update','drug',2, _source,nil )		
			--TriggerEvent("DiscordBot:LogDiscord",webhook2, '***'..GetPlayerName(_source).. '*** đã chế 1 heroin')
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Túi đồ đầy hoặc không đủ nguyên liêu")
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Không đủ "..Config.cahaimeth.." công an")
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