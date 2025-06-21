-- ESX = nil
isUIOpen = false
isReady = false
PlayerData = nil
-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent(Config.ESXEvent, function(obj) ESX = obj end)
--         Wait(1)
--     end
--     PlayerData = ESX.GetPlayerData()
--     ---------------------KEY PRESS HANDLER-------------------------
    
-- end)
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
TriggerEvent('chat:addSuggestion', '/blacklistmed', 'Blacklist', {
	{ name="id", help="Id người chơi" },
    { name="Time", help="Thời gian" },
    { name="Reason", help="Lý do" }
})
TriggerEvent('chat:addSuggestion', '/blacklistch', 'Blacklist', {
	{ name="id", help="Id người chơi" },
    { name="Time", help="Thời gian" },
    { name="Reason", help="Lý do" }
})