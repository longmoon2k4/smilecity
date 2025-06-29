

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

local spawn                 = 0
local HookerSpawned         = false
local OnRouteToHooker       = false
local HookerInCar           = false
xSound = exports.xsound
--------------------------------------------------------------
-- ESX Code
--------------------------------------------------------------
-- ESX                         = nil
local PlayerData            = {}
    
Citizen.CreateThread(function()
    -- while ESX == nil do
    --     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --     Citizen.Wait(0)
    -- end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function (xPlayer)
    PlayerData = xPlayer
end)
-------------------------------------------------------------

-------------------------------------------------------------
-- Main Thread
-------------------------------------------------------------
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local coords, letSleep  = GetEntityCoords(PlayerPedId()), true
        for k,v in pairs(Config.Zones) do
            if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance and k == 'Pimp' then
                letSleep = false
                DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z+1.0, "Nhấn ~b~[E]~w~ đặt một cô gái")
                if IsControlJustReleased(0, Keys['E']) then
                    TriggerEvent("sawu_hookers:OpenPimpMenu")
                end
            end
        end
        if letSleep then
            Citizen.Wait(1000)
        end
    end
end)
-------------------------------------------------------------

-------------------------------------------------------------
-- NUI EVENTS
-------------------------------------------------------------
RegisterNetEvent("sawu_hookers:OpenPimpMenu")
AddEventHandler("sawu_hookers:OpenPimpMenu", function ()
    SetNuiFocus(true, true)
    Citizen.Wait(100)
    SendNUIMessage({
        type = "openPimpMenu",
    })
end)

RegisterNetEvent("sawu_hookers:OpenHookerMenu")
AddEventHandler("sawu_hookers:OpenHookerMenu", function ()
    SetNuiFocus(true, true)
    Citizen.Wait(100)
    SendNUIMessage({
        type    = "openHookerMenu",
        blowjob = Config.BlowjobPrice,    
        sex     = Config.SexPrice,
    })
end)
-------------------------------------------------------------

-------------------------------------------------------------
-- NUI CALLBACKS
-------------------------------------------------------------
RegisterNUICallback("CloseMenu", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
end)

