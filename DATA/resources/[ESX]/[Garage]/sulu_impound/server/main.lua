-- ESX = nil
-- TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
local webhook1="https://discord.com/api/webhooks/tatwebhooks/1098175426540613632/1US2AOhnb_Rb27fG-P44EagG1_fpsXotS8b6kKGfz3P9dosp689spqvSfITx1L5GIV4B"
local webhook2 ="https://discord.com/api/webhooks/tatwebhooks/1098175626269167677/giJ3jKEtNjfcu7N5Xd8oKCeAS-9TcQAb4ItBGNP_SeswCQVXe40gL4GlCQ_I-buQ1M9A"

ESX.RegisterServerCallback("sulu_impound:callback:getVehicleOwner", function(source, cb, plate)
    plate = ESX.Math.Trim(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = {}
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles LEFT JOIN users ON owned_vehicles.owner = users.identifier WHERE plate = @plate", {
        ['@plate'] = plate
    }, function(result)
        if #result > 0 then
            vehicleData = json.decode(result[1].vehicle)
            data["plate"] = plate
            data["owner"] = result[1].name
            data["color"] = {0, 0, 0}
            data["body"] = (vehicleData.bodyHealth or 0) / 1000 * 100
            data["engine"] = (vehicleData.engineHealth or 0) / 1000 * 100
            data["fuel"] = vehicleData.fuelLevel or 0
            --print(json.encode(data))
            cb(data)
        else
            cb(nil)
        end
    end)
end)

RegisterNetEvent("sulu_impound:server:impound", function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    --if xPlayer.job.name == "mechanic" then 
        -- local vehicles = GetAllVehicles()
        -- for k, v in pairs(vehicles) do 
        --     if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == ESX.Math.Trim(data.plate) then 
        --         DeleteEntity(v)
        --     end
        -- end
        TriggerEvent("DiscordBot:LogDiscord",webhook1, '***'..GetPlayerName(_source).. '*** giam xe có biển số: '..ESX.Math.Trim(data.plate)..' với giá '..data.fine)
        MySQL.Async.execute("INSERT INTO impound (officer, identifier, plate, fine, reason,date) VALUES (@officer, @identifier, @plate, @fine, @reason, @date)", {
            ['@officer'] = GetPlayerName(_source),
            ['@identifier'] = xPlayer.identifier,
            ['@plate'] = ESX.Math.Trim(data.plate),
            ['@fine'] = data.fine,
            ['@reason'] = data.reason,
            ['@date'] = os.time() + tonumber(data.date)* 86400,
        }, function(rowChanged)
            MySQL.Async.execute("UPDATE owned_vehicles SET impound = 1 WHERE plate = @plate", {
                ['@plate'] = ESX.Math.Trim(data.plate)
            })
        end)
   -- end
end)

ESX.RegisterServerCallback("lr_garage:callback:unimpound", function(source, cb, plate)
    plate = ESX.Math.Trim(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
	MySQL.Async.fetchAll("SELECT * FROM impound WHERE plate = @plate", {
		['@plate'] = plate
	}, function(result)
		if xPlayer.getMoney() >= result[1].fine then 
			xPlayer.removeMoney(result[1].fine)
            TriggerEvent("DiscordBot:LogDiscord",webhook2, '***'..GetPlayerName(_source).. '*** đã chuộc có biển số: '..ESX.Math.Trim(plate)..' với giá '..result[1].fine)
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_mechanic", function(account)
                account.addMoney(result[1].fine)
            end)
			UnImpoundVehicle(plate)
			cb(true)
		elseif xPlayer.getAccount("bank").money >= result[1].fine then 
			xPlayer.removeAccountMoney("bank", result[1].fine)
            TriggerEvent("DiscordBot:LogDiscord",webhook2, '***'..GetPlayerName(_source).. '*** đã chuộc có biển số: '..ESX.Math.Trim(plate)..' với giá '..result[1].fine)
            TriggerEvent("esx_addonaccount:getSharedAccount", "society_mechanic", function(account)
                account.addMoney(result[1].fine)
            end)
			UnImpoundVehicle(plate)
			cb(true)
		else
			xPlayer.showNotification("Bạn không đủ tiền để chuộc phương tiện này")
			cb(false)
		end
	end)
end)

function UnImpoundVehicle(plate)
    plate = ESX.Math.Trim(plate)
	MySQL.Async.execute("UPDATE owned_vehicles SET impound = 0 WHERE plate = @plate", {
		['@plate'] = plate
	}, function()
		MySQL.Async.execute("DELETE FROM impound WHERE plate = @plate", {
			['@plate'] = plate
		})
	end)
end