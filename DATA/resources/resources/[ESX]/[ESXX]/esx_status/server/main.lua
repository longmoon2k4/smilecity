--ESX                    = nil
local RegisteredStatus = {}


--sở dĩ event này nó bị stress vì nó được gọi rất nhiều bởi người chơi
-- moỗi lần được gọi e để ý nó có call về ESX.GetPlayerFromId
-- ESX.GetPlayerFromId được ref bởi es_extended qua scheduler
-- Mỗi lần gọi thì nó sẽ tạo 1 bản coppy và chứa vào ram của server => lâu dần nó sẽ tràn và gây stress
-- Giải pháp ở đy là mình cache nó lại
-- Mình có thể dùng cho các nơi khác gọi đến ESX.GetPlayerFromId

local cachePlayer = {}
function getPlayerFromCache(playerSrc)
	-- Vì cache mình lưu dưới dạng object nên index của nó mình phải chuyển sang string (playerSRc là number)
	local strSrc = tostring(playerSrc)
	-- Nếu đã cs trông mảng cachePlayer thì mình return nó luôn
	if cachePlayer[strSrc] then return cachePlayer[strSrc] end
	-- Còn không thì lấy từ es_extended sau đó lưu vào cachePlayer rồi return
	cachePlayer[strSrc] = ESX.GetPlayerFromId(playerSrc)
	return cachePlayer[strSrc]
end

--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	local _source        = source
	local xPlayer        = getPlayerFromCache(_source)

	MySQL.Async.fetchAll(
		'SELECT * FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local data = {}

			if result[1].status ~= nil then
				data = json.decode(result[1].status)
			end

			xPlayer.set('status', data)

			TriggerClientEvent('esx_status:load', _source, data)

		end
	)

end)

AddEventHandler('esx:playerDropped', function(source)
	local _source = source
	local xPlayer = getPlayerFromCache(_source)

	local data   = {}
	local status = xPlayer.get('status')

	MySQL.Async.execute(
		'UPDATE users SET status = @status WHERE identifier = @identifier',
		{
			['@status']     = json.encode(status),
			['@identifier'] = xPlayer.identifier
		}
	)
	cachePlayer[tostring(_source)] = nil
end)

AddEventHandler('esx_status:getStatus', function(playerId, statusName, cb)
	local xPlayer = getPlayerFromCache(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end

end)


RegisterServerEvent('esx_status:update')
AddEventHandler('esx_status:update', function(status)
	local _source = source
	local xPlayer = getPlayerFromCache(_source) -- Mỗi lần gọi xPlayer sẽ kiểm tra trong cachePlayer trước khi gọi từ ngoài vào
	
	if xPlayer ~= nil then
		xPlayer.set('status', status)
	end
end)

function SaveData()
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do

		local xPlayer = getPlayerFromCache(xPlayers[i])
		local data    = {}
		local status  = xPlayer.get('status')

		MySQL.Async.execute(
			'UPDATE users SET status = @status WHERE identifier = @identifier',
		 	{
		 		['@status']     = json.encode(status),
		 		['@identifier'] = xPlayer.identifier
		 	}
		)
	
	end

	SetTimeout(10 * 60 * 1000, SaveData)
end

SaveData()