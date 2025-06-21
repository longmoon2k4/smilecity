--ESX = nil 
local Ablip = {}
local blips = {}
local curArea = nil 
local curMarker = nil
local LocationArr = {}
local PlayerData = {}
local isCapturing = false
local captureBlip = {}
local first, second, third = {}, {}, {} 
local curCapture = nil
local deathCheck = false
local NotiBlip = {}
local isPhabom = false
local isBoom = false
local timedelay = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if timedelay > 0 then
            timedelay=timedelay - 1
        end
      
    end
   
end)



Citizen.CreateThread(function()
    -- while ESX == nil do 
    --     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --     Wait(1)
    -- end
    while PlayerData.job == nil do 
        Wait(1000)
        PlayerData = ESX.GetPlayerData()
    end
    TriggerServerEvent('sulu_occupation:GetLocationOwner')
    local sleepThread = 1000
    while true do 
        Wait(sleepThread)
        local areaLoc = GetNearLoc()
        if areaLoc ~= false then 
            local blipLoc = IsNearMarker()
            local isDead = IsPlayerDead(PlayerId())
            if blipLoc ~= false then 
                sleepThread = 1
                local cacheMarker = config.Location[blipLoc[1]] 
                if not blipLoc[3] then
                    DrawMarker(1, cacheMarker.x, cacheMarker.y, cacheMarker.z - 1.100, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 40.0, 40.0, 2.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
                end
                DrawMarker(1, cacheMarker.x, cacheMarker.y, cacheMarker.z - 1.100, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
                if isDead then 
                    if not deathCheck then
                        deathCheck = true 
                    end
                elseif deathCheck == true then
                    deathCheck = false 
                end
                if blipLoc[2] <= 2.0 then 
					DrawHelpNotification( blipLoc[3] and lang.HelpNotificationBoom or lang.HelpNotification, cacheMarker)
                    if IsControlJustReleased(0, 38) and not IsPedInAnyPoliceVehicle(PlayerPedId()) then
                        if timedelay == 0 then
                            timedelay =  7
                            for i = 1, #LocationArr, 1 do 
                                if LocationArr[i].name == blipLoc[1] then 
                                    if config.isUserjob then
                                        if config.job1[PlayerData.job.name] ~= nil or config.job[PlayerData.job2.name] ~= nil then
                                            if LocationArr[i].gang_name == PlayerData.job.name or LocationArr[i].gang_name == PlayerData.job2.name  then
                                                if blipLoc[3] then
                                                    StartCapture(blipLoc[1],blipLoc[3])
                                                else
                                                    ESX.ShowNotification(lang.occupated)
                                                end
                                                
                                            else 
                                                StartCapture(blipLoc[1],blipLoc[3])
                                            end 
                                        else 
                                            ESX.ShowNotification(lang.InvalidJob)
                                        end
                                    else
                                        if config.job1[PlayerData.job.name] ~= nil then
                                            if LocationArr[i].gang_name == PlayerData.job.name then 
                                                ESX.ShowNotification(lang.occupated)
                                            else 
                                                StartCapture(blipLoc[1],blipLoc[3])
                                            end 
                                        else 
                                            ESX.ShowNotification(lang.InvalidJob)
                                        end
                                    end
                                end 
                            end
                        else
                            ESX.ShowNotification("~r~Bấm từ từ thôi anh zai")
                        end
                    end 
                end
            else 
                sleepThread = 1000
            end 
        end 
        
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('sulu_occupation:updateChiemdong')
AddEventHandler('sulu_occupation:updateChiemdong', function(loc)
    if curCapture == loc then
        curCapture = nil
        isCapturing = false
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
    PlayerData.job2 = job
end)

RegisterNUICallback("closeNUI", function(data,cb)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('sulu_occupation:Ui')
AddEventHandler('sulu_occupation:Ui', function()
    ESX.TriggerServerCallback('sulu_occupation:getData', function(result)
        SetNuiFocus(true, true)
        SendNUIMessage({
            data = result
        })
    end)
end)

RegisterNetEvent('sulu_occupation:setCapturingBlip')
AddEventHandler('sulu_occupation:setCapturingBlip', function(location, gangName)
    local coords = config.Location[location]
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipSprite(blip, 161)
	SetBlipScale(blip, 2.0)
	SetBlipColour(blip, 3)
    PulseBlip(blip)
    captureBlip[location] = blip
    NotiBlip[location] = true
   -- print(gangName)
    local curBl = config.job[gangName] or config.job1[gangName]
    local curLc = config.Location[location]
    NotificationArea(curLc.bx, curLc.by, curLc.bz, curLc.w, curLc.h, curLc.heading, curBl.color , 100, nil, 3, false, gangName, location)
end)


RegisterNetEvent('sulu_occupation:removeBlip')
AddEventHandler('sulu_occupation:removeBlip', function(location)
    if captureBlip[location] then 
        RemoveBlip(captureBlip[location]) 
        NotiBlip[location] = false
    end
end)

StartCapture = function(location,boom)
    if not isCapturing then
        if boom then
            ESX.TriggerServerCallback('sulu_occupation:isCapturing', function(result)
                if result == false then 
                    --ESX.TriggerServerCallback('sulu_occupation:checkBoom', function(count)
                    -- if count > 0 then
                            isCapturing = true
                            isBoom = true
                            curCapture = location
                            TriggerServerEvent('sulu_occupation:notify', location)
                        -- TriggerServerEvent('sulu_occupation:start', location)
                            local timer = config.TimeCapture/1000
                            local player = PlayerId()
                            Citizen.CreateThread(function()
                                while isCapturing do 
                                    Wait(1000)
                                    timer = timer - 1                   
                                end
                            end)
                            Citizen.CreateThread(function()
                                while isCapturing do 
                                    Wait(0)
                                    if timer > 0 then 
                                        drawTxt(0.75, 1.44, 1.0, 1.0, 0.4, "~h~Thời gian chiếm đóng:~r~ "..timer.." ~s~giây", 255, 255, 255, 255)
                                    else
                                        --TriggerServerEvent('sulu_occupation:captured', location)
                                        isCapturing = false
                                        curCapture = nil
                                        isBoom = false
                                    end
                                end
                            end)
                        --else
                            --ESX.ShowNotification("~r~Không có boom C4")
                    -- end
                --  end, 'boomc4')
                elseif result == 'goboom' then 
                    ESX.TriggerServerCallback('sulu_occupation:checkBoom', function(count)
                        if count > 0 then
                            isPhabom = true
                            if lib.progressBar({
                                duration =  15000,
                                label = 'đang phá boom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    car = true,
                                    move = true,
                                    combat = true,
                                    mouse = false,
                                },
                                anim = {
                                    dict = 'amb@prop_human_bum_bin@idle_a',
                                    clip = 'idle_a',
                                    flag = 1
                                },
                            }) then 
                                TriggerServerEvent('sulu_occupation:cancel', location,boom)
                            end
                        else
                            ESX.ShowNotification("~r~Không có kìm phá boom")
                        end
                    end, 'kimphaboom')
                end
            end, location,boom)
        else
            ESX.TriggerServerCallback('sulu_occupation:isCapturing', function(result)
                if result == false then 
                    isCapturing = true
                    isBoom = false
                    curCapture = location
                    TriggerServerEvent('sulu_occupation:notify', location)
                    TriggerServerEvent('sulu_occupation:start', location)
                    local timer = config.TimeCapture/1000
                    local player = PlayerId()
                    Citizen.CreateThread(function()
                        while isCapturing do 
                            Wait(1000)
                            timer = timer - 1                   
                        end
                    end)
                    Citizen.CreateThread(function()
                        while isCapturing do 
                            Wait(0)
                            if IsPlayerDead(player) or GetEntityHealth(cache.ped)==101 then                       
                                TriggerServerEvent('sulu_occupation:cancel', location,false)
                                isCapturing = false
                                curCapture = nil
                            end
                            if timer > 0 then 
                                drawTxt(0.75, 1.44, 1.0, 1.0, 0.4, "~h~Thời gian chiếm đóng:~r~ "..timer.." ~s~giây", 255, 255, 255, 255)
                            else
                                TriggerServerEvent('sulu_occupation:captured', location)
                                isCapturing = false
                                curCapture = nil
                            end
                        end
                    end)
                end
            end, location,boom)
        end
    else
        ESX.ShowNotification("~r~Bạn đang chiếm đóng không thể chiếm đóng nữa") 
    end
end

AreaBlip = function(x,y,z,width,height,heading,color,alpha,highDetail,display,shortRange, name, show)
    if Ablip[name] then 
        RemoveBlip(Ablip[name])
    end
	if config.UseRadiusBlip then 
		local blip = AddBlipForRadius((x or 0.0),(y or 0.0),(z or 0.0),150.0)
		SetBlipColour(blip, (color or 1))
		SetBlipAlpha (blip, (alpha or 80))
		SetBlipHighDetail(blip, (highDetail or true))
		SetBlipRotation(blip, (heading or 0.0))
		SetBlipDisplay(blip, (display or 4))
		SetBlipAsShortRange(blip, (shortRange or true))
		Ablip[name] = blip
	else 
		local blip = AddBlipForArea((x or 0.0),(y or 0.0),(z or 0.0),(width or 100.0),(height or 100.0))
		SetBlipColour(blip, (color or 1))
		SetBlipAlpha (blip, (alpha or 80))
		SetBlipHighDetail(blip, (highDetail or true))
		SetBlipRotation(blip, (heading or 0.0))
        if not show then
            SetBlipDisplay(blip, (display or 4))
            SetBlipAsShortRange(blip, (shortRange or true))
        end
		Ablip[name] = blip
	end
end

RegisterFontFile("arial")
fontId = RegisterFontId("arial font")

Blip = function(x,y,z,sprite,color,text,scale,display,shortRange,highDetail, name,nameCD)
    if blips[name] then 
        RemoveBlip(blips[name])
    end
    local blip = AddBlipForCoord((x or 0.0),(y or 0.0),(z or 0.0))
    local blipText = nameCD
    if text ~= nil then 
        blipText= config.JobLabel[text]..' | '..nameCD
    end
    SetBlipSprite               (blip, (sprite or 1))
    SetBlipDisplay              (blip, (display or 4))
    SetBlipScale                (blip, (scale or 1.0))
    SetBlipColour               (blip, (color or 4))
    SetBlipAsShortRange         (blip, (shortRange or false))
    SetBlipHighDetail           (blip, (highDetail or true))
    BeginTextCommandSetBlipName ("STRING")
    AddTextComponentString      (blipText)
    EndTextCommandSetBlipName   (blip)
    blips[name] = blip
end

GetNearLoc = function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    for k, v in pairs(config.Location) do 
        local distance = GetDistanceBetweenCoords(pedCoords, v.x, v.y, v.z, false)
        if distance <= (v.w/2) then 
            return {k, distance}
        end 
    end 
    return false
end

IsNearMarker = function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped) 
    for k, v in pairs(config.Location) do 
        local distance = GetDistanceBetweenCoords(pedCoords, v.x, v.y, v.z, false)
        if distance <= config.DistanceDrawMarker then 
            return {k, distance,v.boom}
        end 
    end 
    return false
end

IsNearMarker2 = function(coords)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped) 
    local distance = GetDistanceBetweenCoords(pedCoords, coords.x, coords.y, coords.z, false)
    if distance <= config.DistanceDrawMarker then 
        return true
    end 
    return false
end

RegisterNetEvent('sulu_occupation:setBlip')
AddEventHandler('sulu_occupation:setBlip', function(arr)
    LocationArr = arr
    for i = 1, #arr , 1 do 
        local curLc = config.Location[arr[i].name]
        if arr[i].gang_name ~= nil then 
            local curBl = config.job[arr[i].gang_name] or config.job1[arr[i].gang_name]
            AreaBlip(curLc.bx, curLc.by, curLc.bz, curLc.w, curLc.h, curLc.heading, curBl.color , 100, nil, 3, false, arr[i].name, false)
            Blip(curLc.x, curLc.y, curLc.z, curBl.sprite, curBl.color, arr[i].gang_name, 1.5, config.blipDisplay, false, false, arr[i].name,arr[i].nameCD)
        else 
            AreaBlip(curLc.bx, curLc.by, curLc.bz, curLc.w, curLc.h, curLc.heading, 4 , 100, nil, 3, false, arr[i].name, true)
            --          x,      y,       z,     width,    height,heading,     color,alpha,highDetail,display,shortRange, name
            Blip(curLc.x, curLc.y, curLc.z, 429, 4, nil, 1.0, config.blipDisplay, false, false, arr[i].name,arr[i].nameCD)
        --        x,       y,       z, sprite,color,text,             scale,display,shortRange,highDetail, name
        end
    end
end)

RegisterNetEvent('sulu_occupation:updateCharts')
AddEventHandler('sulu_occupation:updateCharts', function(pointArr)
    local firstPoint = {point = 0, name = nil}
    local secondPoint = {point = 0, name = nil}
    local thirdPoint = {point = 0, name = nil}
    if #pointArr > 0 then 
        for i = 1, #pointArr, 1 do 
            if pointArr[i].point > firstPoint.point then 
                firstPoint.point = pointArr[i].point
                firstPoint.name = pointArr[i].gang_name
            end
        end
    end
    if #pointArr > 1 then 
        for i = 1, #pointArr, 1 do 
            if pointArr[i].point > secondPoint.point and pointArr[i].gang_name ~= firstPoint.name then 
                secondPoint.point = pointArr[i].point
                secondPoint.name = pointArr[i].gang_name
            end
        end
    end
    if #pointArr > 2 then 
        for i = 1, #pointArr, 1 do 
            if pointArr[i].point > thirdPoint.point and pointArr[i].gang_name ~= firstPoint.name and pointArr[i].gang_name ~= secondPoint.name then 
                thirdPoint.point = pointArr[i].point
                thirdPoint.name = pointArr[i].gang_name
            end
        end
    end
    first, second, third = firstPoint, secondPoint, thirdPoint
end)



function drawCharts()
    local text1 = lang.ChartsTitle.."\n"
    local text2, text3, text4 = nil, nil, nil
    if first.name ~= nil then 
        text2 = "~w~Hạng 1 "..config.JobLabel[first.name].."~w~ | ~y~Điểm : "..first.point
    end
    if second.name ~= nil then 
    --    text3 = "~w~Hạng 2 "..config.JobLabel[second.name].."~w~ |~g~Điểm : "..second.point
    end
    if third.name ~= nil then 
        -- text4 = "~w~Hạng 3 "..config.JobLabel[third.name].."~w~ | ~b~Điểm : "..third.point
    end
    local coordsCharts1 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z+0.5}
    local coordsCharts2 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z+0.3}
    local coordsCharts3 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z}
    local coordsCharts4 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z-0.3}

