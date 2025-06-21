-- ESX = nil
list_datasv = {}
list_datacl1 = {}
list_datacl2 = {}


CreateThread(function()
    while GetResourceState('ox_inventory') ~= 'started' do
        Citizen.Wait(0)
    end
    local ItemList = exports.ox_inventory:Items()
    list_datasv = {}
       -- for i=1, #ItemList, 1 do
            for k,v in pairs(ItemList) do    
            table.insert(list_datasv, {name = v.name, label = v.label, img = "nui://esx_inventoryhud/html/img/items/"..v.name..".png", price_recommended = 100})
        end
        list_datacl1 = ItemList
end) 

-- Creating a table and taking the ESX object
MySQL.ready(function ()
    -- MySQL.Async.execute("CREATE TABLE IF NOT EXISTS market(id int AUTO_INCREMENT, name varchar(100), amount int DEFAULT 1, weight varchar(10) DEFAULT '0', price varchar(10), owner varchar(100), identifier varchar(200), PRIMARY KEY(id))", {},
    -- function()
        MySQL.Async.fetchAll('SELECT * FROM market', {}, function(result)
            itens_market = result
        end)
    -- end)        

    -- while ESX == nil do
    --     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --     Wait(100)
    -- end    
end)  
local cachePlayer ={}
-- This function will return the player's identifier (identifier or id)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if cachePlayer[playerId] ~= nil then
        cachePlayer[playerId] = nil
    end
end)

function getIdentifier(source)
--    local xPlayer = ESX.GetPlayerFromId(source)
--
--    if xPlayer then
--        return xPlayer.identifier
--    end

    if cachePlayer[source] then
		return cachePlayer[source]
	end
	cachePlayer[source] = ESX.GetPlayerFromId(source).identifier
	return cachePlayer[source]
end

-- This function will return the Player Name
function getName(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        return xPlayer.getName()
    end    
end

-- This function will return the amount of money in the player's bank account
function getBankMoney(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        return xPlayer.getAccount('bank').money
    end  
end

-- This function will add money to the player's bank account
function addBankMoney(identifier, value)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        xPlayer.addAccountMoney('bank', value)
    else
        local result = MySQL.Sync.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', { 
            ["@identifier"] = identifier 
        })
        
        if result[1] ~= nil then
            local account = json.decode(result[1].accounts)
    
            account.bank = account.bank + value
    
            MySQL.Sync.execute("UPDATE users SET accounts = @account WHERE identifier = @identifier",{
                ["@identifier"] = identifier,
                ["@account"] = json.encode(account)
            })
        end
    end 
end

-- This function will remove money from the player's bank account
function removeBankMoney(source, value)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        xPlayer.removeAccountMoney('bank', value)
    end 
end

-- This function will return TRUE if the player has enough space in his inventory
function canCarryItem(source, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        return xPlayer.canCarryItem(item, amount)
    end    
end

-- This function will return the player's inventory
function getInventory(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        return xPlayer.getInventory()
    end
end

-- This function will add an item to the player's inventory
function addInventoryItem(source, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        xPlayer.addInventoryItem(item, amount)
    end 
end

-- This function will remove an item from the player's inventory
function removeInventoryItem(source, item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        xPlayer.removeInventoryItem(item, amount)
    end 
end
--xPlayer.getLoadout()
-- This function is a helper of the graphical interface.
-- Responsible for filtering the items allowed for sale.
function filterInventory(source)
    --local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = exports.ox_inventory:GetInventoryItems(source)
   -- local weapon    = xPlayer.getLoadout()
    local itens_filter = {}
    -- for i=1, #weapon, 1 do
    --     table.insert(itens_filter, {
    --         name   = weapon[i].name,
    --         amount = 1,
    --         weight = 0
    --     })
    -- end
    for i,k in pairs(inventory) do
        for j,c in pairs(list_datasv) do
            if k.name == c.name then
                if k.count > 0 then
                  
                    table.insert(itens_filter, {
                        name = c.label,
                        amount = k.count,
                        weight = k.weight
                    })
                end
            end
        end
    end

    return itens_filter
end
--hasWeapon

-- This function is a helper of the graphical interface.
-- Responsible for returning the Label of an item from the player's inventory.
function getItemByLabel(source, label)
    local inventory = exports.ox_inventory:GetInventoryItems(source)
    for i,k in pairs(inventory) do
        if k.label == label then
            return k
        end
    end
end

-- This function is a helper of the graphical interface.
-- Responsible for returning the Label of an item from the list_products variable
function getFilterItemByLabel(label)
    for i,k in pairs(list_datasv) do
        if k.label == label then
            return k
        end
    end
end
