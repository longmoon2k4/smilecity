-- ESX = nil
-- TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)


---------------------------------------------------------Chỉ Tay---------------------------------------------------------
local isPoint = false

local mp_pointing = false
local keyPressed = false
local passengerDriveBy = true
local once = true
local oldval = false
local oldvalped = false


----------------------------------------------------------Đè F xuống xe--------------------------
RestrictEmer = false -- Only allow this feature for emergency vehicles.
keepDoorOpen = true -- Keep the door open when getting out.

Citizen.CreateThread(function()
    while true do 
        local time = 1000
        local ped = cache.ped
        if cache.vehicle then
            time = 1
            if IsControlPressed(2, 75) and not IsEntityDead(ped) then
                Citizen.Wait(150)
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    local veh = GetVehiclePedIsIn(ped, false)
                    SetVehicleEngineOn(veh, true, true, false)
                    if keepDoorOpen then
                        TaskLeaveVehicle(ped, veh, 256)
                    else
                        TaskLeaveVehicle(ped, veh, 0)
                    end
                end
            end
        end
       Citizen.Wait(time)
	end
end)


--------------------------------------------------------TẮT Dịch Vụ NPC--------------------------------------------------

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0) -- prevent crashing

-- 		-- These natives have to be called every frame.
-- 		SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
-- 		SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
-- 		SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
-- 		SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
-- 		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
-- 		SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
-- 		SetRandomBoats(false) -- Stop random boats from spawning in the water.
-- 		SetCreateRandomCops(false) -- disable random cops walking/driving around.
-- 		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
-- 		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
		
-- 		local x,y,z = table.unpack(GetEntityCoords(cache.ped))
-- 		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
-- 	end
-- end)

-----------------------------------------------------------------Lagxac-------------------------------------------------------
-- local timeLagxac = 0
-- RegisterCommand('lagxac', function(source, args, user)
--     --if timeLagxac < 1 then
--         local ped = cache.ped
--         if IsPedDeadOrDying(ped,true) then 
--             ClearPedTasksImmediately(ped)
--             ApplyForceToEntity(ped, 1, 100, 100, 500.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
--            --- timeLagxac = 5
--                                 --chiều ngang - chiều cao
--                                 -- ngang 1000
--                                                 -- cao 1000
--                                         --nếu thấy bay lên mà ra xa quá thì chỉnh ngang = 0.0
--         else
--             TriggerEvent('esx_showNotifiCation', "Bạn phải chết để lag xác!")
--         end	
--    -- end													
-- end)

-- Citizen.CreateThread(function()
--     while true do 
--         Citizen.Wait(1000)
--         if timeLagxac >= 1 then
--             timeLagxac = timeLagxac - 1
--         end
--     end
-- end)
-------------------------------------------------------------Lên máy bay có dù---------------------------------------------------

AddEventHandler('gameEventTriggered', function (name, args)
    if name == 'CEventNetworkPlayerEnteredVehicle' then 
        local playerPed = cache.ped
        if IsPedInAnyHeli(playerPed) or IsPedInAnyPlane(playerPed) then
            GiveWeaponToPed(playerPed, GetHashKey("GADGET_PARACHUTE"), true)
        end
        ----------------------bắn súng trên xe-------------
        local car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed and not GetVehicleClass(car) == 8 then
				SetPlayerCanDoDriveBy(playerPed, false)
			elseif passengerDriveBy then
				SetPlayerCanDoDriveBy(playerPed, true)
			else
				SetPlayerCanDoDriveBy(playerPed, false)
			end
		end
    end
end)

--Citizen.CreateThread(function()
--    while true do 
--        local time = 5000
--       local playerPed = cache.ped
--        if IsPedInAnyHeli(playerPed) or IsPedInAnyPlane(playerPed) then
--            GiveWeaponToPed(cache.ped, GetHashKey("GADGET_PARACHUTE"), true)
--            time = 1
--        end
--        Citizen.Wait(time)
--    end
--end)
------------------------------------------------------------Khỏi Hồi Lại Máu----------------------------------------------------------------------
Citizen.CreateThread(function()
    SetPlayerTargetingMode(2) ---khoa tay cam
    while true do
        Citizen.Wait(1000)
        SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
   end
end)


-----------------------Chạy không mệt------------------
Citizen.CreateThread(function()
    while true do
      RestorePlayerStamina(cache.playerId, 1.0)
      Citizen.Wait(15000) -- 15 seconds
    end
  end)

-----------------------------------------------------------------------------------------------------------------------------------------------------
-- Set vehicle dirt level (called from server)
-----------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setDirt')
AddEventHandler('setDirt', function(vehicle, dirtLevel)	
	
	SetVehicleDirtLevel(vehicle, dirtLevel)

end )


---------------------- dang đi khi hết máu -------------
-- local hurt = false
-- Citizen.CreateThread(function()
--     while true do
--        time = 1000
--         if GetEntityHealth(cache.ped) <= 144 then
--             time = 1
--             setHurt()
--         elseif hurt and GetEntityHealth(cache.ped) > 145 then
--             time = 1
--             setNotHurt()
--         end
--         Citizen.Wait(time)
--     end
-- end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(cache.ped, "move_m@injured", true)
end

function setNotHurt()
    hurt = false
    ResetPedMovementClipset(cache.ped)
    ResetPedWeaponMovementClipset(cache.ped)
    ResetPedStrafeClipset(cache.ped)
end


-----------tat npc police-------------
Citizen.CreateThread(function()
    for i = 1, 15 do
        EnableDispatchService(i, false)
    end

    SetMaxWantedLevel(0)
end)



RegisterNetEvent('fps:openfps') 
AddEventHandler('fps:openfps', function()
    OpenFPSMenu()
end)


function OpenFPSMenu() 

    local elements = {
		  {label = 'FPS ON',		value = 'fps'},	   
    --   {label = 'Pack Grafico',		value = 'fps3'},	       
    --   {label = 'Luces Mejoradas',		value = 'fps2'},               
		  {label = 'FPS OFF',		value = 'fps1'},									          
        }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'Menu FPS',
        align    = 'bottom-right',
        elements = elements
        },
            function(data2, menu2)
              if data2.current.value == 'fps' then
                SetTimecycleModifier('yell_tunnel_nodirect')
             elseif data2.current.value == 'fps1' then
                SetTimecycleModifier()
                ClearTimecycleModifier()
                ClearExtraTimecycleModifier()
              elseif data2.current.value == 'fps2' then
                SetTimecycleModifier('tunnel') 
              elseif data2.current.value == 'fps3' then
                SetTimecycleModifier('MP_Powerplay_blend')
                 SetExtraTimecycleModifier('reflection_correct_ambient')    
              end
            end,
      function(data2, menu2)
        menu2.close()
      end
    )
  
  end

  
  local tanghinh = false
  RegisterNetEvent('tanghinh') 
  AddEventHandler('tanghinh', function()
      tanghinh = not tanghinh
      local ped = cache.ped
      if tanghinh then -- activé
          SetEntityInvincible(ped, true)
          SetEntityVisible(ped, false, false)
      else -- désactivé
          SetEntityInvincible(ped, false)
          SetEntityVisible(ped, true, false)
    end
  end)

  Citizen.CreateThread(function()
    if GetPedMaxHealth(ped) ~= 200 and not IsEntityDead(ped) then
		SetPedMaxHealth(ped, 200)
		SetEntityHealth(ped, GetEntityHealth(ped) + 25)
	end
    for i = 100,1,-1  do
        SetPedConfigFlag(PlayerPedId(), 438, true)
        Citizen.Wait(1000)
    end
  end)

