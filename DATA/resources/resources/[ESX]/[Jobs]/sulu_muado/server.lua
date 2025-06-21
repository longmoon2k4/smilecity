RegisterServerEvent('sulu:muadoban')
AddEventHandler('sulu:muadoban', function(name)
    -- exports["WaveShield"]:AddEventHandler("sulu:muadoban", function(source, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local count =  exports.ox_inventory:Search(_source, "count", "black_money")
    local price = 0
    local label = ""
    local hasItem=false
        for k,v in pairs(Config.DrugDealerItems) do
            if v.name == name then
                hasItem = true
                price = v.price
                label = v.label
            end
        end
        if hasItem==true then
            if count >= price then
                exports.ox_inventory:AddItem(_source,name, 1)
                exports.ox_inventory:RemoveItem(_source,'black_money', price)
                TriggerClientEvent('esx:showNotification', _source, "Bạn đã mua ~g~"..label.." với giá "..price)
                sendDiscord("Mua đồ", GetPlayerName(_source).."đã mua "..label)
            else
                TriggerClientEvent('esx:showNotification', _source, "~r~Bạn không đủ tiền để mua vật phẩm")
            end
        end
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