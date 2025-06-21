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
local Zone = nil
-- ESX = nil

PlayerData = {}
local checkZone = false
local jailTime = 0

Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	--LoadTeleporters()
	Zone =	--Name: nhatu | 2023-04-21T05:49:50Z
	PolyZone:Create({
		vector2(1807.6715087891, 2474.5493164063),
		vector2(1812.0780029297, 2489.125),
		vector2(1805.8160400391, 2536.0844726563),
		vector2(1807.7116699219, 2591.388671875),
		vector2(1818.7592773438, 2592.0766601563),
		vector2(1818.7355957031, 2595.537109375),
		vector2(1817.4426269531, 2611.0388183594),
		vector2(1809.7058105469, 2612.9519042969),
		vector2(1809.228515625, 2621.9387207031),
		vector2(1834.5223388672, 2688.8461914063),
		vector2(1828.9930419922, 2703.7490234375),
		vector2(1776.0991210938, 2745.9775390625),
		vector2(1761.8452148438, 2752.1525878906),
		vector2(1661.3270263672, 2748.5827636719),
		vector2(1649.1475830078, 2740.5297851563),
		vector2(1585.2725830078, 2679.3146972656),
		vector2(1577.3358154297, 2667.498046875),
		vector2(1549.3748779297, 2591.8159179688),
		vector2(1547.7739257813, 2575.33203125),
		vector2(1551.6497802734, 2481.9704589844),
		vector2(1557.2579345703, 2470.1826171875),
		vector2(1652.8212890625, 2410.6936035156),
		vector2(1667.8707275391, 2408.6257324219),
		vector2(1748.9674072266, 2420.8864746094),
		vector2(1762.1767578125, 2427.4799804688)
	  }, {
		name = "nhatu",
		--minZ = 45.411422729492,
		--maxZ = 45.545875549316
	  })
	  Zone:onPlayerInOut(function(check)
        local playerPed = PlayerPedId()
        checkZone = check
        if check then
            Citizen.CreateThread(function()
                --ESX.ShowNotification("Đã vào khu vực an toàn.")
                while checkZone do 
                --    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
                --   TriggerEvent('ox_inventory:disarm')
                    DisablePlayerFiring(playerPed, true)
                    -- SetWeaponDamageModifierThisFrame(GetSelectedPedWeapon(playerPed), -1000)
                    SetEntityInvincible(playerPed, true)
                    SetCanAttackFriendly(PlayerPedId(), false, false)
                    SetPedCanRagdoll(playerPed, false)
                    ClearPedBloodDamage(playerPed)
                    ResetPedVisibleDamage(playerPed)
                    ClearPedLastWeaponDamage(playerPed)
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 141, true)
                    Wait(0)
                end
            end)
        else
            -- ESX.ShowNotification("Đã rời khỏi khu vực an toàn.")
            SetEntityInvincible(playerPed, false)
            SetPedCanRagdoll(playerPed, true)
            NetworkSetFriendlyFireOption(true)
            SetCanAttackFriendly(PlayerPedId(), true, false)
            DisablePlayerFiring(playerPed, false)
        end
    end)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(25000)

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

			JailLogin()
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer1")
AddEventHandler("esx-qalle-jail:jailPlayer1", function(newJailTime)
	jailTime = newJailTime

	Cutscene()
end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

function JailLogin()
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

	ESX.ShowNotification("Trước khi outgame bạn vẫn đi tù giờ thì trở lại nhé !")

	InJail()
end

function UnJail()
	InJail()

	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	ESX.ShowNotification("Bạn đã ra tù ! hãy là 1 công dân tốt !")
end

function InJail()

	--Jail Timer--

	Citizen.CreateThread(function()

		while jailTime > 0 do

			jailTime = jailTime - 1

			TriggerEvent('chatMessage', 'Junventus: ', { 255, 0, 0 }, "Thời gian phạt tù còn lại " .. jailTime .. " phút !")

			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)

			if jailTime <= 0 then
				UnJail()

				TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
			end

			Citizen.Wait(60000)
		end

	end)

	--Jail Timer--

	--Prison Work--

	Citizen.CreateThread(function()
		while jailTime > 0 do
			Citizen.Wait(1)
			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do
                
				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)
				if (DistanceCheck < 30.0)  then
					DrawMarker(20, v["x"], v["y"], v["z"], 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
					if (DistanceCheck < 2 ) then
						ESX.ShowHelpNotification('Nhấn [~g~E~s~] để chill')
						if IsControlJustReleased(1, 51) then
							if lib.progressBar({
								duration = 60000,
								label = "đánh đàn thư giản",
								useWhileDead = false,
								canCancel = true,
								disable = {
									car = true,
									move = true,
									combat = true,
									mouse = false,
								},
								anim = {
									dict = 'amb@world_human_musician@guitar@male@idle_a',
									clip = 'idle_b',
									flag = 1
								},
								prop = {
									model = `prop_acc_guitar_01`,
									pos = vec3(0.0, 0.0, 0.0),
									rot = vec3(0.0, 0.0, 0.0)
								},
							}) then  
								if jailTime > 1 then
									jailTime = jailTime - 1 
								end
								TriggerEvent('chatMessage', 'Junventus', { 255, 0, 0 }, "Thời gian phạt tù còn lại " .. jailTime .. " phút !")
								TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)
								ClearPedTasks(Ped)
							end
						end    
					end
				end

			end
		

		end
	end)

	--Prison Work--
	Citizen.CreateThread(function()
		while jailTime > 0 do
			Citizen.Wait(1000)
			-- local Ped = PlayerPedId()
			-- local PedCoords = GetEntityCoords(Ped)
			-- 	--local DistanceCheck = GetDistanceBetweenCoords(PedCoords, 1799.8345947266, 2489.1350097656, -119.02998352051, true)
			-- 	if #(PedCoords -vec3(1712.202148, 2562.527588, 52.296753)) > 210 then
			-- 		local JailPosition = Config.JailPositions["Cell"]
			-- 		SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
					
			-- 		--jailTime = jailTime + 10
			-- 		--TriggerEvent('chatMessage', 'Junventus', { 255, 0, 0 }, "Thời gian phạt tù còn lại " .. jailTime .. " phút !")
			-- 		TriggerServerEvent('nhatuVuotNguc')
					
			-- 	end

			Zone:onPlayerInOut(function(check)
				if not check and jailTime>0 then
					local JailPosition = Config.JailPositions["Cell"]
					SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
					--TriggerServerEvent('nhatuVuotNguc')
				end
			end)
		end
	end)
