-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('roll', function(source)
	local _source = source
	--local xPlayer  = ESX.GetPlayerFromId(source)

	--xPlayer.removeInventoryItem('roll', 1)

	TriggerClientEvent('roll:Display', _source)
end)