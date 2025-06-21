local PlayerData = {}
local carKey  = {}
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    --Citizen.CreateThread(function()
    PlayerData = xPlayer
    ESX.TriggerServerCallback("sulu_keycar:getData", function(data)
        carKey = data
        table.insert(carKey,'XETAI')
        table.insert(carKey,'ADMINCAR')
        table.insert(carKey,'TEST')
    end)
end)

RegisterNetEvent('sulu_keycar:acceptData')
AddEventHandler('sulu_keycar:acceptData', function(plate)
    local check = false
    for k,v in pairs(carKey) do
        if plate == v then
            check = true
        end
    end
    if check == false then
        table.insert(carKey,plate)
    end
end)

RegisterNetEvent('sulu_keycar:removeKey')
AddEventHandler('sulu_keycar:removeKey', function(plate)
    ESX.TriggerServerCallback("sulu_keycar:checkKey", function(data)
        if not data then
            for k,v in pairs(carKey) do
                if plate == v then
                    table.remove(carKey,k)
                end
            end
        end
    end, plate)
end)

AddEventHandler('gameEventTriggered', function (name, args)
    if name == 'CEventNetworkPlayerEnteredVehicle' then 
        if IsPedInAnyVehicle(cache.ped, true) then
            local player = cache.ped
            SetPedConfigFlag(player, 429, false)
            local vehicle = GetVehiclePedIsIn(player, false)
            local driver = GetPedInVehicleSeat(vehicle, -1)
            local plate =GetVehicleNumberPlateText(vehicle)
            local plateTrim = string.gsub(plate, "%s+", "")
            local check = false
            -- if carKey == nil then
            --     TaskLeaveVehicle(player, vehicle, 0)
            --     return
            -- end
            for k, v in pairs(carKey) do
                if plateTrim == v then
                    check = true
                    break
                end
            end 
            if not check and  driver == player then
                SetVehicleNeedsToBeHotwired(vehicle, false)
			    SetPedConfigFlag(player, 429, true)
                SetVehicleEngineOn(vehicle, false, true, true)
            end
        end
    end
end)
TriggerEvent('chat:addSuggestion', '/givekey', 'Đưa key', {
	{ name="id", help="Id người chơi" },
})


function checkPlate(plate)
    local check = false
    for k,v in pairs(carKey) do
        if v==plate then
            check = true
        end
    end
    return check
end

RegisterNetEvent('sulu_keycar:getPlate')
AddEventHandler('sulu_keycar:getPlate', function(target)
     if IsPedInAnyVehicle(cache.ped, true) then
        local vehicle = GetVehiclePedIsIn(cache.ped, false)
        local plate =GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent('sulu_keycar:giveKey', target, plate)
    else
        ESX.ShowNotification("Bạn phải ngồi trên xe")
    end
end)

RegisterNetEvent('sulu_keycar:copyKey')
AddEventHandler('sulu_keycar:copyKey', function(slot)
     if IsPedInAnyVehicle(cache.ped, true) then
        local vehicle = GetVehiclePedIsIn(cache.ped, false)
        local plate =GetVehicleNumberPlateText(vehicle)
        TriggerServerEvent('sulu_keycar:renderKey', slot, plate)
    else
        ESX.ShowNotification("Bạn phải ngồi trên xe")
    end
end)

RegisterNetEvent('sulu_keycar:getPlate2')
AddEventHandler('sulu_keycar:getPlate2', function()
     if IsPedInAnyVehicle(cache.ped, true) then
        local input = lib.inputDialog('Nhập id ', { {type = 'number', label = 'Nhập id',  required = true, min = 0, max = 9999},})
        if input[1] then
            local vehicle = GetVehiclePedIsIn(cache.ped, false)
            local plate =GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('sulu_keycar:giveKey', input[1] , plate)
        end
    else
        ESX.ShowNotification("Bạn phải ngồi trên xe")
    end
end)

exports.ox_inventory:displayMetadata({
    key = 'Biển số',
})