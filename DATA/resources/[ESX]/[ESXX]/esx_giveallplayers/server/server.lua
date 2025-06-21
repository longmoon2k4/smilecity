-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	if Config.TimeGiveItem ~= false then		
		SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItem)
	end
	if Config.TimeGiveMoney ~= false then
		SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)
	end
	if Config.TimeGiveWeapon ~= false then
		SetTimeout(Config.TimeGiveWeapon * 60000, TimeGiveWeapon)
	end	
end)

function TimeGiveItems()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if Config.RandomGiveItem then
			local ranItem = math.random(1, #Config.Items)
			xPlayer.addInventoryItem(Config.Items[ranItem].name, Config.Items[ranItem].count)	
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', Config.Items[ranItem].count, ESX.GetItemLabel(Config.Items[ranItem].name)), 'CHAR_MP_MORS_MUTUAL', 9)			
		else
			for i=1, #Config.Items, 1 do
				xPlayer.addInventoryItem(Config.Items[i].name, Config.Items[i].count)	
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', Config.Items[i].count, ESX.GetItemLabel(Config.Items[i].name)), 'CHAR_MP_MORS_MUTUAL', 9)
			end
		end
	end
	SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItems)
end

function TimeGiveMoney()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])	
		if Config.RandomGiveMoney then
			local ranMoney = math.random(1, #Config.Money)
			if Config.Money[ranMoney].account == 'money' then
				xPlayer.addMoney(Config.Money[ranMoney].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', Config.Money[ranMoney].amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif Config.Money[ranMoney].account == 'bank' then
				xPlayer.addAccountMoney(Config.Money[ranMoney].account, Config.Money[ranMoney].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', Config.Money[ranMoney].amount), 'CHAR_MP_MORS_MUTUAL', 9)				
			elseif Config.Money[ranMoney].account == 'black_money' then
				xPlayer.addAccountMoney(Config.Money[ranMoney].account, Config.Money[ranMoney].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', Config.Money[ranMoney].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
			end			
		else
			for i=1, #Config.Money, 1 do
				if Config.Money[i].account == 'money' then
					xPlayer.addMoney(Config.Money[i].amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)
				elseif Config.Money[i].account == 'bank' then
					xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)				
				elseif Config.Money[i].account == 'black_money' then
					xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
				end
			end			
		end
	end
	SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)	
end

function TimeGiveWeapon()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])	
		if Config.RandomGiveWeapon then
			local ranWeapon = math.random(1, #Config.Weapon)
			xPlayer.addWeapon(Config.Weapon[ranWeapon].weaponName, Config.Weapon[ranWeapon].amount)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(Config.Weapon[ranWeapon].weaponName), Config.Weapon[ranWeapon].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
		else
			for i=1, #Config.Weapon, 1 do
				xPlayer.addWeapon(Config.Weapon[i].weaponName, Config.Weapon[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(Config.Weapon[i].weaponName), Config.Weapon[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)			
			end					
		end
	end
	SetTimeout(Config.TimeGiveWeapon * 60000, TimeGiveWeapon)	
end

ESX.RegisterCommand('giveallitem', 'admin', function(source, args, user)
	if Config.AllowAdminInGameCommand then
		if source ~= 0 then
			local _source = source
			local xPlayers = exports.esx_scoreboard:data()
			local item    = args[1]
			local count   = (args[2] == nil and 1 or tonumber(args[2]))
			if ESX.GetItemLabel(item) ~= nil then
				for k,v in pairs(xPlayers) do
					exports.ox_inventory:AddItem(v.id, item, count)
					TriggerClientEvent('esx:showAdvancedNotification', v.id, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
					Wait(1000)
				end		
			else
				TriggerClientEvent('esx:showNotification', _source, _U('unknown_item'))
			end	
			-- TriggerClientEvent('esx:showAdvancedNotification', -1, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
		end
	end
end)


RegisterNetEvent('esx:giveallitem')
AddEventHandler('esx:giveallitem', function(source,tenitem,soluong)
	if Config.AllowAdminInGameCommand then
		local _source = source
		local xPlayers = exports.esx_scoreboard:data()
		local item    = tenitem
		local count   = (soluong == nil and 1 or tonumber(soluong))
			
		if ESX.GetItemLabel(item) ~= nil then
			for k,v in pairs(xPlayers) do
				exports.ox_inventory:AddItem(v.id, item, count)
				TriggerClientEvent('esx:showAdvancedNotification', v.id, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
				Wait(1000)
			end		
		else
			TriggerClientEvent('esx:showNotification', _source, _U('unknown_item'))
		end	
		-- TriggerClientEvent('esx:showAdvancedNotification', -1, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
	end
end)


RegisterCommand('_giveallitem', function(source, args)
	if Config.EnableServerCommand then
		if source == 0 then
			local xPlayers = ESX.GetPlayers()
			local item    = args[1]
			local count   = (args[2] == nil and 1 or tonumber(args[2]))
			
			for i=1, #xPlayers, 1 do
				-- exports.ox_inventory:AddItem(xPlayers[i], item, count)
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if ESX.GetItemLabel(item) ~= nil then
					-- xPlayer.addInventoryItem(item, count)
					exports.ox_inventory:AddItem(xPlayer.source, item, count)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
				-- else
				-- 	TriggerClientEvent('esx:showNotification', _source, _U('unknown_item'))
				end	
			end		
		end
	end
end)

-- TriggerEvent('es:addGroupCommand', 'giveallweapon', 'admin', function(source, args, user)
-- 	if Config.AllowAdminInGameCommand then
-- 		if source ~= 0 then
-- 			local _source = source
-- 			local xPlayers = ESX.GetPlayers()
-- 			local weaponName = string.upper(args[1])
-- 			local amount = (args[2] == nil and 1 or tonumber(args[2]))

-- 			for i=1, #xPlayers, 1 do
-- 				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				
-- 				if ESX.GetWeaponLabel(weaponName) ~= nil then
-- 					xPlayer.addWeapon(weaponName, amount)
-- 					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(weaponName), amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 				else
-- 					TriggerClientEvent('esx:showNotification', _source, _U('unknown_weapon'))
-- 				end
-- 			end	
-- 		end
-- 	end
	
-- end, function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
-- end, {help = 'give all players weapon', params = {{name = "weapon", help = 'weapon name'}, {name = "ammo", help = 'ammo amount'}}})

-- RegisterCommand('_giveallweapon', function(source, args)
-- 	if Config.EnableServerCommand then
-- 		if source == 0 then
-- 			local xPlayers = ESX.GetPlayers()
-- 			local weaponName = string.upper(args[1])
-- 			local amount = (args[2] == nil and 1 or tonumber(args[2]))

-- 			for i=1, #xPlayers, 1 do
-- 				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				
-- 				if ESX.GetWeaponLabel(weaponName) ~= nil then
-- 					xPlayer.addWeapon(weaponName, amount)
-- 					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(weaponName), amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 					print('You give all players ' ..amount.. 'x ' ..weaponName)
-- 				else
-- 					print(_U('unknown_weapon'))
-- 				end
-- 			end	
-- 		end
-- 	end	
-- end)

-- ESX.RegisterCommand('addallmoney', 'admin', function(source, args, user)
-- 	if Config.AllowAdminInGameCommand then
-- 		if source ~= 0 then
-- 			local _source = source
-- 			local xPlayers = ESX.GetPlayers()
-- 			local account = args[1]
-- 			local amount  = tonumber(args[2])

-- 			for i=1, #xPlayers, 1 do
-- 				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

-- 				if amount ~= nil then
-- 					if account == "money" then
-- 						xPlayer.addMoney(amount)
-- 						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 					elseif account == 'bank' then
-- 						xPlayer.addAccountMoney(account, amount)
-- 						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 					elseif account == 'black_money' then
-- 						xPlayer.addAccountMoney(account, amount)
-- 						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 					else
-- 						TriggerClientEvent('esx:showNotification', _source, _U('unknown_account', 'money、bank、black_money'))
-- 					end
-- 				else
-- 					TriggerClientEvent('esx:showNotification', _source, _U('unknown_amount'))
-- 				end
-- 			end	
-- 		end
-- 	end
-- end)



-- RegisterCommand('_addallmoney', function(source, args)
-- 	if Config.EnableServerCommand then
-- 		if source == 0 then
-- 			local xPlayers = ESX.GetPlayers()
-- 			local account = args[1]
-- 			local amount  = tonumber(args[2])

-- 			for i=1, #xPlayers, 1 do
-- 				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

-- 				if amount ~= nil then
-- 					if account == "money" then
-- 						xPlayer.addMoney(amount)
-- 						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 						print('You give all players $' ..amount.. ' money')
-- 					elseif account == 'bank' then
-- 						xPlayer.addAccountMoney(account, amount)
-- 						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 						print('You give all players $' ..amount.. ' into bank')
-- 					elseif account == 'black_money' then
-- 						xPlayer.addAccountMoney(account, amount)
-- 						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
-- 						print('You give all players $' ..amount.. ' black money')
-- 					else
-- 						print(_U('unknown_account', 'money、bank、black_money'))
-- 					end
-- 				else
-- 					print(_U('unknown_amount'))
-- 				end
-- 			end	
-- 		end
-- 	end
-- end)

local onTimer       = {}
local savedCoords   = {}
local warnedPlayers = {}
local deadPlayers   = {}

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if onTimer[playerId] then
		onTimer[playerId] = nil
	end
    if savedCoords[playerId] then
    	savedCoords[playerId] = nil
    end
	if warnedPlayers[playerId] then
		warnedPlayers[playerId] = nil
	end
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
	end
end)

-- ESX.RegisterCommand("reviveall", 'admin', function(source, args, user)
-- 	for i,data in pairs(deadPlayers) do
-- 		TriggerClientEvent('bo_ambulance:client:revive', i)
-- 	end
-- end)
