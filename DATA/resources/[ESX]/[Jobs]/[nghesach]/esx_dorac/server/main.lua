--ESX = nil

local currentjobs, currentadd, currentworkers = {}, {}, {}

--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('esx_dorac:bagdumped')
AddEventHandler('esx_dorac:bagdumped', function(location, truckplate)
    local _source = source
    local updated = false
    if currentjobs[location] ~= nil then
        if currentjobs[location].trucknumber == truckplate then
            if  currentjobs[location].workers[_source] ~= nil then
                currentjobs[location].workers[_source] =  currentjobs[location].workers[_source] + 1
                currentjobs[location].bagsdropped = currentjobs[location].bagsdropped + 1
                updated = true
            end
            if not updated then
                if currentjobs[location].workers[_source] == nil then
                    currentjobs[location].workers[_source] = 1
                end
                currentjobs[location].bagsdropped = currentjobs[location].bagsdropped + 1
            end
            if currentjobs[location].bagsremaining <= 0  and currentjobs[location].bagsdropped == currentjobs[location].totalbags then
                TriggerEvent('esx_dorac:paycrew', currentjobs[location].pos)
            end
        end 
    end
end)

RegisterServerEvent('esx_dorac:setworkers')
AddEventHandler('esx_dorac:setworkers', function(location, trucknumber, truckid)
   local  _source = source
   local bagtotal = math.random(Config.MinBags, Config.MaxBags)
   if currentjobs[location] == nil then
    currentjobs[location] = {}
   end
   currentjobs[location] =  {name = 'bagcollection', jobboss = _source, pos = location, totalbags = bagtotal, bagsdropped = 0, bagsremaining = bagtotal, trucknumber = trucknumber, truckid = truckid, workers = {}, }
   TriggerClientEvent('esx_dorac:updatejobs', -1, currentjobs)
end)


RegisterServerEvent('esx_dorac:unknownlocation')
AddEventHandler('esx_dorac:unknownlocation', function(location)
    if currentjobs[location] ~= nil then
        if #currentjobs[location].workers > 0 then
            TriggerEvent('esx_dorac:paycrew',  currentjobs[location].pos)
        end
        currentjobs[location] = nil
        TriggerClientEvent('esx_dorac:updatejobs', -1, currentjobs)
   end
end)

RegisterServerEvent('esx_dorac:bagremoval')
AddEventHandler('esx_dorac:bagremoval', function(location)
    if currentjobs[location] ~= nil  then
        currentjobs[location].bagsremaining = currentjobs[location].bagsremaining - 1
        TriggerClientEvent('esx_dorac:updatejobs', -1, currentjobs)
    end
end)

RegisterServerEvent('esx_dorac:movetruckcount')
AddEventHandler('esx_dorac:movetruckcount', function()
    Config.TruckPlateNumb = Config.TruckPlateNumb + 1
    if Config.TruckPlateNumb == 1000 then
        Config.TruckPlateNumb = 1
    end
    TriggerClientEvent('esx_dorac:movetruckcount', -1, Config.TruckPlateNumb)
end)

RegisterServerEvent('esx_dorac:setconfig')
AddEventHandler('esx_dorac:setconfig', function()
    TriggerClientEvent('esx_dorac:movetruckcount', -1, Config.TruckPlateNumb)
    TriggerClientEvent('esx_dorac:updatejobs', -1, currentjobs)
end)

AddEventHandler('playerDropped', function()
    local removenumber = nil
    _source = source
     for i, v in pairs(currentjobs) do
        if v.jobboss == _source then
            TriggerEvent('esx_dorac:paycrew', v.pos)
            removenumber = i
        end
        if v.workers[_source] ~= nil then
            v.workers[_source] = nil
        end
     end

     if removenumber ~= nil then
        currentjobs[removenumber] = nil
        TriggerClientEvent('esx_dorac:updatejobs', -1, currentjobs)
     end
end)

AddEventHandler('esx_dorac:paycrew', function(number)
    -- print('request recieved to payout for stop: ' .. tostring(number))
    currentcrew = currentjobs[number].workers
    payamount = (Config.StopPay / currentjobs[number].totalbags) + Config.BagPay
    for i, v in pairs(currentcrew) do
        -- local xPlayer = ESX.GetPlayerFromId(i)
        -- if xPlayer ~= nil then
            local amount = math.ceil(payamount * v)
            -- xPlayer.addMoney(tonumber(amount))
            TriggerEvent('reward_event:additem', i , 'trash', v)
            exports.ox_inventory:AddItem(i, 'money', amount)
            -- sendDiscord("đổ rác", GetPlayerName(i).."đổ rác và nhạn được "..amount.." " )
            TriggerClientEvent('esx:showNotification',i, 'Bạn nhận được ~g~'..tostring(amount)..'$~s~ cho lần này!')
            -- TriggerEvent('reward_event:additem', xPlayer.source, 'trash', '1')
        -- end
    end
    local currentboss = currentjobs[number].jobboss
    currentjobs[number] = nil
    TriggerClientEvent('esx_dorac:updatejobs', -1, currentjobs)
    TriggerClientEvent('esx_dorac:selectnextjob', currentboss )
end)
local webhook = "https://discord.com/api/webhooks/tatwebhooks/1052077490560061522/xtkHIOQlQ1w8I38yRuHUvrj15LlbQJmvFOYLmRgOs32goSnEDM7Tbsl0L92vhO7dfdiQ"
function sendDiscord(name, message)
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
