--ESX = exports['es_extended']:GetCoreObject()
local Host = ''
local DataDatCuoc = {}
local DataDiceRandom = {}
local already = false
local processbetting = false
local MoneyHost = 0
local player = {}

RegisterNetEvent('ntl_baucua:UpdateHost',function(bool)
    local src = source
    --local xPlayer = ESX.Functions.GetPlayer(src)
    if bool then
        if Host == '' then
            already = true
            Host = src
            for k,v in pairs(player) do
                TriggerClientEvent('ntl_baucua:client:UpdateData',v,src,bool,GetPlayerName(src))
            end
        else
            TriggerClientEvent('esx:showNotification',src,Config.Languages.some_one_hosted)
        end
    else
    
        if Host ~= '' and not processbetting then
            if MoneyHost > 0 then
                --xPlayer.Functions.AddMoney(Config.MoneyType, MoneyHost) 
                exports.ox_inventory:AddItem(src, 'money', MoneyHost)
                TriggerClientEvent('esx:showNotification',src,Config.Languages.refund ..MoneyHost..'$')
            end
            for k,v in pairs(DataDatCuoc) do
                --local Player = ESX.Functions.GetPlayerByCitizenId(v.citizenid)
                --if Player ~= nil then
                    --if Player.Functions.AddMoney(Config.MoneyType,v.amount) then
                    --    TriggerClientEvent('esx:showNotification',Player.PlayerData.source, Config.Languages.refund ..v.amount..'$','primary',5000)
                    --end
                    if exports.ox_inventory:AddItem(v.citizenid, 'money', v.amount) then
                        TriggerClientEvent('esx:showNotification',v.citizenid, Config.Languages.refund ..v.amount..'$')
                    end
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
            already = false
            processbetting = false
            DataDiceRandom = {}
            DataDatCuoc = {}
            Host = ''
            MoneyHost = 0
            Config.Object['lobster'].money = 0
            Config.Object['crab'].money = 0
            Config.Object['fish'].money = 0
            Config.Object['deer'].money = 0
            Config.Object['gourd'].money = 0
            Config.Object['chicken'].money = 0
            
            Config.ObjectInteraction['dice1'].nameObject = ''
            Config.ObjectInteraction['dice2'].nameObject = ''
            Config.ObjectInteraction['dice3'].nameObject = ''
            for kplayer,vplayer in pairs(player) do
                TriggerClientEvent('ntl_baucua:client:refresh',vplayer,Config.Object)
                TriggerClientEvent('ntl_baucua:client:DeleteDice',vplayer,Config.ObjectInteraction)
                TriggerClientEvent('ntl_baucua:sv:CloseAllMenu',vplayer)
                TriggerClientEvent('ntl_baucua:client:UpdateData',vplayer,src,bool)
            end
        else
            TriggerClientEvent('esx:showNotification',src,Config.Languages.error_504)
        end
    end
end)

