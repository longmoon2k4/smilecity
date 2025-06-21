--ESX = nil 
local LocationArr = {}
local isCapturing = {}
local GangPoint = {}
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local isOpen = true
local isBusy = false
local recently = 0
local khu = 0
local delayThanhCong = {}
local delayThatBai = {}
local nguoibam = {}
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k ,v in pairs(config.Location) do 
        isCapturing[k] = false
    end
end)


AddEventHandler('esx:playerDropped', function(playerId)
    for k, v in pairs(isCapturing) do 
        if v == playerId then 
            isCapturing[k] = false
            TriggerEvent("cancelDropPlayer",k)
        end
    end
end)

IsInTable = function(element, table)
    for k, v in ipairs(table) do 
        if v.name == element then 
            return true 
        end 
    end 
    return false
end

IsInTable2 = function(element, table)
    for k, v in ipairs(table) do 
        if v.gang_name == element then 
            return true 
        end 
    end 
    return false
end

getIndex = function(loc)
    for k, v in ipairs(LocationArr) do 
        if v.name == loc then 
            return k 
        end 
    end 
    return -1
end

PointCount = function()
    for i = 1, #LocationArr, 1 do 
        if LocationArr[i].gang_name ~= nil then 
            MySQL.Sync.execute("UPDATE occupation_point SET point=point+1 WHERE gang_name=@gang_name", {['@gang_name'] = LocationArr[i].gang_name})
            -- TriggerEvent('sulu_dui:update','cd',1, nil, LocationArr[i].gang_name,'a')
        end
    end 
    MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
        GangPoint = result
    end)
    -- TriggerClientEvent('sulu_occupation:updateCharts', -1, GangPoint)
    Citizen.SetTimeout(config.UpdateTime, function()
        PointCount()
    end)
end

ESX.RegisterServerCallback('sulu_occupation:getData', function(source, cb, name)
    local respone = MySQL.query.await('SELECT j.`label`, o.`point` FROM `occupation_point` o INNER JOIN `jobs` j ON o.`gang_name` = j.`name` ORDER BY o.`point` DESC LIMIT 10;')
    cb(respone)
end)

MySQL.ready(function ()
    MySQL.Async.fetchAll('SELECT * FROM occupation', {}, function(result)
        LocationArr = result
        for k, v in pairs(config.Location) do 
            if not IsInTable(k, LocationArr) then 
                MySQL.Async.execute('INSERT INTO occupation (name, gang_name, nameCD) VALUES (@name, NULL, @nameCD)', {["@name"] = k, ["@nameCD"]=v.nameCD}, function(rowsChanged)
                   -- print(rowsChanged)
                end)
                MySQL.Async.fetchAll('SELECT * FROM occupation', {}, function(result)
                    LocationArr = result
                end)
            end 
        end
		--	print(ESX.DumpTable(LocationArr))

    end)
    MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
        GangPoint = result
        for k, v in pairs(config.job) do 
            if not IsInTable2(k, GangPoint) then 
                MySQL.Async.execute('INSERT INTO occupation_point (gang_name, point) VALUES (@name, 0)', {["@name"] = k}, function(rowsChanged)
                  --  print(rowsChanged)
                end)
                MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
                    GangPoint = result
                end)
            end 
        end
        for k, v in pairs(config.job1) do 
            if not IsInTable2(k, GangPoint) then 
                MySQL.Async.execute('INSERT INTO occupation_point (gang_name, point) VALUES (@name, 0)', {["@name"] = k}, function(rowsChanged)
                  --  print(rowsChanged)
                end)
                MySQL.Async.fetchAll('SELECT * FROM occupation_point', {}, function(result)
                    GangPoint = result
                end)
            end 
        end
        TriggerClientEvent('sulu_occupation:updateCharts', -1, GangPoint)
    end)
    PointCount()
end)
RegisterNetEvent('cancelDropPlayer')
AddEventHandler('cancelDropPlayer', function(loc)
   
        TriggerClientEvent('sulu_occupation:removeBlip', -1, loc)
        TriggerClientEvent('esx:showNotification', -1, "~r~Có ai đó out nên khu vực "..config.Location[loc].nameCD.." đã thất bại!")
       khu = khu -1
       delayThatBai[loc] = os.time()
        recently = os.time()
end)
RegisterNetEvent('sulu_occupation:GetLocationOwner')
AddEventHandler('sulu_occupation:GetLocationOwner', function()
    if #LocationArr == 0 then 
        Wait(1000)
    end
    TriggerClientEvent('sulu_occupation:setBlip', source, LocationArr)
end)

