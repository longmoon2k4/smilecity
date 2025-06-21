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
local spawnedPoppys = 0
local PoppyPlants = {}
local isPickingUp, isProcessing = false, false
local cheSanho = vec3(2194.153809, 5595.099121, 53.745850)

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())

		if #(coords- Config.CircleZones.SanhoField1.coords) < 50 then

			SpawnSanhoPlants()
			--print(Config.CircleZones.SanhoField.coords)
			time = 500
		end
		Citizen.Wait(time)
	end
end)


-- Citizen.CreateThread(function()
-- 	while true do
-- 		local time = 1000
-- 		local coords = GetEntityCoords(PlayerPedId())
-- 			if #(coords - cheSanho) < 15.0  then
-- 				time = 1
-- 				DrawMarker(20, cheSanho , 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
-- 			end
-- 			if #(coords - cheSanho) < 1 then
-- 				ESX.ShowHelpNotification('Nhấn [E] để chế ~r~San hô~s~.')
-- 				if IsControlJustReleased(1, 51) then
-- 					-- ESX.TriggerServerCallback('esx_langbam:getItemAmount', function(quantity)
-- 					-- 	if quantity > 1 then
-- 							TriggerEvent("mythic_progbar:client:progress", {
-- 								name = "chehero",
-- 								duration = 7000,
-- 								label = "đang chế san hô",
-- 								useWhileDead = false,
-- 								canCancel = true,
-- 								controlDisables = {
-- 									disableMovement = true,
-- 									disableCarMovement = true,
-- 									disableMouse = false,
-- 									disableCombat = true,
-- 								},
-- 								animation = {
-- 									animDict = "missheistdockssetup1clipboard@idle_a",
-- 								anim = "idle_a",
-- 								}
-- 							}, function(status)
-- 								if not status then
-- 									TriggerServerEvent('esx_illegal:sanhoo')
-- 									ClearPedTasks(PlayerPedId())
-- 								end
-- 							end)
-- 					-- 	else
-- 					-- 		ESX.ShowNotification("~r~bạn cần sanho ")
-- 					-- 	end
-- 					-- end, "poppyresin")
-- 				end
-- 			end
-- 		Citizen.Wait(time)
-- 	end
-- end)


Citizen.CreateThread(function()
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local nearbyObject, nearbyID
		for i=1, #PoppyPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(PoppyPlants[i]), false) < 2 then  
				time = 1
				nearbyObject, nearbyID = PoppyPlants[i], i
			end
		end
		if nearbyObject and IsPedOnFoot(PlayerPedId()) then
			ESX.ShowHelpNotification("Nhấn [E] để hái san hô")

			if IsControlJustReleased(0, Keys['E']) then
				
				
                    if ESX.GetPlayerData().job.name == 'ambulance' or
				       ESX.GetPlayerData().job.name == 'police' or
				       ESX.GetPlayerData().job.name == 'mechanic' then
				       ESX.ShowNotification("Nghề của bạn không thể làm việc này")		    

					else
						TriggerEvent("mythic_progbar:client:progress", {
							name = "haisanho",
							duration = 10000,
							label = "đang thu hoạch san hô",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "amb@world_human_gardener_plant@male@idle_a",
							anim = "idle_a",
							}
						}, function(status)
							if not status then
								ESX.Game.DeleteObject(nearbyObject)
								table.remove(PoppyPlants, nearbyID)
								spawnedPoppys = spawnedPoppys - 1
								 TriggerServerEvent('esx_illegal:Pickupsanhoo')
								ClearPedTasksImmediately(PlayerPedId())
							end
						end)
					end
				end
		end
		Citizen.Wait(time)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(PoppyPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnSanhoPlants()
	while spawnedPoppys < 15 do
		Citizen.Wait(0)
		local sanhoCoords = GenerateSanhoCoords()

		ESX.Game.SpawnLocalObject('proc_searock_01', sanhoCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(PoppyPlants, obj)
			spawnedPoppys = spawnedPoppys + 1
		end)
	end
end

function ValidateSanhoCoord(plantCoord)
	if spawnedPoppys > 0 then
		local validate = true

		for k, v in pairs(PoppyPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.SanhoField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateSanhoCoords()
	while true do
		Citizen.Wait(1)

		local sanhoCoordX, sanhoCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		sanhoCoordX = Config.CircleZones.SanhoField.coords.x + modX
		sanhoCoordY = Config.CircleZones.SanhoField.coords.y + modY

		local coordZ = GetCoordZSanho(sanhoCoordX, sanhoCoordY)
		local coord = vector3(sanhoCoordX, sanhoCoordY, coordZ)
		if ValidateSanhoCoord(coord) then
			return coord
		end
	end
end

function GetCoordZSanho(x, y)
	local groundCheckHeights = { -8.0, -7.0, -6.0, -5.0, -4.0, -3.0, -2.0, -1.0, 0.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return -10.5
end
