if Config.Framework == "esx" then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Framework == "newEsx" then 
    ESX = exports["es_extended"]:getSharedObject()
end

local tasks = {}

function checkJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'ngudan' then
        return true
    end
    return false
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Tasks) do 
        tasks[k] = {}
        tasks[k].fishName = v.itemName
        tasks[k].taken = false
        tasks[k].hasCount = 0
        tasks[k].requiredCount = v.requiredCount
    end

    for k, v in pairs(Config.fishingRods) do 
        ESX.RegisterUsableItem(v.itemName, function(source, item)
            if checkJob(source) then
                TriggerClientEvent('ak4y-advancedFishing:start', source, v.level)
            else
                TriggerClientEvent("esx:showNotification", source,'Bạn không phải ngư dân')
            end
        end)
    end
    
    for x, z in pairs(Config.fishBaits) do 
        ESX.RegisterUsableItem(z.itemName, function(source, item)
            TriggerClientEvent('ak4y-advancedFishing:setBait', source, z.baitType, z.itemName, z.label)
        end)
    end

    Citizen.Wait(3000)
    if Config.sql == "oxmysql" then  
        MySQL.update('UPDATE ak4y_fishing SET tasks = ?, time = NULL WHERE time <= CURDATE()', { json.encode(tasks) })
    elseif Config.sql == "ghmattimysql" then  
        exports.ghmattimysql:execute("UPDATE ak4y_fishing SET tasks = @tasks, time = NULL WHERE time <= CURDATE()", {
            ['@tasks'] = json.encode(tasks)
        })   
    elseif Config.sql == "mysql-async" then 
        MySQL.Async.execute('UPDATE ak4y_fishing SET tasks = @tasks, time = NULL WHERE time <= CURDATE()', {
            ['@tasks'] = json.encode(tasks)
        })
    end
end)

ESX.RegisterServerCallback('ak4y-advancedFishing:getPlayerDetails', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local citizenId = xPlayer.identifier
    local charInfo = GetPlayerName(_source)
    local callbackData = {}
    if Config.sql == "oxmysql" then  
        local result = MySQL.query.await('SELECT * FROM ak4y_fishing WHERE citizenid = ?', { citizenId })
        if result[1] == nil then 
            MySQL.insert('INSERT INTO ak4y_fishing (citizenid, currentXP, tasks) VALUES (?, ?, ?)', {
                citizenId,
                0,
                json.encode(tasks)
            })
            callbackData = {
                resultData = {
                    ["currentXP"] = 0,
                    ["tasks"] = json.encode(tasks),
                },
                charInfo = charInfo
            }
        else
            callbackData = {resultData = result[1], charInfo = charInfo}
        end
        cb(callbackData)
    elseif Config.sql == "ghmattimysql" then  
        exports.ghmattimysql:execute("SELECT * FROM ak4y_fishing WHERE citizenid = @citizenid", {
            ["@citizenid"] = citizenId
        }, function (result)
            if result[1] == nil then 
                exports.ghmattimysql:execute("INSERT INTO ak4y_fishing SET citizenid = @citizenid, currentXP = @currentXP, tasks = @tasks", {
                    ["@citizenid"] = citizenId,
                    ["@currentXP"] = 0,
                    ["@tasks"] = json.encode(tasks),
                })
                callbackData = {
                    resultData = {
                        ["currentXP"] = 0,
                        ["tasks"] = json.encode(tasks),
                    },
                    charInfo = charInfo
                }
            else
                callbackData = {resultData = result[1], charInfo = charInfo}
            end
            cb(callbackData)
        end) 
    elseif Config.sql == "mysql-async" then 
        MySQL.Async.fetchAll("SELECT * FROM ak4y_fishing WHERE citizenid = @citizenid", {
            ["@citizenid"] = citizenId
        }, function (result)
            if result[1] == nil then 
                MySQL.Async.execute('INSERT INTO ak4y_fishing (citizenid, currentXP, tasks) VALUES (@citizenid, @currentXP, @tasks)', {
                    ["@citizenid"] = citizenId,
                    ["@currentXP"] = 0,
                    ["@tasks"] = json.encode(tasks)
                })
                callbackData = {
                    resultData = {
                        ["currentXP"] = 0,
                        ["tasks"] = json.encode(tasks),
                    },
                    charInfo = charInfo
                }
            else
                callbackData = {resultData = result[1], charInfo = charInfo}
            end
            cb(callbackData)
        end) 
    end
end)



