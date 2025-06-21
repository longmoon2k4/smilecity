local CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged, isInShopMenu = false, false
-- ESX = nil
--local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentActionPolice2, CurrentActionMsgPolice2, CurrentActionDataPolice2 = nil, '', {}
local CurrentActionPolice3, CurrentActionMsgPolice3, CurrentActionDataPolice3 = nil, '', {}
local x =0
local HasAlreadyEnteredMarker1, LastZone1 = false, nil
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

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

RegisterNetEvent('HD_Jail:ResetPMenu')
AddEventHandler('HD_Jail:ResetPMenu', function()
	OpenPoliceActionsMenu()
end)

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms[uniform].male
		else
			uniformObject = Config.Uniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)

			if uniform == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			ESX.ShowNotification(_U('no_outfit'))
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name

	local elements = {
		{label = _U('citizen_wear'), value = 'citizen_wear'},
		{label = _U('bullet_wear'), uniform = 'bullet_wear'},
		{label = _U('gilet_wear'), uniform = 'gilet_wear'},
		{label = _U('police_wear'), uniform = grade}
	}

	if Config.EnableCustomPeds then
		for k,v in ipairs(Config.CustomPeds.shared) do
			table.insert(elements, {label = v.label, value = 'freemode_ped', maleModel = v.maleModel, femaleModel = v.femaleModel})
		end

		for k,v in ipairs(Config.CustomPeds[grade]) do
			table.insert(elements, {label = v.label, value = 'freemode_ped', maleModel = v.maleModel, femaleModel = v.femaleModel})
		end
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			if Config.EnableCustomPeds then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if Config.EnableESXService then
				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then
						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')

						TriggerServerEvent('esx_service:disableService', 'police')
						--TriggerEvent('esx_policejob:updateBlip')
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'police')
			end
		end

		if Config.EnableESXService and data.current.value ~= 'citizen_wear' then
			local awaitService

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					if Config.MaxInService == -1 then
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if not canTakeService then
								ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
							else
								awaitService = true
								playerInService = true

								local notification = {
									title    = _U('service_anonunce'),
									subject  = '',
									msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
									iconType = 1
								}

								TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
								--TriggerEvent('esx_policejob:updateBlip')
								ESX.ShowNotification(_U('service_in'))
							end
						end, 'police')
					else 
						awaitService = true
						playerInService = true

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'police')
						--TriggerEvent('esx_policejob:updateBlip')
						ESX.ShowNotification(_U('service_in'))
					end

				else
					awaitService = true
				end
			end, 'police')

			while awaitService == nil do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not awaitService then
				return
			end
		end

		if data.current.uniform then
			setUniform(data.current.uniform, playerPed)
		elseif data.current.value == 'freemode_ped' then
			local modelHash

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)
					SetPedDefaultComponentVariation(PlayerPedId())

					TriggerEvent('esx:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

--------------------------------------------------------------
function OpenArmoryMenu(station)
	local elements = {}
    local grade = ESX.PlayerData.job.grade_name
	table.insert(elements, {label = 'Kho đồ',  value = 'khodo'})  
	
	ESX.UI.Menu.CloseAll()

	--if Config.EnableArmoryManagement then
		--table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		--table.insert(elements, {label = _U('put_weapon'),     value = 'put_weapon'})
		--table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
	--	table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
--	end
    -- if grade == 'boss' then
	--     table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
    -- end
	-- ESX.UI.Menu.CloseAll()
--------------------------------------------------------------------------------------------------------------
ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
	title    = _U('armory'),
	align    = 'bottom-right',
	elements = elements
}, function(data, menu)

	if data.current.value == 'khodo' then
		-- exports.ox_inventory:openInventory('police', {id='police',name='kho police',weight=1000000000})
		 exports.ox_inventory:openInventory('stash', 'police')
	end
	menu.close()
end, function(data, menu)
	menu.close()

	CurrentAction     = 'menu_armory'
	CurrentActionMsg  = _U('open_armory')
	CurrentActionData = {station = station}
