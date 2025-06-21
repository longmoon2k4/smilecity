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
    vec3(1938.96, 5083.97,  41.7),
    vec3(1934.32,   5088.37,   41.9)
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
	if PlayerData.job.name == 'tailor' then
		inservizio = true
			refreshBlips()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	deleteBlips()
	refreshBlips()
	if PlayerData.job.name == 'tailor' then
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
	if PlayerData.job2.name == 'tailor' then
		inservizio = true
			refreshBlips()
	end
	Citizen.Wait(5000)
end)


Citizen.CreateThread(function()
    while true do
        local time = 1000
        local pos = GetEntityCoords(cache.ped, true)
        for i=1, #locations, 1 do
            if #(pos-locations[i]) <25 and PlayerData.job ~= nil and PlayerData.job.name == 'tailor' then
                time = 1
                DrawMarker(20, locations[i],  0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
            end
            if #(pos-locations[i]) <1 and PlayerData.job ~= nil and PlayerData.job.name == 'tailor'  then
                ESX.ShowHelpNotification('Nhấn [E] để lấy vải')
                if IsControlJustReleased(1, 51) then
					if lib.skillCheck('easy', {'e'}) then
						if lib.progressBar({
							duration =  Config.time1*exports.sulu_pet:time(),
							label = 'đang lấy bông gòn',
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
							TriggerServerEvent("esx_vai:givevai") 
							-- exports["WaveShield"]:TriggerServerEvent("esx_vai:givevai")
						end
					end 
				 end   
            end
        end
        Citizen.Wait(time)
    end
end)

local chebien = vec3(1981.03, 5174.39,  47.64)
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local pos = GetEntityCoords(cache.ped, true)
        if #(pos-chebien) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'tailor' then
            time = 1
            DrawMarker(20, chebien, 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
        end
        if #(pos-chebien) < 2 and PlayerData.job ~= nil and PlayerData.job.name == 'tailor' then
            ESX.ShowHelpNotification('Nhấn [E] để dệt vải')
                if IsControlJustReleased(1, 51) then
					if lib.skillCheck('easy', {'e'}) then
						if lib.progressBar({
							duration =  Config.time2,
							label = 'đang dệt vải',
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
							TriggerServerEvent("esx_vai:detvai") 
							-- exports["WaveShield"]:TriggerServerEvent("esx_vai:detvai")
						end
					end 
				 end   
        end
        Citizen.Wait(time)
    end
end)


local donggoi = vec3(712.65,  -963.5,  30.4)
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local pos = GetEntityCoords(cache.ped, true)
        if #(pos-donggoi) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'tailor' then
            time = 1
            DrawMarker(20, donggoi, 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
        end
        if #(pos-donggoi) < 2 and PlayerData.job ~= nil and PlayerData.job.name == 'tailor' then
            ESX.ShowHelpNotification('Nhấn [E] để may quần áo')
            if IsControlJustReleased(1, 51) then
                if lib.skillCheck('easy', {'e'}) then
                    if lib.progressBar({
                        duration =  Config.time3,
                        label = 'đang may quần áo',
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
						TriggerServerEvent("esx_vai:quanao") 
						-- exports["WaveShield"]:TriggerServerEvent("esx_vai:quanao")
					end
                end 
             end   
        end
        Citizen.Wait(time)
    end
end)

--local banvai =vec3(-615.00775146484,  -110.78079223633,  40.008152008057)
-- Citizen.CreateThread(function()
--     while true do
--         local time = 1000
--         local pos = GetEntityCoords(cache.ped)
--         if #(pos - banvai) < 2 then
--             time = 1
--             ESX.ShowHelpNotification('Nhấn [E] để bán Quần Áo')
--             if IsControlJustReleased(1, 51) then
--                 Jeweler()                          
--             end
--         end
--         Citizen.Wait(time)
--     end
-- end)




-- function Jeweler()
--     local elements = {
--         {label = 'Bán Quần Áo',   value = 'clothe'},
--     }

--     ESX.UI.Menu.CloseAll()

--     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
--         title    = 'Chọn vật phẩm để bán',
--         align    = 'bottom-right',
--         elements = elements
--     }, function(data, menu)
--         if data.current.value == 'clothe' then
--             menu.close()
--             --TriggerServerEvent("balance:server:sellStock", "essence")
--             TriggerServerEvent("esx_vai:sellquanao")
--         end
--     end, function(data, menu)
--         menu.close()
--     end)
-- end

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function refreshBlips()
	for i = 1, #JobBlips, 1 do 
		RemoveBlip(JobBlips[i])
	end
	JobBlips = {}
	if inservizio == true then

        for k,v in pairs(Config.Zones) do
		  
		    for i = 1, #v.Pos, 1 do
		
			local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
		
			SetBlipSprite (blip, 366)
			SetBlipDisplay(blip, 4)
		    SetBlipScale  (blip, 0.65)
		    SetBlipColour (blip, 0)
		    SetBlipAsShortRange(blip, true)
		    BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString(v.Pos[i].nome)
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		    end
		end
	else
		local blip = AddBlipForCoord(Config.Zones.Tabacchi.Pos[1].x, Config.Zones.Tabacchi.Pos[1].y, Config.Zones.Tabacchi.Pos[1].z)
		
		SetBlipSprite (blip, 366)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.65)
		SetBlipColour (blip, 0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Zones.Tabacchi.Pos[1].nome)
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlips, blip)
	end
end

blip = false