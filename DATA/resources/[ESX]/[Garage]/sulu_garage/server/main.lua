

-- Get Owned Properties
local cachePlayer ={}

function getId(src)
	if cachePlayer[src] then
		return cachePlayer[src]
	end
	cachePlayer[src] = ESX.GetPlayerFromId(src).identifier
	return cachePlayer[src]
end

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if cachePlayer[playerId] ~= nil then
        cachePlayer[playerId] = nil
    end
end)

RegisterServerEvent('setXeSync')
AddEventHandler('setXeSync', function(plate, props, model)
	MySQL.Async.execute('UPDATE owned_vehicles SET  `vehicle` = @vehicle, `model` = @model WHERE plate = @plate', {
		['@plate'] = ESX.Math.Trim(plate),
		['@vehicle'] = json.encode(props),
		['@model'] = model,
	}, function(rowsChanged)
	end)
end)

ESX.RegisterServerCallback("sulu_garage:server:getOwnedVehicles", function(source, cb, type)
	local ownedVehs = {}
	--local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = getId(source)
	if Config.ShowPoundVehicleInGarage == true then 
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND   type = @type', {
			['@owner']  = identifier,
			['@type']   = type,
			--['@job']    = ''
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				--print(vehicle)
				table.insert(ownedVehs, {vehicle = vehicle, stored = v.stored, plate = v.plate, customName = v.label, soluong = v.soluong, impound = v.impound, type = v.type})
			end
			cb(ownedVehs)
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND `stored` = @stored AND type = @type', {
			['@owner']  = identifier,
			['@type']   = type,
			--['@job']    = '',
			['@stored'] = true
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedVehs, {vehicle = vehicle, stored = v.stored, plate = v.plate, customName = v.label, soluong = v.soluong, impound = v.impound, type = v.type})
			end
			cb(ownedVehs)
		end)
	end
end)

ESX.RegisterServerCallback("sulu_garage:callback:getListImpoundedVehicle", function(source, cb)
	local ownedVehs = {}
	MySQL.Async.fetchAll('SELECT * FROM impound ', {
	}, function(data)
		for _,v in pairs(data) do
			table.insert(ownedVehs, { plate = v.plate})
		end
		cb(ownedVehs)
	end)

	
end)

ESX.RegisterServerCallback("sulu_garage:callback:getImpoundedVehicle", function(source, cb)
	local ownedVehs = {}
	-- local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = getId(source)
		MySQL.Async.fetchAll('SELECT * FROM  impound LEFT JOIN  owned_vehicles ON owned_vehicles.plate = impound.plate WHERE OWNER = @owner', {
			['@owner']  = identifier,
			--['@Type']   = 'car',
			--['@job']    = ''
		}, function(data)
			
			for _,v in pairs(data) do
				if v.date ~= nil then
					if os.time() >= tonumber(v.date) then
						local vehicle = json.decode(v.vehicle)
						table.insert(ownedVehs, {vehicle = vehicle, stored = v.stored, plate = v.plate, customName = v.label, soluong = v.soluong, impound = v.impound, type = v.type})
					end
				end
			end
			cb(ownedVehs)
		end)
end)

ESX.RegisterServerCallback("sulu_garages:server:parkVehicle", function(source, cb, plate, props)
	--local xPlayer = ESX.GetPlayerFromId(source)
	--print(plate)
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored, `vehicle` = @vehicle WHERE plate = @plate', {
		['@stored'] = true,
		['@plate'] = ESX.Math.Trim(plate),
		['@vehicle'] = json.encode(props)
	}, function(rowsChanged)
		if rowsChanged == 0 then
			cb(false)
		else
			cb(true)
		end
	end)

end)

ESX.RegisterServerCallback("sulu_garage:server:returnVehicle", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Config.ReturnPrice then 
		xPlayer.removeMoney(Config.ReturnPrice)
		cb(true)
	elseif xPlayer.getAccount('bank').money >= Config.ReturnPrice then 
		xPlayer.removeAccountMoney('bank', Config.ReturnPrice)
		cb(true)
	else	
		cb(false)
	end

end)

ESX.RegisterServerCallback("sulu_garage:callback:getImpoundData", function(source, cb, data)
	MySQL.Async.fetchAll("SELECT * FROM impound WHERE plate = @plate", {
		['@plate'] = data.plate
	}, function(result)
		--print(json.encode(result[1]))
		cb(result[1],os.date("*t", tonumber(result[1].date)))
	end)
end)

ESX.RegisterServerCallback("sulu_garage:callback:unimpound", function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll("SELECT * FROM impound WHERE plate = @plate", {
		['@plate'] = plate
	}, function(result)
		if xPlayer.getMoney() >= result[1].fine then 
            if os.time() < tonumber(result[1].date) then
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Thời gian giam xe vẫn còn")
                cb(false)
            else
                xPlayer.removeMoney(result[1].fine)
                UnImpoundVehicle(plate)
                cb(true)
            end
		elseif xPlayer.getAccount("bank").money >= result[1].fine then 
            if os.time() < tonumber(result[1].date) then
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Thời gian giam xe vẫn còn")
                cb(false)
            else
                xPlayer.removeAccountMoney("bank", result[1].fine)
                UnImpoundVehicle(plate)
                cb(true)
            end
		else
			TriggerClientEvent("esx:showNotification", xPlayer.source, "Bạn không đủ tiền để chuộc phương tiện này")
			cb(false)
		end
	end)
end)