end)
end

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = 'Police',
		align    = 'bottom-right',
		elements = {
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			 {label ='Danh Sách Người Gọi Police', value = 'ping_police'},
			-- {label = _U('object_spawner'), value = 'object_spawner'}
	}}, function(data, menu)
		if data.current.value == 'ping_police' then
			menu.close()
			TriggerEvent("request_menu:open")
	  	elseif data.current.value == 'citizen_interaction' then
			local elements = {
			--	{label = _U('id_card'), value = 'identity_card'},
				{label = _U('handcuff'), value = 'handcuff'},
				{label = _U('search'), value = 'search'},
				{label = _U('jail_menu'), value = 'jail_menu'},
				{label = _U('drag'), value = 'drag'},
				{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
				--{label = _U('fine'), value = 'fine'},
				
				--{label = _U('unpaid_bills'), value = 'unpaid_bills'}
			}

			--if Config.EnableLicenses then
				table.insert(elements, {label = _U('license_check'), value = 'license'})
			--end
			if ESX.PlayerData.job.grade >=4 and ESX.PlayerData.job.name == "police" then
				table.insert(elements, {label = "Cấp giấy súng", value = 'sung'})
			end
			-- if ESX.PlayerData.job.grade_name =='quany' or ESX.PlayerData.job.grade_name =='qlquany' then
			-- 	table.insert(elements,1 ,{label = "Hồi sinh", value = 'revive'})
			-- end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('citizen_interaction'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'search' then
						OpenBodySearchMenu(closestPlayer)
					elseif action == 'sung' then

						ESX.TriggerServerCallback('esx_license:checkLicense', function(bought)
							if bought then
								ESX.ShowNotification("Đã có bằng súng")
							else
								TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer),'weapon')
								TriggerServerEvent('esx_policejob:addLicense', GetPlayerServerId(closestPlayer))
								ESX.ShowNotification("Đã cấp bằng súng")
							end
						end, GetPlayerServerId(closestPlayer),'weapon')

					elseif action == 'handcuff' then
						TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
					elseif action == 'drag' then
						TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'revive' then
						if closestPlayer == -1 or closestDistance > 2.0 then
							--ESX.ShowNotification(_U('no_players'))
						else
								local closestPlayerPed = GetPlayerPed(closestPlayer)
							if  IsPedInAnyVehicle(PlayerPedId(),false) == false then	
								if GetEntityHealth(closestPlayerPed) == 101 then
								 --if IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()
		
									--ESX.ShowNotification(_U('revive_inprogress'))
									if lib.progressBar({
										duration =  13500,
										label = 'đang hồi sinh',
										useWhileDead = false,
										canCancel = true,
										disable = {
											car = true,
											move = true,
											combat = true,
											mouse = false,
										},
										anim = {
											dict = 'mini@cpr@char_a@cpr_str',
											clip = 'cpr_pumpchest',
											flag = 1
										},
									}) then 
										TriggerServerEvent('esx_policejob:revive', GetPlayerServerId(closestPlayer))
									end
									-- TriggerEvent("mythic_progbar:client:progress", {
									-- 	name = "cuunguoi",
									-- 	duration = 13500,
									-- 	label = "đang hồi sinh",
									-- 	useWhileDead = false,
									-- 	canCancel = true,
									-- 	controlDisables = {
									-- 		disableMovement = true,
									-- 		disableCarMovement = true,
									-- 		disableMouse = false,
									-- 		disableCombat = true,
									-- 	},
									-- 	animation = {
									-- 		animDict = "mini@cpr@char_a@cpr_str",
									-- 		anim = "cpr_pumpchest",
									-- 	}
									-- }, function(status)
									-- 	if not status then
									-- 		TriggerServerEvent('esx_policejob:revive', GetPlayerServerId(closestPlayer))
									-- 	end
									-- end)
									
								else
									ESX.ShowNotification("Người chơi không bị làm sao")
								end
							end
						end
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
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
									TriggerServerEvent('esx_bislling:sesndBill', GetPlayerServerId(closestPlayer), GetPlayerServerId(closestPlayer), _U('police'), amount)
								end
							end
						end, function(data, menu)
							menu.close()
						end)
					elseif action == 'jail_menu' then
						TriggerEvent("esx-qalle-jail:openJailMenu")
					elseif action == 'license' then
						-- ESX.TriggerServerCallback('esx_poilicejob:checkLicense', function(bought)
						-- 	if bought then
						-- 		ESX.ShowNotification("đã co bằng súng")
						-- 	else
						-- 		ESX.ShowNotification("co cai nit")
						-- 	end
						-- end, GetPlayerServerId(closestPlayer))

						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'), value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'), value = 'hijack_vehicle'})
				table.insert(elements, {label = "Xóa xe", value = 'impound'})
			end

			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = _U('vehicle_interaction'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value

				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					if action == 'vehicle_infos' then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
						--TriggerEvent("lr_impound:client:openImpoundMenu")
						-- local playerPed = PlayerPedId()

						-- if IsPedSittingInAnyVehicle(playerPed) then
						-- 	local vehicle = GetVehiclePedIsIn(playerPed, false)
			
						-- 	if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						-- 		ESX.ShowNotification("Đã xóa phương tiện")
						-- 		ESX.Game.DeleteVehicle(vehicle)
						-- 	else
						-- 		ESX.ShowNotification("Phải ngồi ghế lái")
						-- 	end
						-- else
						-- 	local vehicle = ESX.Game.GetVehicleInDirection()
			
						-- 	if DoesEntityExist(vehicle) then
						-- 		ESX.ShowNotification("Đã xóa phương tiện")
						-- 		ESX.Game.DeleteVehicle(vehicle)
						-- 	else
						-- 		ESX.ShowNotification("Không có xe ở gần")
						-- 	end
						-- end
						local coords = GetEntityCoords(PlayerPedId())
						TriggerServerEvent('esx_mechanic:xoaxe', coords, 5)
					else
						ESX.ShowNotification(_U('no_vehicles_nearby'))
					end
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'bottom-right',
				elements = {
					{label = _U('cone'), model = 'prop_roadcone02a'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},
					{label = _U('box'), model = 'prop_boxpile_07d'},
					{label = _U('cash'), model = 'hei_prop_cash_crate_half_full'}
			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
				local objectCoords = (coords + forward * 1.0)

				ESX.Game.SpawnObject(data2.current.model, objectCoords, function(obj)
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

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {
			{label = _U('name', data.name)},
			{label = _U('job', ('%s - %s'):format(data.job, data.grade))}
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = _U('sex', _U(data.sex))})
			table.insert(elements, {label = _U('dob', data.dob)})
			table.insert(elements, {label = _U('height', data.height)})
		end

		if data.drunk then
			table.insert(elements, {label = _U('bac', data.drunk)})
		end

		if data.licenses then
			table.insert(elements, {label = _U('license_label')})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end


function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {}

		for k,v in pairs(data) do
			if v ~= nil then
				if v.name == 'black_money' then

					table.insert(elements, {
						label    = _U('confiscate_dirty', ESX.Math.Round(v.count)),
						value    = v.name,
						itemType = 'item_account',
						amount   = v.count,
						slot 	= v.slot,
					})
				elseif v.name == 'money' then
				elseif string.sub(v.name, 1,6) =='WEAPON' then
					-- table.insert(elements, {
					-- 	label    = _U('confiscate_weapon', data[i].label),
					-- 	value    = data[i].name,
					-- 	itemType = 'item_weapon',
					-- 	amount   = data[i].count,
					-- 	slot 	= data[i].slot,
					-- })
				else
					table.insert(elements, {
						label    = _U('confiscate_inv', v.count, v.label),
						value    = v.name,
						itemType = 'item_standard',
						amount   = v.count,
						slot 	= v.slot,
					})
				end
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		{
			title    = '',
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)

			if data.current.value ~= nil then
				TriggerServerEvent('esx_policejob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount, data.current.label, data.current.slot)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'bottom-right',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

-- function OpenFineCategoryMenu(player, category)
-- 	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
-- 		local elements = {}

-- 		for k,fine in ipairs(fines) do
-- 			table.insert(elements, {
-- 				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
-- 				value     = fine.id,
-- 				amount    = fine.amount,
-- 				fineLabel = fine.label
-- 			})
-- 		end

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
-- 			title    = _U('fine'),
-- 			align    = 'bottom-right',
-- 			elements = elements
-- 		}, function(data, menu)
-- 			menu.close()

-- 			if Config.EnablePlayerManagement then
-- 				TriggerServerEvent('esx_bislling:sesndBill', GetPlayerServerId(player), GetPlayerServerId(player), _U('fine_total', data.current.fineLabel), data.current.amount)
-- 			else
-- 				TriggerServerEvent('esx_bislling:sesndBill', GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
-- 			end

-- 			ESX.SetTimeout(300, function()
-- 				OpenFineCategoryMenu(player, category)
-- 			end)
-- 		end, function(data, menu)
-- 			menu.close()
-- 		end)
-- 	end, category)
-- end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if not data.value or length < 2 or length > 8 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
				local elements = {{label = _U('plate', retrivedInfo.plate)}}
				menu.close()

				if not retrivedInfo.owner then
					table.insert(elements, {label = _U('owner_unknown')})
				else
					table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
					title    = _U('vehicle_info'),
					align    = 'bottom-right',
					elements = elements
				}, nil, function(data2, menu2)
					menu2.close()
				end)
			end, data.value)

		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_license:getLicenses', function(playerData)
		if playerData then
			for i=1, #playerData, 1 do
				if playerData[i].label and playerData[i].type then
					table.insert(elements, {
						label = playerData[i].label,
						type = playerData[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label,GetPlayerName(GetPlayerServerId(player))))
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if not retrivedInfo.owner then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			align    = 'bottom-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = _U('get_weapon_menu'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = _U('put_weapon_menu'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu()
	for k,v in ipairs(Config.AuthorizedWeapons[ESX.PlayerData.job.grade_name]) do
		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
			title    = _U('pharmacy_menu_title'),
			align    = 'bottom-right',
			elements = {
				{label = _U('pharmacy_take', _U('weapon')), item = 'weapon', type = 'slider', value = 1, min = 1, max = 1},
			}
		}, function(data, menu)
			TriggerServerEvent('esx_policejob:giveItem', data.current.item, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end
end

-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
-- 		title    = _U('armory_weapontitle'),
-- 		align    = 'bottom-right',
-- 		elements = elements
-- 	}, function(data, menu)
-- 		if data.current.hasWeapon then
-- 			if #data.current.components > 0 then
-- 				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
-- 			end
-- 		else
-- 			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
-- 				if bought then
-- 					if data.current.price > 0 then
-- 						ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
-- 					end

