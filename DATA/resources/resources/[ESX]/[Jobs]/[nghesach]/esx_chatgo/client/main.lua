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
  
  local PlayerData              = {}
  local iniziato = false
  local statagliando = false
  local JobBlips = {}
  local assi = false
  local inservizio = false
  local firstspawn = false
  local chatgo1 = false
  local catgo1 = false
  local hoanthanh1 = false
  --ESX                           = nil
  
  local chatcay = {
	  vec3(-553.37, 5373.67, 70.34),
	  vec3(-554.13, 5370.97, 70.34),
	  vec3(-555.19, 5367.8, 70.34),
  }
  
  
  local epvan = {
	  vec3(-588.05, 5334.12, 70.21),
  }
  local gocatthanhvan = {
	  vec3(-516.91,5257.22, 80.65),
	  vec3(-514.7,5263.18, 80.65),
  }
  
  Citizen.CreateThread(function()
	--   while ESX == nil do
	-- 	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	  Citizen.Wait(0)
	--   end
  
	  while ESX.GetPlayerData().job == nil do
		  Citizen.Wait(1000)
	  end
  
	  PlayerData = ESX.GetPlayerData()
	  refreshBlips()
  end)
  
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	  PlayerData = xPlayer
	  refreshBlips()
	  if PlayerData.job.name == 'lumberjack' then
		  inservizio = true
			  refreshBlips()
	  end
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	  PlayerData.job = job
	  deleteBlips()
	  refreshBlips()
	  if PlayerData.job.name == 'lumberjack' then
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
	  if PlayerData.job2.name == 'lumberjack' then
		  inservizio = true
			  refreshBlips()
	  end
	  Citizen.Wait(5000)
  end)
  
  function deleteBlips()
	  if JobBlips[1] ~= nil then
		  for i=1, #JobBlips, 1 do
			  RemoveBlip(JobBlips[i])
			  JobBlips[i] = nil
		  end
	  end
  end
  
  Citizen.CreateThread(function() 
  
	  while true do
		local coords = GetEntityCoords(cache.ped)
		  local time = 1000
				  if #(coords - epvan[1]) < 15.0 and PlayerData.job ~= nil and (PlayerData.job.name == 'lumberjack') then
					  time = 1
					  DrawMarker(20, epvan[1] , 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
				  end
				if #(coords - epvan[1]) < 1.1 and PlayerData.job ~= nil and (PlayerData.job.name == 'lumberjack') then
					ESX.ShowHelpNotification('Nhấn [~g~E~s~] để cắt gỗ')
					if IsControlJustReleased(1, 51) then
						if lib.skillCheck('easy', {'e'}) then
							if lib.progressBar({
								duration =  Config.time2,
								label = 'đang cắt gỗ',
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
								TriggerServerEvent("esx_taglialegnasdr:segatura") 
								-- exports["WaveShield"]:TriggerServerEvent("esx_taglialegnasdr:segatura")
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
		  for i=1, #gocatthanhvan, 1 do
				  if #(coords - gocatthanhvan[i]) < 15.0 and PlayerData.job ~= nil and (PlayerData.job.name == 'lumberjack') then
					  time = 5
					  DrawMarker(20, gocatthanhvan[i], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
				  end
  
				if #(coords - gocatthanhvan[i]) < 2 and PlayerData.job ~= nil and (PlayerData.job.name == 'lumberjack') then
					  ESX.ShowHelpNotification('Nhấn [~g~E~s~] để ép gỗ')
					if IsControlJustReleased(1, 51) then
						if lib.skillCheck('easy', {'e'}) then
							if lib.progressBar({
								duration =  Config.time3,
								label = 'đang ép ván',
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
								TriggerServerEvent("esx_taglialegnasdr:tavole") 
								-- exports["WaveShield"]:TriggerServerEvent("esx_taglialegnasdr:tavole")
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
		  for i=1, #chatcay, 1 do
  
			  -- if k == 'PegarJob_food' then
				  if #(coords - chatcay[i]) < 15.0 and PlayerData.job ~= nil and (PlayerData.job.name == 'lumberjack') then
					  time = 5
					  DrawMarker(20, chatcay[i], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
				  end
  
				if #(coords - chatcay[i]) < 2 and PlayerData.job ~= nil and (PlayerData.job.name == 'lumberjack') then
					ESX.ShowHelpNotification('Nhấn [~g~E~s~] để chặt gỗ')
					if IsControlJustReleased(1, 51) then
						if lib.skillCheck('easy', {'e'}) then
							if lib.progressBar({
								duration =  Config.time1*exports.sulu_pet:time(),
								label = 'đang chặt gỗ',
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
								TriggerServerEvent("esx_taglialegnasdr:pickedUpTree",exports.sulu_pet:x2()) 
								-- exports["WaveShield"]:TriggerServerEvent("esx_taglialegnasdr:pickedUpTree")
							end
						end 
					 end  
				end					  
		  end	
  
		  Citizen.Wait(time)
	  end	
  
  end)
  
  function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
	  SetTextFont(0)
	  SetTextProportional(0)
	  SetTextScale(scale, scale)
	  SetTextColour(r, g, b, a)
	  SetTextDropShadow(0, 0, 0, 0,255)
	  SetTextEdge(1, 0, 0, 0, 255)
	  SetTextDropShadow()
	  if(outline)then
		  SetTextOutline()
	  end
	  SetTextEntry("STRING")
	  AddTextComponentString(text)
	  DrawText(x - width/2, y - height/2 + 0.005)
  end
  
  function drawTxt(text)
	  SetTextFont(0)
	  SetTextProportional(0)
	  SetTextScale(0.32, 0.32)
	  SetTextColour(0, 255, 255, 255)
	  SetTextDropShadow(0, 0, 0, 0, 255)
	  SetTextEdge(1, 0, 0, 0, 255)
	  SetTextDropShadow()
	  SetTextOutline()
	  SetTextCentre(1)
	  SetTextEntry("STRING")
	  AddTextComponentString(text)
	  DrawText(0.5, 0.93)
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
			  SetTextFont(ESX.FontId)
			  SetBlipSprite (blip, 237)
			  SetBlipDisplay(blip, 4)
			  SetBlipScale  (blip, 0.65)
			  SetBlipColour (blip, 17)
			  SetBlipAsShortRange(blip, true)
			  BeginTextCommandSetBlipName("STRING")
			  AddTextComponentString(v.Pos[i].nome)
			  EndTextCommandSetBlipName(blip)
			  table.insert(JobBlips, blip)
			  end
		  end
	  else
		  local blip = AddBlipForCoord(Config.Zones.Tabacchi.Pos[1].x, Config.Zones.Tabacchi.Pos[1].y, Config.Zones.Tabacchi.Pos[1].z)
		  SetTextFont(ESX.FontId)
		  SetBlipSprite (blip, 237)
		  SetBlipDisplay(blip, 4)
		  SetBlipScale  (blip, 0.65)
		  SetBlipColour (blip, 17)
		  SetBlipAsShortRange(blip, true)
		  BeginTextCommandSetBlipName("STRING")
		  AddTextComponentString(Config.Zones.Tabacchi.Pos[1].nome)
		  EndTextCommandSetBlipName(blip)
		  table.insert(JobBlips, blip)
	  end
  end
  
  ------------------------------------------------------ BLIP LAVORI OFFLINE
  blip = false
  
  local bango123 = vec3(-625.23608398438, -131.75848388672, 39.008560180664)
  
--   Citizen.CreateThread(function() 
  
-- 	  while true do
-- 		  local time = 1000
  
-- 		  local coords = GetEntityCoords(cache.ped)

-- 				  if #(coords - bango123) < 1.1 then
-- 					  time = 1
-- 					  ESX.ShowHelpNotification("Nhấn [E] để bán gỗ.")
-- 					  if IsControlJustReleased(1, 51) then
-- 						  bango()
-- 					  end
-- 				  end			
-- 		  Citizen.Wait(time)
-- 	  end	
  
--   end)
  
  
  
  function bango()
	  local elements = {
		  {label = 'Bán Gỗ',   value = 'wood'}
  
	  }
	  ESX.UI.Menu.CloseAll()
  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
		  title    = 'Vật Liệu',
		  align    = 'bottom-right',
		  elements = elements
	  }, function(data, menu)
		  menu.close()
			  TriggerServerEvent("esx_lumberjack:sellwood")
	  end)
  end
