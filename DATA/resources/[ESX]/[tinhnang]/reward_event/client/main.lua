display = false
premiumAble = 0
--ESX = nil
playerData = nil

--Citizen.CreateThread(function()
--    while ESX == nil do
--        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--        Citizen.Wait(10)
--    end
--end)

RegisterCommand("event", function(source, args)
    SetDisplay(not display)
end)

RegisterNetEvent('reward_event:openUI')
AddEventHandler('reward_event:openUI', function ()
    SetDisplay(not display)
end)

RegisterNetEvent('reward_event:senddata')
AddEventHandler('reward_event:senddata', function (data)
    playerData = data
    UpdateData()
end)

RegisterNetEvent('reward_event:updateitem')
AddEventHandler('reward_event:updateitem', function (item, mainCount, dailyCount)

    if playerData == nil then 

        TriggerServerEvent("reward_event:getdata")

        while playerData == nil do 
            Wait(10)
        end    

    else 
        playerData.mainData.items[item] = mainCount
        playerData.dailyData.items[item] = dailyCount
    end

    UpdateData()
end)

RegisterNetEvent('reward_event:premium')
AddEventHandler('reward_event:premium', function ()
    playerData.premium = 1
    UpdateData()
    ESX.ShowNotification("Chúc mừng bạn đã được ~g~ kích hoạt ~w~ gói ~b~ Premium Pass Event~w~")
end)



RegisterNUICallback("rewardItem",function(data)
 
    local type = data.type
    local level = tonumber(data.level)
    local currentLevel = GetLevelFromXp(playerData.point)
   
    if  (currentLevel < level) then 
        SendMessage("Không đủ level để có thể nhận phần thưởng này.")
        return 
    end

    if   (not Config.Events[level][type] or not Config.Events[level][type].item)  then 
        SendMessage("Hành động không hợp lệ.")
        return 
    end


    if  IsInclude(playerData.mainData.itemrewarded, {type = type , level = level})  then 
        SendMessage("Bạn đã nhận phần thưởng này rồi.")
        return 
    end
            

    ESX.TriggerServerCallback("reward_event:rewardItem", function (response, crypto)
        SendMessage(response)
        ShowPyro(crypto)
    end ,type, level)
end)


RegisterNUICallback("rewardMision",function(data)
 
    local mission = tonumber(data.mission)
    local rank   = tonumber(data.rank)
    local currentLevel = GetLevelFromXp(playerData.point)
    
    if  not Config.Missions[mission] or not  Config.Missions[mission].data[rank] then 
        SendMessage("Hành động không hợp lệ.")
        return 
    end
    
    if  Config.Missions[mission].data[rank].level > currentLevel  then
        SendMessage("Không đủ level để có thể nhận điểm nhiệm vụ này.")
        return 
    end

    print(Config.Missions[mission].data[rank].level, currentLevel) 


    if IsInclude(playerData.mainData.missionrewarded, {mission = mission , rank = rank})  then 
        SendMessage("Bạn đã nhận điểm nhiệm vụ này rồi.")
        return 
    end

    local missionData = Config.Missions[mission]
    local itemHasCount = playerData.mainData.items[missionData.item]
    local itemRequireCount = missionData.data[rank].count

    if  itemRequireCount > itemHasCount  then 
        SendMessage("Bạn phải hoàn thành đủ số lượng thì mới có thể nhận điểm.")
        return
    end
    
    
    ESX.TriggerServerCallback("reward_event:rewardMision", function (response, crypto)
        SendMessage(response)
        ShowPyro(crypto)
    end, mission, rank)

end)

RegisterNUICallback("rewardMisionDaily",function(data)
 
    local mission = tonumber(data.mission)
    local rank   = tonumber(data.rank)


    if  (not Config.Missions[mission] or not  Config.Missions[mission].data[rank]) or
        not IsInclude(playerData.dailyData.missiondata, {mission = mission , rank = rank}) then 
        SendMessage("Hành động không hợp lệ.")
        return 
    end

    if  IsInclude(playerData.dailyData.missionrewarded, {mission = mission , rank = rank})  then 
        SendMessage("Bạn đã nhận điểm nhiệm vụ này rồi.")
        return 
    end


    local missionData = Config.Missions[mission]
    local itemHasCount = playerData.dailyData.items[missionData.item]
    local itemRequireCount = missionData.data[rank].count

    
    if rank > 1 then 
        itemRequireCount = itemRequireCount - missionData.data[rank-1].count
    end

    if  itemRequireCount > itemHasCount  then 
        SendMessage("Bạn phải hoàn thành đủ số lượng thì mới có thể nhận điểm.")
        return
    end
    
    ESX.TriggerServerCallback("reward_event:rewardMisionDaily", function (response, crypto)
        SendMessage(response)
        ShowPyro(crypto)
    end, mission, rank)

end)






RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("getTopPlayers", function(data)
    ESX.TriggerServerCallback("reward_event:getTopPlayers", function(topPlayers)
        UpdateTopPlayers(topPlayers)
    end)
end)


-- Bật nếu Muốn mở bằng Hotkey

-- Citizen.CreateThread(function()
  
--     while true do 
--         if IsControlJustReleased(0, 51) then 
--             SetDisplay(not display)
--         end
--         Citizen.Wait(0)
--     end

-- end)



--Citizen.CreateThread(function()
--    while display do
--        Citizen.Wait(0)
--        DisableControlAction(0, 1, display) -- LookLeftRight
--        DisableControlAction(0, 2, display) -- LookUpDown
--        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
--        DisableControlAction(0, 18, display) -- Enter
--        DisableControlAction(0, 322, display) -- ESC
--        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
--    end
--end)

TriggerServerEvent("reward_event:getdata")

