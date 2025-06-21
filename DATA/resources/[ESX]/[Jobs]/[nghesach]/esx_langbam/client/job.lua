function randomrevive()
    math.randomseed(GetGameTimer())
    return (math.random(1, 100) >= 30)
end

--   RegisterNetEvent('esx_langbam:hoisinh') 
--   AddEventHandler('esx_langbam:hoisinh', function() 
--       ESX.TriggerServerCallback('esx_langbam:getItemAmount', function(quantity)
--           if quantity > 0 then
--               local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--               if closestPlayer == -1 or closestDistance > 1.0 then
--                   ESX.ShowNotification(_U('no_players'))
--               else
--               local closestPlayerPed = GetPlayerPed(closestPlayer)
--               if IsPedInAnyVehicle(cache.ped, false) then
--                   ESX.ShowNotification('Không thể cứu khi đang trên xe')
--               else
--                 if ESX.GetPlayerData() and ESX.GetPlayerData().job.name == 'langbam' then  
--                     if IsPedDeadOrDying(closestPlayerPed, 1) then
--                         TriggerEvent("dpemotes:clearanim")
--                         TriggerEvent("mythic_progbar:client:progress", {
--                             name = "doing_revive_lb",
--                             duration = 13500,
--                             label = "Đang cấp cứu",
--                             useWhileDead = false,
--                             canCancel = true,
--                             controlDisables = {
--                                 disableMovement = true,
--                                 disableCarMovement = true,
--                                 disableMouse = false,
--                                 disableCombat = true,
--                             },
--                             animation = {
--                                 animDict = "mini@cpr@char_a@cpr_str",
--                                 anim = "cpr_pumpchest",
--                             }
--                         }, function(status)
--                             if not status then
--                                 if randomrevive() then
--                                     local ped = cache.ped
--                                     TriggerServerEvent('esx_langbam:relinhvive', GetPlayerServerId(closestPlayer))
--                                     ClearPedTasks(ped)
--                                 else
--                                     local ped = cache.ped
--                                     ESX.ShowNotification(_U('revive_failed', GetPlayerName(closestPlayer)))
--                                     ClearPedTasks(ped)
--                                 end
--                             end
--                         end)
  
--                     else
--                         ESX.ShowNotification(_U('player_not_unconscious'))
--                     end
--                 else
--                     exports['jnr_notify']:Alert("Hệ Thống", "Bạn không phải là lang băm", 5000, 'error')
--                 end
--                 end
--               end
--           else
--               ESX.ShowNotification(_U('not_enough_medikit'))
--           end
--       end, 'medlangbam')
--   end)
--   RegisterNetEvent("esx_weashop:clip")
--   AddEventHandler(
--       "esx_weashop:clip",
--       function()
--           ped = GetPlayerPed(-1)
--           if IsPedArmed(ped, 4) then
--               hash = GetSelectedPedWeapon(ped)
--               if hash ~= nil then
--                   AddAmmoToPed(GetPlayerPed(-1), hash, 50)
--                   ESX.ShowNotification("Bạn đã nạp đạn")
--               else
--                   ESX.ShowNotification("Bạn không có súng trong tay")
--               end
--           else
--               ESX.ShowNotification("Đạn này không phù hợp")
--           end
--       end
--   )
--   RegisterNetEvent("nfw_wep:HeavyArmor")
--   AddEventHandler(
--       "nfw_wep:HeavyArmor",
--       function(item)
--           local ped = GetPlayerPed(-1)
--           local armor = GetPedArmour(ped)
--           if (armor >= 100) or (armor + 30 > 100) then
--               TriggerServerEvent("returnItem", item)
--               ESX.ShowNotification("Giáp bạn vẫn còn")
--               return
--           end
--           if item == "giapcs" then
--               TriggerEvent(
--                   "mythic_progbar:client:progress",
--                   {
--                       name = "giapnhe",
--                       duration = 6000,
--                       label = "Đang Mặc Giáp...",
--                       useWhileDead = false,
--                       canCancel = true,
--                       controlDisables = {
--                           disableMovement = true,
--                           disableCarMovement = true,
--                           disableMouse = false,
--                           disableCombat = true
--                       },
--                       animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"},
--                       prop = {model = "prop_bodyarmour_02"}
--                   },
--                   function(status)
--                       if not status then
--                           SetPlayerMaxArmour(PlayerId(), 100)
--                           SetPedArmour(cache.ped, 100)
--                           AddArmourToPed(playerPed, 100)
--                           SetPedArmour(playerPed, 100)
--                       end
--                   end
--               )
--           end
--           if item == "giapnhe" then
--               TriggerEvent(
--                   "mythic_progbar:client:progress",
--                   {
--                       name = "giapnhe",
--                       duration = 6000,
--                       label = "Đang Mặc Giáp...",
--                       useWhileDead = false,
--                       canCancel = true,
--                       controlDisables = {
--                           disableMovement = true,
--                           disableCarMovement = true,
--                           disableMouse = false,
--                           disableCombat = true
--                       },
--                       animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"},
--                       prop = {model = "prop_bodyarmour_02"}
--                   },
--                   function(status)
--                       if not status then
--                           SetPedComponentVariation(ped, 9, 11, 0, 0)
--                           AddArmourToPed(ped, 50)
--                       end
--                   end
--               )
--           else
--               TriggerEvent(
--                   "mythic_progbar:client:progress",
--                   {
--                       name = "giapnang",
--                       duration = 9000,
--                       label = "Đang Mặc Giáp...",
--                       useWhileDead = false,
--                       canCancel = true,
--                       controlDisables = {
--                           disableMovement = true,
--                           disableCarMovement = true,
--                           disableMouse = false,
--                           disableCombat = true
--                       },
--                       animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"},
--                       prop = {model = "prop_bodyarmour_02"}
--                   },
--                   function(status)
--                       if not status then
--                           SetPedComponentVariation(ped, 9, 11, 1, 0)
--                           AddArmourToPed(ped, 100)
--                       end
--                   end
--               )
--           end
--       end
--   )

