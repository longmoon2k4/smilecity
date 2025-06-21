-- ESX = nil
isUIOpen = false
isReady = false
PlayerData = nil
quany = false
-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent(Config.ESXEvent, function(obj) ESX = obj end)
--         Wait(1)
--     end
--     PlayerData = ESX.GetPlayerData()
--     ---------------------KEY PRESS HANDLER-------------------------
    
-- end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
    if xPlayer.job.grade_name == 'quany' then
        quany = true
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    if job.grade_name == 'quany' then
        quany = true
    else
        quany = false
    end
end)

RegisterNUICallback("closeNUI", function(data,cb)
    SetNuiFocus(false, false)
    isUIOpen = false
end)

RegisterNUICallback("Notification", function(data,cb)
    ESX.ShowNotification(data.msg)
end)

RegisterNUICallback("ready", function(data, cb)
    isReady = true
end)
