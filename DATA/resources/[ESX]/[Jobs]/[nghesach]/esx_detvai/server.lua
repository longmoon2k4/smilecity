--ESX               = nil
local webhook1 ='https://discord.com/api/webhooks/tatwebhooks/1052076413139824640/Y9R61Co5YN3pcJ0BK6iHmXcPiCkr09lmpX-7qZqgVzhnZgi1io5Nb1A5pw_hwiQKCoQC'
local webhook2 ='https://discord.com/api/webhooks/tatwebhooks/1052076479497912380/1vyyD_cqu59K7Can6L4kA4-4RiBWeU7wDzDDbBs0phAdaKtlfYyyAMytB76dOcSeE_ar'
local webhook3 ='https://discord.com/api/webhooks/tatwebhooks/1052076526973222992/RrvBSYldJPs4iZc8F5csENHjmQ1gYBm7K8dujnevdNAUWB71GlniRCmAC2NqynKQuP1k'
local webhook4 ='https://discord.com/api/webhooks/tatwebhooks/1052076573328674866/Ksa5xKxy90o7c_RrR6XBEDnxJV2K850QA7tiT94czJqKo6WG_6k22Wox7fO-qdcTZh2L'
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_vai:givevai")
AddEventHandler("esx_vai:givevai", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_vai:givevai", function(source)
    local _source = source
    local x = math.random(1,3)
        if exports.ox_inventory:CanCarryItem(_source, 'wool', x) then
            exports.ox_inventory:AddItem(_source, 'wool', x)
            -- sendDiscord(webhook1,"vài 1",  '***'..GetPlayerName(_source).. '*** đã khai thác '..x..' bông gòn ')
		else 
			TriggerClientEvent('esx:showNotification', _source, "Kho đồ đầy",'error')
		end	
end)

    

RegisterNetEvent("esx_vai:detvai")
AddEventHandler("esx_vai:detvai", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_vai:detvai", function(source)
    local _source = source
    if exports.ox_inventory:CanSwapItem(_source, "wool", 2, "fabric", 2)  then 
        exports.ox_inventory:AddItem(_source, 'fabric', 2)
        exports.ox_inventory:RemoveItem(_source, 'wool', 2)
        -- sendDiscord(webhook2,"vài 2",  '***'..GetPlayerName(_source).. '*** đã xử lý 2 Vải')
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn không đủ nguyên liệu",'error')
    end
end)

RegisterNetEvent("esx_vai:quanao")
AddEventHandler("esx_vai:quanao", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_vai:quanao", function(source)
    local _source = source 
    if exports.ox_inventory:CanSwapItem(_source, "fabric", 2, "clothe", 2)  then
        exports.ox_inventory:AddItem(_source, 'clothe', 2)
        exports.ox_inventory:RemoveItem(_source, 'fabric', 2)
        TriggerEvent('reward_event:additem', _source , 'clothe', 2)
        -- sendDiscord(webhook3,"vài 3", '***'..GetPlayerName(_source).. '*** đã chế biến 2 quần áo ')       
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn không đủ nguyên liệu",'error')
    end

end) 
---------
-- RegisterNetEvent("esx_vai:sellquanao")
-- AddEventHandler("esx_vai:sellquanao", function(item, count)
--     local _source = source
--     local QAPrice = Config.VaiPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local QAQuantity = xPlayer.getInventoryItem('clothe').count

--     if QAQuantity > 0  then
--         xPlayer.addMoney(QAQuantity * QAPrice)
--         xPlayer.removeInventoryItem('clothe', QAQuantity)
--         sendDiscord(webhook4,"bán vải",'***'..GetPlayerName(_source).. '*** đã bán ' .. QAQuantity .. ' quần áo và nhận được' .. QAQuantity * QAPrice .. ' ')
--        -- TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán ' .. QAQuantity .. ' quần áo và nhận được' .. QAQuantity * QAPrice .. '')    
--         TriggerClientEvent('esx:showNotification', _source, 'Bạn bán đã ' .. QAQuantity .. ' xăng và nhận được ' .. QAQuantity * QAPrice)
--         --TriggerClientEvent('jnr_notify:Alert', xPlayer.source, "SUCCESS",'Bạn bán ' .. QAQuantity .. ' quần áo và nhận được <span style="color:#47cf73">' .. QAQuantity * QAPrice .. '$</span>', 5000, 'success')
--         else
--             TriggerClientEvent('esx:showNotification', _source, "Bạn không có quần áo để bán")
--         end
--     end)


    function sendDiscord(webhook,name, message)
        local content = {
            {
                ["color"] = '2061822',
                ["title"] = name,
                ["description"] = message  .. os.date ("%X") .." - ".. os.date ("%x") .."",
                ["footer"] = {
                ["text"] = "Log "..name.." By Sulu",
                },
            }
        }
          PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
    end