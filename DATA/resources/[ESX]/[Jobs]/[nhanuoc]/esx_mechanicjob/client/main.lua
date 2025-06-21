local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentAction2, CurrentActionMsg2, CurrentActionData2 = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false
local x = 0
--ESX = nil

Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end
function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	ESX.ShowNotification(_U('drive_to_indicated'))
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob = false
	NPCTargetTowable  = nil
	NPCTargetTowableZone = nil
	NPCHasSpawnedTowable = false
	NPCHasBeenNextToTowable = false

	if cancel then
		ESX.ShowNotification(_U('mission_canceled'))
	else
		--TriggerServerEvent('esx_mechanicjob:onNPCJobCompleted')
	end
end

function OpenMechanicActionsMenu()
	local elements = {
		-- {label = _U('vehicle_list'),   value = 'vehicle_list'},
		--{label = _U('work_wear'),      value = 'cloakroom'},
		--{label = _U('civ_wear'),       value = 'cloakroom2'},
		{label ='Kho đồ',  value = 'khodo'}
		
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
					for i=1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'bottom-right',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
							
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)

						TriggerServerEvent('esx_society:removeVehicleFromGarage', 'mechanic', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'mechanic')

			else

				local elements = {
					{label = "Xe cứu hộ",  value = 'X5E53'},
					--{label = _U('flat_bed'),  value = 'Mesa'},
					--{label = _U('bmciv2'), value = 'bmciv2'},
					--{label = "Trực thăng", value = 'super'},
					--{label = _U('xe_bus'),  value = 'Bus'},
					--{label = _U('tow_truck'), value = 'towtruck2'}
				}
				if ESX.PlayerData.job.grade >=3 then
					table.insert(elements,{label = "Trực thăng", value = 'super'})
				end
				-- if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'chief' or ESX.PlayerData.job.grade_name == 'experimente') then
				-- 	table.insert(elements, {label = 'SlamVan', value = 'slamvan3'})
				-- end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'bottom-right',
					elements = elements
				}, function(data, menu)
					if x == 1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
							local playerPed = PlayerPedId()
							
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
									local playerPed = PlayerPedId()
									
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'mechanic')
					end
					if x == 2 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint2.Pos, 90.0, function(vehicle)
							local playerPed = PlayerPedId()
							
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint2.Pos, 90.0, function(vehicle)
									local playerPed = PlayerPedId()
									
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'mechanic')
					end
					menu.close()
				end, function(data, menu)
					menu.close()
					OpenMechanicActionsMenu()
				end)

			end
		elseif data.current.value == 'cloakroom' then
			menu.close()
			setUniform(PlayerPedId())
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'khodo' then
			TriggerEvent('esx_inventoryhud:Openinventoryhudnganh')
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end)
		end
		menu.close()
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
		CurrentAction2     = 'mechanic_actions_menu'
		CurrentActionMsg2  = _U('open_actions')
		CurrentActionData2 = {}
	end)
end

