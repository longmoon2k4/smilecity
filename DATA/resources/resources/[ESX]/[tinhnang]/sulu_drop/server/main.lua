
local isLooting = false

RegisterCommand('taothinh', function(source, args, showError)
	GuiToaDo()
end,true)

RegisterCommand('xoathinh', function(source, args, showError)
	TriggerClientEvent('sulu_drop:deleteDrop', -1)
end,true)

AddEventHandler('es:playerLoaded', function(source, user) 
	if daLoot == false then
		TriggerClientEvent('sulu_drop:toaDo', source, posX, posY)
	end
end)

RegisterServerEvent('sulu_drop:daLoot')
AddEventHandler('sulu_drop:daLoot', function()
	isLooting = false
	daLoot = true
	local ranDom = {}
	local length = length(Config.PhanThuong.items)
	while #ranDom < 1 do
		local item = Config.PhanThuong.items[math.random(1, length)]
		if maybe(item.percent) then
			table.insert(ranDom, {type2 =item.type, phanthuong = item.name, count = item.count})
		end
	end
    if exports.ox_inventory:CanCarryItem(source, ranDom[1].phanthuong, ranDom[1].count) then
        exports.ox_inventory:AddItem(source, ranDom[1].phanthuong, ranDom[1].count)
        TriggerClientEvent('esx:showNotification', -1, GetPlayerName(source).." đã nhận được "..ranDom[1].count.." "..ranDom[1].phanthuong.." từ kho báu")
    else
        TriggerClientEvent('esx:showNotification', source,"~r~Balo đã đầy")
    end
	TriggerClientEvent('sulu_drop:deleteDrop', -1)
end)

RegisterServerEvent('sulu_drop:syncDrop')
AddEventHandler('sulu_drop:syncDrop', function()
	if daLoot == false then
		TriggerClientEvent('sulu_drop:toaDo', source, posX, posY)
	end
end)

ESX.RegisterServerCallback('sulu_drop:isLooting', function(source, cb)
	if isLooting == false then
		cb(false)
		isLooting = true
		lootingTimeout = ESX.SetTimeout(120000, clearLooting)
	else
		cb(true)
	end
end)

RegisterServerEvent('sulu_drop:stopLoot')
AddEventHandler('sulu_drop:stopLoot', function()
	if isLooting == true then
		isLooting = false
		ESX.ClearTimeout(lootingTimeout)
	end
end)
		
function clearLooting()
	if isLooting == true then
		isLooting = false
	end
end		
		
function dropWebhook(text)
	local connect = {
		{
			["color"] = "8663711",
			["title"] = 'săn kho báu',
			["description"] = text,
			["footer"] = {
				["text"] = 'săn kho báu',
				["icon_url"] = 'https://i.imgur.com/IkT6ase4Pn.png',
			},
		}
	}
	PerformHttpRequest('https://discord.com/api/webhooks/tatwebhooks/1079343236155457618/MEBjbXajDfJaFl6iDHLFGUoMC_03Z4aR3u5O6UTxVomK9Ktp3ycDDpqKuuAGT9WNWbqY', function(err, text, headers) end, 'POST', json.encode({username = 'Thinh', embeds = connect}), { ['Content-Type'] = 'application/json' })	
end
