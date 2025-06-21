-- ESX = nil
local webhook1 = "https://discord.com/api/webhooks/tatwebhooks/1052067075687981087/h4h8SGZ6ssIpaANxmCmGbcL6BO4MZfXWIpKRQDEEARVLwnuyYR7jyoWePGykY4lOgWM_"
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
cop = 0
RegisterServerEvent('esx_scoreboard:cop')
AddEventHandler('esx_scoreboard:cop', function(player)
	cop  = player
end)
 RegisterServerEvent('esx_illegal:sellDrug')
 AddEventHandler('esx_illegal:sellDrug', function(itemName, amount)
-- exports["WaveShield"]:AddEventHandler("esx_illegal:sellDrug", function(source, itemName, amount)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	--local xPlayers = ESX.GetPlayers()
	local price = Config.DrugDealerItems[itemName]
	--local xItem = xPlayer.getInventoryItem(itemName)

	-- local cops = 0
	-- 	for i=1, #xPlayers, 1 do
	-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	-- 		if xPlayer.job.name == 'police' then
	-- 			cops = cops + 1
	-- 		end
	-- 	end

	if cop >= Config.cabando then
		if cop >=6 then
			price = Config.DrugDealerItemsEngough[itemName]
		end
		if not price then
			print(('esx_illegal: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
			return
		end

		if exports.ox_inventory:Search(_source, "count", itemName) < amount then
			TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
			return
		end

		price = ESX.Math.Round(price * amount)

		if Config.GiveBlack then
			xPlayer.addAccountMoney('black_money', price)		
		else
			xPlayer.addMoney(price)
		end

		--xPlayer.removeInventoryItem(xItem.name, amount)
		exports.ox_inventory:RemoveItem(_source,itemName, amount)
		sendDiscord("bán đồ bẩn", '***'..GetPlayerName(_source).. '***đã bán '..amount..' '..itemName..' với giá '..ESX.Math.GroupDigits(price))
		--TriggerEvent("DiscordBot:LogDiscord",webhook1, '***'..GetPlayerName(_source).. '***đã bán '..amount..' '..xItem.label..' với giá '..ESX.Math.GroupDigits(price))
		TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', amount, itemName, ESX.Math.GroupDigits(price)))

	else
		TriggerClientEvent('esx:showNotification', source, "Không đủ công an để bán")
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
	  PerformHttpRequest(webhook1, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end

--[[ESX.RegisterServerCallback('esx_illegal:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license == nil then
		print(('esx_illegal: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= license.price then
		xPlayer.removeMoney(license.price)

		TriggerEvent('esx_license:addLicense', source, licenseName, function()
			cb(true)
		end)
	else
		cb(false)
	end
end)]]

--[[ESX.RegisterServerCallback('esx_illegal:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)]]
-- ESX.RegisterServerCallback('esx_illegal:canPickUp', function(source, cb, item)
-- --	local xPlayer = ESX.GetPlayerFromId(source)
-- 	cb(true)
-- end)

-- TriggerEvent('esx:getSharedObject', function(obj)
-- 	ESX = obj
-- end)

-- Item use
-- ESX.RegisterUsableItem('coke', function(source)
        
--         local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	xPlayer.removeInventoryItem('coke', 1)

-- 	TriggerClientEvent('kypo-drug-effect:onCoke', source)
-- end)

-- -- Item use
-- ESX.RegisterUsableItem('marijuana', function(source)
        
--     local _source = source
-- local xPlayer = ESX.GetPlayerFromId(_source)
-- xPlayer.removeInventoryItem('marijuana', 1)

-- TriggerClientEvent('kypo-drug-effect:onWeed', source)
-- end)

-- ESX.RegisterUsableItem('heroin', function(source)
        
--     local _source = source
-- local xPlayer = ESX.GetPlayerFromId(_source)
-- xPlayer.removeInventoryItem('heroin', 1)

-- TriggerClientEvent('kypo-drug-effect:onHeroin', source)
-- end)

-- ESX.RegisterUsableItem('lsd', function(source)
        
--     local _source = source
-- local xPlayer = ESX.GetPlayerFromId(_source)
-- xPlayer.removeInventoryItem('lsd', 1)

-- TriggerClientEvent('kypo-drug-effect:onLsd', source)
-- end)

-- ESX.RegisterUsableItem('meth', function(source)
        
--     local _source = source
-- local xPlayer = ESX.GetPlayerFromId(_source)
-- xPlayer.removeInventoryItem('meth', 1)

-- TriggerClientEvent('kypo-drug-effect:onMeth', source)
-- end)

-- ESX.RegisterUsableItem('lsa', function(source)
        
--     local _source = source
-- local xPlayer = ESX.GetPlayerFromId(_source)
-- xPlayer.removeInventoryItem('lsa', 1)

-- TriggerClientEvent('kypo-drug-effect:onLsa', source)
-- end)