

-------------------------------------------------------------------------------
-- ESX
-------------------------------------------------------------------------------
-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------------------------------------------------------------------------
-- Get Money / Remove money
-------------------------------------------------------------------------------
RegisterServerEvent('sawu_hookers:pay')
AddEventHandler('sawu_hookers:pay', function(boolean)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local xPlayers  = ESX.GetPlayers()

    if (boolean == true) then
        if xPlayer.getMoney() >= Config.BlowjobPrice then
            xPlayer.removeMoney(Config.BlowjobPrice)
            TriggerClientEvent('sawu_hookers:startBlowjob', _source)
            TriggerClientEvent('esx:showNotification', _source, 'Bạn đã trả tiền: ' .. Config.BlowjobPrice ..' $')
            -- this adds money to society_nightclub
            if Config.SocietyNightclub then
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
                    account.addMoney(Config.BlowjobPrice)
                end)
            end
        else
            TriggerClientEvent('esx:showNotification', _source,  'Bạn không có đủ tiền' )
            TriggerClientEvent('sawu_hookers:noMoney', _source)
        end  
    else
        if xPlayer.getMoney() >= Config.SexPrice then
            xPlayer.removeMoney(Config.SexPrice)
            TriggerClientEvent('sawu_hookers:startSex', _source)
            TriggerClientEvent('esx:showNotification', _source, 'Bạn đã trả tiền: ' .. Config.SexPrice ..' $' )
            -- this adds money to society_nightclub
            if Config.SocietyNightclub then
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
                    account.addMoney(Config.SexPrice)
                end)
            end
        else
            TriggerClientEvent('esx:showNotification', _source, 'Bạn không có đủ tiền' )
            TriggerClientEvent('sawu_hookers:noMoney', _source)
        end 
    end
end)




