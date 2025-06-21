itens_market = {}

RegisterNetEvent('sulu_chotroi:buyItem')
AddEventHandler('sulu_chotroi:buyItem', function(data)
    -- exports["WaveShield"]:AddEventHandler("sulu_chotroi:buyItem", function(source,data)
    local idJ = source
    local xPlayer = ESX.GetPlayerFromId(idJ)
    local playerMoney = xPlayer.getMoney() --getBankMoney(idJ)
    local namePlayer = GetPlayerName(idJ) --getName(idJ)
    local identifier = getIdentifier(idJ)
        local item = getFilterItemByLabel(data.item.name)

        if identifier == data.item.identifier then
            TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_SELF)
            TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
            TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_SELF}})

            return
          --  local newCount = xPlayer.getInventoryItem(item.name).count + count
        -- if error here, item not exists
       -- elseif not canCarryItem(idJ, item.name, data.selectAmount) then
        elseif not exports.ox_inventory:CanCarryItem(idJ, item.name, data.selectAmount) then 
            TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_FULL)
            TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
            TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_FULL}})

            return
        end
            
        local result = MySQL.Sync.fetchAll('SELECT * FROM market WHERE id = @id',{
            ['@id'] = data.item.id
        })

        -- secutiry var
        local item_var = nil

        for i,k in pairs(itens_market) do
            if k.id == data.item.id then
                item_var = k
            end
        end

        if result and #result > 0 and item_var then
            local dbAmount = tonumber(result[1].amount)
            local selectAmount = tonumber(data.selectAmount)
            local price = tonumber(result[1].price) * selectAmount

            local varAmount = tonumber(item_var.amount)
            
            if price > playerMoney then
                TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_MONEY)
                TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_MONEY}})
                TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
                return
            end

            if dbAmount >= selectAmount and varAmount >= selectAmount then
                if dbAmount > selectAmount then
                    item_var.amount = varAmount - selectAmount

                    MySQL.Sync.execute('UPDATE market SET amount = @amount WHERE id = @id',{
                        ['@amount'] = (dbAmount - selectAmount),
                        ['@id'] = data.item.id
                    })
                else
                    for i,k in pairs(itens_market) do
                        if k.id == data.item.id then
                            table.remove(itens_market, i)
                            break
                        end
                    end

                    MySQL.Sync.execute('DELETE FROM market WHERE id = @id',{
                        ['@id'] = data.item.id
                    })
                end

                addBankMoney(data.item.identifier, price)
             --   removeBankMoney(idJ, price)
                xPlayer.removeMoney(tonumber(price))
               -- addInventoryItem(idJ, item.name, selectAmount)
                local slotEmpty = exports.ox_inventory:GetEmptySlot(idJ)
                exports.ox_inventory:AddItem(idJ, item.name, tonumber(selectAmount), json.decode(result[1].metadata), slotEmpty)
                TriggerClientEvent('sulu_chotroi:updateMarket', idJ)
                TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "green", translate.TR_SUCESS)
                TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_SUCESS}})

                sendWebhook(WEBHOOKS.ADMIN_WEBHOOK, WEBHOOKS.TITLE_BUY_ITEM, translate.TR_WEBHOOK_LOG_BUY .. '\n' .. translate.TR_WEBHOOK_OWNER .. data.item.owner .. '\n' .. translate.TR_WEBHOOK_LOG_BUY_BY .. namePlayer .. '\n' .. translate.TR_WEBHOOK_LOG_BUY_AMOUNT .. selectAmount .. '\n' .. translate.TR_WEBHOOK_LOG_BUY_PRICE .. translate.TR_SIMBOL_MONEY .. " " .. price, WEBHOOKS.COLOR_BUY)
            else
                TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_AMOUNT)
                TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_AMOUNT}})
                TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
            end
        else
            TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_NOT_FOUND)
            TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_NOT_FOUND}})
            TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
        end
    