RegisterNetEvent('sulu_occupation:notify')
AddEventHandler('sulu_occupation:notify', function(loc)
    for i = 1, #LocationArr, 1 do 
        if LocationArr[i].name == loc then 
            CaptureNotify(LocationArr[i].gang_name, lang.CaptureNotify)
        end 
    end 
end)

RegisterNetEvent('sulu_occupation:start')
AddEventHandler('sulu_occupation:start', function(loc)
    isCapturing[loc] = true
end)

ESX.RegisterServerCallback('sulu_occupation:checkBoom', function(source, cb, name)
    cb(exports.ox_inventory:Search(source, 'count', name))
end)

ESX.RegisterServerCallback('sulu_occupation:isCapturing', function(source, cb, loc, boom)
    if boom then
        if ChekcTime() and khu < config.khu   then 
            if isCapturing[loc] ~= nil then 
                if isCapturing[loc] == false then 
                    if ( delayThanhCong[loc] == nil or os.time() - delayThanhCong[loc] > config.timethanhcong)   then                 --(os.time()-recently) > 300 then
                        if  (delayThatBai[loc] == nil or os.time()- delayThatBai[loc] > config.timethatbai) then
                            if os.time()-recently >= 180 then
                                if exports.ox_inventory:Search(source, 'count', 'boomc4') > 0 then
                                    cb(false)
                                    khu = khu + 1
                                    isCapturing[loc] = true 
                                    local xPlayer = ESX.GetPlayerFromId(source)
                                    if xPlayer.job.name == "police" then 
                                        TriggerClientEvent('sulu_occupation:setCapturingBlip', -1, loc,xPlayer.job.name)
                                        TriggerClientEvent('esx:showNotification', -1, "Police đang thực hiện chiếm đóng "..ShowName(loc) )
                                    else
                                        TriggerClientEvent('sulu_occupation:setCapturingBlip', -1, loc,xPlayer.job2.name)
                                        TriggerClientEvent('esx:showNotification', -1, "Gang "..xPlayer.job2.label.." đang thực hiện chiếm đóng "..ShowName(loc) )
                                    end
                                    exports.ox_inventory:RemoveItem(source, 'boomc4', 1)
                                    Chiemdong(xPlayer.job.name,xPlayer.job2.name, loc)
                                else
                                    cb(true)
                                    TriggerClientEvent('esx:showNotification', source, "~r~Không có boom C4!" )
                                end
                            else
                                cb(true)
                                TriggerClientEvent('esx:showNotification', source, "Toàn bộ khu vực bị delay "..(180-(os.time()-recently)).." giây" )
                            end
                        else
                            cb(true)
                            TriggerClientEvent('esx:showNotification', source, "Khu vực bị delay "..config.timethatbai-(os.time() - delayThatBai[loc]).." giây" )
                        end
                    else
                        cb(true)
                        TriggerClientEvent('esx:showNotification', source, "Khu vực bị delay "..config.timethanhcong-(os.time() - delayThanhCong[loc]).." giây" )
                    end
                else 
                    cb('goboom')
                --  TriggerClientEvent('esx:showNotification', source, lang.Busy)
                end
            end
        else
            if khu >= config.khu  then
                if isCapturing[loc] == true then 
                    cb('goboom')
                else
                    TriggerClientEvent('esx:showNotification', source, "~r~Không thể bắt đầu vì có ai đó đang chiếm đóng.")
                end
            else
                if isCapturing[loc] == true then 
                    cb('goboom')
                else
                    TriggerClientEvent('esx:showNotification', source, "~r~Chưa đến thời gian chiếm đóng.")
                end
            end
        end
    else
        if ChekcTime() and khu < config.khu        then     
             if isCapturing[loc] ~= nil then 
                 if isCapturing[loc] == false then 
                     if ( delayThanhCong[loc] == nil or os.time() - delayThanhCong[loc] > config.timethanhcong)   then                 --(os.time()-recently) > 300 then
                        if  (delayThatBai[loc] == nil or os.time()- delayThatBai[loc] > config.timethatbai) then
                            if os.time()-recently >= 180 then
                                cb(false)
                                khu = khu + 1
                                isCapturing[loc] = source 
                                local xPlayer = ESX.GetPlayerFromId(source)
                                if xPlayer.job.name == "police" then 
                                    TriggerClientEvent('sulu_occupation:setCapturingBlip', -1, loc,xPlayer.job.name)
                                    TriggerClientEvent('esx:showNotification', -1, "Police đang thực hiện chiếm đóng "..ShowName(loc) )
                                else
                                    TriggerClientEvent('sulu_occupation:setCapturingBlip', -1, loc,xPlayer.job2.name)
                                    TriggerClientEvent('esx:showNotification', -1, "Gang "..xPlayer.job2.label.." đang thực hiện chiếm đóng "..ShowName(loc) )
                                end
                            else
                                cb(true)
                                TriggerClientEvent('esx:showNotification', source, "Toàn bộ khu vực bị delay "..(180-(os.time()-recently)).." giây" )
                            end
                        else
                            cb(true)
                            TriggerClientEvent('esx:showNotification', source, "Khu vực bị delay "..config.timethatbai-(os.time() - delayThatBai[loc]).." giây" )
                        end
                     else
                        cb(true)
                        TriggerClientEvent('esx:showNotification', source, "Khu vực bị delay "..config.timethanhcong-(os.time() - delayThanhCong[loc]).." giây" )
                     end
                 else 
                     cb(true)
                     TriggerClientEvent('esx:showNotification', source, lang.Busy)
                 end
             end
         else
             if khu >= config.khu  then
                  TriggerClientEvent('esx:showNotification', source, "~r~Không thể bắt đầu vì có ai đó đang chiếm đóng.")
             else
                 TriggerClientEvent('esx:showNotification', source, "~r~Chưa đến thời gian chiếm đóng.")
             end
         end
    end
end)

