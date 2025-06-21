-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('esx_langbam:getItemAmount', function(source, cb, item)
	local _source = source
	local quantity = exports.ox_inventory:Search(source, 'count', item)
	cb(quantity)
end)

RegisterServerEvent('esx_langbam:revive')
AddEventHandler('esx_langbam:revive', function(target)
-- exports["WaveShield"]:AddEventHandler("esx_langbam:revive", function(source,target)
    TriggerClientEvent('esx_ambulancejob:revive', target)
end)

RegisterServerEvent('esx_langbam:removeItem')
AddEventHandler('esx_langbam:removeItem', function(target)
    local _source = source
    -- local xPlayer = ESX.GetPlayerFromId(_source)
    exports.ox_inventory:RemoveItem(_source, 'medlangbam', 1)
end)

-- ESX.RegisterUsableItem('medlangbam', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)

--     TriggerClientEvent('esx_langbam:hoisinh', source)
-- end)

-- ESX.RegisterUsableItem('clip', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	xPlayer.removeInventoryItem('clip', 1)
-- 	TriggerClientEvent('esx_weashop:clip', source)
-- end)

-- ESX.RegisterUsableItem('giapnhe', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     xPlayer.removeInventoryItem('giapnhe', 1)
--     TriggerClientEvent('nfw_wep:HeavyArmor', source, 'giapnhe')
-- end)

-- ESX.RegisterUsableItem('giapnang', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     xPlayer.removeInventoryItem('giapnang', 1)
--     TriggerClientEvent('nfw_wep:HeavyArmor', source, 'giapnang')
-- end)

-- ESX.RegisterUsableItem('giapcs', function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     if xPlayer.job.name == 'police' then
--         xPlayer.removeInventoryItem('giapcs', 1)
--         TriggerClientEvent('nfw_wep:HeavyArmor', source, 'giapcs')
--     else
--         TriggerClientEvent('esx:showNotification', source, 'Bạn không phải là cs')
--     end
-- end)

RegisterNetEvent('returnItem')
AddEventHandler('returnItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, 1)
end)

ESX.RegisterServerCallback('esx_langbam:laycode', function(source, cb)
    local _source = source
    local code = [[
  
    ]]
    cb(code)
end)