end


function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for p, v in pairs(Config.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 7.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] Mở Cửa", 0.4)

					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("Canceled!")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Đang đóng gói... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Đặt Gói Hàng", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					-- TriggerServerEvent("esx-qalle-jail:prisonWorkReward")
					jailTime = jailTime - 1 
					TriggerEvent('chatMessage', 'BỘ CÔNG AN', { 255, 0, 0 }, "Thời gian phạt tù còn lại " .. jailTime .. " phút !")
					TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)
				end
			end
		end

	end

end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Menu nhà tù",
			align    = 'center',
			elements = {
				{ label = "Đi tù", value = "jail_closest_player" },
				--{ label = "Thả tù", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Thời gian đi tù (phút)"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("Thời gian cần tính bằng phút!")
            	else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("Không có ai ở gần!")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Lý do đi tù"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("Bạn cần viết một thứ gì đó!")
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("Không có ai ở gần!")
								else
									-- exports["WaveShield"]:TriggerServerEvent("esx-qalle-jail:jailPlayer",GetPlayerServerId(closestPlayer), jailTime, reason)
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("Your jail is empty!")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Prisoner: " .. playerArray[i].name .. " | Jail Time: " .. playerArray[i].jailTime .. " minutes", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Unjail Player",
						align = "center",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)	
end

TriggerEvent('chat:addSuggestion', '/ditu', 'Đi tù', {
	{ name="id", help="Id người chơi" },
    { name="Time", help="Thời gian" },
    { name="Lý do", help="Lý do" }
})


TriggerEvent('chat:addSuggestion', '/thatu', 'Thả tù', {
	{ name="id", help="Id người chơi" },
})