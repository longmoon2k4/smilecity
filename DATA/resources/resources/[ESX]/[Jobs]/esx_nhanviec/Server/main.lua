-- Original Author: SimoN#6253 (Discord) | S_imoN (Forum CFX) --
-- Please Respect My Work --
-- Do Not Touch Here If You Don't Know What You Are Doing --

-- ESX = nil 

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

local cachePolice, cacheMechanic, cacheAmbulance = {},{},{}
local webhookPolice = 'https://discord.com/api/webhooks/tatwebhooks/1161579981240016986/sEPdSDXO076NPgzbsyEztx2kcA_1P-4yzQp2tjVsZh_J-UWGJgX9OH_69oNEJ7020lUD'
local webhookMechanic = 'https://discord.com/api/webhooks/tatwebhooks/1161580317392511006/yiIS3TzICiw17_5YZXqLQOe9rv-JXIqHfaVg6g0Myx4vSRKkReEooeFj2oskM3oNWQQ-'
local webhookAmbulance = 'https://discord.com/api/webhooks/tatwebhooks/1161580077570609242/wfA5Ae_usNTMPJREqqSc9lCICCn4ahRDsgkKIkPjVFcZ8RZ5RWBIiG6cvsLh10UJMTdU'
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

function offDuty(job, source) 
    local name =  GetPlayerName(source)
    if job == 'police' then
        if cachePolice[source] ~= nil then
            updateDb('police',name, GetPlayerIdentifier(source, 0),math.floor((os.time()-cachePolice[source])/60))
            sendDiscord(webhookPolice,'Onduty', name..' đã onduty được '..math.floor((os.time()-cachePolice[source])/60)..' phút. ')
            cachePolice[source] = nil
        end
    elseif job =='mechanic' then
        if cacheMechanic[source] ~= nil then
            updateDb('mechanic', name, GetPlayerIdentifier(source, 0),math.floor((os.time()-cacheMechanic[source])/60))
            sendDiscord(webhookMechanic,'Onduty', name..' đã onduty được '..math.floor((os.time()-cacheMechanic[source])/60)..' phút. ')
            cacheMechanic[source] = nil
        end
    elseif job == 'ambulance' then
        if cacheAmbulance[source] ~= nil then
            updateDb('ambulance', name, GetPlayerIdentifier(source, 0),math.floor((os.time()-cacheAmbulance[source])/60))
            sendDiscord(webhookAmbulance,'Onduty', name..' đã onduty được '..math.floor((os.time()-cacheAmbulance[source])/60)..' phút. ')
            cacheAmbulance[source] = nil
        end
    end
end

function onDuty(job, source)
    if job == 'police' then
        cachePolice[source] = os.time()
    elseif job == 'mechanic' then
        cacheMechanic[source] = os.time()
    elseif job == 'ambulance' then
        cacheAmbulance[source] = os.time()
    end
end

function updateDb(job, name, steam, time)
    local query = ("select * from onduty where job= '%s' and steam = '%s'"):format(job, steam)
    local resultQuery = MySQL.Sync.fetchAll(query)
    if resultQuery[1] == nil then
        MySQL.Async.insert('INSERT INTO onduty (name,job, steam, time) VALUES (@name, @job, @steam, @time)',{
            ['@name'] = name, 
            ['@job'] = job,
            ['@steam'] = steam, 
            ['@time'] = tonumber(time), 
        }, function(id)
         end)
    else
        MySQL.Async.execute('update onduty set time=time + @time, name = @name where steam =  @steam',{
            ['@time'] = tonumber(time), 
            ['@name'] = name,
            ['@steam'] = steam, 
        }, function(id)
         end)
    end
end

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if cachePolice[playerId] ~= nil then
        offDuty('police',playerId)
    elseif cacheMechanic[playerId] ~= nil then
        offDuty('mechanic',playerId)
    elseif  cacheAmbulance[playerId] ~= nil then
        offDuty('ambulance',playerId)
    end
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    if job.name ~= lastJob.name then
        if job.name == 'police' or job.name == 'ambulance' or job.name == 'mechanic' then
            onDuty(job.name, playerId)
        end
        if lastJob.name == 'police' or lastJob.name == 'ambulance' or lastJob.name == 'mechanic' then
            offDuty(lastJob.name, playerId)
        end
    end
end)

RegisterServerEvent('esx_nhanviec:setJob') 
AddEventHandler('esx_nhanviec:setJob', function(job) 
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob(job, 0)
end)

RegisterServerEvent('esx_nhanviec:setJobOff') 
AddEventHandler('esx_nhanviec:setJobOff', function(job) 
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local job= xPlayer.job.name
    local grade = xPlayer.job.grade
    local job2 = xPlayer.job2.name
    local grade2 = xPlayer.job2.grade
    if job == 'ambulance' or job == 'mechanic' then
        offDuty(job, source)
        xPlayer.setJob2(job, tonumber(grade))
        xPlayer.setJob('unemployed', 0)
    end
    if  job2 == 'ambulance' or job2 == 'mechanic' then
        onDuty(job2,source)
        xPlayer.setJob(job2, tonumber(grade2))
        xPlayer.setJob2('nogang', 0)
    end
end)

RegisterServerEvent('esx_nhanviec:loaded') 
AddEventHandler('esx_nhanviec:loaded', function(job) 
    local source = source
    if job == 'police' then
        cachePolice[source] = os.time()
    elseif job == 'mechanic' then
        cacheMechanic[source] = os.time()
    elseif job == 'ambulance' then
        cacheAmbulance[source] = os.time()
    end
end)