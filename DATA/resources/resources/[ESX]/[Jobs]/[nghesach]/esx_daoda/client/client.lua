local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}
local PlayerData              = {}
local JobBlips = {}
local obg1 = 0
local Pop1 = {}
local IsPickingUp, IsProcessing, IsOpenMenu = false, false, false
local standardVolumeOutput = 1.0;
local washingActive = false
local remeltingActive = false
local inservizio = false
local ruada = {
    -- {['x'] = 1902.3,  ['y'] = 386.2,  ['z'] = 161.77},
    -- {['x'] = 1887.59,  ['y'] = 397.33,  ['z'] = 161.77},
    -- {['x'] = 1875.65,  ['y'] = 405.04,  ['z'] = 161.32},
    -- {['x'] = 1863.72,  ['y'] = 410.59,  ['z'] = 160.73}

	vec3(1902.3,   386.2,  161.77),
	vec3(1887.59, 397.33,   161.77),
	vec3(1875.65,   405.04,   161.32),
	vec3(1863.72,   410.59,   160.73),
}
local nungda = {
    -- {['x'] = 1109.03,  ['y'] = -2007.61,  ['z'] = 30.94},
    -- {['x'] = 1090.37,  ['y'] = -2003.93,  ['z'] = 30.41},
    -- {['x'] = 1087.72,  ['y'] = -2001.88,  ['z'] = 30.45},
    -- {['x'] = 1085.64,  ['y'] = -1999.81,  ['z'] = 30.46},

	vec3(1109.03,   -2007.61, 30.94),
	vec3(1090.37,   -2003.93,  30.41),
	vec3(1087.72,  -2001.88,  30.45),
	vec3(1085.64,   -1999.81,   30.46),
}
local daoda123  = {

	-- {['x'] = 2954.24,  ['y'] = 2818.71,  ['z'] = 42.42},
	-- {['x'] = 2946.21,  ['y'] = 2816.35,  ['z'] = 42.42},
	-- {['x'] = 2933.35,  ['y'] = 2811.64,  ['z'] = 42.42},

	vec3  (2954.24,  2818.71,  42.42),
	vec3 (2946.21,  2816.35,   42.42),
	vec3 (2933.35,   2811.64,   42.42),
}
--ESX = nil

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
	if PlayerData.job.name == 'miner' then
		inservizio = true
			refreshBlips()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	refreshBlips()
	if PlayerData.job.name == 'miner' then
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
	if PlayerData.job2.name == 'miner' then
		inservizio = true
			refreshBlips()
	end
	Citizen.Wait(5000)
end)

