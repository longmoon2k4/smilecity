-- ESX               = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local cachePlayer ={}


AddEventHandler('esx:playerDropped', function(playerId, reason)
    if cachePlayer[playerId] ~= nil then
        cachePlayer[playerId] = nil
    end
end)

function getId(src)
	if cachePlayer[src] then
		return cachePlayer[src]
	end
	cachePlayer[src] = ESX.GetPlayerFromId(src).identifier
	return cachePlayer[src]
end

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
	--local identifier = GetPlayerIdentifier(source, 0)
	local identifier = getId(source)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)


