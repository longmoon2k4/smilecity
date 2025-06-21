ESX.RegisterUsableItem('premium_pass', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
    local playerData = GetPlayerData(playerId)

    if playerData == nil then 
        -- xPlayer.ShowNotification("Có lỗi xảy ra vui lòng thử lại.")
        TriggerClientEvent('esx:showNotification', playerId, "Có lỗi xảy ra vui lòng thử lại.")
        return
    end
    
    if xPlayer.getInventoryItem('premium_pass').count < 1 then 
        TriggerClientEvent('esx:showNotification', playerId, "Bạn không sở hữu Premium Event Pass.")
        -- xPlayer.ShowNotification("Bạn không sở hữu Premium Event Pass.")
        return
    end

    if playerData.premium == 1 then 
        TriggerClientEvent('esx:showNotification', playerId, "Bạn đã kích hoạt Premium từ trước.")
        -- xPlayer.ShowNotification("Bạn đã kích hoạt Premium từ trước.")
        return
    end

	xPlayer.removeInventoryItem('premium_pass', 1)

    TriggerEvent("reward_event:premiumable", playerId)
end)