function setUniform(playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms.male then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms.female then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function OpenMechanicHarvestMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'mechanic' then
		local elements = {
			{label = _U('gas_can'), value = 'gaz_bottle'},
			{label = _U('repair_tools'), value = 'fix_tool'},
			{label = _U('body_work_tools'), value = 'caro_tool'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_harvest', {
			title    = _U('harvest'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'gaz_bottle' then
				TriggerServerEvent('esx_mechanicjob:startHarvest')
			elseif data.current.value == 'fix_tool' then
				TriggerServerEvent('esx_mechanicjob:startHarvest2')
			elseif data.current.value == 'caro_tool' then
				TriggerServerEvent('esx_mechanicjob:startHarvest3')
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'mechanic_harvest_menu'
			CurrentActionMsg  = _U('harvest_menu')
			CurrentActionData = {}
			CurrentAction2     = 'mechanic_harvest_menu'
			CurrentActionMsg2  = _U('harvest_menu')
			CurrentActionData2 = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMechanicCraftMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('blowtorch'),  value = 'blow_pipe'},
			{label = _U('repair_kit'), value = 'fix_kit'},
			{label = _U('body_kit'),   value = 'caro_kit'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_craft', {
			title    = _U('craft'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('esx_mechanicjob:startCraft')
			elseif data.current.value == 'fix_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft2')
			elseif data.current.value == 'caro_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft3')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'mechanic_craft_menu'
			CurrentActionMsg  = _U('craft_menu')
			CurrentActionData = {}
			CurrentAction2     = 'mechanic_craft_menu'
			CurrentActionMsg2  = _U('craft_menu')
			CurrentActionData2 = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMobileMechanicActionsMenu()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = 'Danh sách người cần cứu hộ',      value = 'player_list'},
			{label = _U('repair'),        value = 'fix_vehicle'},
			-- {label = _U('billing'),       value = 'billing'},
			{label = _U('hijack'),        value = 'hijack_vehicle'},
			{label = "Xóa xe",       value = 'del_vehicle'},
			{label = _U('clean'),         value = 'clean_vehicle'},
		--	{label = "Giam xe",       value = 'giamxe'},
		--	{label ='Lấy thuyền', value = 'spam_vehicles'},
			--{label = _U('flat_bed'),      value = 'dep_vehicle'},
			--{label = _U('place_objects'), value = 'object_spawner'}
	}
	if ESX.PlayerData.job.grade >=3 and ESX.PlayerData.job.name == "mechanic" then
		table.insert(elements, {label = "Giam xe", value = 'giamxe'})
		table.insert(elements, {label = "Danh sách xe bị giam", value = 'danhsachgiamxe'})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'bottom-right',
		elements = elements
			
	}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'player_list' then
			menu.close()
			TriggerEvent("request_menu:open")
		end

		if data.current.value == 'giamxe' then
			TriggerEvent("sulu_impound:client:openImpoundMenu")
			--local vehicle = ESX.Game.GetVehicleInDirection()
			
			-- if DoesEntityExist(vehicle) then
			-- 	--ESX.ShowNotification("Đã xóa phương tiện")
			-- 	ESX.Game.DeleteVehicle(vehicle)
			-- --else
			-- 	--ESX.ShowNotification("Không có xe ở gần")
			-- end
			-- ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
			-- 	title = _U('invoice_amount')
			-- }, function(data, menu)
			-- 	local amount = tonumber(data.value)

			-- 	if amount == nil or amount < 0 then
			-- 		ESX.ShowNotification(_U('amount_invalid'))
			-- 	else
			-- 		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			-- 		if closestPlayer == -1 or closestDistance > 3.0 then
			-- 			ESX.ShowNotification(_U('no_players_nearby'))
			-- 		else
			-- 			menu.close()
			-- 			TriggerServerEvent('esx_bislling:sesndBill', GetPlayerServerId(closestPlayer), GetPlayerServerId(closestPlayer), _U('mechanic'), amount)
			-- 		end
			-- 	end
			-- end, function(data, menu)
			-- 	menu.close()
			-- end)
		elseif data.current.value == 'billing' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)
				local amount = tonumber(data.value)
		
				if amount == nil or amount < 0 then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_nearby'))
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), GetPlayerServerId(closestPlayer), _U('mechanic'), amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		
		elseif data.current.value == 'spam_vehicles' then
			if IsEntityInWater(PlayerPedId()) then
				local playerCoords = GetEntityCoords(PlayerPedId())
				local playerHeading = GetEntityHeading(PlayerPedId())
				
				ESX.Game.SpawnVehicle("dinghy4", playerCoords, playerHeading, function(cbVeh)
					ESX.Game.SetVehicleProperties(cbVeh,upgrades)
					SetVehRadioStation(cbVeh, "OFF")
					TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
					--SetVehicleEngineHealth(callback_vehicle, vehicle.engineHealth + 0.0)
					SetVehicleEngineHealth(cbVeh, 1000.0)
					SetVehicleBodyHealth(cbVeh, 1000.0)
				end)
				TriggerEvent('sulu_keycar:acceptData',string.gsub('911CAR', "%s+", ""))
			else
				ESX.ShowNotification("Bạn phải ở dưới nước!")
			end
		elseif data.current.value == 'danhsachgiamxe' then
			ESX.TriggerServerCallback('sulu_garage:callback:getListImpoundedVehicle', function(data)
				local elements = {}
		
				for i=1, #data, 1 do
						table.insert(elements, {
							label    = data[i].plate,
							value    = data[i].plate,
						})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'listgiamxe',
				{
					title    = '',
					align    = 'bottom-right',
					elements = elements,
				},
				function(data, menu)
					if data.current.value ~= nil then
						TriggerServerEvent('sulu_garage:server:removeImpound', data.current.value)
						menu.close()
					end
					
				end, function(data, menu)
					menu.close()
				end)
		
			end)
		elseif data.current.value == 'hijack_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()
			local coords = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				--ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					--ESX.ShowNotification(_U('vehicle_unlocked'))
					isBusy = false
				end)
			-- else
			-- 	ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'fix_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			--if IsPedSittingInAnyVehicle(playerPed) then
				--ESX.ShowNotification(_U('inside_vehicle'))
				--return
			

				if DoesEntityExist(vehicle) then
					if lib.progressBar({
						duration =  6000,
						label = "đang sửa xe",
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
						SetVehicleFixed(vehicle)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleUndriveable(vehicle, false)
						SetVehicleEngineOn(vehicle, true, true)
						--ClearPedTasksImmediately(playerPed)
						ClearPedTasks(playerPed)
						ESX.ShowNotification(_U('vehicle_repaired'))
					end
				end
			--else
				--ESX.ShowNotification("Bạn phải ngồi trên xe")
			--end
		elseif data.current.value == 'clean_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_cleaned'))
					isBusy = false
				end)
			-- else
			-- 	ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'del_vehicle' then

			-- local playerPed = PlayerPedId()

			-- if IsPedSittingInAnyVehicle(playerPed) then
			-- 	local vehicle = GetVehiclePedIsIn(playerPed, false)

			-- 	if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			-- 		--ESX.ShowNotification("Xe đã được xóa")
			-- 		ESX.Game.DeleteVehicle(vehicle)
			-- 	-- else
			-- 	-- 	ESX.ShowNotification("Bạn phải đứng gần để xóa nó")
			-- 	end
			-- else
			-- 	local vehicle = ESX.Game.GetVehicleInDirection()

			-- 	if DoesEntityExist(vehicle) then
			-- 		--ESX.ShowNotification("Xe đã được xóa")
			-- 		ESX.Game.DeleteVehicle(vehicle)
			-- 	-- else
			-- 	-- 	ESX.ShowNotification("Bạn phải đứng gần để xóa nó")
			-- 	end
			-- end
			local coords = GetEntityCoords(PlayerPedId())
			TriggerServerEvent('esx_mechanic:xoaxe', coords, 4)
		elseif data.current.value == 'dep_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			local towmodel = GetHashKey('flatbed')
			local isVehicleTow = IsVehicleModel(vehicle, towmodel)

			if isVehicleTow then
				local targetVehicle = ESX.Game.GetVehicleInDirection()

				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 then
						if not IsPedInAnyVehicle(playerPed, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
								CurrentlyTowedVehicle = targetVehicle
								ESX.ShowNotification(_U('vehicle_success_attached'))

								if NPCOnJob then
									if NPCTargetTowable == targetVehicle then
										ESX.ShowNotification(_U('please_drop_off'))
										Config.Zones.VehicleDelivery.Type = 1

										if Blips['NPCTargetTowableZone'] then
											RemoveBlip(Blips['NPCTargetTowableZone'])
											Blips['NPCTargetTowableZone'] = nil
										end

										Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
										SetBlipRoute(Blips['NPCDelivery'], true)
									end
								end
							else
								ESX.ShowNotification(_U('cant_attach_own_tt'))
							end
						end
					else
						ESX.ShowNotification(_U('no_veh_att'))
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle, true, true)

					if NPCOnJob then
						if NPCTargetDeleterZone then

							if CurrentlyTowedVehicle == NPCTargetTowable then
								ESX.Game.DeleteVehicle(NPCTargetTowable)
								TriggerServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
								StopNPCJob()
								NPCTargetDeleterZone = false
							else
								ESX.ShowNotification(_U('not_right_veh'))
							end

						else
							ESX.ShowNotification(_U('not_right_place'))
						end
					end

					CurrentlyTowedVehicle = nil
					ESX.ShowNotification(_U('veh_det_succ'))
				end
			else
				ESX.ShowNotification(_U('imp_flatbed'))
			end
		elseif data.current.value == 'object_spawner' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions_spawn', {
				title    = _U('objects'),
				align    = 'bottom-right',
				elements = {
					{label = _U('roadcone'), value = 'prop_roadcone02a'},
					{label = _U('toolbox'),  value = 'prop_toolchest_01'}
			}}, function(data2, menu2)
				local model   = data2.current.value
				local coords  = GetEntityCoords(playerPed)
				local forward = GetEntityForwardVector(playerPed)
				local x, y, z = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				elseif model == 'prop_toolchest_01' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {x = x, y = y, z = z}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_mechanicjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('mechanic_stock'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mechanicjob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_mechanicjob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mechanicjob:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onCarokit')
AddEventHandler('esx_mechanicjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'MechanicActions' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone=='MechanicActions2' then
		CurrentAction2     = 'mechanic_actions_menu'
		CurrentActionMsg2  = _U('open_actions')
		CurrentActionData2 = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'mechanic_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter2' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction2     = 'delete_vehicle'
			CurrentActionMsg2  = _U('veh_stored')
			CurrentActionData2 = {vehicle = vehicle}
		end
	elseif zone == 'VehicleDeleter'   then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('esx_mechanicjob:stopCraft')
		TriggerServerEvent('esx_mechanicjob:stopCraft2')
		TriggerServerEvent('esx_mechanicjob:stopCraft3')
	elseif zone == 'Garage' then
		TriggerServerEvent('esx_mechanicjob:stopHarvest')
		TriggerServerEvent('esx_mechanicjob:stopHarvest2')
		TriggerServerEvent('esx_mechanicjob:stopHarvest3')
	end

	CurrentAction = nil
	CurrentAction2 = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_mechanicjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
		CurrentAction2     = 'remove_entity'
		CurrentActionMsg2  = _U('press_remove_obj')
		CurrentActionData2 = {entity = entity}
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	elseif  CurrentAction2 == 'remove_entity' then
		CurrentAction2 = nil
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('mechanic'),
		number     = 'mechanic',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Pop NPC mission vehicle when inside area
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)

-- 		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
-- 			local coords = GetEntityCoords(PlayerPedId())
-- 			local zone   = Config.Zones[NPCTargetTowableZone]

-- 			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
-- 				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

-- 				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
-- 					NPCTargetTowable = vehicle
-- 				end)

