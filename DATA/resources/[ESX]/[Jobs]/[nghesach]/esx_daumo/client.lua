--ESX                             = nil
local PlayerData                = {}
local JobBlips = {}
local blip1 = {}
local blips = false
local blipActive = false
local khaithacactive = false
local chebienactive = false
local donggoiactive = false
local firstspawn = false
local impacts = 0
local timer = 0
local inservizio = false
local locations = { 
    vec3(610.6813,   2859.218,   39.97949),
    vec3(608.7824,   2859.864,   39.97949),
    vec3(607.6219,   2854.602,   39.97949),
    vec3(610.9714,  2853.376, 39.97949),
}
Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end
	while ESX.GetPlayerData() == nil do
		Citizen.Wait(5000)
	end
	PlayerData = ESX.GetPlayerData()
    refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    refreshBlips()
	if PlayerData.job.name == 'daumo' then
		inservizio = true
			refreshBlips()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	deleteBlips()
	refreshBlips()
	if PlayerData.job.name == 'daumo' then
		inservizio = true
			refreshBlips()
	end
	Citizen.Wait(5000)
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2
	deleteBlips()
	refreshBlips()
	if PlayerData.job2.name == 'daumo' then
		inservizio = true
			refreshBlips()
	end
	Citizen.Wait(5000)
end)


Citizen.CreateThread(function()
    while true do
        local time = 1000
        local coords = GetEntityCoords(cache.ped)
        for i=1, #locations, 1 do
            if #(coords-locations[i]) < 25  and  PlayerData.job ~= nil  and  PlayerData.job.name == 'daumo' then
                 time = 1
                DrawMarker(20, locations[i], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
            end
            if #(coords-locations[i]) < 1  and  PlayerData.job ~= nil and  PlayerData.job.name == 'daumo' then
                ESX.ShowHelpNotification('Nhấn [E] để lấy dầu')
                if IsControlJustReleased(1, 51) then
					if lib.skillCheck('easy', {'e'}) then
						if lib.progressBar({
							duration =  Config.time1*exports.sulu_pet:time(),
							label = 'đang lấy dầu',
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
                            TriggerServerEvent("esx_daumo:givedaumo") 
                            -- exports["WaveShield"]:TriggerServerEvent("esx_daumo:givedaumo")
                        end
					end 
				 end   
            end
        end
        Citizen.Wait(time)
    end
end)



local chebien = vec3(2717.789,  1430.295,  24.61243)
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local coords = GetEntityCoords(cache.ped)
        if #(coords-chebien) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'daumo' then
            time = 1
            DrawMarker(20, chebien, 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
        end
        if #(coords-chebien) < 2 and PlayerData.job ~= nil and PlayerData.job.name == 'daumo' then
            ESX.ShowHelpNotification('Nhấn [E] để lọc dầu')
            if IsControlJustReleased(1, 51) then
                if lib.skillCheck('easy', {'e'}) then
                    if lib.progressBar({
                        duration =  Config.time2,
                        label = 'đang lọc dầu',
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
                        TriggerServerEvent("esx_daumo:chebien") 
                        -- exports["WaveShield"]:TriggerServerEvent("esx_daumo:chebien")
                    end
                end 
             end  
        end
        Citizen.Wait(time)
    end
end)

local donggoi = vec3(263.644,  -2978.321, 4.915039)
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local coords = GetEntityCoords(cache.ped)
        if #(coords-donggoi) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'daumo' then
            time = 1
            DrawMarker(20, donggoi, 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
        end
        if #(coords-donggoi) < 1 and PlayerData.job ~= nil and PlayerData.job.name == 'daumo' then
            ESX.ShowHelpNotification('Nhấn [E] để chế biến xăng')
            if IsControlJustReleased(1, 51) then
                if lib.skillCheck('easy', {'e'}) then
                    if lib.progressBar({
                        duration =   Config.time3,
                        label = 'đang chế xăng',
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
                        TriggerServerEvent("esx_daumo:donggoi") 
                        -- exports["WaveShield"]:TriggerServerEvent("esx_daumo:donggoi")
                    end
                end 
            end
        end
        Citizen.Wait(time)
    end
end)



-- local banxang =vec3(-578.38,  -128.55,  39.0)
-- Citizen.CreateThread(function()
--     while true do
--         local time = 1000
--         local pos = GetEntityCoords(cache.ped)
--         if #(pos - banxang) < 2 then
--             time = 1
--             ESX.ShowHelpNotification('Nhấn [E] để bán Xăng Dầu')
--             if IsControlJustReleased(1, 51) then
--                 Jeweler()                          
--             end
--         end
--         Citizen.Wait(time)
--     end
-- end)



-- function Jeweler()
--     local elements = {
--         {label = 'Giao Xăng',   value = 'essence'},
--     }

--     ESX.UI.Menu.CloseAll()

--     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
--         title    = 'Chọn vật phẩm để bán',
--         align    = 'bottom-right',
--         elements = elements
--     }, function(data, menu)
--         if data.current.value == 'essence' then
--             menu.close()
--             --TriggerServerEvent("balance:server:sellStock", "essence")
--             TriggerServerEvent("esx_daumo:sellxang")
--         end
--     end, function(data, menu)
--         menu.close()
--     end)
-- end



function refreshBlips()
	for i = 1, #JobBlips, 1 do 
		RemoveBlip(JobBlips[i])
	end
	JobBlips = {}
	if inservizio == true then

        for k,v in pairs(Config.Zones) do
		  
		    for i = 1, #v.Pos, 1 do
		
			local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
			SetBlipSprite (blip, 436)
			SetBlipDisplay(blip, 4)
		    SetBlipScale  (blip, 0.65)
		    SetBlipColour (blip, 5)
		    SetBlipAsShortRange(blip, true)
		    BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString(v.Pos[i].nome)
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		    end
		end
	else
		local blip = AddBlipForCoord(Config.Zones.Tabacchi.Pos[1].x, Config.Zones.Tabacchi.Pos[1].y, Config.Zones.Tabacchi.Pos[1].z)
		SetBlipSprite (blip, 436)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.65)
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Zones.Tabacchi.Pos[1].nome)
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlips, blip)
	end
end

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end
blip = false