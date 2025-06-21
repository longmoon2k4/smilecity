ESX.RegisterServerCallback("sulu_newbie:check", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    --cb(true)
    MySQL.Async.fetchAll("SELECT gift FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result[1].gift == 0 then 
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterNetEvent("sulu_newbie:setVehicleOwned")
    AddEventHandler("sulu_newbie:setVehicleOwned", function(vehicleProps)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
       if _soucre then
        print("source: ".._soucre)
       end
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)',
        {
            ['@owner']   = xPlayer.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@type']    = 'car'
        }, function (rowsChanged)
            TriggerClientEvent("esx:showNotification", xPlayer.source, ("Phương tiện ~y~[%s]~w~ đã thuộc về bạn"):format(vehicleProps.plate))
            -- exports.ox_inventory:AddItem(_soucre, 'bread', 10)
            -- exports.ox_inventory:AddItem(_soucre, 'water', 10)
            -- exports.ox_inventory:AddItem(_soucre, 'bandage', 10)
            -- exports.ox_inventory:AddItem(_soucre, 'WEAPON_CARBINERIFLE', 1)
            -- exports.ox_inventory:AddItem(_soucre, 'WEAPON_ASSAULTSHOTGUN', 1)
            exports.ox_inventory:AddItem(_source, 'bread', 10)
            exports.ox_inventory:AddItem(_source, 'water', 10)
            exports.ox_inventory:AddItem(_source, 'classic_phone', 1)

            MySQL.Async.execute("UPDATE users SET gift = 1 WHERE identifier = @identifier", {
                ['@identifier'] = xPlayer.identifier
            }, function()
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Hãy tới garage ngay bên cạnh để lấy nó !!!")
            end)
        end)
    end)