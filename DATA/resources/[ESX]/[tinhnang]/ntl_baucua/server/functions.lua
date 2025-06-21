function RefundMoney(data)
    for k,v in pairs(data) do
        if exports.ox_inventory:AddItem(v.citizenid, 'money', v.amount) then
            TriggerClientEvent('esx:showNotification',v.citizenid,'Bạn đã nhận được tiền hoàn '..v.amount..'$')
        end
        --local Player = QBCore.Functions.GetPlayerByCitizenId(v.citizenid)
        --if Player ~= nil then
        --    Player.Functions.AddMoney(Config.MoneyType,v.amount)
        --    TriggerClientEvent('QBCore:Notify',Player.PlayerData.source,'Bạn đã nhận được tiền hoàn '..v.amount..'$','success',5000)
        --else
        --    MySQL.Async.fetchAll("SELECT * FROM players WHERE citizenid = @citizenid",{['@citizenid'] = v.citizenid}, function(result) 
        --        local money = json.decode(result[1].money)
        --        if Config.MoneyType == 'cash' then 
        --            money.cash = money.cash + v.amount
        --        elseif Config.MoneyType == 'bank' then
        --            money.bank = money.bank + v.amount                            
        --        end
        --        MySQL.Async.execute('UPDATE players SET `money` = @money WHERE citizenid = @citizenid', {
        --            ['@citizenid'] = v.citizenid,
        --            ['@money'] = json.encode(money)
        --            
        --        }, function()
        --        end)
        --    end)
        --end
    end
end