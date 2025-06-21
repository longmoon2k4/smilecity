--ESX = nil
currentDate = os.date("*t").day
playersData = {}
topPlayers = nil

--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
Citizen.CreateThread(function()

   --while ESX == nil do
   --    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   --    Citizen.Wait(10)
   --end


   while true do    
    --    LoadTopPlayers()
       if currentDate ~= os.date("*t").day then 
           UpdateDailyMissons()
           currentDate = os.date("*t").day
       end
       Citizen.Wait(30000)
   end
end)


--while ESX == nil do
--    Wait(10)
--end

-- RegisterCommand('add' , function(source , args)
--     if #args ~= 2 then return end
--     AddItemCount(source , args[1], tonumber(args[2]))
-- end)
-- lib.cron.new('55 08 * * *', function()
--     UpdateDailyMissons()
-- end)

-- function Tick()
--     local timestamp = os.time()
--     local h         = tonumber(os.date('%H', timestamp))
--     local m         = tonumber(os.date('%M', timestamp))
--     if h == 08 and m == 55 then
--     	UpdateDailyMissons()
--     end
--     SetTimeout(30000, Tick)
-- end

-- Tick()

AddEventHandler('esx:playerDropped', function(playerId, reason)
    SavePlayerData(playerId)
end)


AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    LoadPlayerData(playerId) 
end)

RegisterServerEvent('reward_event:getdata')
AddEventHandler('reward_event:getdata', function()
    TriggerClientEvent('reward_event:senddata', source , GetPlayerData(source))
end)


--TriggerEvent('reward_event:additem', xPlayer.source , "gold", 2)	 

AddEventHandler('reward_event:premiumable', function(playerId)
    PremiumAblePlayer(playerId)
end)


AddEventHandler('reward_event:additem', function(playerId, item ,count)
    AddItemCount(playerId, item ,count)
end)



ESX.RegisterServerCallback('reward_event:rewardItem', function(playerId,cb,type,level)
    local playerData = GetPlayerData(playerId)

    if playerData == nil then 
        cb("Có lỗi xảy ra.", false)
        return 
    end
    
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local currentLevel = GetLevelFromXp(playerData.point)
  
    if  (currentLevel < level) then 
        cb("Không đủ level để có thể nhận phần thưởng này.", false)
        return 
    end

    if   (not Config.Events[level][type] or not Config.Events[level][type].item)  then 
        cb("Hành động không hợp lệ.", false)
        return 
    end

    if  IsInclude(playerData.mainData.itemrewarded, {type = type , level = level})  then 
        cb("Bạn đã nhận phần thưởng này rồi.", false)
        return 
    end

    local itemName  = Config.Events[level][type].item
    local itemCount = Config.Events[level][type].count
    local itemLabel = ESX.GetItemLabel(itemName)

    table.insert(playersData['id:'..playerId].mainData.itemrewarded,{type = type , level = level})

    TriggerClientEvent('reward_event:senddata', playerId , GetPlayerData(playerId))
    
    SendDiscordMessage("**"..xPlayer.name.."("..xPlayer.identifier..")** đã nhận phần thưởng ***"..itemCount.."x "..itemName.."*** (`"..type.." level "..level.."`).")

    if itemName == 'money' then
        xPlayer.addMoney(itemCount)   
        cb("Chúc mừng bạn đã nhận được "..itemCount.."$ ." , true)
    elseif itemName == 'black_money' then
        xPlayer.addAccountMoney('black_money', itemCount)
        cb("Chúc mừng bạn đã nhận được "..itemCount.."$ tiền bẩn." , true)
    else
        xPlayer.addInventoryItem(itemName , itemCount)
        cb("Chúc mừng bạn đã nhận được "..itemCount.."x "..itemLabel.."." , true)
    end

end)


ESX.RegisterServerCallback('reward_event:rewardMision', function(playerId,cb,mission,rank)

    local playerData = GetPlayerData(playerId)

    if playerData == nil then 
        cb("Có lỗi xảy ra.", false)
        return 
    end


    local currentLevel = GetLevelFromXp(playerData.point)
   

    if  (not Config.Missions[mission] or not  Config.Missions[mission].data[rank])  then 
        cb("Hành động không hợp lệ.", false)
        return 
    end

    if  (Config.Missions[mission].data[rank].level > currentLevel) then 
        cb("Không đủ level để có thể nhận điểm nhiệm vụ này.", false)
        return 
    end


    if  IsInclude(playerData.mainData.itemrewarded, {type = type , level = level})  then 
        cb("Bạn đã nhận điểm nhiệm vụ này rồi.", false)
        return 
    end
    
    local missionData = Config.Missions[mission]
    local itemHasCount = playerData.mainData.items[missionData.item]
    local itemRequireCount = missionData.data[rank].count

    if  itemRequireCount > itemHasCount  then 
        cb("Bạn phải hoàn thành đủ số lượng thì mới có thể nhận điểm.", false)
        return
    end

    RewardMission('main', playerId, mission, rank, cb)
end)


ESX.RegisterServerCallback('reward_event:rewardMisionDaily', function(playerId,cb,mission,rank)
    local playerData = GetPlayerData(playerId)

    if playerData == nil then 
        cb("Có lỗi xảy ra.", false)
        return 
    end

    if  (not Config.Missions[mission] or not  Config.Missions[mission].data[rank]) or
        not IsInclude(playerData.dailyData.missiondata, {mission = mission , rank = rank}) then 
        cb("Hành động không hợp lệ.", false)
        return 
    end

    if  (IsInclude(playerData.dailyData.missionrewarded, {mission = mission , rank = rank}))  then 
        cb("Bạn đã nhận điểm nhiệm vụ này rồi.", false)
        return 
    end

    local missionData = Config.Missions[mission]
    local itemHasCount = playerData.dailyData.items[missionData.item]
    local itemRequireCount = missionData.data[rank].count

    if rank > 1 then 
        itemRequireCount = itemRequireCount - missionData.data[rank-1].count
    end

    if  itemRequireCount > itemHasCount  then 
        SendMessage("Bạn phải hoàn thành đủ số lượng thì mới có thể nhận điểm.", false)
        return
    end

    RewardMission('daily',playerId, mission, rank, cb)
end)


ESX.RegisterServerCallback('reward_event:getTopPlayers', function(playerId, cb)
--    while topPlayers == nil do
--        Wait(100)
--    end
--
--    cb(topPlayers)
MySQL.Async.fetchAll("SELECT `identifier`, `name`, `eventpoint`, `eventtime`  FROM `users` ORDER BY `eventpoint` DESC, `eventtime` LIMIT 40;", {},
    function(result)
            local index = 1
            local data = {}
            while index <= 20 and result[index] ~= nil and result[index].eventpoint ~= 0 and result[index].eventtime ~= 0 do
                table.insert(data, { name = result[index].name, point = result[index].eventpoint } )
                index = index + 1
            end

            cb(data)
    end)
end)


