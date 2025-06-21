local RequestData = {}
local RequestIdNhan = {}
local index = 0
local blacklistmed = {}
local blacklistch = {}
local cachePlayer ={}

function getId(src)
	if cachePlayer[src] then
		return cachePlayer[src]
	end
	cachePlayer[src] = ESX.GetPlayerFromId(src).identifier
	return cachePlayer[src]
end
RegisterCommand("blacklistmed", function(source, args, raw)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local target    = tonumber(args[1])
	local duree     = tonumber(args[2])
	local reason    = table.concat(args, " ",3)
    if xPlayer.job.name == 'ambulance' then
        local xPlayerTarget = ESX.GetPlayerFromId(target)
        local identifierTarget = xPlayerTarget.identifier
        if xPlayerTarget then
            if blacklistmed[identifierTarget]  == nil then
                if duree~= nil then
                    local time = os.time() + duree*24*60*60
                    MySQL.Async.execute('INSERT INTO blacklistmed (identifier,target,time,byPlayer,reason) VALUES (@identifier,@target,@time,@byPlayer,@reason)', 
                        { 
                        ['@identifier'] =identifierTarget,
                        ['@time']     = time,
                        ['@byPlayer']      = GetPlayerName(source),
                        ['@reason']    = reason,
                        ['@target']    = GetPlayerName(target),
                        },
                        function ()
                    end)
                    local dateTable = os.date("*t", time)
                    blacklistmed[identifierTarget] = {}
                    blacklistmed[identifierTarget].timeOs = time
                    blacklistmed[identifierTarget].time = "Ngày: "..dateTable.day.." Tháng: "..dateTable.month.." Năm: "..dateTable.year
                    blacklistmed[identifierTarget].by = GetPlayerName(source)
                    blacklistmed[identifierTarget].reason = reason
                    blacklistmed[identifierTarget].target = GetPlayerName(target)
                    TriggerClientEvent('esx:showNotification', source, "Black list thành công!")
                else
                    TriggerClientEvent('esx:showNotification', source, "Nhập ngày balck list!")
                end
            else
                TriggerClientEvent('esx:showNotification', source, "Người này đã bị balcklist rồi!")
            end
        else
            TriggerClientEvent('esx:showNotification', source, "Người chơi không online!")
        end
    else
        TriggerClientEvent('esx:showNotification', source, "Bạn không phải là Bác Sỹ!")
    end

end, false)

RegisterCommand("blacklistch", function(source, args, raw)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local target    = tonumber(args[1])
	local duree     = tonumber(args[2])
	local reason    = table.concat(args, " ",3)
    if xPlayer.job.name == 'mechanic' then
        local xPlayerTarget = ESX.GetPlayerFromId(target)
        local identifierTarget = xPlayerTarget.identifier
        if xPlayerTarget then
            if blacklistch[identifierTarget]  == nil then
                if duree~= nil then
                    local time = os.time() + duree*24*60*60
                    MySQL.Async.execute('INSERT INTO blacklistch (identifier,target,time,byPlayer,reason) VALUES (@identifier,@target,@time,@byPlayer,@reason)', 
                        { 
                        ['@identifier'] =identifierTarget,
                        ['@time']     = time,
                        ['@byPlayer']      = GetPlayerName(source),
                        ['@reason']    = reason,
                        ['@target']    = GetPlayerName(target),
                        },
                        function ()
                    end)
                    local dateTable = os.date("*t", time)
                    blacklistch[identifierTarget] = {}
                    blacklistch[identifierTarget].timeOs = time
                    blacklistch[identifierTarget].time = "Ngày: "..dateTable.day.." Tháng: "..dateTable.month.." Năm: "..dateTable.year
                    blacklistch[identifierTarget].by = GetPlayerName(source)
                    blacklistch[identifierTarget].reason = reason
                    blacklistch[identifierTarget].target = GetPlayerName(target)
                    TriggerClientEvent('esx:showNotification', source, "Black list thành công!")
                else
                    TriggerClientEvent('esx:showNotification', source, "Nhập ngày balck list!")
                end
            else
                TriggerClientEvent('esx:showNotification', source, "Người này đã bị balcklist rồi!")
            end
        else
            TriggerClientEvent('esx:showNotification', source, "Người chơi không online!")
        end
    else
        TriggerClientEvent('esx:showNotification', source, "Bạn không phải là cuu ho!")
    end

end, false)

