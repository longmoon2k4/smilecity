local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

-- ESX = nil
local PlayerData = nil
local dangping   = {status = false, nguoinhan = 'chưa có', id = nil, job = nil, huy = nil}
Citizen.CreateThread(
    function()
        -- while ESX == nil do
        --     TriggerEvent(
        --         "esx:getSharedObject",
        --         function(obj)
        --             ESX = obj
        --         end
        --     )
        --     Citizen.Wait(0)
        -- end
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(100)
        end
        ESX.PlayerData = ESX.GetPlayerData()
    end
)

RegisterNetEvent("esx_ping:menu")
AddEventHandler("esx_ping:menu", function()
    OpenNguoiDan()
end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         if IsControlJustReleased(0, Keys["F6"]) then
--             OpenNguoiDan()
--         end
--     end
-- end)

function OpenNguoiDan()
    SendNUIMessage({
		status   = dangping,
        datajob  = Config.Ping,
    })
    --SetNuiFocus(true, true)
end

--RegisterNUICallback('closemenu', function(data, cb)
--    SetNuiFocus(false, false)
--end)

RegisterCommand('pingch', function()
    if dangping.status == false then
        ESX.TriggerServerCallback("checkblacklistmed", function(data)
            if data == true then
                --local playerCoords = GetEntityCoords(PlayerPedId())
                dangping   = {status = true, nguoinhan = 'chưa có', id = nil, job = nil, huy='/huych'}
                OpenNguoiDan()
                TriggerServerEvent("request_menu:sendData", "ambulance", ' (sửa xe)')
                ESX.ShowNotification('~g~Bạn đã ping cứu hộ sẽ có người tới sửa xe lỏ của bạn!')
            end
        end)
    else
        ESX.ShowNotification('~r~Bạn đang có dịch vụ khác!')
    end
end)

RegisterCommand('huych', function()
    TriggerServerEvent("request_menu:huydichvu", dangping.id, 'ambulance')
    dangping   = {status = false, nguoinhan = 'chưa có', id = nil, job = nil, huy=nil}
    OpenNguoiDan()
end)

RegisterCommand('pingca', function()
    if dangping.status == false then
        -- ESX.TriggerServerCallback("checkblacklistch", function(data)
        --     if data == true then
                --local playerCoords = GetEntityCoords(PlayerPedId())
                dangping   = {status = true, nguoinhan = 'chưa có', id = nil, job = nil, huy='/huyca'}
                OpenNguoiDan()
                TriggerServerEvent("request_menu:sendData", "police", ' ')
                ESX.ShowNotification('~g~Bạn đã ping police!')
        --     end
        -- end)
    else
        ESX.ShowNotification('~r~Bạn đang có dịch vụ khác!')
    end
end)

RegisterCommand('huyca', function()
    TriggerServerEvent("request_menu:huydichvu", dangping.id, 'police')
    dangping   = {status = false, nguoinhan = 'chưa có', id = nil, job = nil, huy=nil}
    OpenNguoiDan()
end)

RegisterCommand('huymed', function()
    TriggerServerEvent("request_menu:huydichvu", dangping.id, 'ambulance')
    dangping   = {status = false, nguoinhan = 'chưa có', id = nil, job = nil, huy=nil}
    OpenNguoiDan()
end)

RegisterCommand('pingmed', function()
    if dangping.status == false then
        ESX.TriggerServerCallback("checkblacklistmed", function(data)
            if data == true then
                --local playerCoords = GetEntityCoords(PlayerPedId())
                dangping   = {status = true, nguoinhan = 'chưa có', id = nil, job = nil, huy='/huymed'}
                OpenNguoiDan()
                TriggerServerEvent("request_menu:sendData", "ambulance", ' (cứu người)')
                ESX.ShowNotification('~g~Bạn đã ping med sẽ có người tới cứu rỗi bạn!')
            end
        end)
    else
        ESX.ShowNotification('~r~Bạn đang có dịch vụ khác!')
    end
end)

--RegisterNUICallback('ping', function(data, cb)
--    ESX.TriggerServerCallback("checkBlacklist", function(data)
--        if data == true then
--            local playerCoords = GetEntityCoords(PlayerPedId())
--            dangping   = {status = true, nguoinhan = 'chưa có', id = nil, job = nil}
--            TriggerServerEvent("request_menu:sendData", data.jobname, data.value, playerCoords)
--        end
--    end)  
--end)
--
--RegisterNUICallback('huydichvu', function(data, cb)
--    TriggerServerEvent("request_menu:huydichvu", dangping.id, dangping.job)
--    dangping   = {status = false, nguoinhan = 'chưa có', id = nil, job = nil}
--end)
RegisterNetEvent("esx_ping:revive")
AddEventHandler("esx_ping:revive", function()
    if dangping.status == true and dangping.huy =='/huymed' then
        TriggerServerEvent("request_menu:huydichvu", dangping.id, 'ambulance', true)
        dangping   = {status = false, nguoinhan = 'chưa có', id = nil, job = nil, huy=nil}
        OpenNguoiDan()
    end
end)

RegisterNetEvent("request_menu:daconguoinhan")
AddEventHandler("request_menu:daconguoinhan", function(job, name, id)
	dangping   = {status = true, nguoinhan = name, id = id, job = job, huy= dangping.huy}
    OpenNguoiDan()
	ESX.ShowNotification(name..' đã nhận bạn')
end)

RegisterNetEvent("request_menu:huynhan")
AddEventHandler("request_menu:huynhan", function(job, name)
	dangping   = {status = true, nguoinhan = 'chưa có', id = nil, job = nil, huy=dangping.huy}
    OpenNguoiDan()
    ESX.ShowNotification(name..' đã hủy bạn')
end)

RegisterNetEvent("request_menu:xoanhan")
AddEventHandler("request_menu:xoanhan", function(job, name)
	dangping   = {status = false, nguoinhan = 'chưa có', id = nil, job = nil, huy=nil}
    OpenNguoiDan()
    ESX.ShowNotification(name..' đã hủy bạn')
end)

function mathRound(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10^numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end