-- 					menu.close()
-- 					OpenBuyWeaponsMenu()
-- 				else
-- 					ESX.ShowNotification(_U('armory_money'))
-- 				end
-- 			end, data.current.name, 1)
-- 		end
-- 	end, function(data, menu)
-- 		menu.close()
-- 	end)
-- end

function OpenWeaponComponentShop(components, weaponName, parentShop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		title    = _U('armory_componenttitle'),
		align    = 'bottom-right',
		elements = components
	}, function(data, menu)
		if data.current.hasComponent then
			ESX.ShowNotification(_U('armory_hascomponent'))
		else
			ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					parentShop.close()
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, weaponName, 2, data.current.componentNum)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('police_stock'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:getStockItem', itemName, count)

					Citizen.Wait(300)
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
	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
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

				if not count then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

					Citizen.Wait(300)
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

-- RegisterNetEvent('esx:setJob')
-- AddEventHandler('esx:setJob', function(job)
-- 	ESX.PlayerData.job = job

-- 	Citizen.Wait(5000)
-- 	TriggerServerEvent('esx_policejob:forceBlip')
-- end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_police'),
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGlrJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGlrJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBlrMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGlrRBQkIxMUU3QkE2RDk4Q0ExQjhBlrMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.EnableESXService and not playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	elseif part == 'BuyArmor' then
		CurrentAction     = 'buyarmor'
		CurrentActionMsg  = "Mở tạp hóa mua giáp"
		CurrentActionData = {}
	elseif part == 'BuyVehicles' then
		CurrentAction     = 'buyvehicles'
		CurrentActionMsg  = "Mở tạp hóa mua xe"
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()

	if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		FreezeEntityPosition(playerPed, true)
		DisplayRadar(false)

		if Config.EnableHandcuffTimer then
			if handcuffTimer.active then
				ESX.ClearTimeout(handcuffTimer.task)
			end

			StartHandcuffTimer()
		end
	else
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(copId)
	if isHandcuffed then

		dragStatus.isDragged = not dragStatus.isDragged
		dragStatus.CopId = copId
	end
end)

Citizen.CreateThread(function()
	local wasDragged

	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed and dragStatus.isDragged then
			local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

			if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
				if not wasDragged then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
					wasDragged = true
				else
					Citizen.Wait(1000)
				end
			else
				wasDragged = false
				dragStatus.isDragged = false
				DetachEntity(playerPed, true, false)
			end
		elseif wasDragged then
			wasDragged = false
			DetachEntity(playerPed, true, false)
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					dragStatus.isDragged = false
				end
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:callbackthudo')
AddEventHandler('esx_policejob:callbackthudo', function(source,slot, count)
	TriggerServerEvent('ox_inventory:giveItem', slot, source,count)
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Create blips
-- Citizen.CreateThread(function()
-- 	for k,v in pairs(Config.PoliceStations) do
-- 		local blip = AddBlipForCoord(v.Blip.Coords)

-- 		SetBlipSprite (blip, v.Blip.Sprite)
-- 		SetBlipDisplay(blip, v.Blip.Display)
-- 		SetBlipScale  (blip, v.Blip.Scale)
-- 		SetBlipColour (blip, v.Blip.Colour)
-- 		SetBlipAsShortRange(blip, true)

-- 		BeginTextCommandSetBlipName('STRING')
-- 		AddTextComponentSubstringPlayerName(_U('map_blip'))
-- 		EndTextCommandSetBlipName(blip)
-- 	end
-- end)

-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.PoliceStations) do
				for i=1, #v.Cloakrooms, 1 do
					local distance = #(playerCoords - v.Cloakrooms[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Cloakrooms, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
						end
					end
				end

				for i=1, #v.Armories, 1 do
					local distance = #(playerCoords - v.Armories[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.Armories, v.Armories[i], 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 153, 255, 150, false, true, 2, true, false, false, false)
						--DrawMarker(Config.MarkerType.Armories, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
						end
					end
				end

				-- for i=1, #v.BuyArmor, 1 do
				-- 	local distance = #(playerCoords - v.BuyArmor[i])

				-- 	if distance < Config.DrawDistance then
				-- 		DrawMarker(Config.MarkerType.BuyArmor, v.BuyArmor[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				-- 		letSleep = false

				-- 		if distance < Config.MarkerSize.x then
				-- 			isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BuyArmor', i
				-- 		end
				-- 	end
				-- end

				for i=1, #v.BuyVehicles, 1 do
					local distance = #(playerCoords - v.BuyVehicles[i])

					if distance < Config.DrawDistance then
						DrawMarker(Config.MarkerType.BuyVehicles, v.BuyVehicles[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BuyVehicles', i
						end
					end
				end
				-- if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
				-- 	for i=1, #v.BossActions, 1 do
				-- 		local distance = #(playerCoords - v.BossActions[i])

				-- 		if distance < Config.DrawDistance then
				-- 			DrawMarker(Config.MarkerType.BossActions, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
				-- 			letSleep = false

				-- 			if distance < Config.MarkerSize.x then
				-- 				isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
				-- 			end
				-- 		end
				-- 	end	
				-- end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(3000)
		end
	end
end)

-- Enter / Exit entity zone events
-- Citizen.CreateThread(function()
-- 	local trackedEntities = {
-- 		'prop_roadcone02a',
-- 		'prop_barrier_work05',
-- 		'p_ld_stinger_s',
-- 		'prop_boxpile_07d',
-- 		'hei_prop_cash_crate_half_full'
-- 	}

-- 	while true do
-- 		Citizen.Wait(500)

-- 		local playerPed = PlayerPedId()
-- 		local playerCoords = GetEntityCoords(playerPed)

-- 		local closestDistance = -1
-- 		local closestEntity   = nil

-- 		for i=1, #trackedEntities, 1 do
-- 			local object = GetClosestObjectOfType(playerCoords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

-- 			if DoesEntityExist(object) then
-- 				local objCoords = GetEntityCoords(object)
-- 				local distance = #(playerCoords - objCoords)

-- 				if closestDistance == -1 or closestDistance > distance then
-- 					closestDistance = distance
-- 					closestEntity   = object
-- 				end
-- 			end
-- 		end

-- 		if closestDistance ~= -1 and closestDistance <= 3.0 then
-- 			if LastEntity ~= closestEntity then
-- 				TriggerEvent('esx_policejob:hasEnteredEntityZone', closestEntity)
-- 				LastEntity = closestEntity
-- 			end
-- 		else
-- 			if LastEntity then
-- 				TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
-- 				LastEntity = nil
-- 			end
-- 		end
-- 	end
-- end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		
		local time = 1000
		if CurrentAction then
			time = 1
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_armory' then
					if not Config.EnableESXService then
						OpenArmoryMenu(CurrentActionData.station)
					elseif playerInService then
						OpenArmoryMenu(CurrentActionData.station)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				-- elseif CurrentAction == 'menu_vehicle_spawner' then
				-- 	if not Config.EnableESXService then
				-- 		OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				-- 	elseif playerInService then
				-- 		OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				-- 	else
				-- 		ESX.ShowNotification(_U('service_not'))
				-- 	end
				-- elseif CurrentAction == 'Helicopters' then
				-- 	if not Config.EnableESXService then
				-- 		OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				-- 	elseif playerInService then
				-- 		OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
				-- 	else
				-- 		ESX.ShowNotification(_U('service_not'))
				-- 	end
				-- elseif CurrentAction == 'delete_vehicle' then
				-- 	ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				-- elseif CurrentAction == 'menu_boss_actions' then
				-- 	ESX.UI.Menu.CloseAll()
				-- 	TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
				-- 		menu.close()

				-- 		CurrentAction     = 'menu_boss_actions'
				-- 		CurrentActionMsg  = _U('open_bossmenu')
				-- 		CurrentActionData = {}
				-- 	end, { wash = false }) -- disable washing money
				-- elseif CurrentAction == 'remove_entity' then
				-- 	DeleteEntity(CurrentActionData.entity)
				-- elseif CurrentAction == 'buyarmor' then
				-- 	muaGiapCS()
				elseif CurrentAction == 'buyvehicles' then
					buyVehicle()
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

		-- if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
		-- 	if not Config.EnableESXService then
		-- 		OpenPoliceActionsMenu()
		-- 	elseif playerInService then
		-- 		OpenPoliceActionsMenu()
		-- 	else
		-- 		ESX.ShowNotification(_U('service_not'))
		-- 	end
		-- end

		-- if IsControlJustReleased(0, 38) and currentTask.busy then
		-- 	ESX.ShowNotification(_U('impound_canceled'))
		-- 	ESX.ClearTimeout(currentTask.task)
		-- 	ClearPedTasks(PlayerPedId())

		-- 	currentTask.busy = false
		-- end
		Citizen.Wait(time)
	end
end)

RegisterKeyMapping('menucs', 'Menu canh sat', 'keyboard', "f6")
RegisterCommand('menucs', function()
	if  not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
		if not Config.EnableESXService then
			OpenPoliceActionsMenu()
		elseif playerInService then
			OpenPoliceActionsMenu()
		else
			ESX.ShowNotification(_U('service_not'))
		end
	end
end, true)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_policejob:updateBlip')
AddEventHandler('esx_policejob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.EnableESXService and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	-- if not hasAlreadyJoined then
	-- 	TriggerServerEvent('esx_policejob:spawned')
	-- end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.EnableESXService then
			TriggerServerEvent('esx_service:disableService', 'police')
		end

		if Config.EnableHandcuffTimer and handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_policejob:unrestrain')
		handcuffTimer.active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
-- function ImpoundVehicle(vehicle)
-- 	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
-- 	ESX.Game.DeleteVehicle(vehicle)
-- 	ESX.ShowNotification(_U('impound_successful'))
-- 	currentTask.busy = false
-- end

----------------------------------------------------------------------------------------------------------------
----------  Menu Tương Tác  -----------
---------  Dev By MiCheo Hưng  --------

RegisterNetEvent('congan:lucsoat')            ----- XONG
AddEventHandler('congan:lucsoat', function()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		local target, distance = ESX.Game.GetClosestPlayer()
		local playerheading = GetEntityHeading(GetPlayerPed(-1))
		local playerlocation = GetEntityForwardVector(PlayerPedId())
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)

		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'cuff', 1.0)
		TriggerServerEvent('esx_policejob:requesthard', target_id, playerheading, playerCoords, playerlocation)

	    TriggerServerEvent('esx_policejob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
	    OpenBodySearchMenu(closestPlayer)

	else	
	    ESX.ShowNotification(_U('no_players_nearby'))
    end

end)

RegisterNetEvent('congan:kiemtra')            --- XONG
AddEventHandler('congan:kiemtra', function()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
		
			OpenIdentityCardMenu(closestPlayer)

		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end

end)

RegisterNetEvent('congan:kiemtraxe')           --- XONG
AddEventHandler('congan:kiemtraxe', function()

	local elements  = {}
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local vehicle   = ESX.Game.GetVehicleInDirection()
	if DoesEntityExist(vehicle) then
		local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
		OpenVehicleInfosMenu(vehicleData)
	else
		ESX.ShowNotification(_U('no_vehicles_nearby'))
	end


end)

RegisterNetEvent('congan:congtay')            --- XONG
AddEventHandler('congan:congtay', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification(_U('no_players_nearby'))
	end
end)

RegisterNetEvent('esx_policejob:danhsach')            --- XONG
AddEventHandler('esx_policejob:danhsach', function()
	TriggerEvent("request_menu:open")
end)

-- RegisterNetEvent('congan:thaocong')            --- XONG
-- AddEventHandler('congan:thaocong', function()

-- 	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
-- 	if closestPlayer ~= -1 and closestDistance <= 3.0 then

-- 		local target, distance = ESX.Game.GetClosestPlayer()
-- 		playerheading = GetEntityHeading(GetPlayerPed(-1))
-- 		playerlocation = GetEntityForwardVector(PlayerPedId())
-- 		playerCoords = GetEntityCoords(GetPlayerPed(-1))
-- 		local target_id = GetPlayerServerId(target)
-- 		TriggerServerEvent('esx_policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
-- 		Citizen.Wait(1200)
-- 		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3, 'Uncuff', 1.0)	

-- 	else
-- 		ESX.ShowNotification(_U('no_players_nearby'))
-- 	end

-- end)

RegisterNetEvent('congan:apgiai')            --- XONG
AddEventHandler('congan:apgiai', function()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then

		TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification(_U('no_players_nearby'))
	end

end)

RegisterNetEvent('congan:nhetvaoxe')         --- XONG
AddEventHandler('congan:nhetvaoxe', function()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then

			TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))

		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end

end)

RegisterNetEvent('congan:loirakhoixe')      --- XONG
AddEventHandler('congan:loirakhoixe', function()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then

			TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))

		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end

end)

RegisterNetEvent('congan:giamxe')            --- XONG
AddEventHandler('congan:giamxe', function()
	local coords  = GetEntityCoords(playerPed)
	vehicle = ESX.Game.GetVehicleInDirection()
	TriggerEvent("lr_impound:client:openImpoundMenu")
end)

RegisterNetEvent('congan:giamgiu')            --- XONG
AddEventHandler('congan:giamgiu', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerEvent("esx-qalle-jail:openJailMenu")
	else
		ESX.ShowNotification(_U('no_players_nearby'))
	end
end)

RegisterNetEvent('congan:phakhoaxe')              --- XONG
AddEventHandler('congan:phakhoaxe', function()

	local elements  = {}
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local vehicle   = ESX.Game.GetVehicleInDirection()
	if DoesEntityExist(vehicle) then
		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
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
				end
			end)
		end
		
	else
		ESX.ShowNotification(_U('no_vehicles_nearby'))
	end

end)

RegisterNetEvent('congan:phat')              --- XONG
AddEventHandler('congan:phat', function()  

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
				TriggerServerEvent('esx_bislling:sesndBill', GetPlayerServerId(closestPlayer), GetPlayerServerId(closestPlayer), _U('police'), amount)
			end
		end
	end, function(data, menu)
		menu.close()
	end)

end)

RegisterNetEvent('congan:giayphep')              --- XONG
AddEventHandler('congan:giayphep', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		ShowPlayerLicense(closestPlayer)
	else
		ESX.ShowNotification(_U('no_players_nearby'))
	end
end)

-- RegisterNetEvent('congan:hoadon')              --- XONG
-- AddEventHandler('congan:hoadon', function()

-- 	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
-- 	if closestPlayer ~= -1 and closestDistance <= 3.0 then
-- 		OpenUnpaidBillsMenu(closestPlayer)
-- 	else
-- 		ESX.ShowNotification(_U('no_players_nearby'))
-- 	end

-- end)


-- function OpenPoliActionsMenu()
-- 	local elements = {
-- 		{label = "Phương tiện",   value = 'vehicle_list'},	
-- 	}
-- 	ESX.UI.Menu.CloseAll()

-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
-- 		title    = "Công an",
-- 		align    = 'bottom-right',
-- 		elements = elements
-- 	}, function(data, menu)
-- 		if data.current.value == 'vehicle_list' then
			
