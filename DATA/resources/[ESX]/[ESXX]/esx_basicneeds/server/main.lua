--ESX = nil

--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

playerCache = {}

function GetPlayerFromCache(source)
    if playerCache[tonumber(source)] == nil then 
        playerCache[tonumber(source)] = ESX.GetPlayerFromId(source)
    end
    return playerCache[tonumber(source)]
end

AddEventHandler("playerDropped", function(reason)
    if playerCache[tonumber(source)] then
        playerCache[tonumber(source)] = nil
    end
end)

-- ESX.RegisterUsableItem('bread', function(source)
-- 	local source = source
-- 	local xPlayer = GetPlayerFromCache(source)
-- 	xPlayer.removeInventoryItem('bread', 1)
-- 	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)

-- 	TriggerClientEvent('esx_basicneeds:onEat', source)
-- 	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
-- end)

-- ESX.RegisterUsableItem('water', function(source)
-- 	local source = source
-- 	local xPlayer = GetPlayerFromCache(source)

-- 	xPlayer.removeInventoryItem( 'water', 1)

-- 	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
-- 	TriggerClientEvent('esx_basicneeds:onDrink', source)
-- 	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
-- end)

RegisterCommand('heal', function(source, args, showError)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() ~= 'user' then
		if args[1] == nil then
			TriggerClientEvent('esx_basicneeds:healPlayer', tonumber(source))
		else
			local tPlayer = ESX.GetPlayerFromIdCard(args[1])
			if tPlayer == nil then
				tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
				if tPlayer ~= nil then
					TriggerClientEvent('esx_basicneeds:healPlayer', tonumber(args[1]))
				end
			else
				TriggerClientEvent('esx_basicneeds:healPlayer', tPlayer.source)
			end
		end
	end
end)