--   local coordsCharts1 = {x = config.ChartsLocation.x, y = config.ChartsLocation.y, z = config.ChartsLocation.z+0.4}
--    local coordsCharts2 = {x = config.gang1.x, y = config.gang1.y, z = config.gang1.z+0.2}
--    local coordsCharts3 = {x = config.gang2.x, y = config.gang2.y, z = config.gang2.z}
--    local coordsCharts4 = {x = config.gang3.x, y = config.gang3.y, z = config.gang3.z-0.2}


    ESX.Game.Utils.DrawText3D(coordsCharts1, text1)
    if text2 ~= nil then
        ESX.Game.Utils.DrawText3D(coordsCharts2, text2)
    end
    if text3 ~= nil then
        ESX.Game.Utils.DrawText3D(coordsCharts3, text3)
    end
    if text4 ~= nil then
        ESX.Game.Utils.DrawText3D(coordsCharts4, text4)
    end
end

function DrawHelpNotification(text, coords)
	ESX.Game.Utils.DrawText3D(coords, text)
end

function DrawHelpNotification(text, coords)
	ESX.Game.Utils.DrawText3D(coords, '<FONT FACE="arial font">'..text)
end

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(fontId)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName('<FONT FACE = "arial font">' ..text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

NotificationArea = function(x,y,z,width,height,heading,color,alpha,highDetail,display,shortRange, name, location)
    Citizen.CreateThread(function()
        while NotiBlip[location] do 
            local blip = AddBlipForArea((x or 0.0),(y or 0.0),(z or 0.0),(width or 100.0),(height or 100.0))
            SetBlipColour(blip, (color or 1))
            SetBlipAlpha (blip, (alpha or 80))
            SetBlipHighDetail(blip, (highDetail or true))
            SetBlipRotation(blip, (heading or 0.0))
            --SetBlipDisplay(blip, (display or 4))
            --SetBlipAsShortRange(blip, (shortRange or true))
            Wait(500)
            RemoveBlip(blip)
            Wait(500)
        end
    end)
end
    

Citizen.CreateThread(function()
	local sleepThread2 = 2000
	while true do 
		Wait(sleepThread2)
		if isCapturing and curCapture~= nil and not isBoom then 
			sleepThread2 = 100
			local pedCoords = GetEntityCoords(PlayerPedId())
			local cacheLoc = config.Location[curCapture]
			local distanceC = GetDistanceBetweenCoords(pedCoords, cacheLoc.x, cacheLoc.y, cacheLoc.z, true)
			if distanceC > 20.0 then 
                TriggerServerEvent('sulu_occupation:cancel', curCapture)
                isCapturing = false
                curCapture = nil
			end 
		else  
			sleepThread2 = 2000
		end 
	end
end)

local joinZone = false
function onEnter(self)
    local weapon = exports.ox_inventory.getCurrentWeapon()
    joinZone = true
    if weapon then
        local weaponHash = GetSelectedPedWeapon(cache.ped)
        if GetWeapontypeGroup(weaponHash) ~= -728555052 then
            Citizen.Wait(1000)
            TriggerEvent('ox_inventory:disarm')
        end
    end
end

AddEventHandler('ox_inventory:currentWeapon', function(weapon) 
    if weapon and joinZone then
        local weaponHash = GetSelectedPedWeapon(cache.ped)
        if GetWeapontypeGroup(weaponHash) ~= -728555052 then
            Citizen.Wait(1000)
            TriggerEvent('ox_inventory:disarm')
        end
    end
end)

function onExit(self)
    joinZone = false
end

Citizen.CreateThread(function()
    for k,v in pairs(config.point) do
        lib.zones.poly({
            points = v,
            thickness = 50,
            debug = false,
            onEnter = onEnter,
            onExit = onExit
        })
    end
end)