-- 				local elements = {
-- 					{label= 'lếch xù', value = 'cls63'},
-- 					{label='Moto lỏ', value='r1custom'}

-- 				}
				
-- 				if ESX.PlayerData.job.grade  >= 1 and ESX.PlayerData.job.grade <=4 then
-- 					table.insert(elements,{label= 'Trực thăng', value = 'as350'})
											
-- 				elseif ESX.PlayerData.job.grade  >= 5 then 
-- 					table.insert(elements,{label= 'Trực thăng', value = 'as350'})
-- 					table.insert(elements,{label= 'Xe SWAT', value = 'WMFENYRCOP'})
-- 				end
-- 				ESX.UI.Menu.CloseAll()

-- 				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
-- 					title    = "Phương tiện",
-- 					align    = 'bottom-right',
-- 					elements = elements
-- 				}, function(data, menu)
-- 					if x == 1 then
-- 						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
-- 							local playerPed = PlayerPedId()
							
-- 							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
-- 						end)
-- 					end
-- 					if x == 2 then
-- 						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint2.Pos, 90.0, function(vehicle)
-- 							local playerPed = PlayerPedId()
							
-- 							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
-- 						end)
-- 					end
-- 					menu.close()
-- 				end, function(data, menu)
-- 					menu.close()
-- 					OpenPoliActionsMenu()
-- 				end)
-- 		end
-- 		menu.close()
-- 	end, function(data, menu)
-- 		menu.close()

