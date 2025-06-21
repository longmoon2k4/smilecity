-- -- Bandage
-- ESX.RegisterUsableItem('bandage', function(source)
--     exports.ox_inventory:RemoveItem(source, 'bandage', 1)
--     TriggerClientEvent('sulu_item:bandage',source)
-- end)

-- ESX.RegisterUsableItem('armor', function(source)
--     exports.ox_inventory:RemoveItem(source, 'armor', 1)
--     TriggerClientEvent('sulu_item:armor',source)
-- end)

-- ESX.RegisterUsableItem('binoculars', function(source)
--     TriggerClientEvent('sulu_item:binoculars',source)
-- end)

-- ESX.RegisterUsableItem('oxygenmask', function(source)
--     exports.ox_inventory:RemoveItem(source, 'oxygenmask', 1)
--     TriggerClientEvent('sulu_item:oxygenmask',source)
-- end)

ESX.RegisterUsableItem('bosuasung', function(source)
    local ox_inventory = exports.ox_inventory

    -- Set the durability of the source player's current weapon to 100
    local weapon = ox_inventory:GetCurrentWeapon(source)

    if weapon ~= nil then
        ox_inventory:SetDurability(source, weapon.slot, 100)
        ox_inventory:RemoveItem(source,'bosuasung', 1)
        TriggerClientEvent('esx:showNotification', source,"Súng của bạn đã được sửa!")
    else
        TriggerClientEvent('esx:showNotification', source,"~r~Bạn phải cầm súng trên tay")
    end
end)

ESX.RegisterUsableItem('bosuasungnganh', function(source)
    local ox_inventory = exports.ox_inventory

    -- Set the durability of the source player's current weapon to 100
    local weapon = ox_inventory:GetCurrentWeapon(source)

    if weapon ~= nil then
        if weapon.name == 'WEAPON_CARBINERIFLE' then
            ox_inventory:SetDurability(source, weapon.slot, 100)
            ox_inventory:RemoveItem(source,'bosuasungnganh', 1)
            TriggerClientEvent('esx:showNotification', source,"Súng của bạn đã được sửa!")
        else
            TriggerClientEvent('esx:showNotification', source,"Chỉ sửa được súng ngành!")
        end
    else
        TriggerClientEvent('esx:showNotification', source,"~r~Bạn phải cầm súng trên tay")
    end
end)

RegisterServerEvent('sulu_item:bosuasung')
AddEventHandler('sulu_item:bosuasung', function()
    local ox_inventory = exports.ox_inventory

    -- Set the durability of the source player's current weapon to 100
    local weapon = ox_inventory:GetCurrentWeapon(source)

    if weapon then
        ox_inventory:SetDurability(source, weapon.slot, 100)
        TriggerClientEvent('esx:showNotification', source,"Súng của bạn đã được sửa!")
    else
        TriggerClientEvent('esx:showNotification', source,"~r~Bạn phải cầm súng trên tay")
    end
end)

RegisterServerEvent('sulu_item:balo')
AddEventHandler('sulu_item:balo', function()
    local ox_inventory = exports.ox_inventory
 
    -- Set the max weight for player 1's inventory to 20kg.
    -- ox_inventory:SetMaxWeight(source, 250000)
    local inventory = exports.ox_inventory:GetInventory(source, false)
    if ox_inventory:Search(source, 'count', 'balo') >= 1 then
        if inventory.maxWeight==100000 then
            ox_inventory:SetMaxWeight(source, 150000)
        else
            ox_inventory:SetMaxWeight(source, 100000)
        end  
    end
end)

RegisterServerEvent('sulu_item:checkBalo')
AddEventHandler('sulu_item:checkBalo', function()
    local ox_inventory = exports.ox_inventory
    --if ox_inventory:Search(source, 'count', 'balo') == 0 then
        ox_inventory:SetMaxWeight(source, 100000)
        TriggerClientEvent('sulu_item:refreshBalo',source,false)
    --end
end)

RegisterServerEvent('sulu_item:loadBalo')
AddEventHandler('sulu_item:loadBalo', function()
    local ox_inventory = exports.ox_inventory
    if ox_inventory:Search(source, 'count', 'balo') >= 1 then
        ox_inventory:SetMaxWeight(source, 150000)
        TriggerClientEvent('sulu_item:refreshBalo',source,true)
    end
end)

local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
    -- print(json.encode(payload, { indent = true }))
    TriggerClientEvent('sulu_item:checkBalo', payload.source)
    return true
end, {
    print = false,
    itemFilter = {
        balo = true,
    },
    --inventoryFilter = {
    --    '^police',
    --}
})