end)

RegisterNetEvent('sulu_chotroi:advertiseItem')
AddEventHandler('sulu_chotroi:advertiseItem', function(data)
    -- exports["WaveShield"]:AddEventHandler("sulu_chotroi:advertiseItem", function(source,data)
    local idJ = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = getIdentifier(idJ)
    local owner = GetPlayerName(idJ)
    local item = getItemByLabel(idJ, data.item.name)
    local amount = tonumber(data.item.amount)
    local checkAmount = MySQL.Sync.fetchAll('SELECT  COUNT(*) AS count FROM market WHERE identifier= @id ORDER BY identifier',{
        ['@id'] = identifier
    })
    if item and item.count >= amount then
        if tonumber(checkAmount[1].count) < 5 then
            --removeInventoryItem(idJ, item.name, amount)
            local slot = exports.ox_inventory:GetSlotIdWithItem(idJ, item.name)
            local itemSlot = exports.ox_inventory:GetSlot(idJ, slot)
            if  exports.ox_inventory:RemoveItem(idJ, item.name, amount, itemSlot.metadata, slot) then
                MySQL.Async.insert('INSERT INTO market (name, amount, weight, price, owner, identifier, metadata) VALUES (@name, @amount, @weight, @price, @owner, @identifier, @metadata)',{
                    ['@name'] = data.item.name, 
                    ['@amount'] = amount, 
                    ['@weight'] = item.weight, 
                    ['@price'] = tonumber(data.item.price), 
                    ['@owner'] = owner, 
                    ['@identifier'] = identifier,
                    ['@metadata'] = json.encode(itemSlot.metadata),
                }, function(id)
                table.insert(itens_market, {id = id, name = data.item.name, amount = amount, weight = item.weight, price = tonumber(data.item.price), owner = owner, identifier = identifier}) 
                end)
                TriggerClientEvent('sulu_chotroi:updatePlayerMarket', idJ)
                TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "green", translate.TR_ADVERTISE_ITEM)
                TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_ADVERTISE_ITEM}})
                sendWebhook(WEBHOOKS.PUBLIC_WEBHOOK, WEBHOOKS.TITLE_ANNOUNCE_ITEM, data.item.name .. " x" .. data.item.amount .. '\n' .. translate.TR_WEBHOOK_OWNER .. owner .. '\n' .. translate.TR_WEBHOOK_AMOUNT .. amount .. '\n' .. translate.TR_WEBHOOK_PRICE .. translate.TR_SIMBOL_MONEY .. " " .. data.item.price, WEBHOOKS.COLOR_ANNOUNCE)
            end
        else
            TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_AMOUNT3)
            TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_AMOUNT3}})
            TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
        end
    else
        TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_AMOUNT2)
        TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_AMOUNT2}})
        TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
    end
end)

