local cachePlayer ={}

function getId(src)
	if cachePlayer[src] then
		return cachePlayer[src]
	end
	cachePlayer[src] = ESX.GetPlayerFromId(src).identifier
	return cachePlayer[src]
end

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if cachePlayer[playerId] ~= nil then
        cachePlayer[playerId] = nil
    end
end)

ESX.RegisterServerCallback("sulu_keycar:getData", function(source, cb)
	local identifier = getId(source)
    local plate = {}
    local trim 
	MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner', {
        ['@owner']  = identifier,
    }, function(data)
        for k,v in pairs(data) do 
            trim = string.gsub(v.plate, "%s+", "")
            table.insert(plate,trim)
        end
        cb(plate)
    end)
end)

ESX.RegisterServerCallback("sulu_keycar:checkKey", function(source, cb, plate)
	local identifier = getId(source)
    local newPlate = plate:sub(1, 3)..' '..plate:sub(4, 6)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner and plate = @plate', {
        ['@owner']  = identifier,
        ['@plate']  = newPlate,
    }, function(data)
        if data[1] == nil then
            cb(false)
        else
            cb(true)
        end
    end)
end)


RegisterServerEvent("sulu_keycar:giveKey")
AddEventHandler("sulu_keycar:giveKey", function(target,plate)
    local source = source
    local identifier = getId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner and plate = @plate', {
        ['@owner']  = identifier,
        ['@plate']  = plate,
    }, function(data)
        if data[1] == nil then
            TriggerClientEvent('esx:showNotification',source, '~r~Không phải xe của bạn' )
        else
            if GetPlayerName(target) ~= nil then
                TriggerClientEvent('esx:showNotification',source, '~g~Đã đưa chìa khóa xe '..plate..' cho '..GetPlayerName(target))
                TriggerClientEvent('sulu_keycar:acceptData',target, string.gsub(plate, "%s+", ""))
            else
                TriggerClientEvent('esx:showNotification',source, '~r~Người chơi không online' )
            end
        end
    end)
end)

RegisterServerEvent("sulu_keycar:renderKey")
AddEventHandler("sulu_keycar:renderKey", function(slot,plate)
    local source = source
    local identifier = getId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner and plate = @plate', {
        ['@owner']  = identifier,
        ['@plate']  = plate,
    }, function(data)
        if data[1] == nil then
            TriggerClientEvent('esx:showNotification',source, '~r~Không phải xe của bạn' )
        else
            local itemSlot = exports.ox_inventory:GetSlot(source, slot)
            itemSlot.metadata.key = plate
            itemSlot.metadata.having = true 
            exports.ox_inventory:SetMetadata(source, slot, itemSlot.metadata)
            TriggerClientEvent('esx:showNotification',source, '~g~Tạo chìa khóa thành công' )
        end
    end)
end)

RegisterCommand('givekey', function(source,args, rawCommand)
	if tonumber(args[1]) ~= nil then
        TriggerClientEvent('sulu_keycar:getPlate', source,tonumber(args[1]) )
    else
        TriggerClientEvent('esx:showNotification',source, '~r~Nhập id người nhận' )
    end
end, false)

exports('keycar', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
        if itemSlot.metadata.having == false then
            TriggerClientEvent('sulu_keycar:copyKey', inventory.id,tonumber(slot) )
        else
            TriggerClientEvent('esx:showNotification',inventory.id, 'Bạn có thể lái được có biển số :~g~'..itemSlot.metadata.key )
            TriggerClientEvent('sulu_keycar:acceptData',inventory.id, string.gsub(itemSlot.metadata.key, "%s+", ""))
        end
    end
end)

local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
    if payload.fromSlot.metadata.having == true then
        -- local identifier = getId(payload.source)
        -- local response = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner =  ?', {
        --     identifier
        -- })
        -- if response[1] == nil then
            TriggerClientEvent('sulu_keycar:removeKey', payload.source,string.gsub(payload.fromSlot.metadata.key, "%s+", ""))
        -- end
    end
    return true
end, {
    print = false,
    itemFilter = {
        keycar = true,
    },
})

local hookIdCreate = exports.ox_inventory:registerHook('createItem', function(payload)
    local metadata = payload.metadata
    if metadata.having == nil then
        metadata.having = false
        metadata.key = 'Chìa khóa zin'
    end
    return metadata
end, {
    itemFilter = {
        keycar = true
    }
})