-- RegisterNetEvent('sulu_occupation:captured')
-- AddEventHandler('sulu_occupation:captured', function(loc)
--     if isCapturing[loc] == false then
--         isCapturing[loc] = true
--     end
-- end)

function Chiemdong(job, job2, loc)
    Wait(config.TimeCapture)
    if isCapturing[loc] == true then
        local LocData = GetLocationData(loc)
        for i = 1, #LocationArr, 1 do 
            if LocationArr[i].name == loc then 
                LocData.lastcapture = os.time()
               
                if config.isUserjob then 
                    if job == 'police' then 
                        LocationArr[i].gang_name = job
                        MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = job, ['@lastcapture'] = curTime, ['@name'] = loc})
                    else 
                        LocationArr[i].gang_name = job2
                        MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = job2, ['@lastcapture'] = curTime, ['@name'] = loc})
                        MySQL.Sync.execute("UPDATE occupation_point SET point=point + 10 WHERE gang_name=@gang_name", {['@gang_name'] = job2})
                    end           
                else    
                    LocationArr[i].gang_name = job
                    MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = job, ['@lastcapture'] = curTime, ['@name'] = loc})
                end
                recently = os.time()
                isCapturing[loc] = false
                khu = khu -1
            end 
        end
        TriggerClientEvent('sulu_occupation:removeBlip', -1, loc)
        TriggerClientEvent('sulu_occupation:setBlip', -1, LocationArr)
        delayThanhCong[loc] = os.time()
        TriggerClientEvent('esx:showNotification', -1, "~g~Khu vực "..ShowName(loc).." boom đã nổ!")
    end
end