MySQL.ready(function ()
	MySQL.Async.fetchAll('SELECT * FROM blacklistmed', {}, function(result)
        for i=1, #result ,1 do 
            --data = result[i]
            local identifier = result[i].identifier
            blacklistmed[identifier]={}

            blacklistmed[identifier].timeOs = tonumber(result[i].time)
            local dateTable = os.date("*t", tonumber(result[i].time))
            blacklistmed[identifier].time = "Ngày: "..dateTable.day.." Tháng: "..dateTable.month.." Năm: "..dateTable.year
            blacklistmed[identifier].by = result[i].byPlayer
            blacklistmed[identifier].reason = result[i].reason
            blacklistmed[identifier].target = result[i].target
        end
	end)
    MySQL.Async.fetchAll('SELECT * FROM blacklistch', {}, function(result)
        for i=1, #result ,1 do 
            --data = result[i]
            local identifier = result[i].identifier
            blacklistch[identifier]={}

            blacklistch[identifier].timeOs = tonumber(result[i].time)
            local dateTable = os.date("*t", tonumber(result[i].time))
            blacklistch[identifier].time = "Ngày: "..dateTable.day.." Tháng: "..dateTable.month.." Năm: "..dateTable.year
            blacklistch[identifier].by = result[i].byPlayer
            blacklistch[identifier].reason = result[i].reason
            blacklistch[identifier].target = result[i].target
        end
	end)
end)
ESX.RegisterServerCallback("getBlacklist", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'mechanic' then
        cb(blacklistch)
    else
        cb(blacklistmed)
    end 
  
end)


ESX.RegisterServerCallback("checkblacklistmed", function(source, cb)
    local source = source
    local identifier = getId(source)
    if blacklistmed[identifier] == nil then
        cb(true)
    else
        if os.time() >= blacklistmed[identifier].timeOs then
            cb(true)
            blacklistmed[identifier] = nil
            MySQL.Async.execute("DELETE FROM blacklistmed where identifier = @identifier", {
                ["@identifier"] = identifier,
            })
        else
            cb(false)
            TriggerClientEvent('esx:showNotification', source, 'Bạn đã bị black list tới ~y~'..blacklistmed[identifier].time.." ~s~ bởi ~g~"..blacklistmed[identifier].by.." ~s~ với lý do ~y~"..blacklistmed[identifier].reason)
        end
    end
end)

ESX.RegisterServerCallback("checkblacklistch", function(source, cb)
    local source = source
    local identifier = getId(source)
    if blacklistch[identifier] == nil then
        cb(true)
    else
        if os.time() >= blacklistch[identifier].timeOs then
            cb(true)
            blacklistch[identifier] = nil
            MySQL.Async.execute("DELETE FROM blacklistch where identifier = @identifier", {
                ["@identifier"] = identifier,
            })
        else
            cb(false)
            TriggerClientEvent('esx:showNotification', source, 'Bạn đã bị black list tới ~y~'..blacklistch[identifier].time.." ~s~ bởi ~g~"..blacklistch[identifier].by.." ~s~ với lý do ~y~"..blacklistch[identifier].reason)
        end
    end
end)

RegisterServerEvent('esx_blacklist:remove')
AddEventHandler('esx_blacklist:remove', function(identifier)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'mechanic' then
        blacklistch[identifier] = nil
        MySQL.Async.execute("DELETE FROM blacklistch where identifier = @identifier", {
        ["@identifier"] = identifier,
         })
    else
        blacklistmed[identifier] = nil
        MySQL.Async.execute("DELETE FROM blacklistmed where identifier = @identifier", {
            ["@identifier"] = identifier,
        })
    end 
   
end)