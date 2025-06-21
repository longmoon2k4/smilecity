-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    -- exports["WaveShield"]:AddEventHandler("bank:deposit", function(source, amount)
    local _source = source
    amount = tonumber(amount)
    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        xPlayer.showNotification(_U('invalid_amount'))
    else
        if amount > xPlayer.getMoney() then
            amount = xPlayer.getMoney()
        end
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount), 'Cất tiền')
        sendDiscord('Gửi Tiền', '**Tên: **'.. xPlayer.name ..' \n **Số lượng** : '..tonumber(amount).." ")
    end
end)

RegisterServerEvent('baxcvnk:withdcvxvraw')
AddEventHandler('baxcvnk:withdcvxvraw', function(amount)
    -- exports["WaveShield"]:AddEventHandler("baxcvnk:withdcvxvraw", function(source, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 then
        xPlayer.showNotification(_U('invalid_amount'))
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeAccountMoney('bank', amount, "Rút Tiền Từ Ngân Hàng")
        xPlayer.addAccountMoney('money', amount, 'Rút Tiền Từ Ngân Hàng')
        sendDiscord('Rút Tiền', '**Tên: **'.. xPlayer.name ..' \n **Số lượng** : '..tonumber(amount).." ")
    end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    TriggerClientEvent('currentbalance1', _source, balance)
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    -- exports["WaveShield"]:AddEventHandler("bank:transfer", function(source, to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money
        if xPlayer.source == zPlayer.source then
            TriggerClientEvent('esx:showNotification', source, 'Bạn không thể chuyển giao cho chính mình', 2)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
                TriggerClientEvent('esx:showNotification', source, 'Bạn Không Đủ Tiền', 2)
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt), ("Đã chuyển cho %s số tiền %s"):format(zPlayer.getName(), tonumber(amountt)))
                zPlayer.addAccountMoney('bank', tonumber(amountt), ("Nhận tiền từ %s số tiền %s"):format(xPlayer.getName(), tonumber(amountt)))
                xPlayer.showNotification(("Đã chuyển cho %s số tiền $~y~%s~s~"):format(zPlayer.getName(), tonumber(amountt)))
                zPlayer.showNotification(("Nhận tiền từ %s số tiền $~y~%s~s~"):format(xPlayer.getName(), tonumber(amountt)))
                sendDiscord('Chuyển Tiền ', '**Tên: **'.. zPlayer.name ..' \n **Số lượng** : '..tonumber(amountt)..' \n **Người Nhận** : '..xPlayer.name.." ")
            end
        end
    end
end)
webhookurl = 'https://discord.com/api/webhooks/tatwebhooks/1052057071320834139/nvrKHdRtD809Hu3MyL6W4oG0fxvf6cLVNFkga394cbGdC3_o3trDbKdE3jjlZ5K9A9X-'


 function sendDiscord(name, message)
	local content = {
        {
        	["color"] = '2061822',
            ["title"] = name,
            ["description"] = message.. os.date ("%X") .." - ".. os.date ("%x") .."",
            ["footer"] = {
            ["text"] = "Log "..name.." By Sulu",
            },
        }
    }
  	PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end