RegisterNetEvent('sulu_occupation:captured')
AddEventHandler('sulu_occupation:captured', function(loc)
    local LocData = GetLocationData(loc)
    local xPlayer = ESX.GetPlayerFromId(source)
    for i = 1, #LocationArr, 1 do 
        if LocationArr[i].name == loc then 
            LocData.lastcapture = os.time()
            local xPlayer = ESX.GetPlayerFromId(source)
            local curTime = os.time()
            if config.isUserjob then 
                if xPlayer.job.name == 'police' then 
                    LocationArr[i].gang_name = xPlayer.job.name
                    MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = xPlayer.job.name, ['@lastcapture'] = curTime, ['@name'] = loc})
                else 
                    LocationArr[i].gang_name = xPlayer.job2.name
                    MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = xPlayer.job2.name, ['@lastcapture'] = curTime, ['@name'] = loc})
                    MySQL.Sync.execute("UPDATE occupation_point SET point=point + 10 WHERE gang_name=@gang_name", {['@gang_name'] = xPlayer.job2.name})
                end           
            else    
                LocationArr[i].gang_name = xPlayer.job.name
                MySQL.Sync.execute("UPDATE occupation SET gang_name=@gang_name, lastcapture = @lastcapture WHERE name=@name", {['@gang_name'] = xPlayer.job.name, ['@lastcapture'] = curTime, ['@name'] = loc})
            end
            recently = os.time()
            isCapturing[loc] = false
            khu = khu -1
        end 
    end
	TriggerClientEvent('sulu_occupation:removeBlip', -1, loc)
    TriggerClientEvent('sulu_occupation:setBlip', -1, LocationArr)
    delayThanhCong[loc] = os.time()
    if xPlayer.job.name =='police' then
        TriggerClientEvent('esx:showNotification', -1, "~g~Police đã chiếm đóng khu vực thành công!")
      else
        TriggerClientEvent('esx:showNotification', -1, "~g~Gang "..xPlayer.job2.label.." đã chiếm đóng khu vực thành công!")
      end
end)


RegisterNetEvent('sulu_occupation:cancel')
AddEventHandler('sulu_occupation:cancel', function(loc,boom)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job2 = xPlayer.job2.name
    if isCapturing[loc] then 
        isCapturing[loc] = false 
        TriggerClientEvent('sulu_occupation:removeBlip', -1, loc)
        -- if xPlayer.job.name =='police' then
        if boom then
            TriggerClientEvent('esx:showNotification', -1, "~g~Khu vực "..ShowName(loc).." đã được tháo boom!")
            --if LocationArr[loc].gang_name ~= nil then
                MySQL.Sync.execute("UPDATE occupation_point SET point=point + 5 WHERE gang_name=@gang_name", {['@gang_name'] = job2})
            --end
            exports.ox_inventory:RemoveItem(source, 'boomc4', 1)
        else
            local indexLocation = getIndex(loc)
            if indexLocation ~= -1 then
                MySQL.Sync.execute("UPDATE occupation_point SET point=point + 5 WHERE gang_name=@gang_name", {['@gang_name'] = LocationArr[indexLocation].gang_name})
            end
            TriggerClientEvent('esx:showNotification', -1, "~r~Gang "..xPlayer.job2.label.." đã thất bại trong khi cố chiếm đóng khu vực!")
        end
        TriggerClientEvent('sulu_occupation:updateChiemdong', -1, loc)
        -- else
        -- TriggerClientEvent('esx:showNotification', -1, "~r~Gang "..xPlayer.job2.label.." đã thất bại trong khi cố chiếm đóng khu vực!")
        -- end
       khu = khu -1
       delayThatBai[loc] = os.time()
        recently = os.time()

    end
end)

CaptureNotify = function(gangName, text)
    local xPlayers = ESX.GetPlayers()
    if config.isUserjob then 
        for i = 1, #xPlayers, 1 do 
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer ~= nil then
                if xPlayer.job.name == gangName or xPlayer.job2.name == gangName then 
                    TriggerClientEvent('esx:showNotification', xPlayers[i], text)
                end 
            end
        end
    else 
        for i = 1, #xPlayers, 1 do 
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == gangName  then 
                TriggerClientEvent('esx:showNotification', xPlayers[i], text)
            end 
        end
    end
end

GetLocationData = function(locName)
	for i = 1, #LocationArr, 1 do 
		if LocationArr[i].name == locName then 
			return LocationArr[i]
		end
	end 
	return false
end


function GetTime() 
    local timestamp = os.time() + 7200
	local d         = os.date('*t', timestamp).wday
	local h         = tonumber(os.date('%H', timestamp))
	local m         = tonumber(os.date('%M', timestamp))

	return {d = d, h = h, m = m}
end

function ChekcTime()
    --  return true
    local time = GetTime()
    if time.d == 1 then 
        if time.h == 7 or time.h == 8 or time.h == 3 or time.h == 2   then
            return true 
        else
            return false
        end
    else

        if time.d == 2 or time.d ==4 or time.d ==6 then
            if time.h == 7 or time.h == 8  then
                return true
            else
                return false
            end
        else
            return false
        end
    end
   
end

function ShowName(loc)
    for i = 1, #LocationArr, 1 do 
		if LocationArr[i].name == loc then 
			return LocationArr[i].nameCD
		end
	end 
end

