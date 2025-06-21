-- ESX = nil
random = {
    [1] = {x=-1665.16, y=-1083.85, z=12.15},
    [2] = {x=-1674.58, y=-1170.29, z=12.02},
    [3] = {x=-1700.93, y=-1127.82, z=12.15},
    [4] = {x=-1711.21, y=-1130.45, z=12.16},
    [5] = {x=-1711.64, y=-1110.28, z=12.15},
    [6] = {x=-1677.95, y=-1095.97, z=12.15},
    [7] = {x=-1624.8, y=-1097.71, z=12.02},
    [8] = {x=-1612.97, y=-1027.67, z=12.15},
    [9] = {x=-1599.84, y=-1058.78, z=12.02},
    [10] = {x=-1636.9, y=-1029.92, z=12.15},
    [11] = {x=-1663.92, y=-1007.99, z=6.38},
    [12] = {x=-1719.36, y=-1013.83, z=4.3},
    [13] = {x=-1674.08, y=-1012.95, z=6.38},
    [14] = {x=-1674.08, y=-1012.95, z=6.38},
}
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ListJoin = {}

RegisterServerEvent('nonrp:revive')
AddEventHandler('nonrp:revive', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeAccountMoney('bank',1000)
    TriggerClientEvent('bringNonrp', source,random[math.random(1,14)] )
   -- Wait(500)
    TriggerClientEvent('esx_ambulancejob:revive', source)
   
    TriggerClientEvent('healNonrp', source)
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Bạn đã bị trừ 1000$")
end)

RegisterServerEvent('nonrp:join')
AddEventHandler('nonrp:join',function()
    local _source = source
    local check = false
    if #ListJoin > 0 then
        for k,v in ipairs(ListJoin) do
            if v.id == _source then
                check = true
            end
        end
    end
    if not check then
        table.insert(ListJoin,{id = _source, name = GetPlayerName(_source), diem = 0})
        table.sort(ListJoin, function (k1, k2) return k1.diem > k2.diem end )
        TriggerClientEvent('nonrp:setList', _source, ListJoin)
    end
end)

RegisterServerEvent('nonrp:out')
AddEventHandler('nonrp:out',function()
    local _source = source
    for k,v in ipairs(ListJoin) do
        if v.id == _source then
            table.remove(ListJoin, k)
        end
    end
    table.sort(ListJoin, function (k1, k2) return k1.diem > k2.diem end )
end)

AddEventHandler('playerDropped', function()
    local _source = source
    for k,v in ipairs(ListJoin) do
        if v.id == _source then
            table.remove(ListJoin, k)
        end
    end
    table.sort(ListJoin, function (k1, k2) return k1.diem > k2.diem end )
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath',function(killer)
    local _source = source
    if killer.killedByPlayer == true then
        for k,v in ipairs(ListJoin) do
            if v.id == killer.killerServerId then
                TriggerClientEvent('healNonrp', killer.killerServerId)
                v.diem =  v.diem + 2
            end
            if v.id == _source then
                if v.diem > 0 then
                    v.diem = v.diem - 1
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4000)
        table.sort(ListJoin, function (k1, k2) return k1.diem > k2.diem end)
        for k,v in ipairs(ListJoin) do
            TriggerClientEvent('nonrp:setList', v.id, ListJoin)
        end
    end
end)