-- 				NPCHasSpawnedTowable = true
-- 			end
-- 		end

-- 		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
-- 			local coords = GetEntityCoords(PlayerPedId())
-- 			local zone   = Config.Zones[NPCTargetTowableZone]

-- 			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
-- 				ESX.ShowNotification(_U('please_tow'))
-- 				NPCHasBeenNextToTowable = true
-- 			end
-- 		end
-- 	end
-- end)

-- Create Blips
-- Citizen.CreateThread(function()
-- 	local blip = AddBlipForCoord(Config.Zones.MechanicActions.Pos.x, Config.Zones.MechanicActions.Pos.y, Config.Zones.MechanicActions.Pos.z)

-- 	SetBlipSprite (blip, 446)
-- 	SetBlipDisplay(blip, 4)
-- 	SetBlipScale  (blip, 1.0)
-- 	SetBlipColour (blip, 5)
-- 	SetBlipAsShortRange(blip, true)

-- 	BeginTextCommandSetBlipName('STRING')
-- 	AddTextComponentSubstringPlayerName(_U('mechanic'))
-- 	EndTextCommandSetBlipName(blip)
-- end)

-- Display markers
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)

-- 		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
-- 			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

-- 			for k,v in pairs(Config.Zones) do
-- 				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
-- 					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
-- 					letSleep = false
-- 				end
-- 			end

