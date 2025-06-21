
local data = {}
RegisterServerEvent('sulu:bando')
AddEventHandler('sulu:bando', function(name)
-- exports["WaveShield"]:AddEventHandler("sulu:bando", function(source, name)
    local _source = source
    -- local xPlayer = ESX.GetPlayerFromId(_source)
    local count =  exports.ox_inventory:Search(_source, "count", name)
    local price = 0
    local label = ""
    if count and count > 0 then
        for k,v in pairs(data) do
            if v.name == name then
                price = v.price
                label = v.label
            end
        end
        -- xPlayer.addMoney(price*count)
        exports.ox_inventory:AddItem(_source,'money', price*count)
        exports.ox_inventory:RemoveItem(_source,name, count)
        TriggerClientEvent('esx:showNotification', _source, "Bạn đã bán ~g~"..count.." "..label.."~o~và thu được ~g~"..price*count)
        sendDiscord("Bán đồ", GetPlayerName(_source).."đã bán "..count.." "..label.."và thu được "..price*count.." ")
    else
        TriggerClientEvent('esx:showNotification', _source, "Bán cái nịt hả bạn!")
    end
end)

ESX.RegisterServerCallback("sulu_bando:getData", function(source, cb)
    cb(data)
end)

function loop()
    data = {}
    for k,v in pairs(Config.DrugDealerItems) do
        table.insert(data, {
            --label = v.label,
			label = v.label, 
            price = math.random(v.min, v.max),
            name = v.name,
        })
    end
    TriggerClientEvent('chatMessage', -1, "",  { 255, 255, 255 },'^1Hệ thống: ^0Giá tiền đã được thay đổi.')
    Wait(5400000)
    loop()
end
Citizen.CreateThread( function()
    loop()
end)

function sendDiscord(name, message)
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
	  PerformHttpRequest("https://discord.com/api/webhooks/tatwebhooks/1098488574346797138/F8heh49GfoPuGcqPDWEQ-6Wu-TaytqrcL8eu4f1_sVvf9lOcOi3YaU8fKsdzJK3WyiFx", function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end