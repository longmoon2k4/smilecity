--local ESX = exports['qb-core']:GetCoreObject()
local HasHost = false
local isHost = false
local NameHost = ''
local spawnObj = false
local objLoad = ''
local dice = {}
local diceDisplaying = false
--AddEventHandler('esx:playerLoaded', function(xPlayer)
--    Wait(1500)
--    TriggerServerEvent('ntl_baucua:sv:playerloaded')
--end)
if Config.ShowDiceOnCoords then
    Citizen.CreateThread(function()
        local strin = ""
    
        while true do
            Wait(0)
            local currentTime, html = GetGameTimer(), ""
            if diceDisplaying then
                for k, v in pairs(diceDisplaying) do
              
                    -- local player = GetPlayerFromServerId(k)
                    -- if NetworkIsPlayerActive(player) then
                        local sourceCoords = GetEntityCoords(PlayerPedId())
            
                        if  #(sourceCoords - Config.ShowDiceCoords) < 10 then
                            local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(Config.ShowDiceCoords.x, Config.ShowDiceCoords.y, Config.ShowDiceCoords.z + 1.2)
                            if not onScreen then
                                html = html .. "<span style=\"position: absolute; padding-left: 150px;left: ".. xxx * 66 .."%;top: ".. yyy * 100 .."%;\">"
                                for a, b in pairs(v.res) do
                                    html = html .. "<img style=\"margin-left:15px;border-radius:10px \"".. "\" width=\"75px\" height=\"75px\" src=\"./img/".. b.dice ..".jpg\">"
                                end
                        
                        end
                    end
                    if v.time <= currentTime then
                        diceDisplaying = false
                    end
                end
    
                
            else
                Wait(500)
            end
            if strin ~= html then
                SendNUIMessage({
                    action = 'showdice',
                    html = html
                })
                strin = html
            end
        end
    end)
end

RegisterNetEvent("ntl_baucua:displayDice")
AddEventHandler("ntl_baucua:displayDice", function(displayTime,dice)
	diceDisplaying = {
        {
            num = 3,
            time = GetGameTimer() + displayTime,
            res = dice
        }
    }

end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local distanceHost = GetDistanceBetweenCoords(GetEntityCoords(ped),Config.Distance,true)
        local distance = GetEntityCoords(PlayerPedId())
        local letSleep = false
        if distanceHost <= Config.DistanceMax then
            if not HasHost and not isHost then
                DrawMarker(1, Config.Distance, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 50, 204, 100, false, true, 2, true, false, false, false)
                DrawText3D(Config.Distance.x,Config.Distance.y,Config.Distance.z , "~g~E~w~ - làm chủ HOST")
                if distanceHost <= 1.0  then
                    if IsControlJustPressed(0,Config.Key) then
                        TriggerServerEvent('ntl_baucua:UpdateHost',true)
                    end
                end
            -- them code hiện tên HOST nếu ko phải là isHost
       
            elseif NameHost ~= '' and HasHost and not isHost then
                DrawMarker(1, Config.Distance, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 50, 204, 100, false, true, 2, true, false, false, false)
                DrawText3D(Config.Distance.x,Config.Distance.y,Config.Distance.z, "[~y~"..NameHost.."] - ~r~HOST")
            elseif isHost then
                DrawMarker(1, Config.Distance, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 50, 204, 100, false, true, 2, true, false, false, false)
                DrawText3D(Config.Distance.x,Config.Distance.y,Config.Distance.z , "~g~E~w~ - OUT HOST")
                if distanceHost <= 1.0  then
                    if IsControlJustPressed(0,Config.Key) then
                        TriggerServerEvent('ntl_baucua:UpdateHost',false)
                    end
                end
            end
            if isHost or HasHost then
                DrawMarker(1, Config.WhereBet, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 50, 50, 204, 100, false, true, 2, true, false, false, false)
                DrawText3D(Config.WhereBet.x,Config.WhereBet.y,Config.WhereBet.z , "~g~E~w~ - để mở MENU")
                if #(GetEntityCoords(PlayerPedId()) - Config.WhereBet) <= 2.0  then
                    if IsControlJustPressed(0,Config.Key) then
                        ESX.TriggerServerCallback('ntl_baucua:IsStartedMatch',function(res)
                            if not res then return end
                            SendNUIMessage({
                                action = 'show',
                                dataMatch = res
                            })
                            SetNuiFocus(true,true)
                        end)
                    end
                end
            end
            if HasHost then
                if not spawnObj then
                    if (Config.ObjectInteraction['dice1'].nameObject and Config.ObjectInteraction['dice1'].nameObject and Config.ObjectInteraction['dice1'].nameObject ) ~= '' then
                        for i = 1,3,1 do
                            SpawnLocalObject(Config.ObjectInteraction['dice'..i].nameObject, Config.ObjectInteraction['dice'..i].coords, function(obj)
                                dice[i] = obj
                                PlaceObjectOnGroundProperly(obj)
                                FreezeEntityPosition(obj, true)
                            
                            end)
                        end
                    else
                        SpawnLocalObject(Config.ObjectInteraction['bowl'].nameObject, Config.ObjectInteraction['bowl'].coords, function(obj)
                            objLoad = obj
                            PlaceObjectOnGroundProperly(obj)
                            FreezeEntityPosition(obj, true)
                        
                        end)
                    end
                   
                    spawnObj = true                
                end
            
                    -- function check successfully
                    -- else still spawn bowl
                for k,v in pairs(Config.Object) do
                    DrawText3D(v.coords.x,v.coords.y,v.coords.z, "Tổng tiền đặt cược: ~y~ "..v.money..'$')
                    DrawMarker(1, v.coords.x,v.coords.y,v.coords.z - 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 50, 204, 95, false, true, 2, true, false, false, false)
                end
            end
            letSleep = true
        end
        if not letSleep then
            --if isHost then
            --    TriggerServerEvent('ntl_baucua:UpdateHost',false)
            --end
            if json.encode(dice) ~= '[]' then
                for i = 1,3,1 do
                    DeleteObject(dice[i])
                end
            end
            if objLoad ~= '' then
                DeleteObject(objLoad)
                objLoad = ''
            end
            spawnObj = false
            Citizen.Wait(500)
        end
    end
end)
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        if json.encode(dice) ~= '[]' then
            for i = 1,3,1 do
                DeleteObject(dice[i])
            end
        end
        if objLoad ~= '' then
            DeleteObject(objLoad)
            objLoad = ''
        end
        spawnObj = false
	end