-- 			if letSleep then
-- 				Citizen.Wait(1000)
-- 			end
-- 		else
-- 			Citizen.Wait(3000)
-- 		end
-- 	end
-- end)

-- -- Enter / Exit marker events
-- Citizen.CreateThread(function()
-- 	while true do
		
-- 		local time = 1000
-- 		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

-- 			local coords = GetEntityCoords(PlayerPedId())
-- 			local isInMarker = false
-- 			local currentZone = nil

-- 			for k,v in pairs(Config.Zones) do
-- 				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
-- 					isInMarker  = true
-- 					currentZone = k
-- 					time = 1
-- 				end
-- 			end

-- 			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
-- 				HasAlreadyEnteredMarker = true
-- 				LastZone                = currentZone
-- 				TriggerEvent('esx_mechanicjob:hasEnteredMarker', currentZone)
-- 			end

-- 			if not isInMarker and HasAlreadyEnteredMarker then
-- 				HasAlreadyEnteredMarker = false
-- 				TriggerEvent('esx_mechanicjob:hasExitedMarker', LastZone)
-- 			end

-- 		end
-- 		Citizen.Wait(time)
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	local trackedEntities = {
-- 		'prop_roadcone02a',
-- 		'prop_toolchest_01'
-- 	}

-- 	while true do
-- 		Citizen.Wait(500)

-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)

