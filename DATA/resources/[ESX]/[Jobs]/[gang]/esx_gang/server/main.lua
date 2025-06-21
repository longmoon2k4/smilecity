-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_gangScript:registerSocieties')
AddEventHandler('esx_gangScript:registerSocieties', function(societyName)
	TriggerEvent('esx_society:registerSociety', societyName, 'Gang', 'society_' .. societyName, 'society_' .. societyName, 'society_' .. societyName, {type = 'public'})
end)

RegisterServerEvent('esx_gang:Scriptbuyweapona')
AddEventHandler('esx_gang:Scriptbuyweapona', function(weapon, giaiten)
  local xPlayer = ESX.GetPlayerFromId(source)
  local accountMoney = xPlayer.getAccount('black_money').money
  if weapon ~= "weapon_microsmg" then
     TriggerClientEvent('esx:showNotification', xPlayer.source,  'Dừng tay đi bro')
     return
  end
    if xPlayer.hasWeapon(weapon) then
  	    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Bạn Đã Có Súng Này')
    else
  	    if accountMoney >= giaiten then
  	        xPlayer.removeAccountMoney('black_money', giaiten)
            xPlayer.addWeapon(weapon, 0)
        else
        	TriggerClientEvent('esx:showNotification', source, 'Bạn không đủ tiền bẩn')
        end
    end
end)

local cacheGrade = {}

AddEventHandler('esx:setJob2', function(playerId, job, lastJob)
	cacheGrade[tonumber(playerId)] = tonumber(job.grade)
end)

function sendDiscordLog(webhook,name, message)
    if webhook ~= nil then
        local content = {
            {
                ["color"] = '2061822',
                ["title"] = name,
                ["description"] = message ..' '..os.date ("%X") .." - ".. os.date ("%x") .."",
                ["footer"] = {
                ["text"] = "Log "..name.." By Sulu",
                },
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
    end
end

function sendDiscord(payload)
    if payload.action == 'swap' then
        if payload.fromType =='player' then
            sendDiscordLog(Config.Swap[payload.toInventory], 'Swap item', ('"%s" đổi %s %s cho %s %s trong kho'):format(GetPlayerName(payload.source), payload.fromSlot.count, payload.fromSlot.name, payload.toSlot.count, payload.toSlot.name))
        else
            sendDiscordLog(Config.Swap[payload.fromInventory], 'Swap item', ('"%s" đổi %s %s cho %s %s trong người'):format(GetPlayerName(payload.source), payload.fromSlot.count, payload.fromSlot.name, payload.toSlot.count, payload.toSlot.name))
        end
    else
        if payload.fromType =='player' then
            sendDiscordLog(Config.LogCat[payload.toInventory], 'Cất đồ', ('"%s" cất %s %s vào kho'):format(GetPlayerName(payload.source), payload.fromSlot.count, payload.fromSlot.name))
        else
            sendDiscordLog(Config.LogLay[payload.fromInventory], 'Lấy đồ', ('"%s" lấy %s %s từ kho'):format(GetPlayerName(payload.source), payload.fromSlot.count, payload.fromSlot.name))
        end
    end
end

function getGrade(id)
    if cacheGrade[id] then
        return cacheGrade[id]
    else
        if  ESX.GetPlayerFromId(id) ~=nil then
            cacheGrade[id] = ESX.GetPlayerFromId(id).job2.grade
            return cacheGrade[id] 
        end
        return 0
    end
end

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for k,v in pairs(Config.Gangs) do
            exports.ox_inventory:RegisterStash(v.JobName, v.Blip.Name, 100, v.Weight, false)
        end
    end
end)

local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
    --print(json.encode(payload, { indent = true })) 
    if getGrade(payload.source) < 3  then
        if payload.fromType =='player' and payload.action ~= 'swap' then
            sendDiscord(payload)
            return true
        end
        return false
    end
    sendDiscord(payload)
    return true
end, {
    print = false,
    --itemFilter = {
    --    --money = true,
    --},
    inventoryFilter = {
        '^gang[%w]+',
    }
})
