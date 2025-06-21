-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local activity = 0
local activitySource = 0
cooldown = 0
cop = 0
RegisterServerEvent('esx_scoreboard:cop')
AddEventHandler('esx_scoreboard:cop', function(player)
	cop  = player
end)
RegisterServerEvent('esx_carthief:pay')
AddEventHandler('esx_carthief:pay', function(payment)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addAccountMoney('black_money',tonumber(payment))
	
	--Add cooldown
	cooldown = Config.CooldownMinutes
end)

ESX.RegisterServerCallback('esx_carthief:anycops',function(source, cb)
--   local anycops = 0
--   local playerList = ESX.GetPlayers()
--   for i=1, #playerList, 1 do
--     local _source = playerList[i]
--     local xPlayer = ESX.GetPlayerFromId(_source)
--     local playerjob = xPlayer.job.name
--     if playerjob == 'police' then
--       anycops = anycops + 1
--     end
--   end
	local check = false
	local job = ESX.GetPlayerFromId(source).job.name
	if job == 'police' or job == 'ambulance' or job == 'mechanic' then
		check = true
	end
  cb(cop, check)
end)

ESX.RegisterServerCallback('esx_carthief:isActive',function(source, cb)
  cb(activity, cooldown)
end)

RegisterServerEvent('esx_carthief:registerActivity')
AddEventHandler('esx_carthief:registerActivity', function(value)
	local source = source
	activity = value
	cooldown = Config.CooldownMinutes
	TriggerEvent('PlayersName:SetTruyNa', source, 60,5)
	if value == 1 then
		activitySource = source
		--Send notification to cops
		-- local xPlayers = ESX.GetPlayers()
		-- for i=1, #xPlayers, 1 do
		-- 	local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		-- 	if xPlayer ~= nil then
		-- 		if xPlayer.job.name == 'police' then
					TriggerClientEvent('esx_carthief:setcopnotification',-1)
		-- 		end
		-- 	end
		-- end
	else
		activitySource = 0
	end
end)

RegisterServerEvent('esx_carthief:alertcops')
AddEventHandler('esx_carthief:alertcops', function(cx,cy,cz)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer ~= nil then
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief:setcopblip', xPlayers[i], cx,cy,cz)
			end
		end
	end
end)

RegisterServerEvent('esx_carthief:stopalertcops')
AddEventHandler('esx_carthief:stopalertcops', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer ~= nil then
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief:removecopblip', xPlayers[i])
			end
		end
	end
end)

AddEventHandler('playerDropped', function ()
	local _source = source
	if _source == activitySource then
		--Remove blip for all cops
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief:removecopblip', xPlayers[i])
			end
		end
		--Set activity to 0
		activity = 0
		activitySource = 0
	end
end)

--Cooldown manager
Citizen.CreateThread( function()
	while true do
		Wait(60000)
		if cooldown > 0 then
			cooldown = cooldown - 1
		end
	end
end)
