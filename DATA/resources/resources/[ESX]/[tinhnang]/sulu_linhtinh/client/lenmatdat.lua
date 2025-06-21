---------------------------------------------------------- GROUND PLAYER BY HQLY DEVELOPMENT ---------------------------------------------
local time = 1000
Citizen.CreateThread(function()
	Citizen.Wait(1000)
	
	while true do
		-- lấy thông tin chi tiết
        time = 1000
		_ped = cache.ped
		-- kiểm tra xem người chơi đã chết hay không còn tồn tại
		if IsEntityDead(_ped) or not DoesEntityExist(_ped) then
			Citizen.Wait(1000) -- delay it a bit to optimize a little bit
			goto m_next
		end
		
		_coords = GetEntityCoords(_ped)
		_, z = GetGroundZFor_3dCoord(_coords.x, _coords.y, 150.0, 0) -- bắt đầu từ 150.0 tại Z vì nó hoạt động theo chiều hướng lên, nhưng không hoạt động theo chiều hướng xuống
		-- ped có thấp hơn tọa độ z mà chúng tôi muốn xem xét không
		if _coords.z < config.z_check then
            time = 1
			-- kiểm tra cờ cho mỗi tệp cấu hình cho: ped đang bơi / rơi / bên trong
			local flag_swimming, flag_falling, flag_inside = true, true, true
			if config.check_swimming and (IsPedSwimming(_ped) or IsPedSwimmingUnderWater(_ped)) then
				flag_swimming = false
			end
			if config.check_falling and not IsPedFalling(_ped) then
				flag_falling = false
			end
			if config.check_inside and not IsPedFalling(_ped) and z > _coords.z then 
				flag_inside = false
			end
			
			-- hiển thị lời nhắc kích hoạt
			if flag_falling and flag_swimming and flag_inside then
				drawTxt2(config.displayText, 0, 1, 0.5, 0.8, 0.4, 128, 128, 128, 255)
			end
			if IsControlJustReleased(0, config.key) and (flag_falling and flag_swimming and flag_inside) then
				ClearPedTasksImmediately(_ped)
				-- có dịch chuyển người chơi xuống mặt đất hoặc vị trí xác định trước hay không
				if config.preset then
					SetEntityCoords(_ped, config.coords.x, config.coords.y, config.coords.z, true, false, false, false)
				else
					SetEntityCoords(_ped, _coords.x, _coords.y, z + 1.0, true, false, false, false) -- +1.0 on Z to compensate for _ped height
				end
				-- đóng băng trình phát trong x giây cho mỗi tệp cấu hình
				if config.freeze then
					Citizen.CreateThread(function()
						FreezeEntityPosition(_ped, true)
						local timer = config.freeze_time
						while timer > 0 do
							timer = timer - 1
							Citizen.Wait(1000)
						end
						FreezeEntityPosition(_ped, false)
					end)
				end
			end
		end
		
		::m_next::
		Citizen.Wait(time)
	end
end)

function drawTxt2(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(1)
	SetTextScale(0.0, 0.3)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end


-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------Made by PERP Gamer AKA Tyler--------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
------Config-------
DisableBikeWings = true --Change to false if you would like to deploy the wings on like the oppressor
DisableVehicleRocket = true --Change to false if you would like to turn on the vehicle rocket boost
DisableVehicleJump = true --Change to false if would like to turn on vehicle jump
DisableVehicleTransform = true --Change to false if you would like to enable vehicle transform
DisableVehicleWeapons = true --Change to false if you would like to enable vehicle weapons
----END OF CONFIG---

Citizen.CreateThread(function()
	while true do
		local time =1000
		local playerped = GetPlayerPed(-1)		
		if cache.vehicle then	
			time = 1
			if DisableBikeWings then
				DisableControlAction(0, 354, true)
			end
			if DisableVehicleRocket then
				DisableControlAction(0, 351, true)
			end
			if DisableVehicleJump then
				DisableControlAction(0, 350, true)
			end
			if DisableVehicleTransform then
				DisableControlAction(0, 357, true)
			end
			
			local veh = GetVehiclePedIsUsing(playerped)
			if DoesVehicleHaveWeapons(veh) == 1 and DisableVehicleWeapons and vehicleweaponhash ~= 1422046295 then
				vehicleweapon, vehicleweaponhash = GetCurrentPedVehicleWeapon(playerped)
				if vehicleweapon == 1 then
					DisableVehicleWeapon(true, vehicleweaponhash, veh, playerped)
					SetCurrentPedWeapon(playerped, GetHashKey("weapon_unarmed"))
				end
			end	
		end
		Citizen.Wait(time)
	end
end)
