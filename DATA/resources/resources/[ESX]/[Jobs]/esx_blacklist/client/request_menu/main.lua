local RequestData = {}
local isRequestMenuOpen = false
AddEventHandler('black_list:open', function()
    InitData()
    OpenMenu()
end)

-- RegisterCommand('request', function()
--     TriggerEvent('request_menu:open')
-- end)

-- RegisterNetEvent("request_menu:sync")
-- AddEventHandler("request_menu:sync", function()
--     if isRequestMenuOpen then 
--         InitData()
--     end
-- end)

-- RegisterNetEvent("request_menu:audio")
-- AddEventHandler("request_menu:audio", function()
--     Sound()
-- end)

-- RegisterNetEvent("request_menu:cancelPlayer")
-- AddEventHandler("request_menu:cancelPlayer", function(text)
--     local time= 200
--     while time > 0 do
--         SetTextProportional(1)
--         SetTextScale(0.5, 0.8)
--         SetTextColour(128, 128, 128, 255)
--         SetTextDropshadow(0, 0, 0, 0, 255)
--         SetTextEdge(1, 0, 0, 0, 255)
--         SetTextDropShadow()
--         SetTextOutline()
--         SetTextEntry("STRING")
--         AddTextComponentString(text)
--         DrawText(0.25, 0.5)
--         time = time - 1
--         Wait(1)
--     end
-- end)




function mathRound(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10^numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end

-- RegisterNUICallback('request:accept', function(data, cb)
--     local id = data.id:gsub("%s", "")
--     id = tonumber(id)
--     for k, v in ipairs(RequestData) do 
--         if v.id == id then 
--             local target = v.source
--             --SetNewWaypoint(v.targetCoords.x, v.targetCoords.y)
--             SetNewWaypoint(mathRound(v.targetCoords.x,2), mathRound(v.targetCoords.y,2))
--             TriggerServerEvent("request_menu:acceptRequest", id, target)
--         end
--     end
-- end)


-- RegisterNUICallback('request:getPos', function(data, cb)
--     local id = data.id:gsub("%s", "")
--     id = tonumber(id)
--     for k, v in ipairs(RequestData) do 
--         if v.id == id then 
--             SetNewWaypoint(mathRound(v.targetCoords.x,2), mathRound(v.targetCoords.y,2))
--         end
--     end
-- end)

RegisterNUICallback('request:remove', function(data, cb)
   TriggerServerEvent('esx_blacklist:remove',data.identifier)
   InitData()
end)

-- RegisterNUICallback('request:cancel', function(data, cb)
--     local id = data.id:gsub("%s", "")
--     id = tonumber(id)
--     for k, v in ipairs(RequestData) do 
--         if v.id == id then 
--             local target = v.source
--             TriggerServerEvent('request_menu:cancelRequest', id, target)
--         end
--     end
-- end)

-- Sound = function()
--     SendNUIMessage({
--         name = 'request_menu',
--         event = 'sound',
--         open = true
--     })
-- end

OpenMenu = function()
    if not isUIOpen then 
        isUIOpen = true 
        isRequestMenuOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({
            name = 'request_menu',
            event = 'toggle',
            open = true
        })
    end
end

InitData = function()
    ESX.TriggerServerCallback("getBlacklist", function(data)
        local requestData = {}
        for k,v in pairs(data) do 
            table.insert(requestData, { name = v.target, time = v.time, by = v.by, reason = v.reason, identifier = k})
        end
        SendNUIMessage({
            name = "request_menu",
            event = "init",
            initData = requestData
        })
    end)
end