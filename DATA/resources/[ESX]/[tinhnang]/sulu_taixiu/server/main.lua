local isOpen = true
local webhook = "https://discord.com/api/webhooks/tatwebhooks/1052052633239703602/u6axQb9B1HWKP668WlPgtYiPj3_nR-P3UBhGOVIVPu__bRSV4WlvrnKMBZNuuPt2hLkJ"
local dataPlayer = {}
local datTai = {}
local datXiu = {}
local time = 60
local timeWait = 0
local playing = true
local waiting = false

function datCua(source, dice, money)
    local check = true 
    if dice =='tai' then
        for k,v in pairs(datTai) do
            if v.id == source then
                check = false
            end
        end
        if check then
            if exports.ox_inventory:RemoveItem(source, 'money', money) then
                table.insert(datTai,{id = source, money = money})
                TriggerClientEvent('esx:showNotification', source,"Đã đặt "..money.."$")
                for k1,v1 in pairs(dataPlayer) do
                    TriggerClientEvent('taixiu:gameData', v1, datTai, datXiu, time)
                end
                SendToDiscord(source, " Đã đặt "..dice.." "..money.."$")
            end
        else
            TriggerClientEvent('esx:showNotification', source,"Bạn đã đặt cửa này rồi")
        end
    elseif dice =='xiu' then
        for k,v in pairs(datXiu) do
            if v.id == source then
                check = false
            end
        end
        if check then
            if exports.ox_inventory:RemoveItem(source, 'money', money) then
                table.insert(datXiu,{id = source, money = money})
                TriggerClientEvent('esx:showNotification', source,"Đã đặt "..money.."$")
                for k1,v1 in pairs(dataPlayer) do
                    TriggerClientEvent('taixiu:gameData', v1, datTai, datXiu, time)
                end
                SendToDiscord(source, " Đã đặt "..dice.." "..money.."$")
            end
        else
            TriggerClientEvent('esx:showNotification', source,"Bạn đã đặt cửa này rồi")
        end
    end
end

function totalCua(array)
    local sum = 0
    for k,v in pairs(array) do
        sum = sum + v.money
    end
    return sum
end

