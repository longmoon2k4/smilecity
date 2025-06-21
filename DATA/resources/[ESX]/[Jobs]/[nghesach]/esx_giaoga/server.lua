--ESX               = nil
local webhook1 ='https://discord.com/api/webhooks/tatwebhooks/1052078662339538974/_ny2i1CCL76QET54qCsqJWYjNoG9L6Ykwo7t8O0WW8vMUnP1drSDU3M1OH0Twp_ePS7Z'
local webhook2 ='https://discord.com/api/webhooks/tatwebhooks/1052078724289413232/nTUZ6PkqlJ2WGREr3ZVgQklbSwj2N6FLGr8fZrw1_BFJJyn4FCYQLJpaFfMmS8hE8qTx'
local webhook3 ='https://discord.com/api/webhooks/tatwebhooks/1052078773702496286/aVW7ARcfEI9zJ7tcd3iVO96MXPToKIg0RE4WmdY11RFmYAxila99Fo6VtJVnc-jWEOjI'
local webhook4 ='https://discord.com/api/webhooks/tatwebhooks/1052078822670991371/c0Ak_PMul6M8cehQuOa4MFFOfQrkWGiGy7K7FpCg-0I1OIU8SY9L15ETHFcQbV_LyJoD'
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_giaoga:givegasong")
AddEventHandler("esx_giaoga:givegasong", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_giaoga:givegasong", function(source)
    local _source = source
    local x = math.random(1,3)
    if exports.ox_inventory:CanCarryItem(_source, 'wood', x) then
        exports.ox_inventory:AddItem(_source, 'alive_chicken', x)
        -- sendDiscord(webhook1,"gà 1", '***'..GetPlayerName(_source).. '*** đã bắt '..x..' gà sống')
    else 
        TriggerClientEvent('esx:showNotification', _source, "Gà đã đầy",'error')
    end       	
end)

    
RegisterNetEvent("esx_giaoga:chatga")
AddEventHandler("esx_giaoga:chatga", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_giaoga:chatga", function(source)
    local _source = source
    if exports.ox_inventory:CanSwapItem(_source, "alive_chicken", 2, "slaughtered_chicken", 2)  then 
        exports.ox_inventory:AddItem(_source, 'slaughtered_chicken', 2)
        exports.ox_inventory:RemoveItem(_source, 'alive_chicken', 2)
        -- sendDiscord(webhook2,"gà 2", '***'..GetPlayerName(_source).. '*** đã xẻ thịt 2 gà sống ')
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn không đủ nguyên liệu",'error')
    end       
end)

RegisterNetEvent("esx_giaoga:donghop")
AddEventHandler("esx_giaoga:donghop", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_giaoga:donghop", function(source)
    local _source = source
    if exports.ox_inventory:CanSwapItem(_source, "slaughtered_chicken", 2, "packaged_chicken", 2)  then  
        exports.ox_inventory:AddItem(_source, 'packaged_chicken', 2)
        exports.ox_inventory:RemoveItem(_source, 'slaughtered_chicken', 2)
        TriggerEvent('reward_event:additem', _source , 'slaughtered_chicken', 2)
        -- sendDiscord(webhook3,"gà 3", '***'..GetPlayerName(_source).. '*** đã chế biến 2 gà đóng hộp ')
    else
        TriggerClientEvent('esx:showNotification', _source, "Túi đã đầy hoặc bạn không đủ nguyên liệu",'error')
    end
end)

-- RegisterNetEvent("esx_giaoga:sellga")
-- AddEventHandler("esx_giaoga:sellga", function(item, count)
--     local _source = source
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local ChickenQuantity = xPlayer.getInventoryItem('packaged_chicken').count
--         if xPlayer ~= nil then
--             if ChickenQuantity > 0 then
--                 local money = Config.GaPrice
--                 xPlayer.removeInventoryItem('packaged_chicken', ChickenQuantity)
--                 xPlayer.addMoney(ChickenQuantity * money)
--                 sendDiscord(webhook4,"bán gà",  '***'..GetPlayerName(_source).. '*** đã bán ' .. ChickenQuantity .. ' gà đóng hộp và nhận được' .. ChickenQuantity * money .. ' ')
--               -- TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán ' .. ChickenQuantity .. ' gà đóng hộp và nhận được' .. ChickenQuantity * money .. '') 
--                 TriggerClientEvent('esx:showNotification', _source, 'Bạn bán ' .. ChickenQuantity .. ' Gà đóng hộp và nhận được ' .. ChickenQuantity * money )
--             else
--                 TriggerClientEvent('esx:showNotification', _source, 'Bạn không đủ gà đóng hộp để giao.')
--             end
--         end
--     end)

-- RegisterNetEvent("esx_giaoga:selldabo")
-- AddEventHandler("esx_giaoga:selldabo", function(item, count)
--     local _source = source
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local DaboQuantity = xPlayer.getInventoryItem('dabo').count
--         if xPlayer ~= nil then
--             if DaboQuantity > 0 then
--                 local money = Config.DaboPrice
--                 xPlayer.removeInventoryItem('dabo', DaboQuantity)
--                 xPlayer.addMoney(DaboQuantity * money)
--                 sendDiscord(webhook4,"bán da bò",   '***'..GetPlayerName(_source).. '*** đã bán ' .. DaboQuantity .. ' da bò và nhận được' .. DaboQuantity * money .. ' ')
--               --  TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán ' .. DaboQuantity .. ' da bò và nhận được' .. DaboQuantity * money .. '')    
--                 TriggerClientEvent('esx:showNotification', _source,'Bạn bán ' .. DaboQuantity .. ' Da Bò và nhận được ' .. DaboQuantity * money )
--             else
--                 TriggerClientEvent('esx:showNotification', _source, 'Bạn không đủ da bò để giao.')
--             end
--         end
--     end)



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