function UnImpoundVehicle(plate)

	MySQL.Async.execute("UPDATE owned_vehicles SET impound = 0 WHERE plate = @plate", {
		['@plate'] = plate
	}, function()
		MySQL.Async.execute("DELETE FROM impound WHERE plate = @plate", {
			['@plate'] = plate
		})
	end)
end

RegisterNetEvent("sulu_garage:server:setState")
AddEventHandler("sulu_garage:server:setState", function(plate, state)
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			--print(('esx_advancedgarage: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

RegisterNetEvent("sulu_garage:server:removeImpound")
AddEventHandler("sulu_garage:server:removeImpound", function(plate)
	UnImpoundVehicle(plate)
end)

RegisterNetEvent("esx_advancedgarage:changeName")
AddEventHandler("esx_advancedgarage:changeName", function(plate, newName)
	--local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = getId(source)
	MySQL.Async.execute('UPDATE owned_vehicles SET `label` = @label WHERE plate = @plate AND owner = @owner', {
		['@label'] = newName,
		['@plate'] = plate,
		['@owner'] = identifier
	}, function(rowsChanged)
		if rowsChanged == 0 then
			TriggerClientEvent("esx:showNotification", xPlayer.source, ("Phương tiện với biển số: %s đã đổi tên thành ~y~%s~w~"):format(plate, newName))
		end
	end)
end)

RegisterNetEvent("sulu_garage:server:deleteVehicle")
AddEventHandler("sulu_garage:server:deleteVehicle", function(plate)
	--local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local identifier = getId(_source)
	MySQL.Async.execute("DELETE FROM owned_vehicles WHERE owner = @owner AND plate = @plate", {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(rowDeleted)
		if rowDeleted > 0 then 
			TriggerClientEvent("esx:showNotification", _source, ("Bạn đã ~r~ XÓA ~w~ phương tiện ~y~[%s]~w~ "):format(plate))
		end
	end)
end)

--MySQL.ready(function()
--	if Config.ReturnVehicleAfterRS then
--		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
--			['@stored'] = false
--		}, function(rowsChanged)
--			if rowsChanged > 0 then
--				print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
--			end
--		end)
--	end
--end)


RegisterNetEvent("sulu_garage:server:removeOldVehicle")
AddEventHandler("sulu_garage:server:removeOldVehicle", function(plate)
	plate = ESX.Math.Trim(plate)
	local vehicles = GetAllVehicles()
	for k, v in pairs(vehicles) do
		local p = ESX.Math.Trim(GetVehicleNumberPlateText(v))
		if plate == p then 
			DeleteEntity(v)
		end
	end


	plate = ESX.Math.Trim(plate)
	local vehicles = GetAllVehicles()
	for k, v in pairs(vehicles) do
		local p = ESX.Math.Trim(GetVehicleNumberPlateText(v))
		if plate == p then 
			DeleteEntity(v)
		end
	end
end)

--[[ Citizen.CreateThread(function()
	while true do 
		Wait(60000 * 30)
		TriggerClientEvent("esx:showNotification", -1, "Phương tiện không có người sẽ bị xóa sau 1 phút")
		Wait(60000)
		local objects = GetAllObjects()
		local peds = GetAllPeds()
		local vehicles = GetAllVehicles()
		for k, v in pairs(objects) do 
			DeleteEntity(v)
		end
		for k, v in pairs(peds) do 
			DeleteEntity(v)
		end
		for k, v in pairs(vehicles) do 
			local hasStart = GetIsVehicleEngineRunning(v)
			if not hasStart then 
				DeleteEntity(v)
			end
		end
	end
end)]]
RegisterCommand("clearserver", function(source, args, rawCommand)
	if source == 0 then 
		TriggerClientEvent("esx:showNotification", -1, "Phương tiện không có người sẽ bị xóa sau 1 phút")
		Wait(60000)
		local objects = GetAllObjects()
		local peds = GetAllPeds()
		local vehicles = GetAllVehicles()
		for k, v in pairs(objects) do 
			DeleteEntity(v)
		end
		for k, v in pairs(peds) do 
			DeleteEntity(v)
		end
		for k, v in pairs(vehicles) do 
			local hasStart = GetIsVehicleEngineRunning(v)
			if not hasStart then 
				DeleteEntity(v)
			end
		end
	end
end, true)

RegisterServerEvent('sulu_garage:nhatvechai')
AddEventHandler('sulu_garage:nhatvechai', function(veh)
    local source = source
    local veh1= NetworkGetEntityFromNetworkId(veh)
    if DoesEntityExist(veh1) then
        exports.ox_inventory:AddItem(source, 'water',  1)
        DeleteEntity(veh1)
    end
end)