-- 		local closestDistance = -1
-- 		local closestEntity = nil

-- 		for i=1, #trackedEntities, 1 do
-- 			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

-- 			if DoesEntityExist(object) then
-- 				local objCoords = GetEntityCoords(object)
-- 				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

-- 				if closestDistance == -1 or closestDistance > distance then
-- 					closestDistance = distance
-- 					closestEntity   = object
-- 				end
-- 			end
-- 		end

-- 		if closestDistance ~= -1 and closestDistance <= 3.0 then
-- 			if LastEntity ~= closestEntity then
-- 				TriggerEvent('esx_mechanicjob:hasEnteredEntityZone', closestEntity)
-- 				LastEntity = closestEntity
-- 			end
-- 		else
-- 			if LastEntity then
-- 				TriggerEvent('esx_mechanicjob:hasExitedEntityZone', LastEntity)
-- 				LastEntity = nil
-- 			end
-- 		end
-- 	end
-- end)

-- Key Controls
-- Citizen.CreateThread(function()
-- 	while true do

-- 		local time = 1000
-- 		if CurrentAction then
-- 			time = 1
-- 			ESX.ShowHelpNotification(CurrentActionMsg)
-- 			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

-- 				if CurrentAction == 'mechanic_actions_menu' then
-- 					x = 1
-- 					OpenMechanicActionsMenu()
-- 				elseif CurrentAction == 'mechanic_harvest_menu' then
-- 					OpenMechanicHarvestMenu()
-- 				elseif CurrentAction == 'mechanic_craft_menu' then
-- 					OpenMechanicCraftMenu()
-- 				elseif CurrentAction == 'delete_vehicle' then

-- 					-- if Config.EnableSocietyOwnedVehicles then

-- 					-- 	local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
-- 					-- 	TriggerServerEvent('esx_society:putVehicleInGarage', 'mechanic', vehicleProps)

-- 					-- else

-- 					-- 	if
-- 					-- 		GetEntityModel(vehicle) == GetHashKey('flatbed')   or
-- 					-- 		GetEntityModel(vehicle) == GetHashKey('towtruck2') or
-- 					-- 		GetEntityModel(vehicle) == GetHashKey('slamvan3')
-- 					-- 	then
-- 					-- 		TriggerServerEvent('esx_service:disableService', 'mechanic')
-- 					-- 	end

-- 					-- end

-- 					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

-- 				elseif CurrentAction == 'remove_entity' then
-- 					DeleteEntity(CurrentActionData.entity)
-- 				end

-- 				CurrentAction = nil
-- 			end
-- 		elseif CurrentAction2 then
-- 			time = 1
-- 			ESX.ShowHelpNotification(CurrentActionMsg2)

-- 			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

-- 				if CurrentAction2 == 'mechanic_actions_menu' then
-- 					x = 2
-- 					OpenMechanicActionsMenu()
-- 				elseif CurrentAction2 == 'mechanic_harvest_menu' then
-- 					OpenMechanicHarvestMenu()
-- 				elseif CurrentAction2 == 'mechanic_craft_menu' then
-- 					OpenMechanicCraftMenu()
-- 				elseif CurrentAction2 == 'delete_vehicle' then
-- 					--print("xoa xe")
-- 					if Config.EnableSocietyOwnedVehicles then

-- 						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData2.vehicle)
-- 						TriggerServerEvent('esx_society:putVehicleInGarage', 'mechanic', vehicleProps)