RegisterNUICallback("ChooseCathrine", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    TriggerEvent("sawu_hookers:ChosenHooker", "honoka_beach") -- Cathrine
   -- exports['mythic_notify']:SendUniqueAlert('inform', "Eimi Fukada được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    ESX.ShowNotification("Eimi Fukada được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseTatiana", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    TriggerEvent("sawu_hookers:ChosenHooker", "lunav") -- Tatiana
    --exports['mythic_notify']:SendUniqueAlert('inform', "Yui Hatano được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    ESX.ShowNotification("Yui Hatano được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseBootylicious", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    TriggerEvent("sawu_hookers:ChosenHooker", "Hentai girl") -- Bootylicious
   -- exports['mythic_notify']:SendUniqueAlert('inform', "Erika Momotani được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    ESX.ShowNotification("Erika Momotani được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseVennesa", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    TriggerEvent("sawu_hookers:ChosenHooker", "Nagisa-Short") -- Vennesa
    ESX.ShowNotification("Erika Momotani được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    --exports['mythic_notify']:SendUniqueAlert('inform', "Skylarvox được đánh dấu trên GPS của bạn, hãy lái xe đến đó.")
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseBlowjob", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    HookerInCar = false
    TriggerServerEvent("sawu_hookers:pay", true)
end)

RegisterNUICallback("ChooseSex", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    HookerInCar = false
    TriggerServerEvent("sawu_hookers:pay", false)
end)

RegisterNUICallback("CloseServiceMenu", function (data, callback)
    SetNuiFocus(false, false)
    callback("ok")
    HookerInCar = true
end)
-------------------------------------------------------------

-------------------------------------------------------------
-- No Money
-------------------------------------------------------------  
RegisterNetEvent("sawu_hookers:noMoney")
AddEventHandler("sawu_hookers:noMoney", function()
    HookerInCar = true
end)
-------------------------------------------------------------

-------------------------------------------------------------
-- Blowjob Animation and Speech
-------------------------------------------------------------  
RegisterNetEvent("sawu_hookers:startBlowjob")
AddEventHandler("sawu_hookers:startBlowjob", function()
    local ped = PlayerPedId()
    hookerAnim(Hooker,"oddjobs@towing","f_blow_job_loop")
    playerAnim(ped,"oddjobs@towing","m_blow_job_loop")
    SendNUIMessage({
        type    = "soundBlow",
    })
    Citizen.Wait(30000)
    --Citizen.Wait(2000)
    --PlayAmbientSpeech1(Hooker, "Sex_Oral", "Speech_Params_Force_Shouted_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Oral", "Speech_Params_Force_Shouted_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Oral", "Speech_Params_Force_Shouted_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Oral_Fem", "Speech_Params_Force_Shouted_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Oral_Fem", "Speech_Params_Force_Shouted_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Finished", "Speech_Params_Force_Shouted_Clear")
    ClearPedTasks(ped)
    ClearPedTasks(Hooker)
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Hooker_Offer_Again", "Speech_Params_Force_Shouted_Clear")
    HookerInCar = true
end)
------------------------------------------------------------- 

-------------------------------------------------------------
-- Sex Animation and Speech
------------------------------------------------------------- 
RegisterNetEvent("sawu_hookers:startSex")
AddEventHandler("sawu_hookers:startSex", function()
    local ped = PlayerPedId()
    hookerAnim(Hooker,"mini@prostitutes@sexlow_veh","low_car_sex_loop_female")
    playerAnim(ped,"mini@prostitutes@sexlow_veh","low_car_sex_loop_player")
    --local pos = GetEntityCoords(ped)
    --xSound:PlayUrlPos("sex","https://drive.google.com/file/d/1iqHUolO8XWDOJvc8eNQdYG3q6l6QPAkv/view",100,pos)
    --xSound:Distance("sex",30)
    --Citizen.Wait(30000)
    --xSound:Destroy("sex")
    SendNUIMessage({
        type    = "soundFinal",
    })
    Citizen.Wait(30000)
    --PlayAmbientSpeech1(Hooker, "Sex_Generic", "Speech_Params_Force_Normal_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Generic", "Speech_Params_Force_Normal_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Generic", "Speech_Params_Force_Normal_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Generic_Fem", "Speech_Params_Force_Shouted_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Generic_Fem", "Speech_Params_Force_Shouted_Clear")
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Sex_Finished", "Speech_Params_Force_Shouted_Clear")
    ClearPedTasks(ped)
    ClearPedTasks(Hooker)
    --Citizen.Wait(5000)
    --PlayAmbientSpeech1(Hooker, "Hooker_Offer_Again", "Speech_Params_Force_Shouted_Clear")
    HookerInCar = true
end)
------------------------------------------------------------- 

-------------------------------------------------------------
-- DrawText Function
-------------------------------------------------------------
function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
-------------------------------------------------------------

-------------------------------------------------------------
-- Pimp ped
-------------------------------------------------------------  
Citizen.CreateThread(function()
    for _,v in pairs(Config.PimpGuy) do
        loadmodel(v.model)
        loaddict("mini@strip_club@idles@bouncer@base")

        pimp =  CreatePed(1, v.model, v.x, v.y, v.z, v.heading, false, true)
        FreezeEntityPosition(pimp, true)
        SetEntityInvincible(pimp, true)
        SetBlockingOfNonTemporaryEvents(pimp, true)
        TaskPlayAnim(pimp,"mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)
-------------------------------------------------------------

-------------------------------------------------------------
-- Create Hooker,  Setwaypoint and Blip
-------------------------------------------------------------  
function CreateHooker(model)
    spawn = math.random(1,12)

    loadmodel(model)
    loaddict("switch@michael@parkbench_smoke_ranger")

    Hooker =  CreatePed("PED_TYPE_PROSTITUTE", model, Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y, Config.Hookerspawns[spawn].z, Config.Hookerspawns[spawn].heading, true, true)
    FreezeEntityPosition(Hooker, true)
    SetEntityInvincible(Hooker, true)
    SetBlockingOfNonTemporaryEvents(Hooker, true)
    TaskStartScenarioInPlace(Hooker, "WORLD_HUMAN_SMOKING", 0, false)

    HookerBlip = AddBlipForCoord(Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y, Config.Hookerspawns[spawn].z)
    SetBlipSprite(HookerBlip, 280)
    SetNewWaypoint(Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y)
end
-------------------------------------------------------------

-------------------------------------------------------------
-- Thread after ordered hooker
------------------------------------------------------------- 
RegisterNetEvent("sawu_hookers:ChosenHooker")
AddEventHandler("sawu_hookers:ChosenHooker", function(model)
    if HookerSpawned then
        --exports['mythic_notify']:SendUniqueAlert('error', "Bạn đã chọn một con điếm rồi! Bạn không muốn có một orgy?")
        ESX.ShowNotification("Bạn đã chọn một con điếm rồi! Bạn không muốn có một orgy?")
    else
        HookerSpawned = true
        CreateHooker(model)
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(5)
                local Coords, letSleep  = GetEntityCoords(PlayerPedId()), true
                if OnRouteToHooker then 
                    if GetDistanceBetweenCoords(Coords, Config.Hookerspawns[spawn].x,Config.Hookerspawns[spawn].y,Config.Hookerspawns[spawn].z, true) < Config.DrawMarker then
                      
                        letSleep = false
                        local ped = GetPlayerPed(PlayerId())
                        local vehicle = GetVehiclePedIsIn(ped, false)
                        if GetPedInVehicleSeat(vehicle, -1) and IsPedInVehicle(ped, vehicle, true) and IsVehicleSeatFree(vehicle, 0) and not IsVehicleSeatFree(vehicle, -1) then
                            DrawText3Ds(Config.Hookerspawns[spawn].x,Config.Hookerspawns[spawn].y,Config.Hookerspawns[spawn].z+1.0, 'Nhấn [~b~E~w~] để mời gái lên xe')
                            if IsControlJustPressed(0, Keys["E"]) then
                                RemoveBlip(HookerBlip)
                                signalHooker()
                                PlayAmbientSpeech1(Hooker, "Generic_Hows_It_Going", "Speech_Params_Force")
                                HookerInCar = true
                                OnRouteToHooker = false
                            end
                        end
                    end
                end
                if HookerInCar then
                    local ped = GetPlayerPed(PlayerId())
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    if GetPedInVehicleSeat(vehicle, -1) and IsPedInVehicle(ped, vehicle, true) and not IsVehicleSeatFree(vehicle, 0) and not IsVehicleSeatFree(vehicle, -1) then
                        letSleep = false
                        local ped = GetPlayerPed(PlayerId())
                        if IsVehicleStopped(vehicle) then
                            DrawText3Ds(Coords.x, Coords.y, Coords.z+1.0, '[~b~E~w~] Chon dịch vụ. [~r~H~w~] Đuổi đi.')
                            if IsControlJustPressed(0, Keys["E"]) then
                                PlayAmbientSpeech1(Hooker, "Hooker_Offer_Service", "Speech_Params_Force_Shouted_Clear")
                                TriggerEvent("sawu_hookers:OpenHookerMenu")
                            end
                            if IsControlJustPressed(0, Keys["H"]) then
                                HookerInCar = false
                                PlayAmbientSpeech1(Hooker, "Hooker_Had_Enough", "Speech_Params_Force_Shouted_Clear")
                                hookerGoHome()
                                break
                            end
                        else
                            DrawText3Ds(Coords.x, Coords.y, Coords.z+1.0, '<Lái xe đến một nơi kín đáo (trốn)')
                        end
                    end
                end
                if letSleep then
                    Citizen.Wait(1000)
                end
            end
        end)
    end   
end)
-------------------------------------------------------------

-------------------------------------------------------------
-- Send Hooker Home
------------------------------------------------------------- 
function hookerGoHome()
    TaskLeaveVehicle(Hooker, vehicle, 0)
    SetPedAsNoLongerNeeded(Hooker)
    HookerSpawned = false
end
-------------------------------------------------------------

-------------------------------------------------------------
-- Signal Hooker to Enter Vehicle
------------------------------------------------------------- 
function signalHooker()
    local ped = PlayerPedId()
    FreezeEntityPosition(Hooker, false)
    SetEntityAsMissionEntity(Hooker)
    SetBlockingOfNonTemporaryEvents(Hooker, true)
    TaskEnterVehicle(Hooker, GetVehiclePedIsIn(ped, false), -1, 0, 1.0, 1, 0)
end
-------------------------------------------------------------

-------------------------------------------------------------
-- Animation on Hooker
-------------------------------------------------------------  
function hookerAnim(Hooker, animDictionary, animationName, time)
    if (DoesEntityExist(Hooker) and not IsEntityDead(Hooker)) then
        loaddict(animDictionary)
        TaskPlayAnim(Hooker, animDictionary, animationName, 1.0, -1.0, -1, 1,  0, false, false, false)
    end
end
-------------------------------------------------------------

-------------------------------------------------------------
-- Animation on player
-------------------------------------------------------------  
function playerAnim(ped, animDictionary, animationName, time)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        loaddict(animDictionary)
        TaskPlayAnim(ped, animDictionary, animationName, 1.0, -1.0, -1, 1,  0, false, false, false)
    end
end
-------------------------------------------------------------

-------------------------------------------------------------
-- Load Models and AnimDict
------------------------------------------------------------- 
function loadmodel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end
end

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end
-------------------------------------------------------------

Citizen.CreateThread(function()
    local Blip = AddBlipForCoord(130.91, -1325.1, 29.2)
    SetBlipSprite(Blip, 121)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 1.0)
    SetBlipColour(Blip, 8)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gái Gọi")
    EndTextCommandSetBlipName(Blip)
end)