RegisterNetEvent('ntl_baucua:sv:playerloaded', function()
    local src = source
    if Host ~= '' then
        --local nameHost = ESX.Functions.GetPlayerByCitizenId(Host)
        --TriggerClientEvent('ntl_baucua:client:UpdateData',src,nameHost.PlayerData.source,true,nameHost.PlayerData.charinfo.firstname ..' '..nameHost.PlayerData.charinfo.lastname)
        TriggerClientEvent('ntl_baucua:client:UpdateData',src,Host,true,GetPlayerName(Host))
    end
end)
ESX.RegisterServerCallback('ntl_baucua:spin',function(source,cb)
    --local xPlayer = ESX.Functions.GetPlayer(source)
    local total = 0
    for k,v in pairs(DataDatCuoc) do
        total = total + v.amount
    end
    local res = {}
    if MoneyHost > 0  and total * Config.MinRate <= MoneyHost and total > 0 then   
        local numDice = 3
        local totalDice = 0

        while totalDice < 3 do
            local random = math.random(1,#Config.Dice[1])
            local dice = Config.Dice[1][random]
            table.insert(DataDiceRandom,{
                dice = dice
            })
            totalDice = totalDice + 1
            Citizen.Wait(0)
        end
        res.status = 'success'
        res.data = DataDiceRandom
        cb(res)
    else
        res.status = 'error'
        res.message = Config.Languages.deposit_min..total * Config.MinRate..Config.Languages.deposit_min2
        cb(res)
    end
end)

RegisterNetEvent('ntl_baucua:sv:ProcessDice',function()
    processbetting = true
    local src = source
    --local Player = ESX.Functions.GetPlayer(src)
    
    Config.ObjectInteraction['dice1'].nameObject = Config.Object[DataDiceRandom[1].dice].obj
    Config.ObjectInteraction['dice2'].nameObject = Config.Object[DataDiceRandom[2].dice].obj
    Config.ObjectInteraction['dice3'].nameObject = Config.Object[DataDiceRandom[3].dice].obj
    for kplayer,vplayer in pairs(player) do
        TriggerClientEvent('ntl_baucua:sv:CloseAllMenu',vplayer)
        TriggerClientEvent('ntl_baucua:client:SpawnDice',vplayer,Config.ObjectInteraction)
        TriggerClientEvent('ntl_baucua:displayDice',vplayer,15000,DataDiceRandom)
    end
    local TotalBet = GetTotalBet()

    for k,v in pairs(DataDiceRandom) do
        for k2,v2 in pairs(DataDatCuoc) do
            --local xPlayer = ESX.Functions.GetPlayerByCitizenId(v2.citizenid)
            if v.dice == v2.dice then
                v2.totalwin = v2.totalwin + v2.amount
            end
        end
    end
    for k,v in pairs(DataDatCuoc) do
        --local xPlayer = ESX.Functions.GetPlayerByCitizenId(v.citizenid)
        if v.totalwin > 0 then
            local money = v.totalwin + v.amount
            TotalBet = TotalBet - money
            if exports.ox_inventory:AddItem(v.citizenid, 'money', money*0.95) then
                TriggerClientEvent('esx:showNotification',v.citizenid, Config.Languages.receiver_player ..money..'$')
            end
            --if xPlayer ~= nil then
                --xPlayer.Functions.AddMoney(Config.MoneyType,money)
                --TriggerClientEvent('esx:showNotification',xPlayer.PlayerData.source,Config.Languages.receiver_player ..money..'$','success',5000)
            --else
            --    MySQL.Async.fetchAll("SELECT * FROM players WHERE citizenid = @citizenid",{['@citizenid'] = v.citizenid}, function(result) 
            --        local DataMoney = json.decode(result[1].money)
            --        if Config.MoneyType == 'cash' then 
            --            DataMoney.cash = DataMoney.cash + money
            --        elseif Config.MoneyType == 'bank' then
            --            DataMoney.bank = DataMoney.bank + money                          
            --        end
            --        MySQL.Async.execute('UPDATE players SET `money` = @money WHERE citizenid = @citizenid', {
            --            ['@citizenid'] = v.citizenid,
            --            ['@money'] = json.encode(DataMoney)
            --            
            --        }, function()
            --        end)
            --    end)
            --end
        end
    end
    DataDatCuoc = {}
    DataDiceRandom = {}
    if MoneyHost > 0 then
        local realMoney =  MoneyHost + TotalBet*0.95
        --Player.Functions.AddMoney(Config.MoneyType,realMoney)
        exports.ox_inventory:AddItem(src, 'money', realMoney)
        TriggerClientEvent('esx:showNotification',src,Config.Languages.receiver_host ..realMoney.. Config.Languages.money_host)
        MoneyHost = 0
    end
    Citizen.Wait(Config.TimeStartNewRound * 1000)
    Config.Object['lobster'].money = 0
    Config.Object['crab'].money = 0
    Config.Object['fish'].money = 0
    Config.Object['deer'].money = 0
    Config.Object['gourd'].money = 0
    Config.Object['chicken'].money = 0
    
    Config.ObjectInteraction['dice1'].nameObject = ''
    Config.ObjectInteraction['dice2'].nameObject = ''
    Config.ObjectInteraction['dice3'].nameObject = ''
    for kplayer,vplayer in pairs(player) do
        TriggerClientEvent('ntl_baucua:client:refresh',vplayer,Config.Object)
        TriggerClientEvent('ntl_baucua:client:DeleteDice',vplayer,Config.ObjectInteraction)
    end
    processbetting = false
end)



function GetTotalBet()
    local t = 0
    for k,v in pairs(DataDatCuoc) do
        t = t + v.amount
    end
    return t
end

-- RegisterCommand('randomdice',function()
--     local totalDice = 0

--     while totalDice < 3 do
--         local random = math.random(1,#Config.Dice[1])
--         local dice = Config.Dice[1][random]
--         local found = false
--         for k,v in pairs(DataDiceRandom) do
--             if v.dice == dice then
--                 found = true
--                 break
--             end
--         end
--         if not found then 
--             table.insert(DataDiceRandom,{
--                 dice = dice
--             })
--             totalDice = totalDice + 1
--         end
--         Citizen.Wait(0)
--     end
-- end)
ESX.RegisterServerCallback('ntl_baucua:sv:SetMoneyHost',function(source,cb,data)
    --local xPlayer = ESX.Functions.GetPlayer(source)
    local res = {}
    --if xPlayer.Functions.RemoveMoney(Config.MoneyType, data.amount) and data.amount > 0 then
    if exports.ox_inventory:RemoveItem(source, 'money', data.amount) and data.amount > 0 then
        MoneyHost = MoneyHost + data.amount
        res.status = 'success'
        res.message = Config.Languages.deposit_success
        
    else
        res.status = 'error'
        res.message = Config.Languages.deposit_fail 
    end
    for kplayer,vplayer in pairs(player) do
        TriggerClientEvent('ntl_baucua:client:refresh',vplayer)
    end
    res.money = MoneyHost
    cb(res)
end)
ESX.RegisterServerCallback('ntl_baucua:IsStartedMatch',function(source,cb)
    --local xPlayer = ESX.Functions.GetPlayer(source)
    if not already and processbetting then
        TriggerClientEvent('esx:showNotification',source, Config.Languages.not_yet)
        cb(false)
    end
    if already then
        --local PlayerHost = ESX.Functions.GetPlayerByCitizenId(Host)
        local respon = {
            Host = GetPlayerName(Host),
            money = MoneyHost,
            DataBet = DataDatCuoc,
            --isHost = (Host == xPlayer.PlayerData.citizenid)
            isHost = (Host == source)
        }
        cb(respon)
    end
end)

AddEventHandler('playerDropped', function()
	local src = source
    --local xPlayer = ESX.Functions.GetPlayer(src)
    --if Host ~= '' and xPlayer.PlayerData.citizenid == Host then
    for k,v in pairs(player) do
        if v == src then
            table.remove(player, k)
            break
        end
    end
    if Host ~= '' and src == Host then
        --if MoneyHost > 0  then
        --    MySQL.Async.fetchAll("SELECT * FROM players WHERE citizenid = @citizenid",{['@citizenid'] = xPlayer.PlayerData.citizenid}, function(result) 
        --        local money = json.decode(result[1].money)
        --        if Config.MoneyType == 'cash' then 
        --            money.cash = money.cash + MoneyHost
        --        elseif Config.MoneyType == 'bank' then
        --            money.bank = money.bank + MoneyHost                            
        --        end
        --        MySQL.Async.execute('UPDATE players SET `money` = @money WHERE citizenid = @citizenid', {
        --            ['@citizenid'] = xPlayer.PlayerData.citizenid,
        --            ['@money'] = json.encode(money)
        --            
        --        }, function()
        --        end)
        --    end)  
        --end
        MoneyHost = 0
        Host = ''
        already = false
        processbetting = false
        RefundMoney(DataDatCuoc)
        DataDatCuoc = {}
        DataDiceRandom = {}
        Config.Object['lobster'].money = 0
        Config.Object['crab'].money = 0
        Config.Object['fish'].money = 0
        Config.Object['deer'].money = 0
        Config.Object['gourd'].money = 0
        Config.Object['chicken'].money = 0
        
        Config.ObjectInteraction['dice1'].nameObject = ''
        Config.ObjectInteraction['dice2'].nameObject = ''
        Config.ObjectInteraction['dice3'].nameObject = ''
        for kplayer,vplayer in pairs(player) do
            TriggerClientEvent('ntl_baucua:client:refresh',vplayer,Config.Object)
            TriggerClientEvent('ntl_baucua:client:DeleteDice',vplayer,Config.ObjectInteraction)
            TriggerClientEvent('ntl_baucua:client:UpdateData',vplayer,nil,false)
        end
        
    end
end)
function PutMoneyForDice(Player,data)
    if Config.Object[data.dice] ~= nil then
    --   if Player.PlayerData.money[Config.MoneyType] >= data.money then
        if exports.ox_inventory:Search(Player, 'count', 'money') >= data.money then
            Config.Object[data.dice].money = Config.Object[data.dice].money + data.money
            local found = false
            for k,v in pairs(DataDatCuoc) do
                if v.citizenid == Player and v.dice == data.dice then
                    v.amount = v.amount + data.money
                    found = true
                    break
                end
            end
            if not found then
                table.insert(DataDatCuoc,{
                    citizenid = Player,
                    --name = Player.PlayerData.charinfo.firstname .. ' '..Player.PlayerData.charinfo.lastname,
                    name = GetPlayerName(Player),
                    dice = data.dice,
                    diceLabel =  Config.Object[data.dice].label,
                    amount = data.money,
                    totalwin = 0
                })
            end
            --Player.Functions.RemoveMoney(Config.MoneyType,data.money)
            exports.ox_inventory:RemoveItem(Player, 'money', data.money)
            for kplayer,vplayer in pairs(player) do
                TriggerClientEvent('ntl_baucua:client:refresh',vplayer,Config.Object)
            end
            return true
            -- TriggerClientEvent('esx:showNotification',src,'Cược thành công','success',5000)
        end
    end
end
ESX.RegisterServerCallback('ntl_baucua:CheckIsAlready', function(source, cb, data)
    --local Player = ESX.Functions.GetPlayer(source)
    local res = {}
    if data.money == 0 then
        res.status = 'error'
        res.message = Config.Languages.bet_money
        -- TriggerClientEvent('esx:showNotification',source,'Số tiền cược phải > 0','error',5000)
        cb(res)
        return
    elseif data.money < Config.MoneyBewteen['min'] or data.money > Config.MoneyBewteen['max'] then
        res.status = 'error'
        res.message = Config.Languages.bet_money_min_max
        -- TriggerClientEvent('esx:showNotification',source,'Số tiền tối thiểu [10000,50000]','error',5000)
        cb(res)
        return
    --elseif Player.PlayerData.money[Config.MoneyType] < data.money then
    elseif exports.ox_inventory:Search(source, 'count', 'money') < data.money then
        res.status = 'error'
        res.message = Config.Languages.not_enough_money
        -- TriggerClientEvent('esx:showNotification',source,'Số tiền tối thiểu [10000,50000]','error',5000)
        cb(res)
        return
    end

    --if Host ~= '' and Host ~= Player.PlayerData.citizenid then
    if Host ~= '' and Host ~= source then
        --if PutMoneyForDice(Player,data) then
        if PutMoneyForDice(source,data) then
            res.status = 'success'
            res.message = Config.Languages.bet_success..data.money..'$'
            cb(res)
            return
        end
    else
        res.status = 'error'
        res.message = Config.Languages.cant_bet
        cb(res)
        return
    end
    -- cb(false)
end)

RegisterNetEvent('ntl_baucua:sv:joinPlay',function()
    local _source = source
    table.insert(player, _source)
    if already then
        TriggerClientEvent('ntl_baucua:client:refresh',_source,Config.Object)
        TriggerClientEvent('ntl_baucua:client:UpdateData',_source,Host,true,GetPlayerName(Host))
    end
end)

RegisterNetEvent('ntl_baucua:sv:leftPlay',function()
    local _source = source
    for k,v in pairs(player) do
        if v == _source then
            table.remove(player, k)
            break
        end
    end
end)