-- 					else

-- 						if
-- 							GetEntityModel(vehicle) == GetHashKey('flatbed')   or
-- 							GetEntityModel(vehicle) == GetHashKey('towtruck2') or
-- 							GetEntityModel(vehicle) == GetHashKey('slamvan3')
-- 						then
-- 							TriggerServerEvent('esx_service:disableService', 'mechanic')
-- 						end

-- 					end

-- 					ESX.Game.DeleteVehicle(CurrentActionData2.vehicle)

-- 				elseif CurrentAction2 == 'remove_entity' then
-- 					DeleteEntity(CurrentActionData2.entity)
-- 				end

-- 				CurrentAction2 = nil
-- 			end
-- 		end

-- 		-- if IsControlJustReleased(0, 167) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
-- 		-- 	OpenMobileMechanicActionsMenu()
-- 		-- end

-- 		-- if IsControlJustReleased(0, 178) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
-- 		-- 	if NPCOnJob then
-- 		-- 		if GetGameTimer() - NPCLastCancel > 5 * 60000 then
-- 		-- 			StopNPCJob(true)
-- 		-- 			NPCLastCancel = GetGameTimer()
-- 		-- 		else
-- 		-- 			ESX.ShowNotification(_U('wait_five'))
-- 		-- 		end
-- 		-- 	else
-- 		-- 		local playerPed = PlayerPedId()

-- 		-- 		if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey('flatbed')) then
-- 		-- 			StartNPCJob()
-- 		-- 		else
-- 		-- 			ESX.ShowNotification(_U('must_in_flatbed'))
-- 		-- 		end
-- 		-- 	end
-- 		-- end
-- 		Citizen.Wait(time)
-- 	end
-- end)

RegisterKeyMapping('menucuuho', 'Menucuu ho', 'keyboard', "f6")
RegisterCommand('menucuuho', function()
	if  ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
		OpenMobileMechanicActionsMenu()
	end
end, true)

AddEventHandler('esx:onPlayerDeath', function(data) isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)


-- function billingcuuho()
-- 	ESX.UI.Menu.CloseAll()

