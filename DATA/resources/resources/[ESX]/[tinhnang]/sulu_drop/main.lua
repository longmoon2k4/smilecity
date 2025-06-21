--ESX = nil 
local toaDoDrop = nil
local spawnedObj = nil
local sleepTime = 1000
local looting = false
spawned = false
local pressed = false
-- Citizen.CreateThread(function()
-- 	Citizen.Wait(20000)
-- 	TriggerServerEvent('sulu_drop:syncDrop')
-- end)

RegisterNetEvent('sulu_drop:toaDo')
AddEventHandler('sulu_drop:toaDo', function(posX, posY)
	local coords = vector3(posX, posY, 30.00)
	CreateBlip(coords)
	CreateBlip2(coords)
	toaDoDrop = {
		x = posX,
		y = posY
	}
end)


RegisterNetEvent('sulu_drop:deleteDrop')
AddEventHandler('sulu_drop:deleteDrop', function()
	ESX.Game.DeleteObject(spawnedObj)
	spawnedObj = nil
	toaDoDrop = nil
	RemoveBlip(blip)
	RemoveBlip(blip2)
	spawned = false
end)
	
	

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(sleepTime)
		if toaDoDrop ~= nil then
			
			sleepTime = 1
			local ped =  PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local Distance = GetDistanceBetweenCoords(pedCoords, toaDoDrop.x, toaDoDrop.y, toaDoDrop.z, false)
			if Distance < 20 then
				if spawned == false then
					local hash = `xm_prop_rsply_crate04a`
					for height = 1, 1000, 1 do
						local foundGround, zPos = GetGroundZFor_3dCoord(toaDoDrop.x, toaDoDrop.y, height + 0.0)
						if foundGround then
							coords = vector3(toaDoDrop.x, toaDoDrop.y, zPos)
								
								ESX.Game.SpawnLocalObject(hash, coords, function(obj)
									PlaceObjectOnGroundProperly(obj)
									FreezeEntityPosition(obj, true)
									spawnedObj = obj
									spawned = true
								end)
							
							break
						end
						Citizen.Wait(5)
					end
				end
				ESX.Game.Utils.DrawText3D(coords, '~r~Nhấn [E] để mở rương', 1, ESX.FontId)
				if Distance < 2 and pressed == false then
					if IsControlJustReleased(0, 38) then
						if not IsPedInAnyVehicle(PlayerPedId(),true) then
							pressed = true
							SetTimeout(10000, delaypress)
							ESX.TriggerServerCallback('sulu_drop:isLooting', function(cb)
								if cb == false then
									looting = true
									if lib.progressBar({
										duration =  60000,
										label = 'đang loot',
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
										TriggerServerEvent('sulu_drop:daLoot')
											-- ESX.Game.DeleteObject(spawnedObj)
											sleepTime = 500
											looting = false
									else
										looting = false
										TriggerServerEvent('sulu_drop:stopLoot')
									end
								end
							end)
						end
					end
				end
			end
		end
	end
end)


function delaypress()
	if pressed == true then
		pressed = false
	end
end
