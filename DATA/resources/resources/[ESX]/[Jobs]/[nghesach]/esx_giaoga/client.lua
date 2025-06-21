--ESX                             = nil
local PlayerData                = {}
local JobBlips = {}
local blip1 = {}
local blips = false
local blipActive = false
local laygaActive = false
local chatgaActive = false
local donghopActive = false
local firstspawn = false
local impacts = 0
local timer = 0
local inservizio = false
local locations = {
    vec3(-62.71,   6241.77,   31.09),
    vec3(-64.79,   6245.83,   31.09)
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
	if PlayerData.job.name == 'giaoga' then
		inservizio = true
			refreshBlips()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
	deleteBlips()
	refreshBlips()
	if PlayerData.job.name == 'giaoga' then
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
	if PlayerData.job2.name == 'giaoga' then
		inservizio = true
			refreshBlips()
	end
	Citizen.Wait(5000)
end)

RegisterNetEvent("esx_giaoga:chatga")
AddEventHandler("esx_giaoga:chatga", function()
    Chatga()
end)

RegisterNetEvent("esx_giaoga:donghop")
AddEventHandler("esx_giaoga:donghop", function()
    Donghop()
end)

RegisterNetEvent("esx_giaoga:givega")
AddEventHandler("esx_giaoga:givega", function()
    Animation()
end)



Citizen.CreateThread(function()
    while true do
        local time = 1000
        local pos = GetEntityCoords(cache.ped)
        for i=1, #locations, 1 do
            if #(pos - locations[i]) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'giaoga' then
                time = 1
                DrawMarker(20, locations[i], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
            end
            if #(pos - locations[i]) < 2 and PlayerData.job ~= nil and PlayerData.job.name == 'giaoga' then
                ESX.ShowHelpNotification('Nhấn [E] để bắt gà')
                if IsControlJustReleased(1, 51) then
                    if lib.skillCheck('easy', {'e'}) then
                        if lib.progressBar({
                            duration =  Config.time1*exports.sulu_pet:time(),
                            label = 'đang bắt gà',
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
                            TriggerServerEvent("esx_giaoga:givegasong") 
                            -- exports["WaveShield"]:TriggerServerEvent("esx_giaoga:givegasong")
                        end
                    end 
                 end            
            end
        end
        Citizen.Wait(time)
    end
end)



local chebien = vec3(-78.06,  6229.2,  31.09)
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local pos = GetEntityCoords(cache.ped)
        if #(pos - chebien) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'giaoga' then
            time = 1
            DrawMarker(20, chebien, 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
        end
        if #(pos - chebien) < 2 and PlayerData.job ~= nil and PlayerData.job.name == 'giaoga' then
            ESX.ShowHelpNotification('Nhấn [E] để chặt gà')
            if IsControlJustReleased(1, 51) then
                if lib.skillCheck('easy',{'e'}) then
                    if lib.progressBar({
                        duration =  Config.time2,
                        label = 'đang chặt gà',
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
                        TriggerServerEvent("esx_giaoga:chatga") 
                        -- exports["WaveShield"]:TriggerServerEvent("esx_giaoga:chatga")
                    end
                end 
             end     
        end
        Citizen.Wait(time)
    end
end)




local donggoi = vec3(-101.91,  6208.81, 31.03)
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local pos = GetEntityCoords(cache.ped)
        if #(pos - donggoi) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'giaoga' then
            time = 1
            DrawMarker(20, donggoi, 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
        end
        if #(pos - donggoi) < 2 and PlayerData.job ~= nil and PlayerData.job.name == 'giaoga' then
            ESX.ShowHelpNotification('Nhấn [E] để đóng hộp')
            if IsControlJustReleased(1, 51) then
                if lib.skillCheck('easy', {'e'}) then
                    if lib.progressBar({
                        duration =  Config.time3,
                        label = 'đang đóng gói',
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
                        TriggerServerEvent("esx_giaoga:donghop") 
                        -- exports["WaveShield"]:TriggerServerEvent("esx_giaoga:donghop")
                    end
                end 
             end     
        end
        Citizen.Wait(time)
    end
end)




-- local banga = vec3(-623.96,  -119.34, 38.61)
-- Citizen.CreateThread(function()
--     while true do
--         local time = 1000
--         local pos = GetEntityCoords(cache.ped)
--         if #(pos- banga) < 2 then
--             time = 1
--             ESX.ShowHelpNotification('Nhấn [E] để bán Thịt')
--             if IsControlJustReleased(1, 51) then
--                 Jeweler()                          
--             end
--         end
--         Citizen.Wait(time)
--     end
-- end)
    



-- function Jeweler()
--     local elements = {
--         {label = 'Giao Gà',   value = 'packaged_chicken'},
--         {label = 'Da Bò',   value = 'dabo'},
--     }

--     ESX.UI.Menu.CloseAll()

--     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
--         title    = 'Chọn vật phẩm để bán',
--         align    = 'bottom-right',
--         elements = elements
--     }, function(data, menu)
--         if data.current.value == 'packaged_chicken' then
--             menu.close()
--             TriggerServerEvent("esx_giaoga:sellga")
--             --TriggerServerEvent("balance:server:sellStock", "packaged_chicken")
--         elseif data.current.value == 'dabo' then 
--             menu.close()
--             TriggerServerEvent("esx_giaoga:selldabo")
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
		
			SetBlipSprite (blip, 256)
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
		
		SetBlipSprite (blip, 256)
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

blip = false