Citizen.CreateThread(function()
    while true do
		local time = 1000
		local coords = GetEntityCoords(cache.ped)
		for i=1, #ruada, 1 do
			if #(coords - ruada[i]) < 25 and  PlayerData.job ~= nil and PlayerData.job.name == 'miner' then  
				time = 1
				DrawMarker(20, ruada[i], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
			end
			if #(coords - ruada[i])  < 1  and PlayerData.job.name == 'miner' then
				ESX.ShowHelpNotification('Nhấn [~g~E~s~] để rửa đá')	
				if IsControlJustReleased(1, 51) then
					if lib.skillCheck('easy', {'e'}) then
						if lib.progressBar({
							duration =  Config.time2,
							label = 'đang rửa đá',
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
							-- exports["WaveShield"]:TriggerServerEvent("esx_miner:washing")
							TriggerServerEvent("esx_miner:washing") 
						end
					end 
				 end    
			end
		end
		Citizen.Wait(time)
	end
end)


Citizen.CreateThread(function()
    while true do
		local time = 1000
		local coords = GetEntityCoords(cache.ped)
		for i=1, #nungda, 1 do
			if #(coords - nungda[i]) < 25 and PlayerData.job ~= nil and PlayerData.job.name == 'miner' then  
				time = 1
				DrawMarker(20, nungda[i], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
			end
			if #(coords - nungda[i]) < 1  and PlayerData.job.name == 'miner' then
				ESX.ShowHelpNotification('Nhấn [~g~E~s~] để nung đá')
				if IsControlJustReleased(1, 51) then
					if lib.skillCheck('easy', {'e'}) then
						if lib.progressBar({
							duration =  Config.time3,
							label = 'đang nung',
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
							TriggerServerEvent("esx_miner:remelting") 
							-- exports["WaveShield"]:TriggerServerEvent("esx_miner:remelting")
						end
					end 
				 end    
			end
		end
		Citizen.Wait(time)
	end
end)


-- local banda = vec3(-588.48, -135.6, 38.91)
-- Citizen.CreateThread(function()
--     while true do
-- 		local time = 1000
-- 		local pos = GetEntityCoords(cache.ped)
-- 		if #(pos - banda) < 2 then
-- 			time = 1
-- 			ESX.ShowHelpNotification("Nhấn [E] để bán hợp kim.")
--             if IsControlJustReleased(1, 51) then
--             Jeweler()                          
--             end
-- 		end
-- 		Citizen.Wait(time)
-- 	end
-- end)


--  function Jeweler()
--     local elements = {
--         {label = 'Bán Kim Cương',   value = 'diamonds'},
--         {label = 'Bán Vàng',      value = 'gold'},
--         {label = 'Bán Sắt',       value = 'iron'},
--         {label = 'Bán Đồng',       value = 'copper'},
--     }

--     ESX.UI.Menu.CloseAll()

--     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
--         title    = 'Vật Liệu',
--         align    = 'bottom-right',
--         elements = elements
--     }, function(data, menu)
--         if data.current.value == 'diamonds' then
--             menu.close()
--             TriggerServerEvent("esx_miner:selldiamond")
--         elseif data.current.value == 'gold' then
--             menu.close()
--             TriggerServerEvent("esx_miner:sellgold")
--         elseif data.current.value == 'iron' then
--             menu.close()
--             TriggerServerEvent("esx_miner:selliron")
--         elseif data.current.value == 'copper' then
--             menu.close()
--             TriggerServerEvent("esx_miner:sellcopper")
--         end
--     end)
-- end

Citizen.CreateThread(function()
	while true do
		local time = 1000
		local coords = GetEntityCoords(cache.ped)
		for i=1, #daoda123, 1 do
			if #(coords- daoda123[i])< 25 and PlayerData.job ~= nil and PlayerData.job.name == 'miner' then  
				time = 1 
				DrawMarker(20, daoda123[i], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
			end
			if #(coords- daoda123[i]) < 1 and PlayerData.job.name == 'miner' then
				ESX.ShowHelpNotification('Nhấn [~g~E~s~] để tìm đá')
				if IsControlJustReleased(1, 51) then
					if lib.skillCheck('easy', {'e'}) then
						if lib.progressBar({
							duration =  Config.time1*exports.sulu_pet:time(),
							label = 'đang tìm đá',
							useWhileDead = false,
							canCancel = true,
							disable = {
								car = true,
								move = true,
								combat = true,
								mouse = false,
							},
							anim = {
								dict = 'amb@world_human_gardener_plant@male@idle_a',
								clip = 'idle_a',
								flag = 1
							},
						}) then 
							-- exports["WaveShield"]:TriggerServerEvent("ant_stone:pickedUp")
							TriggerServerEvent("ant_stone:pickedUp") 
						end
					end 
				 end   
			end
		end
		Citizen.Wait(time)
	end
end)








-- AddEventHandler('onResourceStop', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		for k, v in pairs(Pop1) do
-- 			ESX.Game.DeleteObject(v)
-- 		end
-- 	end
-- end)

RegisterFontFile('Helvetica')
function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
	local fontId = RegisterFontId('Helvetica')
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local dist       = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)    
	local scale      = (1 / dist) * 20
	local fov        = (1 / GetGameplayCamFov()) * 100
	local scale      = scale * fov   
	SetTextScale(scaleX * scale, scaleY * scale)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(250, 250, 250, 255)
	SetTextDropshadow(1, 1, 1, 1, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(textInput)
	SetDrawOrigin(x, y, z + 2, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
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
		
			SetBlipSprite (blip, 728)
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
		
		SetBlipSprite (blip, 728)
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