RegisterNetEvent('sulu_chotroi:removeItem')
AddEventHandler('sulu_chotroi:removeItem', function(data)
    -- exports["WaveShield"]:AddEventHandler("sulu_chotroi:removeItem", function(source,data)
    local idJ = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = getIdentifier(idJ)
    local namePlayer = getName(idJ)
    local status     = false
    local result1 = MySQL.Sync.fetchAll('SELECT * FROM market WHERE id = @id',{
        ['@id'] = data.item.id
    })
    if result1[1].identifier ~= identifier then
        TriggerClientEvent('sulu_chotroi:updatePlayerMarket', idJ)
        return
    end
    local amount = tonumber(data.item.amount)
        local item = getFilterItemByLabel(data.item.name)
        
        -- if error here, item not exists
        if not exports.ox_inventory:CanCarryItem(idJ, item.name, amount) then  
       -- if not canCarryItem(idJ, item.name, amount) then
            TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_FULL)
            TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
            TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_FULL}})

            return
        end

        if item then
            local result = MySQL.Sync.execute('DELETE FROM market WHERE id = @id and amount = @amount',{
                ['@id'] = data.item.id,
                ['@amount'] = amount
            })

            -- secutiry var
            local item_var = nil

            for i,k in pairs(itens_market) do
                if k.id == data.item.id then
                    item_var = k
                end
            end

            if result ~= 0 and item_var then
                for i,k in pairs(itens_market) do
                    if k.id == data.item.id then
                        table.remove(itens_market, i)
                    end
                end

                --addInventoryItem(idJ, item.name, amount)
                local slotEmpty = exports.ox_inventory:GetEmptySlot(idJ)
                exports.ox_inventory:AddItem(idJ, item.name, amount, json.decode(result1[1].metadata),slotEmpty )
                TriggerClientEvent('sulu_chotroi:updatePlayerMarket', idJ)
                TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "green", translate.TR_REMOVED_ITEM)
                TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_REMOVED_ITEM}})

                sendWebhook(WEBHOOKS.ADMIN_WEBHOOK, WEBHOOKS.TITLE_REMOVE_ITEM, data.item.name .. " x" .. data.item.amount .. '\n' .. translate.TR_WEBHOOK_OWNER .. namePlayer .. '\n' .. translate.TR_WEBHOOK_LOG_BUY_AMOUNT .. amount .. '\n' .. translate.TR_WEBHOOK_PRICE .. translate.TR_SIMBOL_MONEY .. " " .. data.item.price, WEBHOOKS.COLOR_REMOVE)
            else
                TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_AMOUNT2)
                TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_AMOUNT2}})
                TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
            end
        else
            TriggerClientEvent("sulu_chotroi:marketNotify", idJ, "brown", translate.TR_DONT_AMOUNT2)
            TriggerClientEvent("chat:addMessage", idJ, {args = {translate.TR_DONT_AMOUNT2}})
            TriggerClientEvent("sulu_chotroi:marketRefused", idJ)
        end
end)

RegisterNetEvent('sulu_chotroi:loadMarket')
AddEventHandler('sulu_chotroi:loadMarket', function()
    local idJ = source

    local identifier = getIdentifier(idJ)

    MySQL.Async.fetchAll('SELECT * FROM market ORDER BY price',{
    }, function(result)
        TriggerClientEvent('sulu_chotroi:loadMarket', idJ, identifier, result)
    end)
end)


RegisterNetEvent('sulu_chotroi:loadPlayerMarket')
AddEventHandler('sulu_chotroi:loadPlayerMarket', function()
    local idJ = source
    local identifier = getIdentifier(idJ)
    local itens_filter = filterInventory(idJ)    

    MySQL.Async.fetchAll('SELECT * FROM market WHERE identifier = @identifier ORDER BY price',{
        ['@identifier'] = identifier
    }, function(result)
        TriggerClientEvent('sulu_chotroi:loadPlayerMarket', idJ, itens_filter, result)
    end)
end)
 
function sendWebhook(DISCORD_WEBHOOK, DISCORD_TITLE, message, color)
    local send = {
        {
            ["color"] = color,
            ["title"] = DISCORD_TITLE,
            ["description"] = message,
            ["footer"] = {
                ["text"] = WEBHOOKS.DISCORD_FOOTER,
                ['icon_url'] = WEBHOOKS.DISCORD_FOOTER_IMG
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = send, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('sulu_chotroi:openmenu')
AddEventHandler('sulu_chotroi:openmenu', function()
    local idJ = source
    local identifier = getIdentifier(idJ)
    local itens_filter = filterInventory(idJ) 
    
    MySQL.Async.fetchAll('SELECT * FROM market ORDER BY price',{
    }, function(result)
        TriggerClientEvent('sulu_chotroi:loadPlayerMarket', idJ, itens_filter, result)
        TriggerClientEvent('sulu_chotroi:loadMarket', idJ, identifier, result, list_datacl1, list_datacl2)
    end)
end)