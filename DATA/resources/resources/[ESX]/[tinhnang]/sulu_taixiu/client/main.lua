local isUiOpen = false 
local join = false
local PlayerData = {}
local taixiuloc = {
	{ ['x'] = 1111.06, ['y'] = 237.16, ['z'] = -49.84 },
	{ ['x'] = 1113.63, ['y'] = 238.19, ['z'] = -49.84 },
	{ ['x'] = 1107.28, ['y'] = 238.18, ['z'] = -49.84 },
}

RegisterKeyMapping('taixiu', 'Tai Xiu', 'keyboard', "MINUS")
RegisterCommand('taixiu', function()
    if  isUiOpen == false and not IsPlayerDead(PlayerId()) then
        --ESX.TriggerServerCallback("sulu_taixiu:callback:isOpen", function(isOpen)
        --    --print(isOpen)
        --    if isOpen then 
                SendNUIMessage({
                    displayWindow = 'true'
                })
                isUiOpen = true
                TriggerEvent('taixiu:enter')
                --TransitionToBlurred(1000)
        --    end 
        --end)
    end
end, true)

RegisterNUICallback("NUIFocusOff",function()
    SetNuiFocus(false, false)
    isUiOpen = false
    --closeTaixiu()
end)
RegisterNUICallback("Close", function()
    TriggerServerEvent('taixiu:left')
    closeTaixiu()
end)

RegisterNUICallback('Notification', function(data, cb)
	ESX.ShowNotification(data.message)
end)

RegisterNUICallback("datxiu",function(dulieu)
    TriggerServerEvent("taixiu:checkmoney", dulieu.dice, dulieu.money)
end)

RegisterNUICallback("dattai",function(dulieu)
    TriggerServerEvent("taixiu:checkmoney", dulieu.dice, dulieu.money)
end)

function closeTaixiu()
    isUiOpen = false  
    join = false
    SendNUIMessage(
        {
            displayWindow = 'false'
        }
    )
    SetNuiFocus(false, false)
	--TransitionFromBlurred(1000)
end

RegisterNetEvent("taixiu:enter")
AddEventHandler("taixiu:enter", function ()
    if not join then
        TriggerServerEvent('taixiu:join')
        join = true
    end
    SetNuiFocus(true, true)
end)

RegisterNetEvent("taixiu:exit")
AddEventHandler("taixiu:exit", function ()
    SetNuiFocus(false, false)	
end)


--[[ RegisterNetEvent("taixiu:checkmoney")
AddEventHandler("taixiu:checkmoney", function (id, dice, money)
	TriggerServerEvent('taixiu:pull', id, dice, money);
end) ]]

RegisterNetEvent("taixiu:pull")
AddEventHandler("taixiu:pull", function (msg)
	SendNUIMessage({
        type = "pull",
        tinnhan = msg.status,
    })
	--TriggerServerEvent('taixiu:checkthoigian', msg)
end)

--RegisterCommand("tai", function()
--    TriggerServerEvent('taixiu:pull', GetPlayerServerId(PlayerId()), "tai", 100000)
--end)

--RegisterNUICallback("ketQua",function()
--	TriggerServerEvent("taixiu:layketqua")
--end)
--RegisterNetEvent('taixiu:traketqua')
--AddEventHandler('taixiu:traketqua', function(ketqua1, ketqua2, ketqua3)
--	SendNUIMessage({
--		type = "ketqua",
--        traketqua1 = ketqua1,
--        traketqua2 = ketqua2,
--        traketqua3 = ketqua3,
--	})
--end)
RegisterNetEvent('taixiu:gameData')
AddEventHandler('taixiu:gameData', function (dattai, datxiu, time)
    local sumTai = 0
    local sumXiu = 0
    for k,v in pairs(dattai) do
        sumTai = sumTai + v.money
    end
    for k,v in pairs(datxiu) do
        sumXiu = sumXiu + v.money
    end
	SendNUIMessage({
        type = "gameData",
        id = 0,
        chontai = #dattai,
        chonxiu = #datxiu,
        tientai = sumTai,
        tienxiu = sumXiu,
        t = time,
    })
end)

--RegisterNetEvent('taixiu:gameData')
--AddEventHandler('taixiu:gameData', function (dulieu2)
--    
--	SendNUIMessage({
--        type = "gameData",
--        id = dulieu2.idGame,
--        chontai = dulieu2.soNguoiChonTai,
--        chonxiu = dulieu2.soNguoiChonXiu,
--        tientai = dulieu2.tongTienDatTai,
--        tienxiu = dulieu2.tongTienDatXiu,
--        t = dulieu2.time,
--    })
--end)

RegisterNUICallback("nhankeo",function (nhankeo)
	SendNUIMessage({
        type = "nhankeo",
        msg = nhankeo.msg,
    })
end)

RegisterNetEvent('taixiu:gameStart')
AddEventHandler('taixiu:gameStart',function(ketQua)
	SendNUIMessage({
        type = "gameStart",
    })
end)

RegisterNetEvent('taixiu:gameOver')
AddEventHandler('taixiu:gameOver', function(ketQua)
	SendNUIMessage(
		{
			type = "gameOver",
			dice1 = ketQua.dice1,
			dice2 = ketQua.dice2,
			dice3 = ketQua.dice3,
			result = ketQua.result,
		}
	)
end)

