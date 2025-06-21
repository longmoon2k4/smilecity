

list_products = {}
satus = false
AddEventHandler('playerSpawned', function()
    SendNUIMessage({
        config = Config,
        translate = translate,
        NameResource = GetCurrentResourceName()
    })
end)

AddEventHandler('onResourceStart', function()
    Wait(5000)
    SendNUIMessage({
        config = Config,
        translate = translate,
        NameResource = GetCurrentResourceName()
    })
end)

RegisterNetEvent('sulu_chotroi:loadMarket')
AddEventHandler('sulu_chotroi:loadMarket', function(identifier, result, datacl1, datacl2)
    if satus ~= true then
        Interdata(datacl1, datacl2)
    end
    if list_products ~= {} then
        SendNUIMessage({
            open = true,
            list_products = list_products,
            products = result,
            identifier = identifier
        })
        SetNuiFocus(true, true)
    end
end)

RegisterNetEvent('sulu_chotroi:loadPlayerMarket')
AddEventHandler('sulu_chotroi:loadPlayerMarket', function(inventory, result)
    if list_products ~= {} then
        SendNUIMessage({
            myProductsOpen = true,
            list_products = list_products,
            inventory = inventory,
            myProducts = result
        })
    end
end)

RegisterNetEvent('sulu_chotroi:updatePlayerMarket')
AddEventHandler('sulu_chotroi:updatePlayerMarket', function()
    TriggerServerEvent('sulu_chotroi:loadPlayerMarket')
end)


RegisterNetEvent('sulu_chotroi:updateMarket')
AddEventHandler('sulu_chotroi:updateMarket', function()
    TriggerServerEvent('sulu_chotroi:loadMarket')
end)

RegisterNetEvent('sulu_chotroi:marketNotify')
AddEventHandler('sulu_chotroi:marketNotify', function(color, Notify)
    SendNUIMessage({
        Notify = Notify,
        color = color
    })
end)

RegisterNetEvent('sulu_chotroi:marketRefused')
AddEventHandler('sulu_chotroi:marketRefused', function()
    SendNUIMessage({
        Refused = true
    })
end)

RegisterNUICallback('loadAnuncios', function(data, cb)
    TriggerServerEvent('sulu_chotroi:loadMarket')

    cb('ok')
end)

RegisterNUICallback('loadMyAnuncios', function(data, cb)
    TriggerServerEvent('sulu_chotroi:loadPlayerMarket')
    cb('ok')
end)

RegisterNUICallback('anunciarItem', function(data, cb)
    TriggerServerEvent('sulu_chotroi:advertiseItem', data)
    -- exports["WaveShield"]:TriggerServerEvent("sulu_chotroi:advertiseItem",data)
    cb('ok')
end)

RegisterNUICallback('buyItem', function(data, cb)
    TriggerServerEvent('sulu_chotroi:buyItem', data)
    -- exports["WaveShield"]:TriggerServerEvent("sulu_chotroi:buyItem",data)
    cb('ok')
end)

RegisterNUICallback('removeItem', function(data, cb)
    TriggerServerEvent('sulu_chotroi:removeItem', data)
    -- exports["WaveShield"]:TriggerServerEvent("sulu_chotroi:removeItem",data)
    cb('ok')
end)

RegisterNUICallback('sendNotify', function(data, cb)
    TriggerEvent('sulu_chotroi:marketNotify', data.color, data.Notify)

    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)

    cb('ok')
end)

MarkerColor  = {r = 204, g = 204, b = 0}
local chotroi = vec3(388.75, -356.05, 48.02)
Citizen.CreateThread(function()
    while true do
    local time = 1000
    local coords = GetEntityCoords(PlayerPedId())
    if #(coords - chotroi) < 15 then 
        time = 1
        DrawMarker(21, 388.75, -356.05, 48.02, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, MarkerColor.r, MarkerColor.g, MarkerColor.b, 100, false, true, 2, false, false, false, false)
    end
    if #(coords - chotroi) < 2 then 
        ESX.ShowHelpNotification("~o~Nhấn ~g~[E]~o~ để mở chợ trời")
        if IsControlJustReleased(1, 51) then   
            TriggerServerEvent('sulu_chotroi:openmenu')
        end
    end
        -- if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 388.75, -356.05, 48.02, true) < 50.0 then
        --     -- DrawMarker(21, 388.75, -356.05, 48.02, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, MarkerColor.r, MarkerColor.g, MarkerColor.b, 100, false, true, 2, false, false, false, false)
        --     if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 388.75, -356.05, 48.02, true) < 2 then
        --         ESX.ShowHelpNotification("~o~Nhấn ~g~[E]~o~ để mở chợ trời")
        --         if IsControlJustReleased(1, 51) then   
        --             TriggerServerEvent('sulu_chotroi:openmenu')
        --         end
        --     end
        -- end
        Citizen.Wait(time)
    end
end)

function Interdata(data1, data2)
    if satus == false then
        --for i=1, #data1, 1 do    
        for k,v in pairs(data1) do    
            table.insert(list_products, {name = v.name, label = v.label, img = "nui://ox_inventory/web/images/"..v.name..".png", price_recommended = 0})
        end
      
        satus = true
    end
end

Citizen.CreateThread(function()        
    blip = AddBlipForCoord(388.75, -356.05, 48.02)
    SetBlipSprite(blip, 605)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Chợ Trời")
    EndTextCommandSetBlipName(blip)
end)