end)
RegisterNUICallback('close',function()
    SetNuiFocus(false,false)
end)


RegisterNetEvent('ntl_baucua:sv:CloseAllMenu',function()
    SendNUIMessage({
        action = 'hide'
    })
end)

RegisterNetEvent('ntl_baucua:client:SpawnDice',function(data)
    if objLoad ~= '' then
        DeleteObject(objLoad)
    end
    Config.ObjectInteraction = data
    spawnObj = false
end)
RegisterNetEvent('ntl_baucua:client:DeleteDice',function(data)
    local distanceHost = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Config.Distance,true)
    if distanceHost <= Config.DistanceMax then
        ESX.ShowNotification(Config.Languages.roundnew)
    end
    if json.encode(dice) ~= '' then
        for i = 1,3,1 do
            DeleteObject(dice[i])
        end
    end
    Config.ObjectInteraction = data
    spawnObj = false
end)
RegisterNUICallback('spin',function(data,cb)
    ESX.TriggerServerCallback('ntl_baucua:spin',function(res)
        cb(res)
        if res.status == 'success' then
            TriggerServerEvent('ntl_baucua:sv:ProcessDice')
        end
    end)
end)

RegisterNUICallback('PutMoneyHost',function(data,cb)
    ESX.TriggerServerCallback('ntl_baucua:sv:SetMoneyHost',function(res)
        cb(res)
    end,data)
end)


RegisterCommand('baucua',function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Config.Distance,true)
    if distance >= 10 then
        ESX.ShowNotification(Config.Languages.too_far)
        return
    end
    if not HasHost then
        ESX.ShowNotification(Config.Languages.not_yet)
        return
    end
    ESX.TriggerServerCallback('ntl_baucua:IsStartedMatch',function(res)
        if not res then return end
        SendNUIMessage({
            action = 'show',
            dataMatch = res
        })
        SetNuiFocus(true,true)
    end)

end)
RegisterNetEvent('ntl_baucua:client:refresh',function(config)
    if config ~= nil then
        Config.Object = config
    end
    ESX.TriggerServerCallback('ntl_baucua:IsStartedMatch',function(res)
        if not res then return end
        SendNUIMessage({
            action = 'refresh',
            dataMatch = res
        })
    end)
end)
RegisterNUICallback('PutMoneyDice',function(data,cb)
    ESX.TriggerServerCallback('ntl_baucua:CheckIsAlready', function(response)
        cb(response)
        -- if ok then
        --     TriggerServerEvent('ntl_baucua:datcuoc',data)
        -- end
    end,data)
end)

RegisterNetEvent('ntl_baucua:client:UpdateData',function(playerId,bool,name)
    HasHost = bool
    if not bool and spawnObj then
        if json.encode(dice) ~= '[]' then
            for i = 1,3,1 do
                DeleteObject(dice[i])
            end
        end
        if objLoad ~= '' then
            DeleteObject(objLoad)
            objLoad = ''
        end
        spawnObj = false
     
    end
    if name ~= nil then
        NameHost = name
    end
    if playerId ~= nil and GetPlayerServerId(PlayerId()) ==  playerId then
        isHost = bool
    end
end)
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z + 0.95, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function onEnter(self)
    TriggerServerEvent('ntl_baucua:sv:joinPlay')
end
 
function onExit(self)
    TriggerServerEvent('ntl_baucua:sv:leftPlay')
    if isHost then
        TriggerServerEvent('ntl_baucua:UpdateHost',false)
    end
    HasHost = false
    isHost = false
    NameHost = ''
end

local poly = lib.zones.poly({
    points = {
        vec(219.507690, -881.617554, 30.476196),
        vec(237.810989, -892.127441, 30.476196),
        vec(247.358246, -867.283508, 29.532593),
        vec(219.415390, -856.430786, 30.240234),
    },
    thickness = 10,
    debug = false,
    onEnter = onEnter,
    onExit = onExit
})