-- ESX                = nil

--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("ditu", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" and xPlayer.job.grade >=4 then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		--local jailReason = args[3]
		local jailReason    = table.concat(args, " ",3)
		local victim = ESX.GetPlayerFromId(args[1])
		if jailReason ~=nil then
			if victim ~= nil then

				if jailTime ~= nil then
					JailPlayer(victim.source, jailTime)

					TriggerClientEvent("esx:showNotification", src, victim.getName() .. " đã bị đi tù trong " .. jailTime .. " minutes!")
					TriggerClientEvent('chat:addMessage', -1, { args = { "Junventor",   GetPlayerName(args[1]).." đã bị đi tù ".. jailTime .." phút. Bởi ^1"..GetPlayerName(src).." ^0vì tội danh : " .. jailReason }, color = { 249, 166, 0 } })
					--TriggerEvent('ata_wanted:xoatruyna',src)
					TriggerEvent('PlayersName:SetTruyNa',jailPlayer, 0,0)
					Citizen.Wait(10000)
					TriggerClientEvent('esx_ambulancejob:revive', jailPlayer)
					-- if args[3] ~= nil then
					-- 	GetRPName(jailPlayer, function(Firstname, Lastname)
					-- 	end)

					-- end
				else
					TriggerClientEvent("esx:showNotification", src, "Thời gian không hợp lệ !")
				end
			else
				TriggerClientEvent("esx:showNotification", src, "ID không hợp lệ !")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "Không được lý do trống !")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Bạn không phải là cảnh sát !")
	end
end)

RegisterCommand("thatu", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police"  and xPlayer.job.grade >=4 then

		local jailPlayer = args[1]
		local victim = ESX.GetPlayerFromId(args[1])

		if victim ~= nil then
			UnJail(victim.source)
			TriggerClientEvent('chat:addMessage', -1, { args = { "Junventus",  GetPlayerName(args[1]).." đã được thả tù bởi: " .. GetPlayerName(src) }, color = { 249, 166, 0 } })
		else
			TriggerClientEvent("esx:showNotification", src, "ID không hợp lệ !")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Bạn không phải là cảnh sát !")
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason)
-- exports["WaveShield"]:AddEventHandler("esx-qalle-jail:jailPlayer", function(source,targetSrc, jailTime, jailReason)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local targetSrc = tonumber(targetSrc)
	jailTime = tonumber(jailTime)
	JailPlayer(targetSrc, jailTime)

	--GetRPName(targetSrc, function(Firstname, Lastname)
	-- TriggerEvent('ata_wanted:xoatruyna', targetSrc)
	TriggerEvent('PlayersName:SetTruyNa', targetSrc, 0,0)
--  TriggerClientEvent('chat:addMessage', targetSrc, "Bạn đã hết truy nã")
	TriggerClientEvent('chat:addMessage', -1, { args = { "Junventus",   GetPlayerName(targetSrc).." đã bị đi tù ".. jailTime .." phút. Bởi ^1"..GetPlayerName(src).." ^0vì tội danh : " .. jailReason }, color = { 249, 166, 0 } })

		--TriggerClientEvent('chat:addMessage', -1, { args = { "BỘ CÔNG AN",  GetPlayerName(targetSrc).."  đã bị đi tù vì tội danh : " .. jailReason }, color = { 249, 166, 0 } })
	--end)

	TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " Đã bị đi tù trong " .. jailTime .. " phút !")
	Citizen.Wait(10000)
	TriggerClientEvent('esx_ambulancejob:revive', targetSrc)
		 
		
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " Unjailed!")
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)


RegisterServerEvent("nhatuVuotNguc")
AddEventHandler("nhatuVuotNguc", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	TriggerClientEvent("chatMessage", -1, xPlayer.name.." đã vượt ngục!")
end)
-- RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
-- AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
-- 	local src = source

-- 	local xPlayer = ESX.GetPlayerFromId(src)
-- 	local x = math.random(500, 600)
-- 	xPlayer.addMoney(x)

-- 	TriggerClientEvent("esx:showNotification", src, "Bo cho bạn ~y~"..x.."~s~ đồng nè!")
-- end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPlayer1", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)