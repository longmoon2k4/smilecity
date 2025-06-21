-- ESX = nil
local spawnedHydrochloricAcidBarrels = 0
local HydrochloricAcidBarrels = {}
local chethaoduoc = vec3(5183.0424804688, -5149.646484375, 3.5469818115234)
-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HydrochloricAcidFarm.coords, true) < 50 then
			SpawnHydrochloricAcidBarrels()
			Citizen.Wait(500)
		else
			Citizen.Wait(1000)
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
			if #(coords - chethaoduoc) < 15.0  then
				time = 1
				DrawMarker(20, chethaoduoc , 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
			end
			if #(coords - chethaoduoc) < 2 then
				ESX.ShowHelpNotification('Nhấn [E] để chế ~r~Thảo dược~s~.')
				if IsControlJustReleased(1, 51) then
					if lib.progressBar({
						duration = 10000,
						label = "đang chế thảo dược",
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
						TriggerServerEvent('esx_illegal:processMeth')
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
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #HydrochloricAcidBarrels, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(HydrochloricAcidBarrels[i]), false) < 1 then
				time = 1
				nearbyObject, nearbyID = HydrochloricAcidBarrels[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
				ESX.ShowHelpNotification(_U('HydrochloricAcid_pickupprompt'))

			if IsControlJustReleased(0, 38)   then
                    if ESX.GetPlayerData().job.name == 'ambulance' or
				       ESX.GetPlayerData().job.name == 'police' or
				       ESX.GetPlayerData().job.name == 'mechanic' then
				       ESX.ShowNotification("Nghề của bạn không thể làm việc này")		    

					else
						if lib.progressBar({
							duration = 8000,
							label = 'đang thu hoạch thảo dược',
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
								table.remove(HydrochloricAcidBarrels, nearbyID)
								spawnedHydrochloricAcidBarrels = spawnedHydrochloricAcidBarrels - 1
								TriggerServerEvent('esx_illegal:pickedUpHydrochloricAcid')
								ClearPedTasksImmediately(playerPed)
						end
					end
			end
		end
		Citizen.Wait(time)
	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(HydrochloricAcidBarrels) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnHydrochloricAcidBarrels()
	while spawnedHydrochloricAcidBarrels < 30 do
		Citizen.Wait(0)
		local weedCoords = GenerateHydrochloricAcidCoords()

		ESX.Game.SpawnLocalObject('prop_plant_fern_01b', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(HydrochloricAcidBarrels, obj)
			spawnedHydrochloricAcidBarrels = spawnedHydrochloricAcidBarrels + 1
		end)
	end
end

function ValidateHydrochloricAcidCoord(plantCoord)
	if spawnedHydrochloricAcidBarrels > 0 then
		local validate = true

		for k, v in pairs(HydrochloricAcidBarrels) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.HydrochloricAcidFarm.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateHydrochloricAcidCoords()
	while true do
		Citizen.Wait(1)

		local weed2CoordX, weed2CoordY

		math.randomseed(GetGameTimer())
		local modX2 = math.random(-50, 50)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY2 = math.random(-50, 50)

		weed2CoordX = Config.CircleZones.HydrochloricAcidFarm.coords.x + modX2
		weed2CoordY = Config.CircleZones.HydrochloricAcidFarm.coords.y + modY2

		local coordZ2 = GetCoordZHydrochloricAcid(weed2CoordX, weed2CoordY)
		local coord2 = vector3(weed2CoordX, weed2CoordY, coordZ2)

		if ValidateHydrochloricAcidCoord(coord2) then
			return coord2
		end
	end
end

function GetCoordZHydrochloricAcid(x, y)
	local groundCheckHeights = { 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0, 30.0 }

	for i, height in ipairs(groundCheckHeights) do
		local found2Ground, z = GetGroundZFor_3dCoord(x, y, height)

		if found2Ground then
			return z
		end
	end

	return 24.5
end