-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
-- 		title    = _U('mechanic'),
-- 		align    = 'top-right',
-- 		elements = {
-- 			{label = 'Bill 3k',                value = 'bill1'},
-- 			{label = 'Bill 5k',                value = 'bill2'},
-- 	}}, function(data, menu)
-- 		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
-- 			if closestPlayer == -1 or closestDistance > 3.0 then
-- 				ESX.ShowNotification(_U('no_players_nearby'))
-- 			else
-- 				if data.current.value == 'bill1' then
-- 					menu.close()
-- 				    TriggerServerEvent("esx_bislling:sesndBill", GetPlayerServerId(closestPlayer), GetPlayerServerId(closestPlayer), "Cứu hộ", 3000)
-- 				    ESX.ShowNotification('bạn đã giử bill cho '..exports['esx_scoreboard']:GetPlayerRegisterName(closestPlayer))
-- 				elseif data.current.value == 'bill2' then
-- 					menu.close()
-- 				    TriggerServerEvent("esx_bislling:sesndBill", GetPlayerServerId(closestPlayer), GetPlayerServerId(closestPlayer), "Cứu hộ", 5000)
-- 				    ESX.ShowNotification('bạn đã giử bill cho '..exports['esx_scoreboard']:GetPlayerRegisterName(closestPlayer))
-- 				end
-- 			end
-- 	end, function(data, menu)
-- 		menu.close()
-- 	end)
-- end

----------------------------------------------------------------------------------------------------------------
----------  Menu Tương Tác  -----------
---------   Dev By HTP Team   --------

RegisterNetEvent('esx_mechanicjob:suaxe')
AddEventHandler('esx_mechanicjob:suaxe', function()

	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TriggerEvent('mythic_progbar:client:progress', {
			name = 'Sửa Xe',
			duration = 20000,
			label = 'Đang sửa xe',
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = false,
			},
			animation = {
				animDict = nil,
				anim = nil,
				flags = 0,
				task = "PROP_HUMAN_BUM_BIN",
			},
			prop = {
				model = nil,
			},
		}, function(status)
			if not status then
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, true, true)
				ClearPedTasksImmediately(playerPed)
				--exports['mythic_notify']:DoHudText('inform', 'Đã sửa xe xong')
				isBusy = false
			end
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end

end)

RegisterNetEvent('esx_mechanicjob:hoadon')
AddEventHandler('esx_mechanicjob:hoadon', function()

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
		title = _U('invoice_amount')
	}, function(data, menu)
		local amount = tonumber(data.value)

		if amount == nil or amount < 0 then
			ESX.ShowNotification(_U('amount_invalid'))
		else
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players_nearby'))
			else
				menu.close()
				TriggerServerEvent('esx_bislling:sesndBill', GetPlayerServerId(closestPlayer), GetPlayerServerId(closestPlayer), _U('mechanic'), amount)
			end
		end
	end, function(data, menu)
		menu.close()
	end)

end)

RegisterNetEvent('esx_mechanicjob:phakhoa')
AddEventHandler('esx_mechanicjob:phakhoa', function()

	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TriggerEvent('mythic_progbar:client:progress', {
			name = 'Sửa Xe',
			duration = 20000,
			label = 'Đang phá khóa',
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = false,
			},
			animation = {
				animDict = nil,
				anim = nil,
				flags = 0,
				task = "WORLD_HUMAN_WELDING",
			},
			prop = {
				model = nil,
			},
		}, function(status)
			if not status then
				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				exports['mythic_notify']:DoHudText('inform', 'Đã phá khóa xong')
				isBusy = false
			end
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end

end)

RegisterNetEvent('esx_mechanicjob:lauxe')
AddEventHandler('esx_mechanicjob:lauxe', function()

	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TriggerEvent('mythic_progbar:client:progress', {
			name = 'Lau Xe',
			duration = 10000,
			label = 'Đang lau xe',
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = false,
			},
			animation = {
				animDict = nil,
				anim = nil,
				flags = 0,
				task = "WORLD_HUMAN_MAID_CLEAN",
			},
			prop = {
				model = nil,
			},
		}, function(status)
			if not status then
				SetVehicleDirtLevel(vehicle, 0)
				ClearPedTasksImmediately(playerPed)
				exports['mythic_notify']:DoHudText('inform', 'Đã lau xe xong')
				isBusy = false
			end
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end

end)

RegisterNetEvent('esx_mechanicjob:xoaxe')
AddEventHandler('esx_mechanicjob:xoaxe', function()

	local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_seat_driver'))
				end
			else
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_near'))
				end
			end

end)

