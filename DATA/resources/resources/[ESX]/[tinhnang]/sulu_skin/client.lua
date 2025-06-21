-- ESX = nil
-- TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('sulu_skin:use')
AddEventHandler('sulu_skin:use', function(model)	
    local hash = GetHashKey(model)
    local hashUse = GetEntityModel(PlayerPedId())
    if hashUse == hash then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            if skin['sex'] == 0 then
                TriggerEvent('skinchanger:loadDefaultModel', true, cb)
            else
                TriggerEvent('skinchanger:loadDefaultModel', false, cb)
            end
            Citizen.Wait(100)
            TriggerEvent('skinchanger:loadSkin', skin)      
        end)
    else
        RequestModel(hash)
        while not HasModelLoaded(hash) do
        Wait(500)
        end
        SetPlayerModel(PlayerId(), hash)
        SetPedDefaultComponentVariation(PlayerPedId())
        SetModelAsNoLongerNeeded(PlayerPedId())
    end
end)