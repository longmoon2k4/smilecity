-- ESX = nil
-- ESX = exports["es_extended"]:getSharedObject()
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local hideName = {}
local cachePlayer ={}

function getId(src)
	if cachePlayer[src] then
		return cachePlayer[src]
	end
	cachePlayer[src] = ESX.GetPlayerFromId(src).identifier
	return cachePlayer[src]
end

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if cachePlayer[playerId] ~= nil then
        cachePlayer[playerId] = nil
    end
end)
RegisterServerEvent("PlayersName:truyna")
AddEventHandler("PlayersName:truyna", function(loadFirst)
	local src = source
	local truynatime=0
    local saotruyna = 0
	--local xPlayer = ESX.GetPlayerFromId(src)
	--local Identifier = xPlayer.identifier
    local Identifier = getId(src)
	MySQL.Async.fetchAll("SELECT truyna, saotruyna FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
        truynatime = tonumber(result[1].truyna)
        saotruyna = tonumber(result[1].saotruyna)
        if truynatime ~= nil then
            if truynatime > 0 then
                MySQL.Async.execute(
                    "UPDATE users SET truyna = @newtruyna, saotruyna = @saotruyna WHERE identifier = @identifier",
                    {
                        ['@identifier'] = Identifier,
                        ['@newtruyna'] = truynatime - 1,
                        ['@saotruyna'] = saotruyna
                    }
                )
            end
            TriggerClientEvent("PlayersName:truyna",src,truynatime - 1,truynatime > 0 and true or false, saotruyna)
            if loadFirst and truynatime > 0 then
                TriggerClientEvent('chatMessage', -1,'^1SYSTEM^0: '..'^3'..GetPlayerName(src)..' ^0vừa vào lại game vẫn còn truy nã với Mức độ :^2 '..saotruyna..' Sao')
            end
        end
    end)
end)

--TriggerEvent('es:addGroupCommand','truyna','user',function(source, args,truynatime)
--    local xPlayer = ESX.GetPlayerFromId(source)
--    local truynatime = 0
--    if xPlayer.job.name == "police" then
--        if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then -- Cấp bật trong police để truy nã
--            if GetPlayerName(tonumber(args[1])) ~= nil then
--                Citizen.CreateThread(function()
--                    --local str = ""
--                    --for i = 4, #args do
--                        --str = str .. " " .. args[i]
--                    --end
--                    TriggerClientEvent('chatMessage', -1,'^1SYSTEM^0: '..'^3'..GetPlayerName(tonumber(args[1]))..'  ^0đã bị truy nã bởi ( ^5'..GetPlayerName(source)..'^0 ). ' .. 'Mức độ :^2 '..tonumber(args[3])..' Sao^0 . Thời gian : ^6'..tonumber(args[2])..'  Phút')
--                    --TriggerClientEvent('nui:on', -1,GetPlayerName(tonumber(args[1])) .. ' đã bị truy nã bởi Công An ( '..GetPlayerName(source)..' ) ' .. 'vì tội ' .. str)
--                    --Citizen.Wait((15+3)*1000)
--                    --TriggerClientEvent('nui:off', -1)
--                  --  TriggerEvent('logwantd', '**Thông tin**' ..xPlayer.identifier.. '\n Tên : ' ..xPlayer.name.. '\n **đã mua súng** : ' ..weapon.. '\n**số tiền bị trừ** :' ..v.price)
--                end)
--                local xPlayer1 = ESX.GetPlayerFromId(tonumber(args[1]))
--                local Identifier = xPlayer1.identifier
--                --MySQL.Async.fetchAll("SELECT truyna FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
--                    MySQL.Async.execute(
--                        "UPDATE users SET truyna = @newtruyna WHERE identifier = @identifier",
--                        {
--                            ['@identifier'] = Identifier,
--                            ['@newtruyna'] = tonumber(args[2])
--                        }
--                    )
--                --end)
--                TriggerClientEvent("TruyNa",tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
--            end
--        end
--    end
--end)


RegisterCommand("truyna", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    --local tpPlayer = ESX.GetPlayerFromIdCard(args[1])
    if xPlayer.job.name == "police" then
        if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then -- Cấp bật trong police để truy nã
            if GetPlayerName(tonumber(args[1])) ~= nil then
                TriggerClientEvent('chatMessage', -1,'^1SYSTEM^0: '..'^3'..GetPlayerName(tonumber(args[1]))..'  ^0đã bị truy nã bởi ( ^5'..GetPlayerName(source)..'^0 ). ' .. 'Mức độ :^2 '..tonumber(args[3])..' Sao^0 . Thời gian : ^6'..tonumber(args[2])..'  Phút')
                --local xPlayer1 = ESX.GetPlayerFromId(tonumber(args[1]))
                --local Identifier = xPlayer1.identifier
                local Identifier = getId(tonumber(args[1]))
                --MySQL.Async.fetchAll("SELECT truyna FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
                    MySQL.Async.execute(
                        "UPDATE users SET truyna = @newtruyna, saotruyna = @saotruyna WHERE identifier = @identifier",
                        {
                            ['@identifier'] = Identifier,
                            ['@newtruyna'] = tonumber(args[2]),
                            ['@saotruyna'] = tonumber(args[3])
                        }
                    )
                --end)
                TriggerClientEvent("TruyNa",tonumber(args[1]),tonumber(args[2]),tonumber(args[3]))
            end
        end
    end
end, false)

RegisterServerEvent("PlayersName:SetTruyNa")
AddEventHandler("PlayersName:SetTruyNa", function(source,time,sao)
	local src = source
    --local xPlayer = ESX.GetPlayerFromId(src)
    if GetPlayerName(src) ~= nil then
        local Identifier = getId(src)
        --MySQL.Async.fetchAll("SELECT truyna FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
            MySQL.Async.execute(
                "UPDATE users SET truyna = @newtruyna, saotruyna = @saotruyna WHERE identifier = @identifier",
                {
                    ['@identifier'] = Identifier,
                    ['@newtruyna'] = time,
                    ['@saotruyna'] = sao
                }
            )
        --end)
        TriggerClientEvent("TruyNa",src,time,sao)
    end
end)

function inArray(source)
    for _, v in pairs(hideName) do
        if v == source then
            return true
        end
    end
    return false
end

function removeArray(source)
    for k, v in pairs(hideName) do
        if v == source then
            table.remove(hideName, k)
            break
        end
    end
    return false
end

RegisterCommand("hidename", function(source, args, rawCommand)
    if not inArray(source) then
        table.insert(hideName, source)
        TriggerClientEvent('PlayersName:HideName', -1 , source)
    end
end, true)

RegisterCommand("showname", function(source, args, rawCommand)
    if inArray(source) then
        removeArray(source)
        TriggerClientEvent('PlayersName:ShowName', -1 , source)
    end
end, true)

ESX.RegisterServerCallback("getListHide", function(source, cb)
   cb(hideName)
end)