AddEventHandler("playerSpawned", function()
	local ped = cache.ped
    SetPedConfigFlag(PlayerPedId(), 438, true)
	if GetPedMaxHealth(ped) ~= 200 and not IsEntityDead(ped) then
		SetPedMaxHealth(ped, 200)
		SetEntityHealth(ped, GetEntityHealth(ped) + 25)
	end
end)

Citizen.CreateThread(function()
    while true do
        -- local time = 1000
	    local ped = cache.ped
        DisableControlAction( 0, 36, true ) -- INPUT_DUCK  
        if IsPedArmed(ped, 6) then
            
	        DisableControlAction(0, 140, true)
       	    DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
        end
        Citizen.Wait(1)
    end
end)

------------gioi han xe 400--------
Citizen.CreateThread( function()
    local speed = 310 / 3.6
	while true do 
		Citizen.Wait( 0 )   
		if IsPedInAnyVehicle(cache.ped,true) then
			SetEntityMaxSpeed(GetVehiclePedIsIn(cache.ped, false), speed)
        else
            Citizen.Wait(5000)
	    end
    end
end)

--------------tat het am thanh coi xe, bla bla
Citizen.CreateThread(function()

    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
end)

-------giam delay nhao lon--------
local Cooldown = 130

-- Set player stats
local a = {
	'MP0_STAMINA',
	'MP0_STRENGTH',
	'MP0_LUNG_CAPACITY',
	'MP0_WHEELIE_ABILITY',
	'MP0_FLYING_ABILITY',
	'MP0_SHOOTING_ABILITY',
	'MP0_STEALTH_ABILITY'
}

Citizen.CreateThread( function()
    for _, s in ipairs(a) do
        StatSetInt(s, Cooldown, true)
    end
end)

RegisterCommand('testtanghinh', function()
    print(GetEntityHealth(cache.ped))
 end,false)

 RegisterCommand('lagbalo', function()
    exports.ox_inventory:closeInventory()
end,false)

local neo = lib.addKeybind({
    name = 'thaneo',
    description = 'Tha neo',
    defaultKey = 'K',
    onPressed = function(self)
        if IsPedInAnyBoat(cache.ped,true) and cache.seat==-1 then
            local freeze = not IsEntityPositionFrozen(cache.vehicle)
            FreezeEntityPosition(cache.vehicle, freeze)
        end
    end,
    --onReleased = function(self)
    --    k = false
    --end
})

exports.ox_inventory:displayMetadata({
    resource = 'Nguồn',
    registered = 'Người tạo ra',
    time = 'Thời gian',
})