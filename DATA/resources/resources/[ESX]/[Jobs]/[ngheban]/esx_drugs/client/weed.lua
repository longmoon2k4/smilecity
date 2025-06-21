local Keys = {
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

-- ESX = nil
local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp, isProcessing = false, false
local cheCansa = vec3(1543.147217, 6334.443848, 24.073242)

Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end
end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())

		if  #(coords - Config.CircleZones.WeedField1.coords) < 50 then
			SpawnWeedPlants()
			time = 500
		
		end
		Citizen.Wait(time)
	end
end)


Citizen.CreateThread(function()
    while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
		
		if #(coords -  cheCansa) < 25 then
			DrawMarker(20, cheCansa, 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
			time = 1
		end
		if #(coords -  cheCansa) < 2 then
			ESX.ShowHelpNotification('Nhấn [E] để chế ~r~Cần Sa~s~.')
			if IsControlJustReleased(1, 51) then
				if lib.progressBar({
					duration = 7000,
					label = "đang chế cần sa",
					useWhileDead = false,
					canCancel = true,
					disable = {
						car = true,
						move = true,
						combat = true,
						mouse = false,
					},
					anim = {
						dict = 'missheistdockssetup1clipboard@idle_a',
						clip = 'idle_a',
						flag = 1
					},
				}) then 
					TriggerServerEvent('esx_illegal:processCannabis')
					ClearPedTasks(PlayerPedId())
				end
			end
		end
		Citizen.Wait(time)
	end
end)


Citizen.CreateThread(function()
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local nearbyObject, nearbyID
		for i=1, #weedPlants, 1 do
			if  GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false)  < 1 then
				time = 1
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end
		if nearbyObject and IsPedOnFoot(PlayerPedId()) then       
			ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			if IsControlJustReleased(0, Keys['E'])  then					    
						if ESX.GetPlayerData().job.name == 'ambulance' or
						   ESX.GetPlayerData().job.name == 'police' or
						   ESX.GetPlayerData().job.name == 'mechanic' then
						   ESX.ShowNotification("Nghề của bạn ~r~không~s~ thể ~y~làm việc~s~ này")		    
						else
							if lib.progressBar({
								duration = 6000,
								label = "đang thu hoạch cần sa",
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
								ESX.Game.DeleteObject(nearbyObject)			
								table.remove(weedPlants, nearbyID)
								spawnedWeeds = spawnedWeeds - 1							
								TriggerServerEvent('esx_illegal:pickedUpCannabis')
								ClearPedTasksImmediately(PlayerPedId())
							end
						end	
			end
		end
		Citizen.Wait(time)
	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnWeedPlants()
	while spawnedWeeds < 15 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()

		ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(weedPlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZWeed(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end