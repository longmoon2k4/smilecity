--ESX = nil
local webhook1 ='https://discord.com/api/webhooks/tatwebhooks/1052072803735715850/U3wBqupbiC1mr1cnqlK3r8ZGn8pZKR28T2ADoVBFV-ZU1sgHWtYr88oier_PXSGAY0Ez'
local webhook2 ='https://discord.com/api/webhooks/tatwebhooks/1052072855438893127/oYN6Fw6SNSYgKXPDUwCd_lIr_QbYp4vZfk7A2jqfwUMzwR3BeSIw6i9mUdi2Ldh-j58y'
local webhook3 ='https://discord.com/api/webhooks/tatwebhooks/1052072910061326376/Wa7g7anJgNsJQrWusLm1XgX71nSqsujhKsolnpDTdR4jCR8qXt2DBILUscDCCWFFb8Y4'
local webhook4 ='https://discord.com/api/webhooks/tatwebhooks/1052072975622484028/7eNfC4Uz4A6oDfYY5hgyzezM3jptX_oyNo9Ne4g_W3CHnmCV63E15wJx46lyKl-rkbkp'
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ant_stone:pickedUp')
AddEventHandler('ant_stone:pickedUp', function()
-- exports["WaveShield"]:AddEventHandler("ant_stone:pickedUp", function(source)
	local _source = source
    local x =  math.random(1,3)
    if exports.ox_inventory:CanCarryItem(_source, 'stones', x) then
        exports.ox_inventory:AddItem(_source, 'stones', x)
        -- sendDiscord(webhook1,"đào đá",'***'..GetPlayerName(_source).. '*** đã khai thác '..x..' đá ' )
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn đã đủ đá trong túi","error")
    end       
end)


RegisterNetEvent("esx_miner:washing")
AddEventHandler("esx_miner:washing", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_miner:washing", function(source)
    local _source = source
    if exports.ox_inventory:CanSwapItem(_source, "stones", 5, "washedstones", 5)  then 
        exports.ox_inventory:AddItem(_source, 'washedstones', 5)
        exports.ox_inventory:RemoveItem(_source, 'stones', 5)
        -- sendDiscord(webhook2,"rửa đá",'***'..GetPlayerName(_source).. '*** đã xử lý 5 đá ' )
    else
        TriggerClientEvent('esx:showNotification', _source, "Bạn đã đủ đá hoặc không còn nguyên liệu","error")
    end  
end)


RegisterNetEvent("esx_miner:remelting")
AddEventHandler("esx_miner:remelting", function(item, count)
-- exports["WaveShield"]:AddEventHandler("esx_miner:remelting", function(source)
    local _source = source
    local randomChance = math.random(1, 100)
    if exports.ox_inventory:Search(_source, 'count', "washedstones" ) >=1 then  
        if  randomChance < 5  then
            if exports.ox_inventory:CanSwapItem(_source, "washedstones", 1, "diamond", 3)  then 
                exports.ox_inventory:AddItem(_source, 'diamond', 1)
                exports.ox_inventory:AddItem(_source, 'gold', 1)
                exports.ox_inventory:AddItem(_source, 'iron', 1)
                exports.ox_inventory:AddItem(_source, 'copper', 1)
                exports.ox_inventory:RemoveItem(_source, 'washedstones', 1) 
                TriggerEvent('reward_event:additem', _source , 'copper', 1)
                TriggerEvent('reward_event:additem', _source , 'diamond', 1)
            else
                TriggerClientEvent('esx:showNotification', _source, "Kho đồ đầy","error")
            end
            -- sendDiscord(webhook3,"nung đá",'***'..GetPlayerName(_source).. '*** đã chế biến 1 đá sạch được 1 Kim Cương 1 vàng 1 sắt 1 đồng ' ) 
        elseif  randomChance > 5 and randomChance < 20 then
            if exports.ox_inventory:CanSwapItem(_source, "washedstones", 1, "gold", 2)  then 
                exports.ox_inventory:AddItem(_source, 'gold', 1)
                exports.ox_inventory:AddItem(_source, 'iron', 1)
                exports.ox_inventory:AddItem(_source, 'copper', 1)
                exports.ox_inventory:RemoveItem(_source, 'washedstones', 1)
                TriggerEvent('reward_event:additem', _source , 'copper', 1)
            else
                TriggerClientEvent('esx:showNotification', _source, "Kho đồ đầy","error")
            end
            -- sendDiscord(webhook3,"nung đá",'***'..GetPlayerName(_source).. '*** đã chế biến 1 đá sạch được 1 vàng 1 sắt 1 đồng ' )
         elseif  randomChance > 20 and randomChance < 55 then
            if exports.ox_inventory:CanSwapItem(_source, "washedstones", 1, "iron", 2)  then 
                exports.ox_inventory:AddItem(_source, 'iron', 1)
                exports.ox_inventory:AddItem(_source, 'copper', 1)
                exports.ox_inventory:RemoveItem(_source, 'washedstones', 1)
                TriggerEvent('reward_event:additem', _source , 'copper', 1)
            else
                TriggerClientEvent('esx:showNotification', _source, "Kho đồ đầy","error")
            end
            -- sendDiscord(webhook3,"nung đá",'***'..GetPlayerName(_source).. '*** đã chế biến 1 đá sạch được 1 sắt 1 đồng ' )
        elseif  randomChance > 55 and randomChance < 95 then
            if exports.ox_inventory:CanSwapItem(_source, "washedstones", 1, "copper", 1)  then
                exports.ox_inventory:AddItem(_source, 'copper', 1)
                exports.ox_inventory:RemoveItem(_source, 'washedstones', 1)
                TriggerEvent('reward_event:additem', _source , 'copper', 1)
            else
                TriggerClientEvent('esx:showNotification', _source, "Kho đồ đầy","error")
            end
            -- sendDiscord(webhook3,"nung đá",'***'..GetPlayerName(_source).. '*** đã chế biến 1 đá sạch được 1 đồng ' )
        else
            TriggerClientEvent('esx:showNotification', _source, "em đen lắm",'error')
        end
    else
        TriggerClientEvent('esx:showNotification', _source, "Không đủ nguyên liệu!")
    end    
end)

-- RegisterNetEvent("esx_miner:selldiamond")
-- AddEventHandler("esx_miner:selldiamond", function(item, count)
--     local _source = source
--     local DiamondPrice = Config.DiamondPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local DiamondQuantity = xPlayer.getInventoryItem('diamond').count
--     if DiamondQuantity > 0  then
--         xPlayer.addMoney(DiamondQuantity * DiamondPrice)
--         xPlayer.removeInventoryItem('diamond', DiamondQuantity)
--         sendDiscord(webhook4,"bán kim cương",'***'..GetPlayerName(_source).. '*** đã bán '.. DiamondQuantity .. ' Kim cương và nhận được '.. DiamondQuantity * DiamondPrice .. ' ' )
--        -- TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán '.. DiamondQuantity .. ' Kim cương và nhận được '.. DiamondQuantity * DiamondPrice .. '')
--         TriggerClientEvent('esx:showNotification', _source,  ("Bạn đã bán %s Kim cương và nhận đc %s"):format(DiamondQuantity, DiamondQuantity * DiamondPrice))
--     else
--         TriggerClientEvent('esx:showNotification', _source, 'Bạn không còn đủ Kim cương.')
--     end
--     end)


-- RegisterNetEvent("esx_miner:sellgold")
-- AddEventHandler("esx_miner:sellgold", function(item, count)
--     local _source = source
--     local GoldPrice = Config.GoldPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local GoldQuantity = xPlayer.getInventoryItem('gold').count

--     if GoldQuantity > 0  then
--         xPlayer.addMoney(GoldQuantity * GoldPrice)
--         xPlayer.removeInventoryItem('gold', GoldQuantity)
--         sendDiscord(webhook4,"bán vàng", '***'..GetPlayerName(_source).. '*** đã bán '.. GoldQuantity .. ' Vàng và nhận được '.. GoldQuantity * GoldPrice .. ' ' )
--        -- TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán '.. GoldQuantity .. ' Vàng và nhận được '.. GoldQuantity * GoldPrice .. '')
--         TriggerClientEvent('esx:showNotification', _source, ("Bạn đã bán %s Sắt và nhận đc %s"):format(GoldQuantity, GoldQuantity * GoldPrice))
--         else
--             TriggerClientEvent('esx:showNotification', _source, 'Bạn không còn đủ Vàng.')
--         end
--     end)


-- RegisterNetEvent("esx_miner:selliron")
-- AddEventHandler("esx_miner:selliron", function(item, count)
--     local _source = source
--     local IronPrice = Config.IronPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local IronQuantity = xPlayer.getInventoryItem('iron').count

--     if IronQuantity > 0  then
--         xPlayer.addMoney(IronQuantity * IronPrice)
--         xPlayer.removeInventoryItem('iron', IronQuantity)
--         sendDiscord(webhook4,"bán sắt",  '***'..GetPlayerName(_source).. '*** đã bán '.. IronQuantity .. ' Sắt và nhận được '.. IronQuantity * IronPrice .. ' ' )
--       --  TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán '.. IronQuantity .. ' Sắt và nhận được '.. IronQuantity * IronPrice .. '')
--        TriggerClientEvent('esx:showNotification', _source, ("Bạn đã bán %s Sắt và nhận đc %s"):format(IronQuantity, IronQuantity * IronPrice))
--         else
--             TriggerClientEvent('esx:showNotification', _source, 'Bạn không còn đủ Sắt.')
--         end
--     end)


-- RegisterNetEvent("esx_miner:sellcopper")
-- AddEventHandler("esx_miner:sellcopper", function(item, count)
--     local _source = source
--     local CopperPrice = Config.CopperPrice
--     local xPlayer  = ESX.GetPlayerFromId(_source)
--     local CopperQuantity = xPlayer.getInventoryItem('copper').count

--     if CopperQuantity > 0  then
--         xPlayer.addMoney(CopperQuantity * CopperPrice)
--         xPlayer.removeInventoryItem('copper', CopperQuantity)
--         sendDiscord(webhook4,"bán đồng",  '***'..GetPlayerName(_source).. '*** đã bán '.. CopperQuantity .. ' Đồng và nhận được '.. CopperQuantity * CopperPrice .. ' ' )
--       --  TriggerEvent("DiscordBot:LogDiscord",webhook4, '***'..GetPlayerName(_source).. '*** đã bán '.. CopperQuantity .. ' Đồng và nhận được '.. CopperQuantity * CopperPrice .. '')
--         TriggerClientEvent('esx:showNotification', _source, ("Bạn đã bán %s Đồng và nhận đc %s"):format(CopperQuantity, CopperQuantity * CopperPrice))
--         else
--             TriggerClientEvent('esx:showNotification', _source, 'Bạn không còn đủ Đồng.')
--         end
--     end)

    

-- RegisterServerEvent('lsrp_stone:PlayWithinDistance')
-- AddEventHandler('lsrp_stone:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
-- 	TriggerClientEvent('lsrp_stone:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume)
-- end)

-- function havePermission(_source)
-- 	local identifier = GetPlayerIdentifier(_source)
-- 	local isVip = false
-- 	for _,v in pairs(Config.vip) do
-- 		if v == identifier then
-- 			isVip = true
-- 			break
-- 		end
-- 	end
	
-- 	if IsPlayerAceAllowed(_source, "giveownedcar.command") then isVip = true end
	
-- 	return isVip
-- end



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