RegisterNetEvent('esx_mechanicjob:danhsach')
AddEventHandler('esx_mechanicjob:danhsach', function()

	TriggerEvent("request_menu:open")

end)

RegisterCommand('suaxe', function(source)
	ESX.TriggerServerCallback('bacsionline', function(cuuho, enough)
		if cuuho == 0 and enough then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)
					if DoesEntityExist(vehicle) then
						--TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
						Citizen.CreateThread(function()
							if lib.progressBar({
								duration = 6000,
								label = "đang sửa xe",
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
									SetVehicleFuelLevel(vehicle, 70 +0.0)
									DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
									SetVehicleFixed(vehicle)
									SetVehicleDeformationFixed(vehicle)
									SetVehicleUndriveable(vehicle, false)
									SetVehicleEngineOn(vehicle, true, true)
									ClearPedTasksImmediately(playerPed)
									SetVehicleDirtLevel(vehicle, 0)
									ESX.ShowNotification(_U('vehicle_repaired'))
									TriggerServerEvent('tratiensuaxe')
							end
							
						end)	
					-- else
					-- 	ESX.ShowNotification(_U('no_vehicle_nearby'))
					end
		else
			if cuuho >= 1 then
				ESX.ShowNotification("Đang có cứu hộ trong server")
			else
				ESX.ShowNotification('Bạn không đủ tiền')
			end   
		end
	end)
end)


function buyVehicle()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job
	local elements = {}
	for k, v in pairs(Config.Vehicles) do 
		if ESX.PlayerData.job.grade >= v.grade and ESX.PlayerData.job.name == "mechanic" then
			table.insert(elements,{label = v.label.." "..v.price, value = v.model, price = v.price})
		end
	end
	table.insert(elements,{label = "Mua bình xăng với gía 5k", value = "xang", price = 5000})
	table.insert(elements,{label = "Kho đồ", value = "khodo", price = 10000})
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy-armor', {
		title    = 'Police',
		align    = 'center',
		elements = elements
	 }, function(data, menu)
		if data.current.value == 'xang' then
			TriggerServerEvent('esx_ambulance:muaXang',data.current.price)
		elseif data.current.value == 'khodo' then
			exports.ox_inventory:openInventory('stash', 'police1')
			menu.close()
		else
			ESX.TriggerServerCallback("esx_mechanic:checkVehicles", function(check)
				if check then
					ESX.Game.SpawnVehicle(data.current.value, vector3(-370.63, -130.31, 37.68), 173.98, function (vehicle)
						if DoesEntityExist(vehicle) then
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							local newPlate     = GeneratePlate()
							local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
							vehicleProps.plate = newPlate
							SetVehicleNumberPlateText(vehicle, newPlate)
							TriggerEvent('sulu_keycar:acceptData',string.gsub(newPlate, "%s+", ""))
							TriggerServerEvent('esx_mechanic:setVehicleOwned', vehicleProps,data.current.price )
						else
							ESX.ShowNotification("~r~ một lỗi vô tình xảy ra lúc nhận xe vui lòng thu lai")
						end
					end)
					menu.close()
				else
					ESX.ShowNotification("~r~ Nghèo mà đòi mua xe")
				end
			end, data.current.value)
		end
	end, function(data,menu)
		menu.close()
	end)
end

local NumberCharset = {}
local Charset = {}
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end
function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
		ESX.TriggerServerCallback('d3x_vehicleshop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
Citizen.CreateThread(function() 
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local buy =  vec3(-356.79, -130.39, 39.43)
		if #(coords - buy) < 40.0 and ESX.PlayerData.job.name == "mechanic" then
			time = 5
			DrawMarker(37, buy, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.5, 255, 102, 0, 100, true, true, 2, false, false, false, false)
		end

		if #(coords - buy) < 1.1 and ESX.PlayerData.job.name == "mechanic"  then
			ESX.ShowHelpNotification("Nhấn [E] để mua xe.")
			if IsControlJustReleased(0, 51) then
				buyVehicle()
			end
		end	
		Citizen.Wait(time)	
	end
end)