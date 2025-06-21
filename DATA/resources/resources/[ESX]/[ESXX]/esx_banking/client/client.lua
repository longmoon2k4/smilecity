-- ESX = nil
inMenu = true
local atbank = false
local bankMenu = true
local keys = {
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
function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
-- Citizen.CreateThread(
--     function()
--         while ESX == nil do
--             TriggerEvent(
--                 "esx:getSharedObject",
--                 function(obj)
--                     ESX = obj
--                 end
--             )
--             Citizen.Wait(0)
--         end
--     end
-- )
-- if bankMenu then
--     Citizen.CreateThread(function()
--             while true do
--                 Wait(5)
--                 if nearBank() or nearATM() then
--                     DisplayHelpText(_U("atm_open"))
--                     if IsControlJustPressed(1, keys[Config.Keys.Open]) then
--                         openUI()
--                         TriggerServerEvent("bank:balance")
--                         local ped = GetPlayerPed(-1)
--                     end
--                 end
--                 if IsControlJustPressed(1, keys[Config.Keys.Close]) then
--                     if nearBank() or nearATM() then
--                         closeUI()
--                     end
--                 end
--             end
--         end
--     )
-- end

if bankMenu then
    Citizen.CreateThread(function()
        while true do
            local time = 1000
            if nearBank() or nearATM() then
                time = 1
                DisplayHelpText(_U("atm_open"))
                if IsControlJustPressed(1, keys[Config.Keys.Open]) then
                    openUI()
                    TriggerServerEvent("bank:balance")
                    local ped = GetPlayerPed(-1)
                end
            end
            if IsControlJustPressed(1, keys[Config.Keys.Close]) then
                if nearBank() or nearATM() then
                    closeUI()
                end
            end
            Citizen.Wait(time)
        end
    end)
end

Citizen.CreateThread(
    function()
        if Config.ShowBlips then
            for k, v in ipairs(Config.Bank) do
                local blip = AddBlipForCoord(v.pos)
                SetBlipSprite(blip, v.id)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.8)
                SetBlipColour(blip, 2)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(_U("bank_blip"))
                EndTextCommandSetBlipName(blip)
                -- blip1 = AddBlipForRadius(v.x, v.y, v.z, 150.0) -- you can use a higher number for a bigger zone 
                -- SetBlipHighDetail(blip1, true) 
                -- SetBlipColour(blip1, 1) 
                -- SetBlipAlpha (blip1, 128)
            end
        end
    end
)
RegisterNetEvent("currentbalance1")
AddEventHandler(
    "currentbalance1",
    function(balance)
        local id = PlayerId()
        local playerName = GetPlayerName(id)
        SendNUIMessage({type = "balanceHUD", balance = balance, player = playerName})
    end
)
RegisterNUICallback(
    "deposit",
    function(data)
        TriggerServerEvent("bank:deposit", tonumber(data.amount))
        -- exports["WaveShield"]:TriggerServerEvent("bank:deposit",tonumber(data.amount))
        TriggerServerEvent("bank:balance")
    end
)
RegisterNUICallback(
    "withdrawl",
    function(data)
       TriggerServerEvent("baxcvnk:withdcvxvraw", tonumber(data.amountw))
        -- exports["WaveShield"]:TriggerServerEvent("baxcvnk:withdcvxvraw",tonumber(data.amountw))
        TriggerServerEvent("bank:balance")
    end
)
RegisterNUICallback(
    "balance",
    function()
        TriggerServerEvent("bank:balance")
    end
)
RegisterNetEvent("balance:back")
AddEventHandler(
    "balance:back",
    function(balance)
        SendNUIMessage({type = "balanceReturn", bal = balance})
    end
)
RegisterNUICallback(
    "transfer",
    function(data)
       TriggerServerEvent("bank:transfer", data.to, data.amountt)
        -- exports["WaveShield"]:TriggerServerEvent("bank:transfer",data.to, data.amountt)
        TriggerServerEvent("bank:balance")
    end
)
RegisterNetEvent("bank:result")
AddEventHandler(
    "bank:result",
    function(type, message)
        SendNUIMessage({type = "result", m = message, t = type})
    end
)
RegisterNUICallback(
    "esx_invest",
    function()
        if (inMenu) then
            inMenu = false
            SetNuiFocus(false, false)
            SendNUIMessage({type = "closeAll"})
            exports.esx_invest:openUI()
        end
    end
)
RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeUI()
    end
)
AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        closeUI()
    end
)
AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        closeUI()
    end
)
function nearBank()
    -- local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(PlayerPedId())
    for _, search in pairs(Config.Bank) do          
        if #(playerloc - search.pos) <= 3 then
            return true
        end
    end
end
function nearATM()
    -- local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(PlayerPedId())
    for _, search in pairs(Config.ATM) do
        if #(playerloc - search.pos) <= 2 then
            return true
        end
    end
end
function closeUI()
    inMenu = false
    SetNuiFocus(false, false)
    if Config.Animation.Active then
        playAnim("mp_common", "givetake1_a", Config.Animation.Time)
        Citizen.Wait(Config.Animation.Time)
    end
    SendNUIMessage({type = "closeAll"})
end
function openUI()
    if Config.Animation.Active then
        playAnim("mp_common", "givetake1_a", Config.Animation.Time)
        Citizen.Wait(Config.Animation.Time)
    end
    inMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = "openGeneral"})
    TriggerServerEvent("bank:balance")
end
function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
