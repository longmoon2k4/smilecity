--ESX = nil
local webhook1 ='https://discord.com/api/webhooks/tatwebhooks/1052070354060849243/UneAlEVPqYRiK4Oe6d9Y4fZUQiPQQKdk4uCDCZZ6UEbcsOuwvfZUnd-DYhA479Y1nFeB'
local webhook2 ='https://discord.com/api/webhooks/tatwebhooks/1052070405873078353/K8WbihVimivN5l3R0h4XXAFpa-Tz9nrFs8PQmxiLNCjq6xS1WIRb7dncq8WBdQAuBQGO'
local webhook3 ='https://discord.com/api/webhooks/tatwebhooks/1052070462944989195/ZBO_sPtczmqnezQP9N0auI7xMiah0nhi1GFZ6ynQne1pNBVaB6rKojvG3tKeJ6B7OXvW'
local webhook4 ='https://discord.com/api/webhooks/tatwebhooks/1052070521380012073/RF7saSiYeJ5WG5zwWHorWIPfyxttwOZk0mH0kh6TFD2EP-TbrjucsPtLu8ZGYeD9aM_r'
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_taglialegnasdr:pickedUpTree')
AddEventHandler('esx_taglialegnasdr:pickedUpTree', function()
-- exports["WaveShield"]:AddEventHandler("esx_taglialegnasdr:pickedUpTree", function(source)
	local _source = source
	local x = math.random(1,2)
	if exports.ox_inventory:CanCarryItem(_source, 'wood', x) then
		exports.ox_inventory:AddItem(_source, 'wood', x)
		-- sendDiscord(webhook1,"gỗ 1", '***'..GetPlayerName(_source).. '*** đã chặt '..x..' gỗ ')	
	else 
		TriggerClientEvent('esx:showNotification', _source, "Gỗ đã đầy",'error')
	end		
end)

RegisterServerEvent('esx_taglialegnasdr:segatura')
AddEventHandler('esx_taglialegnasdr:segatura', function()
-- exports["WaveShield"]:AddEventHandler("esx_taglialegnasdr:segatura", function(source)
	local _source = source
	if exports.ox_inventory:CanSwapItem(_source, "wood", 2, "cutted_wood", 2)  then 
		exports.ox_inventory:AddItem(_source, 'cutted_wood', 2)
		exports.ox_inventory:RemoveItem(_source, 'wood', 2)
		-- sendDiscord(webhook2,"gỗ 2", '***'..GetPlayerName(_source).. '*** đã xử lý 2 gỗ ')
	else 
		TriggerClientEvent('esx:showNotification', _source, "Túi đã đầy hoặc bạn không đủ nguyên liệu","error")
	end		
end)


RegisterServerEvent('esx_taglialegnasdr:tavole')
AddEventHandler('esx_taglialegnasdr:tavole', function()
-- exports["WaveShield"]:AddEventHandler('esx_taglialegnasdr:tavole', function(source)
	local _source = source
	if exports.ox_inventory:CanSwapItem(_source, "cutted_wood", 2, "packaged_plank", 2)  then 
		exports.ox_inventory:AddItem(_source, 'packaged_plank', 2)
		exports.ox_inventory:RemoveItem(_source, 'cutted_wood', 2)
		TriggerEvent('reward_event:additem', _source , 'cutted_wood', 2)
		-- sendDiscord(webhook3,"gỗ 3",  '***'..GetPlayerName(_source).. '*** đã chế biến 2 gỗ ép ')
	else 
		TriggerClientEvent('esx:showNotification', _source, "túi đã đầy hoặc bạn không đủ nguyên liệu")
	end		
end)



-- RegisterNetEvent("esx_taglialegnasdr:venditablip")
-- AddEventHandler("esx_taglialegnasdr:venditablip", function(item, count)
--     local _source = source
--     local WoodPrice = Config.GoPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local WoodQuantity = xPlayer.getInventoryItem('packaged_plank').count

--     if WoodQuantity > 0  then
--         xPlayer.addMoney(WoodQuantity * WoodPrice)
--         xPlayer.removeInventoryItem('packaged_plank', WoodQuantity)
--         TriggerClientEvent('jnr_notify:Alert', xPlayer.source, "SUCCESS",'Bạn bán ' .. WoodQuantity .. ' gỗ và nhận được <span style="color:#47cf73">' .. WoodQuantity * WoodPrice .. '$</span>', 5000, 'success')
-- 		sendDiscord(webhook4,"bán gỗ",   '***'..GetPlayerName(_source).. '*** đã bán ' .. WoodQuantity .. ' gỗ đóng gói và nhận được' .. WoodQuantity * WoodPrice .. ' ')
-- 		--TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán ' .. WoodQuantity .. ' gỗ đóng gói và nhận được' .. WoodQuantity * WoodPrice .. '')    
-- 	else
--             TriggerClientEvent('jnr_notify:Alert', xPlayer.source, "SUCCESS","Bạn không có gỗ để bán", 5000, 'error')
--         end
--     end)
   

-- 	RegisterNetEvent("esx_lumberjack:sellwood")
-- AddEventHandler("esx_lumberjack:sellwood", function(item, count)
-- 	local _source = source
--     local WoodPrice =  Config.GoPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local WoodQuantity = xPlayer.getInventoryItem('packaged_plank').count
--     local money = 10000
-- 	if WoodQuantity > 0  then
--         xPlayer.addMoney(WoodQuantity * WoodPrice)
--         xPlayer.removeInventoryItem('packaged_plank', WoodQuantity)
--        -- TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán '.. WoodQuantity .. ' Kim cương và nhận được '.. WoodQuantity * WoodPrice .. '')
-- 		sendDiscord(webhook4,"bán gỗ",   '***'..GetPlayerName(_source).. '*** đã bán ' .. WoodQuantity .. ' gỗ đóng gói và nhận được' .. WoodQuantity * WoodPrice .. ' ')
--         --TriggerClientEvent('jnr_notify:Alert', xPlayer.source, "SUCCESS",'Bạn bán ' .. DiamondQuantity .. ' Kim cương và nhận được <span style="color:#47cf73">' .. DiamondQuantity * DiamondPrice .. '$</span>', 5000, 'success')
--         TriggerClientEvent('esx:showNotification', _source,  ("Bạn đã bán %s gỗ đóng gói và nhận đc %s"):format(WoodQuantity, WoodQuantity *WoodPrice))
--     else
--         TriggerClientEvent('esx:showNotification', _source, 'Bạn không còn đủ gỗ đóng gói.')
--     end
-- end)


function sendDiscord(webhook,name, message)
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
	  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end