-- 		CurrentActionPolice2     = 'police_actions_menu'
-- 		CurrentActionMsgPolice2  = "Nhấn E để mở gara"
-- 		CurrentActionDataPolice2 = {}
-- 		CurrentActionPolice3     = 'police_actions_menu'
-- 		CurrentActionMsgPolice3  = "Nhấn E để mở gara"
-- 		CurrentActionDataPolice3 = {}
-- 	end)
-- end

-- Citizen.CreateThread(function()
-- 	while true do
		
-- 		local time = 1000
-- 		if CurrentActionPolice2 then
-- 			time  = 1
-- 			ESX.ShowHelpNotification(CurrentActionMsgPolice2)

-- 			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then

-- 				if CurrentActionPolice2 == 'police_actions_menu' then
-- 					x = 1
-- 					CurrentActionPolice2 = nil
-- 					OpenPoliActionsMenu()
-- 				elseif CurrentActionPolice2 == 'delete_vehicle' then
-- 					ESX.Game.DeleteVehicle(CurrentActionDataPolice2.vehicle)
-- 				end
-- 				CurrentActionPolice2 = nil
-- 			end
-- 		elseif CurrentActionPolice3 then
-- 			time  = 1
-- 			ESX.ShowHelpNotification(CurrentActionMsgPolice3)

-- 			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then

-- 				if CurrentActionPolice3 == 'police_actions_menu' then
-- 					x = 2
-- 					CurrentActionPolice3 = nil
-- 					OpenPoliActionsMenu()
-- 				elseif CurrentActionPolice3 == 'delete_vehicle' then
-- 					ESX.Game.DeleteVehicle(CurrentActionDataPolice3.vehicle)
-- 				end
-- 				CurrentActionPolice3 = nil
-- 			end
-- 		end
-- 		Citizen.Wait(time)
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local time = 1000
-- 		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then

-- 			local coords1 = GetEntityCoords(PlayerPedId())
-- 			local isInMarker1 = false
-- 			local currentZone1 = nil

-- 			for k,v in pairs(Config.Zones) do
-- 				if(GetDistanceBetweenCoords(coords1, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
-- 					isInMarker1  = true
-- 					currentZone1 = k
-- 					time = 1
-- 				end
-- 			end

-- 			if (isInMarker1 and not HasAlreadyEnteredMarker1) or (isInMarker1 and LastZone1 ~= currentZone1) then
-- 				HasAlreadyEnteredMarker1 = true
-- 				LastZone1                = currentZone1
-- 				TriggerEvent('esx_policejob:hasEnteredMarker3', currentZone1)
-- 			end
-- 			if not isInMarker1 and HasAlreadyEnteredMarker1 then
-- 				HasAlreadyEnteredMarker1 = false
-- 				TriggerEvent('esx_policejob:hasExitedMarker', LastZone1)
-- 			end		
-- 		end
-- 		Citizen.Wait(time)
-- 	end
-- end)

-- AddEventHandler('esx_policejob:hasExitedMarker', function(zone)

-- 	CurrentActionPolice2  = nil
-- 	CurrentActionPolice3  = nil
-- 	ESX.UI.Menu.CloseAll()
-- end)

-- AddEventHandler('esx_policejob:hasEnteredMarker3', function(zone)

-- 	if zone == 'MechanicActions' then
-- 		CurrentActionPolice2     = 'police_actions_menu'
-- 		CurrentActionMsgPolice2  = "Nhấn E để mở gara"
-- 		CurrentActionDataPolice2 = {}
-- 	elseif zone=='MechanicActions2' then
-- 		CurrentActionPolice3     = 'police_actions_menu'
-- 		CurrentActionMsgPolice3  = "Nhấn E để mở gara"
-- 		CurrentActionDataPolice3 = {}

-- 	elseif zone == 'VehicleDeleter2' then
-- 		local playerPed = PlayerPedId()

-- 		if IsPedInAnyVehicle(playerPed, false) then
-- 			local vehicle = GetVehiclePedIsIn(playerPed,  false)

-- 			CurrentActionPolice3     = 'delete_vehicle'
-- 			CurrentActionMsgPolice3  = "Nhấn E để cất xe"
-- 			CurrentActionDataPolice3 = {vehicle = vehicle}
-- 		end
-- 	elseif zone == 'VehicleDeleter'   then
-- 		local playerPed = PlayerPedId()

-- 		if IsPedInAnyVehicle(playerPed, false) then
-- 			local vehicle = GetVehiclePedIsIn(playerPed,  false)

-- 			CurrentActionPolice2     = 'delete_vehicle'
-- 			CurrentActionMsgPolice2  = "Nhấn E để cất xe"
-- 			CurrentActionDataPolice2 = {vehicle = vehicle}
-- 		end
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)

-- 		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
-- 			local coords, letSleep1 = GetEntityCoords(PlayerPedId()), true

-- 			for k,v in pairs(Config.Zones) do
-- 				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance2 then
-- 					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
-- 					letSleep1 = false
-- 				end
-- 			end

-- 			if letSleep1 then
-- 				Citizen.Wait(1000)
-- 			end
-- 		else
-- 			Citizen.Wait(3000)
-- 		end
-- 	end
-- end)


function muaGiapCS()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job
	local _source = source
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy-armor', {
		title    = 'Police',
		align    = 'center',
		elements = {{label = "Mua giáp cảnh sát "..Config.ArmorPrice.."$", value = 'buygiap'},
		{label = "Mua bandage cảnh sát "..Config.BandagePrice.."$", value = 'buybandage'},}
	 }, function(data, menu)
		if data.current.value == 'buygiap' then
			TriggerServerEvent("esx_policebuyarmor")
		else
			TriggerServerEvent("esx_policebuybandage")
		end
	end, function(data,menu)
		menu.close()
	end)