local IsBusy = false
  function OpenLangBamActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_langbam_actions', {
		title    = 'Lang băm',
		align    = 'bottom-right',
		elements = {
			{label = 'Hồi sinh người chơi(70%)', value = 'revive'}
		}
	}, function(data, menu)
		if data.current.value == 'revive' then
			if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification(_U('no_players'))
				else

					--if data.current.value == 'revive' then
						ESX.TriggerServerCallback('esx_langbam:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								if IsPedInAnyVehicle(cache.ped, false) then
									ESX.ShowNotification('Không thể cứu khi đang trên xe')
								else
									if GetEntityHealth(closestPlayerPed) == 101 then -- IsPedDeadOrDying(closestPlayerPed, 1) then
										IsBusy= true
										if lib.progressBar({
											duration =  11500,
											label = 'Đang cấp cứu',
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
											if randomrevive() then
												IsBusy = false
												TriggerServerEvent('esx_langbam:removeItem', 'medikit')
												-- exports["WaveShield"]:TriggerServerEvent("esx_langbam:revive", GetPlayerServerId(closestPlayer))
												TriggerServerEvent('esx_langbam:revive', GetPlayerServerId(closestPlayer))
												ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
											else
												IsBusy = false
												  ESX.ShowNotification(_U('revive_failed', GetPlayerName(closestPlayer)))
											end
										else
											IsBusy = false
										 end
									else
										ESX.ShowNotification(_U('player_not_unconscious'))
									end
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end

							

						end, 'medlangbam')
					--end
				end
            end
	end, function(data, menu)
		menu.close()
	end)
end
RegisterKeyMapping('langbam', 'menu langbam', 'keyboard', "f6")
RegisterCommand('langbam', function()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'langbam' then
		OpenLangBamActionsMenu()

	end
end, false)
