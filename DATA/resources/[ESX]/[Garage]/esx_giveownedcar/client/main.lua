--ESX = nil

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

TriggerEvent('chat:addSuggestion', '/givecar', 'Give a vehicle to player', {
	{ name="id", help="The ID of the player" },
    { name="vehicle", help="Vehicle model" },
    { name="<plate>", help="Vehicle plate, skip if you want random generate plate number" }
})

TriggerEvent('chat:addSuggestion', '/delcarplate', 'Delete a owned vehicle by plate number', {
	{ name="plate", help="Vehicle's plate number" }
})

RegisterNetEvent('esx_giveownedcar:spawnVehicle')
AddEventHandler('esx_giveownedcar:spawnVehicle', function(playerID, model, playerName, type)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local carExist  = false

	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			carExist = true
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = exports.d3x_vehicleshop:GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerEvent('sulu_keycar:acceptData', string.gsub(newPlate, "%s+", "") )
			TriggerServerEvent('esx_giveownedcar:setVehicle', vehicleProps, playerID)
			ESX.Game.DeleteVehicle(vehicle)	
			if type ~= 'console' then
				ESX.ShowNotification(_U('gived_car', model, newPlate, playerName))
			else
				local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
				TriggerServerEvent('esx_giveownedcar:printToConsole', msg)
			end				
		end		
	end)
	
	Wait(2000)
	if not carExist then
		if type ~= 'console' then
			ESX.ShowNotification(_U('unknown_car', model))
		else
			TriggerServerEvent('esx_giveownedcar:printToConsole', "ERROR: "..model.." is an unknown vehicle model")
		end		
	end
end)

RegisterNetEvent('esx_giveownedcar:giveVehicleItem')
AddEventHandler('esx_giveownedcar:giveVehicleItem', function(model)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = exports.d3x_vehicleshop:GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerEvent('sulu_keycar:acceptData', string.gsub(newPlate, "%s+", "") )
			TriggerServerEvent('esx_giveownedcar:setVehicle', vehicleProps, GetPlayerServerId(PlayerId()))
            ESX.ShowNotification(_U('gived_car', model, newPlate, ''))
			ESX.Game.DeleteVehicle(vehicle)				
		end		
	end)
end)

RegisterNetEvent('esx_giveownedcar:spawnVehiclePlate')
AddEventHandler('esx_giveownedcar:spawnVehiclePlate', function(playerID, model, plate, playerName, type)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local generatedPlate = string.upper(plate)
	local carExist  = false

	ESX.TriggerServerCallback('d3x_vehicleshop:isPlateTaken', function (isPlateTaken)
		if not isPlateTaken then
			ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info	
				if DoesEntityExist(vehicle) then
					carExist = true
					SetEntityVisible(vehicle, false, false)
					SetEntityCollision(vehicle, false)	
					
					local newPlate     = string.upper(plate)
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					TriggerEvent('sulu_keycar:acceptData', string.gsub(newPlate, "%s+", ""))
					TriggerServerEvent('esx_giveownedcar:setVehicle', vehicleProps, playerID)
					ESX.Game.DeleteVehicle(vehicle)
					if type ~= 'console' then
						ESX.ShowNotification(_U('gived_car',  model, newPlate, playerName))
                        local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
						TriggerServerEvent('esx_giveownedcar:printToConsole', msg)
					else
						local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
						TriggerServerEvent('esx_giveownedcar:printToConsole', msg)
					end				
				end
			end)
		else
			carExist = true
			if type ~= 'console' then
				ESX.ShowNotification(_U('plate_already_have'))
			else
				local msg = ('ERROR: this plate is already been used on another vehicle')
				TriggerServerEvent('esx_giveownedcar:printToConsole', msg)
			end					
		end
	end, generatedPlate)
	
	Wait(2000)
	if not carExist then
		if type ~= 'console' then
			ESX.ShowNotification(_U('unknown_car', model))
		else
			TriggerServerEvent('esx_giveownedcar:printToConsole', "ERROR: "..model.." is an unknown vehicle model")
		end		
	end	
end)



RegisterNetEvent('DiscordBOT:givecar')
AddEventHandler('DiscordBOT:givecar', function(model, plate , giveId, ten) 
	
	local newPlate

	if plate ~= nil and plate ~= "" then 
		newPlate = string.upper(plate)
	else 
		newPlate = exports.d3x_vehicleshop:GeneratePlate()
	end
	
	ESX.TriggerServerCallback('d3x_vehicleshop:isPlateTaken', function (isPlateTaken)
		if not isPlateTaken then
			if IsModelInCdimage(model) then
				local playerPed = PlayerPedId()
				local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)
				ESX.Game.SpawnVehicle(model, playerCoords, playerHeading , function (vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(vehicle, newPlate)
					--TriggerEvent('sulu_keycar:acceptData', string.gsub(newPlate, "%s+", ""))
					ESX.ShowNotification("Bạn đã nhận xe từ ~b~Admin~w~")
					--TriggerServerEvent("DisordBOT:giveCarResponse" , giveId , newPlate)
                    local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..ten)
					TriggerServerEvent('esx_giveownedcar:printToConsoleGuild', msg)
					TriggerServerEvent('d3x_vehicleshop:setVehicleOwned', vehicleProps)
				end)
			else 
                local msg = ('loi add lai xe di cu')
				TriggerServerEvent('esx_giveownedcar:printToConsoleGuild', msg)
			end
		else
            local msg = ('loi add lai xe di cu')
            TriggerServerEvent('esx_giveownedcar:printToConsoleGuild', msg)		
		end
	end, newPlate)


end)