end

function buyVehicle()
	local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job
	local elements = {}
	for k, v in pairs(Config.Vehicles) do 
		if ESX.PlayerData.job.grade >= v.grade and ESX.PlayerData.job.name == "police" then
			table.insert(elements,{label = v.label.." "..v.price, value = v.model, price = v.price})
		end
	end
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy-armor', {
		title    = 'Police',
		align    = 'center',
		elements = elements
	 }, function(data, menu)
		ESX.TriggerServerCallback("esx_police:checkVehicles", function(check)
			if check then
				ESX.Game.SpawnVehicle(data.current.value, Config.Zones1.Pos, 173.98, function (vehicle)
					if DoesEntityExist(vehicle) then
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						local newPlate     = GeneratePlate()
						local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
						vehicleProps.plate = newPlate
						SetVehicleNumberPlateText(vehicle, newPlate)
						if data.current.value == 'polmav' then
							vehicleProps.modLivery = 0
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						end
						TriggerEvent('sulu_keycar:acceptData',string.gsub(newPlate, "%s+", ""))
						TriggerServerEvent('esx_police:setVehicleOwned', vehicleProps,data.current.price )
					else
						ESX.ShowNotification("~r~ một lỗi vô tình xảy ra lúc nhận xe vui lòng thu lai")
					end
				end)
				menu.close()
			else
				ESX.ShowNotification("~r~ Nghèo mà đòi mua xe")
			end
		end, data.current.value)
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

function buyWeapon()
	local playerPed = PlayerPedId()
	local elements = {}
	for k, v in pairs(Config.Weapon) do 
		if ESX.PlayerData.job.grade >= v.grade and ESX.PlayerData.job.name == "police" then
			table.insert(elements,{label = v.label.." "..v.price, value = v.model, price = v.price})
		end
	end
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy-armor', {
		title    = 'Police',
		align    = 'center',
		elements = elements
	 }, function(data, menu)
		TriggerServerEvent('esx_police:buyWeapon', data.current.value)
		menu.close()
	end, function(data,menu)
		menu.close()
	end)
end


Citizen.CreateThread(function() 
	local buy = vec3(451.51, -979.44, 30.68)
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
		if #(coords - buy) < 40.0 and ESX.PlayerData.job.name == "police" then
			time = 1
			DrawMarker(20, buy, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.5, 255, 102, 0, 100, true, true, 2, false, false, false, false)
		end

		if #(coords - buy) < 1.1  then
			ESX.ShowHelpNotification("Nhấn [E] để mua súng.")
			if IsControlJustReleased(0, 51) then
				buyWeapon()
			end
		end	
		Citizen.Wait(time)	
	end
end)