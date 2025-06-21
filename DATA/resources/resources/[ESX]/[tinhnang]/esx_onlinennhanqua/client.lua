local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
-- ESX = nil
local PlayerData = nil
local thoigianonline = 0
local day1 = nil
local day2 = nil
local day3 = nil
local day4 = nil
local day5 = nil
local day6 = nil
local day7 = nil
local day8 = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    if PlayerData == nil then 
       PlayerData = xPlayer
    end
    ESX.TriggerServerCallback('esx_onlinenhanqua:retrievetime', function(time, day1, day2, day3, day4, day5, day6, day7, day8)
        checkra(time, day1, day2, day3, day4, day5, day6, day7, day8)
    end)
end)

function checkra(v, a, b, c, d, g, h, k, l)
    thoigianonline = v
    day1 = a
    day2 = b
    day3 = c
    day4 = d
    day5 = g
    day6 = h
    day7 = k
    day8 = l
    SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
end

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
--     PlayerData = xPlayer
-- end)

RegisterNetEvent('esx_onlinenhanqua:restartdiem')
AddEventHandler('esx_onlinenhanqua:restartdiem', function()
    thoigianonline = 0
    day1 = nil
    day2 = nil
    day3 = nil
    day4 = nil
    day5 = nil
    day6 = nil
    day7 = nil
    day8 = nil
    SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
    ESX.TriggerServerCallback('esx_onlinenhanqua:retrievetime', function(time, day1, day2, day3, day4, day5, day6, day7, day8)
        checkra(time, day1, day2, day3, day4, day5, day6, day7, day8)
    end)
end)

Citizen.CreateThread(function()
	while true do
		Wait(600000)
		thoigianonline = thoigianonline + 10
        SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
        TriggerServerEvent('esx_onlinenhanqua:updatetime', 10)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(0)
-- 		if IsControlJustReleased(0, 344) then
--             toggle(true)
-- 		end
-- 	end
-- end)
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(0)
-- 		if IsControlJustReleased(0, 322) then
--             toggle(false)
--             SetNuiFocus(false, false)
-- 		end
-- 	end
-- end)
RegisterCommand('fixmenu', function()
    toggle(false)
    SetNuiFocus(false, false)
end)
RegisterNUICallback('closemenu', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('nhanqua1', function(data, cb)
    if day1 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 30 then
        day1 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day1")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 30 phút')
    end
end)

RegisterNUICallback('nhanqua2', function(data, cb)
    if day2 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 120 then
        day2 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day2")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotificationNew('Bạn chưa đủ điền kiện online: 120 phút')
    end
end)

RegisterNUICallback('nhanqua3', function(data, cb)
    if day3 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 180 then
        day3 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day3")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 180 phút')
    end
end)

RegisterNUICallback('nhanqua4', function(data, cb)
    if day4 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 240 then
        day4 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day4")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 240 phút')
    end
end)

RegisterNUICallback('nhanqua5', function(data, cb)
    if day5 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 300 then
        day5 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day5")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 300 phút')
    end
end)

RegisterNUICallback('nhanqua6', function(data, cb)
    if day6 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 360 then
        day6 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day6")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 360 phút')
    end
end)


RegisterNUICallback('nhanqua7', function(data, cb)
    if day7 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 420 then
        day7 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day7")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 420 phút')
    end
end)


RegisterNUICallback('nhanqua8', function(data, cb)
    if day8 == "danhan" then return ESX.ShowNotificationNew('Bạn đã nhận rồi') end
    if thoigianonline >= 500 then
        day8 = "danhan"
        open()
        TriggerServerEvent('esx_onlinenhanqua:updateday', "day8")
        TriggerServerEvent("esx_onlinenhanqua:nhanqua")
        -- exports["WaveShield"]:TriggerServerEvent("esx_onlinenhanqua:nhanqua")
    else
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 500 phút')
    end
end)


function open()
	PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
	SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
end

function toggle(status)
    SendNUIMessage({
        action = "toggle", 
        show = status, 
        online = thoigianonline,
        day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8
    })
    SetNuiFocus(status, status)
end

RegisterNetEvent('esx_nhanquaonline')
AddEventHandler('esx_nhanquaonline', function()
    toggle(true)
end)
