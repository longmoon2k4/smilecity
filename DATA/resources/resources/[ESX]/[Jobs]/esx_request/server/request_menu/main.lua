local RequestData = {}
local RequestIdNhan = {}
local index = 0

RegisterServerEvent('request_menu:sendData')
AddEventHandler('request_menu:sendData', function(job, info)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local inti = GetEntityCoords(ped)
    if not RequestData[job] then 
        RequestData[job] = {}
        RequestIdNhan[job] ={}
    end
    local isRequest = false
    for k, v in pairs(RequestData[job]) do 
        if v.identifier == xPlayer.identifier then 
            isRequest = true 
        end
    end
    if not isRequest then 
        --table.insert(RequestData[job], {identifier = xPlayer.identifier, job = job, time = os.time(), status = 0, info = info, source = source})
        table.insert(RequestData[job], {identifier = xPlayer.identifier, job = job, time = os.time(), status = 0, info = 'empty', name = GetPlayerName(source)..info, source = source, coords = inti})
        TriggerClientEvent('request_menu:sync', -1)
        local playerList = GetPlayerByJob(job)
        for i = 1, #playerList, 1 do 
            TriggerClientEvent('request_menu:audio', playerList[i])
            TriggerClientEvent('esx:showNotification', playerList[i], "Có người cần giúp đỡ")
        end
    end


end)

ESX.RegisterServerCallback("getdata", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(xPlayer)
    local cbData = {}
    --GetEntityCoords(xPlayer)
    table.insert(cbData, GetEntityCoords(ped))
    cb(cbData)
end)
ESX.RegisterServerCallback("request_menu:getData", function(source, cb, isQuanY)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cbData = {}
    local Request = isQuanY and RequestData['police'] or RequestData[xPlayer.job.name]
    if Request ~= nil then
        for k, v in pairs(Request) do 
            local Player = GetPlayerByIdentifier(v.identifier)
            local status = 0
            local player = "none"
            if Player then 
                player = Player.source 
            end
            if v.status ~= 0 then 
                local receiver = GetPlayerByIdentifier(v.status)
                if receiver then 
                    status = receiver.name 
                end
            end
           
            table.insert(cbData, {id = k, source = player, status = status, time = os.time() - v.time, info = v.info, srcname = v.name, coords = v.coords})
        end
    end
    cb({cbData, GetPlayerName(source)})
end)

RegisterServerEvent("request_menu:acceptRequest")
AddEventHandler("request_menu:acceptRequest", function(id, target, isQuanY)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = (xPlayer.job.grade_name =='quany' and isQuanY) and 'police' or xPlayer.job.name
    RequestIdNhan[job][id] = source
    if RequestData[job][id].status == 0 or RequestData[job][id].status == nil then
        RequestData[job][id].status = xPlayer.identifier
    
   
        local Player = GetPlayerByIdentifier(RequestData[job][id].identifier)
        TriggerClientEvent('request_menu:sync', -1)
        if Player then
            TriggerClientEvent('request_menu:daconguoinhan', target, job, GetPlayerName(source), id)
        end
        --if xPlayer.job.name == "ambulance" and Player then
        --    TriggerClientEvent('request_menu:daconguoinhan', target, xPlayer.job.name, GetPlayerName(source), id)
        ---- TriggerClientEvent('esx_ambulcvbancejob:bacsinhan', target, GetPlayerName(source))
        --elseif xPlayer.job.name == "mechanic" and Player then 
        --    TriggerClientEvent('request_menu:daconguoinhan', target, xPlayer.job.name, GetPlayerName(source), id)
        --elseif xPlayer.job.name == "police" and Player then 
        --    TriggerClientEvent('request_menu:daconguoinhan', target, xPlayer.job.name, GetPlayerName(source), id)
        --end
    end
end)
RegisterServerEvent("request_menu:removeRequest")
AddEventHandler("request_menu:removeRequest", function(id, target, isQuanY)
    --local xPlayer = ESX.GetPlayerFromId(source)
    local job =   (Players[source].grade_name =='quany' and isQuanY) and 'police' or Players[source].job
    if ESX.GetPlayerFromId(target) ~= nil then TriggerClientEvent('request_menu:xoanhan', target, job, GetPlayerName(source)) end
    RequestData[job][id] = nil
    TriggerClientEvent('request_menu:sync', -1)
end)

RegisterServerEvent('request_menu:cancelRequest')
AddEventHandler('request_menu:cancelRequest', function(id, target, isQuanY)
   -- local xPlayer = ESX.GetPlayerFromId(source)
   local job =   (Players[source].grade_name =='quany' and isQuanY) and 'police' or Players[source].job
    if ESX.GetPlayerFromId(target) ~= nil then TriggerClientEvent('request_menu:huynhan', target, job, GetPlayerName(source)) end
    RequestData[job][id].status = 0
    TriggerClientEvent('request_menu:sync', -1)
end)

RegisterServerEvent('request_menu:huydichvu')
AddEventHandler('request_menu:huydichvu', function(id, jobname, revive  )
   -- local xPlayer = ESX.GetPlayerFromId(source)
   local source = source
   if revive then
        if id ~= nil and jobname ~= nil and  RequestIdNhan[jobname][id] ~= nil then
            local src = RequestIdNhan[jobname][id]
            if src ~= tonumber(id) then
                TriggerClientEvent('request_menu:cancelPlayer', src,GetPlayerName(source).." đã được ai đó cứu sống.")
            end
            RequestData[jobname][id] = nil
            TriggerClientEvent('request_menu:sync', -1)
        end
        if RequestIdNhan[jobname][id] == nil then
            for k,v in pairs(RequestData[jobname]) do
                if v.source == source then
                    table.remove(RequestData[jobname], k)
                end
            end
        end
   else
        if id ~= nil and jobname ~= nil and  RequestIdNhan[jobname][id] ~= nil then
            local src = RequestIdNhan[jobname][id]
            TriggerClientEvent('request_menu:cancelPlayer', src,"Buồn chưa ~y~"..GetPlayerName(source).." ~s~ đã hủy dịch vụ của bạn.")
            RequestData[jobname][id] = nil
            TriggerClientEvent('request_menu:sync', -1)
            return
        end
        if RequestIdNhan[jobname][id] == nil then
            for k,v in pairs(RequestData[jobname]) do
                if v.source == source then
                    table.remove(RequestData[jobname], k)
                end
            end
        end
    end
end)