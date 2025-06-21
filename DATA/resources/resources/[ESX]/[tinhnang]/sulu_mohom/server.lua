local webhook1='https://discord.com/api/webhooks/tatwebhooks/1055799594765787187/prgs3FFwbNet3qJVJGHNDLpc4Ts64638tqqkCh8mIGIDhCYzOn1rPv2mlQOOUECLhDjN'
local data = {}

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        if data ~= nil then
            SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(data, {indent = true}), -1)
        end
    end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
	SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(data, {indent = true}), -1)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    SaveResourceFile(GetCurrentResourceName(), "data.json", json.encode(data, {indent = true}), -1)
end)

function getItem(name, hom)
    for k,v in pairs(Config.Hom[hom].items) do
        if v.name == name then
            return v
        end
    end
end

function createData(hom)
    data[hom] = {}
    for k,v in pairs(Config.Hom[hom].items) do
        for i = 1, v.countData do
            table.insert(data[hom], v.name)
        end
    end
end

function _UseCrateSkin(hom,_source)
    local ran_Crate = {}
    local WinItem = {}
    local length = #Config.Hom[hom].items
    math.randomseed(os.time())
    while #ran_Crate < 100 do
        local item = Config.Hom[hom].items[math.random(1, length)]
        table.insert(ran_Crate,item.name)
        if #ran_Crate == 70 then
            if  #data[hom] <= 0 then
                createData(hom)
            end
            while #data[hom] <= 0 do
                Wait(100)
            end
            local randomValue = math.random(1, #data[hom])
            local winItemRandom = data[hom][randomValue]
            table.remove(data[hom], randomValue)
            table.insert(ran_Crate, 70, winItemRandom)
            WinItem = getItem(winItemRandom, hom)
        end
    end
    TriggerClientEvent("ace_mohom:nhanhom", _source,{status = true, seed = math.random(9970,10110), pick = ran_Crate[70], list = ran_Crate,crate = hom, label = Config.Hom[hom].label})
    Wait(7000)
    if not exports.ox_inventory:CanCarryItem(_source, WinItem.name, WinItem.count) then
        TriggerClientEvent('esx:showNotification',_source,'~r~Bạn không còn chỗ trống')
    else     
        if WinItem.noti then
            local labelItem = exports.ox_inventory:Items(WinItem.name).label
            TriggerClientEvent('chatMessage', -1, "",  { 255, 255, 255 }, '^6Mở hòm: ^0'.. GetPlayerName(_source)..' đã quay trúng  '..labelItem)
        end
        exports.ox_inventory:AddItem(_source, WinItem.name, WinItem.count)
        sendDiscord(hom, '***'..GetPlayerName(_source).. '*** đã quay được '..WinItem.count..' '..WinItem.name.. ' ')
    end
end

Citizen.CreateThread(function()
    data = json.decode(LoadResourceFile(GetCurrentResourceName(), "./data.json"))
    for k,v in pairs(Config.Hom) do
        if not data[k] then
            createData(k)
        end
    end 
end)

exports('hom', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local dataHom  = Config.Hom[item.name]
        if dataHom then
            if dataHom.key then
                if exports.ox_inventory:Search(inventory.id, "count", 'key') > 0 then
                    exports.ox_inventory:RemoveItem(inventory.id, 'key',1)
                    exports.ox_inventory:RemoveItem(inventory.id, item.name,1)
                    _UseCrateSkin(item.name,inventory.id)
                else
                    TriggerClientEvent('esx:showNotification',inventory.id,'Bạn cần chìa khóa để mở rương')
                end
            else
                exports.ox_inventory:RemoveItem(inventory.id, item.name,1)
                _UseCrateSkin(item.name,inventory.id)
            end
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
	  PerformHttpRequest(webhook1, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end