-- ESX = nil
-- TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
--------------------------------------------------------TOA DO-------------------------------------------------------------

POSITIONS = {}

POSITIONS.list = {}

RegisterServerEvent("position:s:insert")
AddEventHandler("position:s:insert", function (text)
    -- print(text)
    
    local source = source

    local f,err = io.open('positions.txt','w')
    if not f then return print(err) end

    table.insert(POSITIONS.list, text)

    for i,line in pairs(POSITIONS.list) do
      f:write(line..' \n')
    end

	f:close()
end)

----------------------------------------------------------Xi Nhan--------------------------------------------------------------

local playerIndicators = {}

RegisterServerEvent('IndicatorL')
RegisterServerEvent('IndicatorR')

AddEventHandler('IndicatorL', function(IndicatorL)
	local netID = source
	TriggerClientEvent('updateIndicators', -1, netID, 'left', IndicatorL)
	--playerIndicators[netID][left] = IndicatorL
end)

AddEventHandler('IndicatorR', function(IndicatorR)
	local netID = source
	TriggerClientEvent('updateIndicators', -1, netID, 'right', IndicatorR)
	--playerIndicators[netID][right] = IndicatorR
end)

-------------------------------------------------------------Sync Dơ Xe --------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Pass vehicle dirt level over to server and then back to client (attempt to sync it)
-----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('wash_car:sync')
AddEventHandler('wash_car:sync', function(vehicle, dirtLevel)

	local src = source
	local veh = vehicle
	local dirt = dirtLevel
	
	TriggerClientEvent('setDirt', source, veh, dirt)
end)


------------------------------------------------------------------Drag Xác---------------------------------------------------------------------------

RegisterServerEvent("Drag")
AddEventHandler("Drag", function(Target)
	local Source = source
	TriggerClientEvent("Drag", Target, Source)
end)




ESX.RegisterServerCallback('trian',function(source, cb)
	
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM users  where identifier = @id', {['@id'] = xPlayer.identifier}, function(result)
		local coin = json.decode(result[1].trian)
		cb(coin)
	end)
	
end)


RegisterCommand('fps', function(source)
    --  local _source = source
    -- local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('fps:openfps', source)
end,false)

RegisterCommand('tanghinh', function(source)
    local _source = source
    TriggerClientEvent('tanghinh', _source)
end, true)