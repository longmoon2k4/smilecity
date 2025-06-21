-- ESX = nil
-- TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Skin) do
        ESX.RegisterUsableItem(k, function(source)
            TriggerClientEvent('sulu_skin:use', source,v.model)
        end)
    end 
end)