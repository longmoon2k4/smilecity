


--visit my discord: https://discord.gg/wsyryrC  CREATE BY Stark#5844 DO NOT REMOVE CREDITS
--visit my discord: https://discord.gg/wsyryrC  CREATE BY Stark#5844 DO NOT REMOVE CREDITS
--visit my discord: https://discord.gg/wsyryrC  CREATE BY Stark#5844 DO NOT REMOVE CREDITS

--ESX  = nil
local QBCore = nil 

-- if Config.FrameWork == 'ESX' then 
-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- elseif Config.FrameWork == 'QBUS' then 
-- 	QBCore = exports['qb-core']:GetCoreObject()
-- end



RegisterServerEvent('ifood:darmoney')
AddEventHandler('ifood:darmoney', function()
-- exports["WaveShield"]:AddEventHandler("ifood:darmoney", function(source)
	local _source = source 
	if ESX ~= nil then 
		-- local xPlayer = ESX.GetPlayerFromId(_source)
		-- xPlayer.addMoney(Config.Pagamento)
		exports.ox_inventory:AddItem(_source, 'money', Config.Pagamento)
		TriggerEvent('reward_event:additem', _source , 'pizza', 1)
		-- sendDiscord('pizze', GetPlayerName(_source).." đã giao bánh và nhận được "..Config.Pagamento.. "$ ")
	elseif QBCore ~= nil then 
		local xPlayer = QBCore.Functions.GetPlayer(src)
		xPlayer.Functions.AddMoney('cash', Config.Pagamento, 'Pay Job')
	end

end)

RegisterServerEvent('ifood:darmoney1')
AddEventHandler('ifood:darmoney1', function()
	-- exports["WaveShield"]:AddEventHandler("ifood:darmoney1", function(source)
	local _source = source 
	local money = 10000

	if ESX ~= nil then 
		-- local xPlayer = ESX.GetPlayerFromId(_source)
		-- xPlayer.removeMoney(money)
		exports.ox_inventory:RemoveItem(_source, 'money', money)
	end
end)

RegisterServerEvent('ifood:darmoney2')
AddEventHandler('ifood:darmoney2', function()
	-- exports["WaveShield"]:AddEventHandler("ifood:darmoney2", function(source)
	local _source = source 
	local money = 10000

	if ESX ~= nil then 
		-- local xPlayer = ESX.GetPlayerFromId(_source)
		-- xPlayer.addMoney(money)
		exports.ox_inventory:AddItem(_source, 'money', money)
	end
end)

local webhook = "https://discord.com/api/webhooks/tatwebhooks/1052078250047840287/j-3GRlI-3L58QFC_r9Fyi-E9k4n2N9BwzCiX1pKiB3CLJWkEMZw85YU0AQ2x3KGR0w_M"
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
      PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end