function canKeo(tongTai, tongXiu)
    if tongTai > tongXiu then
        local needRemove = tongTai - tongXiu
        while needRemove > 0 do
            if needRemove >= datTai[#datTai].money then
                needRemove = needRemove - datTai[#datTai].money
                exports.ox_inventory:AddItem(datTai[#datTai].id, 'money', datTai[#datTai].money)
                TriggerClientEvent('esx:showNotification', datTai[#datTai].id,"Trả lại tiền cân kèo "..datTai[#datTai].money)
                table.remove(datTai, #datTai)
            elseif needRemove < datTai[#datTai].money then
                datTai[#datTai].money = datTai[#datTai].money - needRemove
                exports.ox_inventory:AddItem(datTai[#datTai].id, 'money', needRemove)
                TriggerClientEvent('esx:showNotification', datTai[#datTai].id,"Trả lại tiền cân kèo "..needRemove)
                needRemove = 0
            end
        end
    elseif tongXiu > tongTai then
        local needRemove = tongXiu - tongTai
        while needRemove > 0 do
            if needRemove >= datXiu[#datXiu].money then
                needRemove = needRemove - datXiu[#datXiu].money
                exports.ox_inventory:AddItem(datXiu[#datXiu].id, 'money', datXiu[#datXiu].money)
                TriggerClientEvent('esx:showNotification', datXiu[#datXiu].id,"Trả lại tiền cân kèo "..datXiu[#datXiu].money)
                table.remove(datXiu, #datXiu)
            elseif needRemove < datXiu[#datXiu].money then
                datXiu[#datXiu].money = datXiu[#datXiu].money - needRemove
                exports.ox_inventory:AddItem(datXiu[#datXiu].id, 'money', needRemove)
                TriggerClientEvent('esx:showNotification', datXiu[#datXiu].id,"Trả lại tiền cân kèo "..needRemove)
                needRemove = 0
            end
        end
    end
end

function rollDice()
    local dice1 = math.random(1, 6)
    local dice2 = math.random(1, 6)
    local dice3 = math.random(1, 6)
    local total = dice1 + dice2 + dice3
    TriggerClientEvent('taixiu:gameOver', -1 ,{dice1 = dice1, dice2 = dice2, dice3 = dice3, result = total <= 10 and 'xiu' or 'tai'})
    local sumTai = totalCua(datTai)
    local sumXiu = totalCua(datXiu)
    canKeo(sumTai, sumXiu)
    if total <= 10 then
        for k,v in pairs(datXiu) do
            if exports.ox_inventory:AddItem(v.id, 'money', v.money*1.95) then
                TriggerClientEvent('esx:showNotification', v.id,"Bạn đã chiến thắng và nhận được "..v.money*1.95)
                --TriggerClientEvent('chatMessage', -1, 'TÀI XỈU', { 255, 255, 255 }, '^1* [' .. GetPlayerName(v.id)..' chơi tài xỉu và đã thắng được '..math.ceil(v.money)..'$')
            end
        end
    else
        for k,v in pairs(datTai) do
            if exports.ox_inventory:AddItem(v.id, 'money', v.money*1.95) then
                TriggerClientEvent('esx:showNotification', v.id,"Bạn đã chiến thắng và nhận được "..v.money*1.95)
                --TriggerClientEvent('chatMessage', -1, 'TÀI XỈU', { 255, 255, 255 }, '^1* [' .. GetPlayerName(v.id)..' chơi tài xỉu và đã thắng được '..math.ceil(v.money)..'$')
            end
        end
    end
    datTai = {}
    datXiu = {}
end

RegisterServerEvent("taixiu:checkmoney")
AddEventHandler("taixiu:checkmoney", function(dice, money)
    local _source   = source
    if playing and not waiting then
        local money = math.floor(money)
        local cashAmount = exports.ox_inventory:Search(_source, 'count', 'money')
        if money > 0 and money <= 10000000 then
            if cashAmount >= money then
                --TriggerEvent('taixiu:pull', _source, dice, money)
                datCua(_source, dice, money)
            else
                TriggerClientEvent('esx:showNotification', _source,"Bạn không có đủ tiền")
            end
        else
            TriggerClientEvent('esx:showNotification', _source, "Tiền đặt phải lớn hơn 0 và nhỏ hơn 10.000.000 ")
        end
    else
        TriggerClientEvent('esx:showNotification', _source, "Đang trong thời gian chờ "..timeWait.." giây")
    end
end)

RegisterServerEvent("taixiu:join")
AddEventHandler("taixiu:join", function()
    local source = source
    table.insert(dataPlayer, source)
    TriggerClientEvent('taixiu:gameData', source, datTai, datXiu, time)
end)

RegisterServerEvent("taixiu:left")
AddEventHandler("taixiu:left", function()
    local source = source
    for k,v in pairs(dataPlayer) do
        if v == source then
            table.remove(dataPlayer, k)
            break
        end
    end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    for k,v in pairs(dataPlayer) do
        if v == playerId then
            table.remove(dataPlayer, k)
            break
        end
    end
end)

--function startGame()
Citizen.CreateThread( function()
    while true do 
        if playing and not waiting then
            time = time - 1
            if time <= 0 then
                playing = false
                waiting = true
                timeWait = 15
                rollDice()
            end
        end
        if waiting and not playing then
            timeWait = timeWait - 1
            if timeWait <= 0 then
                playing = true
                waiting = false
                time = 60
                TriggerClientEvent('taixiu:gameStart', -1)
                for k1,v1 in pairs(dataPlayer) do
                    TriggerClientEvent('taixiu:gameData', v1, datTai, datXiu, time)
                end
            end
        end
        Citizen.Wait(1000)
    end
end)
--end

----------------------DISCORD--------------------------------
function SendToDiscord(id, msg)
	local _source = id
	local playername = GetPlayerName(_source)
	local connect = {
		{
			["color"] = "8663711",
			["title"] = "Tài xỉu",
			["description"] = "**Người chơi: "..playername.."\n  "..msg.."**",
			["footer"] = {
				["text"] = "Sulu",
				["icon_url"] = "",
			},
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Tài xỉu", embeds = connect}), { ['Content-Type'] = 'application/json' })
end