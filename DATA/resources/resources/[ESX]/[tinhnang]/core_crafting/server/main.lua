-- local QBCore = exports['qb-core']:GetCoreObject()

-- function setCraftingLevel(citizenid, level)
--     exports.oxmysql:execute('UPDATE players SET crafting_level = @xp WHERE citizenid = @citizenid',{["@xp"] = level, ["@citizenid"] = identifier}, function() end)
-- end

-- function giveCraftingLevel(citizenid, level)
--    exports.oxmysql:execute('UPDATE players SET crafting_level = crafting_level + "'..level..'" WHERE citizenid = "'..citizenid..'"', function() end)
-- end

-- RegisterServerEvent("core_crafting:setExperiance")
-- AddEventHandler("core_crafting:setExperiance", function(citizenid, xp)
--         setCraftingLevel(citizenid, xp)
-- end)

-- RegisterServerEvent("core_crafting:giveExperiance")
-- AddEventHandler("core_crafting:giveExperiance", function(citizenid, xp)
--         giveCraftingLevel(citizenid, xp)
-- end)
local webhook = 'https://discord.com/api/webhooks/tatwebhooks/1052053595341721700/O8TNq4w9HTs8tRzFHnhjQe3ExkkICrC3bB8bmky_Tr321i91Nl-Tf1sMdprdpCL7y1l5'

function craft(src, item, retrying)
   -- local Player = QBCore.Functions.GetPlayer(src)
    local cancraft = true
    local inventory = exports.ox_inventory:GetInventoryItems(src)
   -- local count = Config.Recipes[item].Amount
    local check = 0
    local checkTwo = 0
    if not retrying then
        -- for k, v in pairs(Config.Recipes[item].Ingredients) do
		
        --     if Player.Functions.GetItemByName(k) == nil or Player.Functions.GetItemByName(k).amount < v then
		-- 		cancraft = false
		-- 	end
			
        -- end
        for k, v in pairs(Config.Recipes[item].Ingredients) do
            for z,x in pairs(inventory) do
                if k == x.name then
                    check = check + 1
                    if x.count < v.count then
                        cancraft = false
                    end
                end
            end
        end
    end
    for k, v in pairs(Config.Recipes[item].Ingredients) do
        if v ~= nil then
            checkTwo = checkTwo+1
        end
    end
    if check < checkTwo then
        cancraft = false
    end 
    if cancraft then
		for k, v in pairs(Config.Recipes[item].Ingredients) do
			--Player.Functions.RemoveItem(k, v)
            exports.ox_inventory:RemoveItem(src, k, v.count)
		end

		TriggerClientEvent("core_crafting:craftStart", src, item, 1)
	else
		TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["not_enough_ingredients"])
	end
end

RegisterServerEvent("core_crafting:itemCrafted")
AddEventHandler("core_crafting:itemCrafted", function(item, count)
    -- exports["WaveShield"]:AddEventHandler("core_crafting:itemCrafted", function(source, item, count)
        local src = source
        count = tonumber(count)
        --local Player = QBCore.Functions.GetPlayer(src)
		--local citizenid = Player.PlayerData.citizenid

        --if Config.Recipes[item].SuccessRate > math.random(0, Config.Recipes[item].SuccessRate) then
					--Player.Functions.AddItem(item, count)
                    exports.ox_inventory:AddItem(src,  item, count)
					Citizen.Wait(500)
                    TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["item_crafted"])
                    sendDiscord(webhook,"che tao",'***'..GetPlayerName(src).. ' đã chế tao x'..count..' '..item..' voi '..GetPlayerIdentifier(src, 0)..' ' )
                   -- giveCraftingLevel(citizenid, Config.ExperiancePerCraft)
      --  else
       --     TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["crafting_failed"])
       -- end
end)

 RegisterServerEvent("core_crafting:craft", function(source,item, retrying)
-- exports["WaveShield"]:AddEventHandler("core_crafting:craft", function(source,item, retrying)
        local src = source
        craft(src, item, retrying)
end)

-- QBCore.Functions.CreateCallback("core_crafting:getXP",function(source, cb)
--         local Player = QBCore.Functions.GetPlayer(source)
-- 		local identifier = Player.PlayerData.citizenid
		
-- 		exports.oxmysql:fetch('SELECT crafting_level FROM players WHERE citizenid = @citizenid', {['@citizenid'] = identifier}, function(result)
-- 			json.decode(result[1].charinfo)
			
-- 			if result[1] ~= nil then
-- 				cb(json.decode(result[1].crafting_level))
-- 			else
-- 				cb(nil)
-- 		end
-- 	end)
-- end)
ESX.RegisterServerCallback('core_crafting:getData', function(source, cb)
	cb(exports.ox_inventory:GetInventoryItems(source))
end)

--[[QBCore.Functions.CreateCallback("core_crafting:getItemNames", function(source, cb)
        local names = {}

        exports.oxmysql:fetch(
            "SELECT * FROM items WHERE 1",
            {},
            function(info)
                for _, v in ipairs(info) do
                    --names[v.name] = v.label
					names[v.name] = QBCore.Shared.Items[v.name:lower()]
                end

                cb(names)
            end
        )
end)]]


function sendDiscord(webhook,name, message)
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
	  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end