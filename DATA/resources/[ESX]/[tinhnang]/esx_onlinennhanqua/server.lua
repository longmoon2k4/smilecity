-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback("esx_onlinenhanqua:retrievetime", function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll("SELECT * FROM nhanqua_online WHERE identifier = @identifier", { ["@identifier"] = identifier }, function(result)
		if result[1] then
		    local online = tonumber(result[1].online)
		    cb(online, result[1].day1, result[1].day2, result[1].day3, result[1].day4, result[1].day5, result[1].day6, result[1].day7, result[1].day8)
		else
			MySQL.Async.execute('INSERT INTO nhanqua_online (identifier, online) VALUES (@identifier, @online)', {["@identifier"] = identifier, ["@online"] = 0}, function(rowsChanged) end)
		end
	end)
end)

RegisterServerEvent("esx_onlinenhanqua:updatetime")
AddEventHandler("esx_onlinenhanqua:updatetime", function(time)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Sync.execute("UPDATE nhanqua_online SET online=online + @online WHERE identifier=@identifier", {['@identifier'] = identifier, ['@online'] = time})
end)

RegisterServerEvent("esx_onlinenhanqua:nhanqua")
AddEventHandler("esx_onlinenhanqua:nhanqua", function()
	-- exports["WaveShield"]:AddEventHandler("esx_onlinenhanqua:nhanqua", function(source)
	local source = source
	exports.ox_inventory:AddItem(source, 'hommayman', 1)
	-- local xPlayer = ESX.GetPlayerFromId(source)
	-- xPlayer.addInventoryItem("hommayman", 1)
end)

RegisterServerEvent("esx_onlinenhanqua:updateday")
AddEventHandler("esx_onlinenhanqua:updateday", function(day)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	if day == "day1" then
	    MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day1`=@day1 WHERE `identifier`=@identifier", {['@day1'] = "danhan", ['@identifier'] = identifier})
    elseif day == "day2" then
    	MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day2`=@day2 WHERE `identifier`=@identifier", {['@day2'] = "danhan", ['@identifier'] = identifier})
    elseif day == "day3" then
    	MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day3`=@day3 WHERE `identifier`=@identifier", {['@day3'] = "danhan", ['@identifier'] = identifier})
    elseif day == "day4" then
    	MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day4`=@day4 WHERE `identifier`=@identifier", {['@day4'] = "danhan", ['@identifier'] = identifier})
    elseif day == "day5" then
    	MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day5`=@day5 WHERE `identifier`=@identifier", {['@day5'] = "danhan", ['@identifier'] = identifier})
    elseif day == "day6" then
    	MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day6`=@day6 WHERE `identifier`=@identifier", {['@day6'] = "danhan", ['@identifier'] = identifier})
    elseif day == "day7" then
    	MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day7`=@day7 WHERE `identifier`=@identifier", {['@day7'] = "danhan", ['@identifier'] = identifier})
    elseif day == "day8" then
    	MySQL.Sync.execute("UPDATE `nhanqua_online` SET `day8`=@day8 WHERE `identifier`=@identifier", {['@day8'] = "danhan", ['@identifier'] = identifier})
    end
end)

-- function funcRestartDatanq(d,h,m)
-- 	print('nhan qua online cronjob restart data')
-- 	MySQL.Async.execute("DELETE FROM nhanqua_online", {})
-- 	TriggerClientEvent("esx_onlinenhanqua:restartdiem", -1)
-- end

function Tick()
    local timestamp = os.time()
    local h         = tonumber(os.date('%H', timestamp))
    local m         = tonumber(os.date('%M', timestamp))
    if h == 08 and m == 55 then
    	--print('nhan qua online restart data')
    	MySQL.Async.execute("DELETE FROM nhanqua_online", {})
		-- MySQL.Async.execute("DELETE FROM event_wc", {})
		-- MySQL.Async.execute("DELETE FROM zombie", {})
    	TriggerClientEvent("esx_onlinenhanqua:restartdiem", -1)
    end
    SetTimeout(30000, Tick)
end

Tick()

--TriggerEvent('cron:runAt', 0, 0, funcRestartDatanq)