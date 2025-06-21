-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local webhook = 'https://discord.com/api/webhooks/tatwebhooks/1052048844780736632/xhInSOhQr3Notm0yNdQwsf6ri8W4B5mgvWYDZ1lfo5vPTNyKcv1z7ZUlNQCU82SiFTwU'

RegisterServerEvent('okokContract:changeVehicleOwner')
AddEventHandler('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	})

	if Config.RemoveMoneyOnSign then
		local bankMoney = tPlayer.getAccount('bank').money

		if result[1] ~= nil  then
			if bankMoney >= vehicle_price then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = tPlayer.identifier,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then	
						tPlayer.removeAccountMoney('bank', vehicle_price)
						xPlayer.addAccountMoney('bank', vehicle_price)

						TriggerClientEvent('thong_notify:Alert', _source, "Hệ Thống", "Bạn đã bán thành công chiếc xe <b>"..model.."</b> với biển số <b>"..plate.."</b>", 10000, 'success')
						TriggerClientEvent('thong_notify:Alert', target, "Hệ Thống", "Bạn đã mua thành công chiếc xe <b>"..model.."</b> với biển số <b>"..plate.."</b>", 10000, 'success')

						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent('thong_notify:Alert', _source, "Hệ Thống", target_name.." không có đủ tiền trong bank để mua xe của bạn", 10000, 'error')
				TriggerClientEvent('thong_notify:Alert', target, "Hệ Thống", "Bạn không có đủ tiền trong bank để mua "..source_name.." xe", 10000, 'error')
			end
		else
			TriggerClientEvent('thong_notify:Alert', _source, "Hệ Thống", "Chiếc xe với biển số <b>"..plate.."</b> không phải của bạn", 10000, 'error')
			TriggerClientEvent('thong_notify:Alert', target, "Hệ Thống", source_name.." đã cố gắng bán cho bạn một chiếc xe mà anh ta không sở hữu", 10000, 'error')
		end
	else
		if result[1] ~= nil then
			if result[1].soluong >0 then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target , soluong = @soluong WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = tPlayer.identifier,
					['@plate'] = plate,
					['@soluong'] = result[1].soluong - 1
				}, function (result2)
					if result2 ~= 0 then
						TriggerClientEvent('esx:showNotification', _source, "~g~Bạn đã bán thành công chiếc xe "..model.." với biển số"..plate)
						TriggerClientEvent('esx:showNotification', target, "~g~Bạn đã mua thành công chiếc xe "..model.." với biển số "..plate)
						sendDiscord(webhook,"Bán xe", GetPlayerName(_source).." đã bắn xe với biển số "..plate.." cho "..GetPlayerName(target))
					end
				end)
			else
				TriggerClientEvent('esx:showNotification', _source, "~r~ Xe của bạn đã hết lượt chuyển liên hệ admin để mua thêm lượt chuyển!")
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "Chiếc xe với biển số  ~b~"..plate.."~s~ ~r~không phải của bạn")
			TriggerClientEvent('esx:showNotification', target, "~b~".. source_name.." ~s~ đã cố gắng bán cho bạn một chiếc xe mà anh ta không sở hữu")
		end
	end
end)
ESX.RegisterServerCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = ESX.GetPlayerFromId(targetid)
	local targetname = target.getName()

	cb(targetname)
end)

RegisterServerEvent('okokContract:SendVehicleInfo')
AddEventHandler('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:GetVehicleInfo', _source, xPlayer.getName(), os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer')
AddEventHandler('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
	TriggerClientEvent('okokContract:startContractAnimation', data.targetID)

	if Config.RemoveContractAfterUse then
		xPlayer.removeInventoryItem('contract', 1)
	end
end)

-- ESX.RegisterUsableItem('contract', function(source)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

-- 	TriggerClientEvent('okokContract:OpenContractInfo', _source)
-- 	TriggerClientEvent('okokContract:startContractAnimation', _source)
-- end)

-------------------------- SELL VEHICLE WEBHOOK

function sendDiscord(webhookurl,name, message)
	local content = {
        {
        	["color"] = '2061822',
            ["title"] = name,
            ["description"] = message .. os.date ("%X") .." - ".. os.date ("%x") .."",
            ["footer"] = {
            ["text"] = "Log "..name.." By Sulu",
            },
        }
    }
  	PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end