ESX.RegisterServerCallback('ak4y-advancedFishing:rewards', function(source, cb, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local citizenId = xPlayer.identifier
    local taskId = tonumber(data.taskId)
    local money = data.money
    if Config.sql == "oxmysql" then  
        local result = MySQL.query.await('SELECT tasks FROM ak4y_fishing WHERE citizenid = ?', { citizenId })
        if result[1] then 
            local resultak4y = json.decode(result[1].tasks)
            if not resultak4y[taskId].taken then 
                if resultak4y[taskId].hasCount >= resultak4y[taskId].requiredCount then 
                    resultak4y[taskId].taken = true
                    -- xPlayer.addMoney(money)
                    exports.ox_inventory:AddItem(_source,'money', money)
                    MySQL.update('UPDATE ak4y_fishing SET tasks = ?, time = (CURDATE() + INTERVAL '..Config.Settings.tasksResetDay..' DAY) WHERE citizenid = ?', { json.encode(resultak4y), citizenId })
                    cb(true)
                else
                    cb(false)
                end
            else
                cb(false)
            end
        end
    elseif Config.sql == "ghmattimysql" then  
        exports.ghmattimysql:execute("SELECT tasks FROM ak4y_fishing WHERE citizenid = @citizenid", {
            ["@citizenid"] = citizenId
        }, function (result)
            if result[1] then 
                local resultak4y = json.decode(result[1].tasks)
                if not resultak4y[taskId].taken then 
                    if resultak4y[taskId].hasCount >= resultak4y[taskId].requiredCount then 
                        resultak4y[taskId].taken = true
                        xPlayer.addMoney(money)
                        exports.ghmattimysql:execute("UPDATE ak4y_fishing SET tasks = @tasks, time = (CURDATE() + INTERVAL "..Config.Settings.tasksResetDay.." DAY) WHERE citizenid = @citizenid", {
                            ['@citizenid'] = citizenId,
                            ['@tasks'] = json.encode(resultak4y)
                        })
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            end
        end) 
    elseif Config.sql == "mysql-async" then 
        MySQL.Async.fetchAll("SELECT tasks FROM ak4y_fishing WHERE citizenid = @citizenid", {
            ["@citizenid"] = citizenId
        }, function (result)
            if result[1] then 
                local resultak4y = json.decode(result[1].tasks)
                if not resultak4y[taskId].taken then 
                    if resultak4y[taskId].hasCount >= resultak4y[taskId].requiredCount then 
                        resultak4y[taskId].taken = true
                        xPlayer.addMoney(money)
                        MySQL.Async.execute("UPDATE ak4y_fishing SET tasks = @tasks, time = (CURDATE() + INTERVAL "..Config.Settings.tasksResetDay.." DAY) WHERE citizenid = @citizenid", {
                            ['@citizenid'] = citizenId,
                            ['@tasks'] = json.encode(resultak4y)
                        })
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            end
        end) 
    end
end)

RegisterNetEvent('ak4y-advancedFishing:addTaskCount')
AddEventHandler('ak4y-advancedFishing:addTaskCount', function(itemName)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local citizenId = xPlayer.identifier
    if Config.sql == "oxmysql" then  
        local result = MySQL.query.await('SELECT tasks FROM ak4y_fishing WHERE citizenid = ?', { citizenId })
        if result[1] then 
            local kayit = true
            local resultak4y = json.decode(result[1].tasks)
            for k, v in pairs(resultak4y) do 
                if v.fishName == itemName then 
                    if v.taken or v.hasCount >= v.requiredCount then 
                        kayit = false
                    end
                    v.hasCount = v.hasCount + 1
                end
            end
            if kayit then 
                MySQL.update('UPDATE ak4y_fishing SET tasks = ? WHERE citizenid = ?', { json.encode(resultak4y), citizenId })
            end
        end
    elseif Config.sql == "ghmattimysql" then  
        exports.ghmattimysql:execute("SELECT tasks FROM ak4y_fishing WHERE citizenid = @citizenid", {
            ["@citizenid"] = citizenId
        }, function (result)
            if result[1] then 
                local kayit = true
                local resultak4y = json.decode(result[1].tasks)
                for k, v in pairs(resultak4y) do 
                    if v.fishName == itemName then 
                        if v.taken or v.hasCount >= v.requiredCount then 
                            kayit = false
                        end
                        v.hasCount = v.hasCount + 1
                    end
                end
                if kayit then 
                    exports.ghmattimysql:execute("UPDATE ak4y_fishing SET tasks = @tasks WHERE citizenid = @citizenid", {
                        ['@citizenid'] = citizenId,
                        ['@tasks'] = json.encode(resultak4y)
                    })
                end
            end
        end) 
    elseif Config.sql == "mysql-async" then 
        MySQL.Async.fetchAll("SELECT tasks FROM ak4y_fishing WHERE citizenid = @citizenid", {
            ["@citizenid"] = citizenId
        }, function (result)
            if result[1] then 
                local kayit = true
                local resultak4y = json.decode(result[1].tasks)
                for k, v in pairs(resultak4y) do 
                    if v.fishName == itemName then 
                        if v.taken or v.hasCount >= v.requiredCount then 
                            kayit = false
                        end
                        v.hasCount = v.hasCount + 1
                    end
                end
                if kayit then 
                    MySQL.Async.execute("UPDATE ak4y_fishing SET tasks = @tasks WHERE citizenid = @citizenid", {
                        ['@citizenid'] = citizenId,
                        ['@tasks'] = json.encode(resultak4y)
                    })
                end
            end
        end) 
    end
end)

ESX.RegisterServerCallback('ak4y-advancedFishing:addXP', function(source, cb, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local citizenId = xPlayer.identifier
    local deger = tonumber(amount)
    if Config.sql == "oxmysql" then  
        MySQL.update('UPDATE ak4y_fishing SET currentXP = currentXP + ? WHERE citizenid = ?', { deger, citizenId })
    elseif Config.sql == "ghmattimysql" then  
        exports.ghmattimysql:execute("UPDATE ak4y_fishing SET currentXP = currentXP + @currentXP WHERE citizenid = @citizenid", {
            ['@citizenid'] = citizenId,
            ['@currentXP'] = deger,
        })
    elseif Config.sql == "mysql-async" then 
        MySQL.Async.execute("UPDATE ak4y_fishing SET currentXP = currentXP + @currentXP WHERE citizenid = @citizenid", {
            ['@citizenid'] = citizenId,
            ['@currentXP'] = deger,
        })
    end
    cb(true)
end)


ESX.RegisterServerCallback('ak4y-advancedFishing:upgradeRod', function(source, cb, data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local hedef = tonumber(data.hedef)
    local current = tonumber(data.hedef) - 1
    local currentItemName = nil
    local hedefItemName = nil
    local requiredCash = tonumber(data.price)
    local cashPara = xPlayer.getMoney()

    for k, v in pairs(Config.fishingRods) do
        if v.level == current then 
            currentItemName = v.itemName
        elseif v.level == hedef then 
            hedefItemName = v.itemName
        end
    end

    if cashPara >= requiredCash then 
        if xPlayer and currentItemName ~= nil and hedefItemName ~= nil then  
            local items = xPlayer.getInventoryItem(currentItemName)
            if items == nil then
                TriggerClientEvent("esx:showNotification", src, Config.Language.youDontHaveItemUPGRADE, "error")
                cb(false)
            else
                if items.count > 0 then 
                    xPlayer.removeMoney(requiredCash)
                    xPlayer.removeInventoryItem(currentItemName, 1)
                    if math.random(1, 100) > Config.Settings.rodBrokeChanceWhenUpgrade then 
                        xPlayer.addInventoryItem(hedefItemName, 1)
                        TriggerClientEvent("esx:showNotification", src, Config.Language.upgradedRod, "success")
                    else
                        TriggerClientEvent("esx:showNotification", src, Config.Language.brokenRod, "error")
                    end
                    cb(true)
                else
                    TriggerClientEvent("esx:showNotification", src, Config.Language.youDontHave, "error")
                    cb(false)
                end
            end
        else
            cb(false)
        end
    else
        TriggerClientEvent("esx:showNotification", src, Config.Language.youDontHaveMoney, "error")
        cb(false)
    end
end)

ESX.RegisterServerCallback('ak4y-advancedFishing:buyItem', function(source, cb, data)
    local src = source
    -- local xPlayer = ESX.GetPlayerFromId(source)
    local buyItemId = tonumber(data.itemId)
    local buyItemCount = tonumber(data.itemCount)
    local currentItem = {}
    -- local cashPara = xPlayer.getMoney()
    local cashPara = exports.ox_inventory:Search(src, 'count', 'money')
    for k, v in pairs(Config.buyMarketItems) do
        if v.itemId == buyItemId then 
            currentItem.itemName = v.itemName
            currentItem.price = v.itemPrice
        end
    end
    
    local requiredCash = currentItem.price * buyItemCount

    if cashPara >= requiredCash then 
        -- if xPlayer.canCarryItem(currentItem.itemName, buyItemCount) then 
        if exports.ox_inventory:CanCarryItem(src, currentItem.itemName, buyItemCount) then
            exports.ox_inventory:AddItem(src,currentItem.itemName, buyItemCount)
            exports.ox_inventory:RemoveItem(src,'money', requiredCash)
            -- xPlayer.addInventoryItem(currentItem.itemName, buyItemCount)
            -- xPlayer.removeMoney(requiredCash) 
            TriggerClientEvent("esx:showNotification", src, Config.Language.succesBuy..": "..buyItemCount..'x - '.. currentItem.itemName..'!', "success")
            cb(true)
        else
            TriggerClientEvent("esx:showNotification", src, Config.Language.youDontHaveEnoughSpace, "error")
            cb(false)
        end
    else
        TriggerClientEvent("esx:showNotification", src, Config.Language.youDontHaveMoney, "error")
        cb(false)
    end
end)

ESX.RegisterServerCallback('ak4y-advancedFishing:sellItem', function(source, cb, data)
    local src = source
    -- local xPlayer = ESX.GetPlayerFromId(source)
    local sellItemId = tonumber(data.itemId)
    local sellItemCount = tonumber(data.itemCount)
    local currentItem = {}

    for k, v in pairs(Config.sellMenuItems) do
        if v.id == sellItemId then 
            currentItem.itemName = v.itemName
            currentItem.price = v.fishPrice
        end
    end
    
    local rewardsCash = currentItem.price * sellItemCount

    -- local currentAmount = xPlayer.getInventoryItem(currentItem.itemName)
    local currentAmount =  exports.ox_inventory:Search(src, 'count', currentItem.itemName)
    if currentAmount >= sellItemCount then 
        exports.ox_inventory:RemoveItem(src, currentItem.itemName, sellItemCount)
        -- xPlayer.removeInventoryItem(currentItem.itemName, sellItemCount)
        TriggerClientEvent("esx:showNotification", src, Config.Language.succesSold.. ": "..sellItemCount..'x, '.. currentItem.itemName..' - $'..rewardsCash..'!', "success")
        -- xPlayer.addMoney(rewardsCash)
        exports.ox_inventory:AddItem(src,'money', rewardsCash)
        sendDiscord('https://discord.com/api/webhooks/tatwebhooks/1052068873991639050/QKE9ig9_AbZm6NH-5KL-EJy9xIYXFwf1-oCzfCjHDsama0kfZdiXPwbC4e-3G1AiQdsQ','ban ca', GetPlayerName(src)..'da ban ca duoc '..rewardsCash..' ')
        cb(true)
    else
        TriggerClientEvent("esx:showNotification", src, Config.Language.youDontHaveWantSell, "error")
        cb(false)
    end
end)


RegisterNetEvent('ak4y-advancedFishing:addItem')
AddEventHandler('ak4y-advancedFishing:addItem', function(item)
    -- exports["WaveShield"]:AddEventHandler("ak4y-advancedFishing:addItem", function(source,item)
    local src = source
    -- local xPlayer = ESX.GetPlayerFromId(src)
    -- xPlayer.addInventoryItem(item, 1) 
    if exports.ox_inventory:CanCarryItem(src, item, 1) then
        exports.ox_inventory:AddItem(src,item, 1)
        if item ~= 'cainit' then
            TriggerEvent('reward_event:additem', src , 'fish', 1)
        end
        sendDiscord('https://discord.com/api/webhooks/tatwebhooks/1052068753938071623/e8WqzcJK62FkGbsxD0rm6WG013YEi7rzfVuPjL2TyHtm6qHJBI13ftXJXLZRkHUtaHs-','cau ca', GetPlayerName(src)..'da cau duoc '..item..' ')
    end
end)


RegisterNetEvent('ak4y-advancedFishing:removeBait')
AddEventHandler('ak4y-advancedFishing:removeBait', function(item)
    -- local xPlayer = ESX.GetPlayerFromId(source)
    -- xPlayer.removeInventoryItem(item, 1)
    exports.ox_inventory:RemoveItem(source, item, 1)
end)



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