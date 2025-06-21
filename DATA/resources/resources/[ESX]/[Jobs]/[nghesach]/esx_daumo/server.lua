--ESX               = nil
local webhook1 ='https://discord.com/api/webhooks/tatwebhooks/1052075427201552415/g16PZW996nLazXK1wnsS7XbC7KAiZVUl7UCmiZY6VgZhsJLOO8OSJKbNjQMxM3CaBXji'
local webhook2 ='https://discord.com/api/webhooks/tatwebhooks/1052075476522381423/Ewas9R7e-GTvO7oL5jLqnWZs4l-Q6soDUqgCvqBhkBSjrpo_-84z-aUGjcNZfXVkB3Vc'
local webhook3 ='https://discord.com/api/webhooks/tatwebhooks/1052075522294820934/dRfPT3gnYvoUVIRZ83Lg_Ckxh5IE50vWlpcbWm8ITJGOjmzQ119LTQnb73BNl7YEwxzM'
local webhook4 ='https://discord.com/api/webhooks/tatwebhooks/1052075574547447859/VTOAj-kQmb7LloMcyeYlDEBfO90-nUkZeprC5S4fOZ4-6BnvK-Salxo_ngPr97Mdt9cI'
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_daumo:givedaumo")
AddEventHandler("esx_daumo:givedaumo", function()
-- exports["WaveShield"]:AddEventHandler("esx_daumo:givedaumo", function(source)
    local _source = source
    local x= math.random(1,3)
    if exports.ox_inventory:CanCarryItem(_source, 'petrol', x) then
        exports.ox_inventory:AddItem(_source, 'petrol', x)
        -- sendDiscord(webhook1,"dầu 1", '***'..GetPlayerName(_source).. '*** đã khai thác '..x..' dầu ')
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn đã đủ dầu trong túi",'error')
    end       
end)


RegisterNetEvent("esx_daumo:chebien")
AddEventHandler("esx_daumo:chebien", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_daumo:chebien", function(source)
    local _source = source
    if exports.ox_inventory:CanSwapItem(_source, "petrol", 2, "petrol_raffin", 2)  then 
        exports.ox_inventory:AddItem(_source, 'petrol_raffin', 2)
        exports.ox_inventory:RemoveItem(_source, 'petrol', 2)
        -- sendDiscord(webhook2,"dầu 2",'***'..GetPlayerName(_source).. '*** đã xử lý 2 dầu ')        
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn không đủ nguyên liệu",'error')
    end     
end)

RegisterNetEvent("esx_daumo:donggoi")
AddEventHandler("esx_daumo:donggoi", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_daumo:donggoi", function(source)
    local _source = source
    if exports.ox_inventory:CanSwapItem(_source, "petrol_raffin", 2, "essence", 2)  then 
        exports.ox_inventory:AddItem(_source, 'essence', 2)
			exports.ox_inventory:RemoveItem(_source, 'petrol_raffin', 2)
            TriggerEvent('reward_event:additem', _source , 'xang', 2)
            -- sendDiscord(webhook3,"dầu 3", '***'..GetPlayerName(_source).. '*** đã chế biến 2 xăng ')
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn không đủ nguyên liệu",'error')
    end
end) 
---------
-- RegisterNetEvent("esx_daumo:sellxang")
-- AddEventHandler("esx_daumo:sellxang", function(item, count)
--     local _source = source
--     local XangPrice = Config.XangPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local XangQuantity = xPlayer.getInventoryItem('essence').count

--     if XangQuantity > 0  then
--         xPlayer.addMoney(XangQuantity * XangPrice)
--         xPlayer.removeInventoryItem('essence', XangQuantity)
--         sendDiscord(webhook4,"bán đầu", '***'..GetPlayerName(_source).. '*** đã bán ' .. XangQuantity .. ' xăng và nhận được' .. XangQuantity * XangPrice .. ' ')
--       --  TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán ' .. XangQuantity .. ' xăng và nhận được' .. XangQuantity * XangPrice .. '')    
--         TriggerClientEvent('esx:showNotification', _source, 'Bạn bán đã ' .. XangQuantity .. ' xăng và nhận được ' .. XangQuantity * XangPrice)
--        -- TriggerClientEvent('jnr_notify:Alert', xPlayer.source, "SUCCESS",'Bạn bán ' .. XangQuantity .. ' xăng và nhận được <span style="color:#47cf73">' .. XangQuantity * XangPrice .. '$</span>', 5000, 'success')
--         else
--             TriggerClientEvent('esx:showNotification', _source, 'Bạn không đủ xăng')
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