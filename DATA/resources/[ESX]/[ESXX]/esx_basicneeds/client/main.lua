--ESX          = nil
local IsDead = false
local IsAnimated = false

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

AddEventHandler('esx_basicneeds:resetStatus', function()
    IsDead = false
	TriggerEvent('esx_status:set', 'hunger', 250000)
	TriggerEvent('esx_status:set', 'thirst', 250000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()

	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	local playerPed = PlayerPedId()
	SetEntityHealth(  playerPed, GetEntityMaxHealth(playerPed))
end)
RegisterCommand('doi', function(source, args, showError)
	TriggerEvent('esx_status:set', 'hunger', 0)
	TriggerEvent('esx_status:set', 'thirst', 0)

	local playerPed = PlayerPedId()
	SetEntityHealth(  playerPed, GetEntityMaxHealth(playerPed))
end)
AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

-- AddEventHandler('esx:playerLoaded', function(spawn)
-- 	if IsDead then
-- 		TriggerEvent('esx_basicneeds:resetStatus')
-- 	end

-- 	IsDead = false
-- end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return true
	end, function(status)
		status.remove(5555)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return true
	end, function(status)
		status.remove(5555)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(2000)
			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				TriggerEvent('esx_ecologica:updateBasics', 'hunger', status.val / 30000)
				if status.val == 0 then
                    if not IsDead then
                        ESX.ShowNotification('🚫 Bạn đang đói')
                        if prevHealth <= 150 then
                            health = health - 10
                        else
                            health = health - 5
                        end
                    end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				TriggerEvent('esx_ecologica:updateBasics', 'thirst', status.val / 30000)
				if status.val == 0 then
                    if not IsDead then
                        ESX.ShowNotification('🚫 Bạn đang khát nước')
                        if prevHealth <= 150 then
                            health = health - 10
                        else
                            health = health - 5
                        end
                    end
				end
			end)

			if health ~= prevHealth then
				if health <= 107 then
					TriggerEvent('esx_ambulancejob:kill')
				else
					SetEntityHealth(playerPed, health)
				end
			end
		end
	end)
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(  prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(  prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
				EnableControlAction(0, 32, true) -- w
				EnableControlAction(0, 34, true) -- a
				EnableControlAction(0, 8, true) -- s
				EnableControlAction(0, 9, true) -- d
				EnableControlAction(0, 22, true) -- space
				EnableControlAction(0, 36, true) -- ctrl
				EnableControlAction(0, 21, true) -- SHIFT

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)
	end
end)

