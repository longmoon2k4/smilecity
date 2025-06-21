
-- local recoils = {
-- 	[416676503] = 0.34,
-- 	[-957766203] = 0.22,
-- 	[970310034] = 0.17,  
-- }

-- Citizen.CreateThread(function()
-- 	while true do 
--     Citizen.Wait(0)
--         local ply = PlayerPedId()
--         SetPedSuffersCriticalHits(ply, true)

--         if IsPedArmed(ply, 6) then
-- 			DisableControlAction(1, 140, true)
--             DisableControlAction(1, 141, true)
--             DisableControlAction(1, 142, true)
--             -- DisableControlAction(1, 21, true)
--         elseif IsPedArmed(ply, 1) then
--             N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.1)   
--         else
--             N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.35)
-- 		end
		
--         if IsPedShooting(ply) then      
--             local _,wep = GetCurrentPedWeapon(ply)
--             local _,cAmmo = GetAmmoInClip(ply, wep)
			
-- 		--	if hasar[wep] and hasar[wep] ~= 0 then
--               --  yenihasar = ((hasar[wep]/100)*25)/10
--                -- print(yenihasar)
-- 			--	N_0x4757f00bc6323cfe(wep, yenihasar)
-- 			--end
			
--             local GamePlayCam = GetFollowPedCamViewMode()
--             local Vehicled = IsPedInAnyVehicle(ply, false)
--             local MovementSpeed = math.ceil(GetEntitySpeed(ply))

--             if MovementSpeed > 69 then
--                 MovementSpeed = 69
--             end
--             Citizen.Wait(50)
--             local _,wep = GetCurrentPedWeapon(ply)
--             if wep ~= 126349499 then
--                 local group = GetWeapontypeGroup(wep)
--                 local p = GetGameplayCamRelativePitch()
--                 local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

--                 local recoil = math.random(100,140+MovementSpeed)/100
--                 local rifle = false

--                 if group == 970310034 then
--                     rifle = true
--                 end

--                 if cameraDistance < 3.3 then
--                     cameraDistance = 1.5
--                 else
--                     if cameraDistance < 6.0 then
--                         cameraDistance = 3.0
--                     else
--                         cameraDistance = 5.0
--                     end
--                 end

--                 if Vehicled then
--                     recoil = recoil + (recoil * cameraDistance)
--                 else
--                     recoil = recoil * 0.5
--                 end

--                 if GamePlayCam == 3 then
--                     recoil = recoil * 0.3
--                     if rifle then
--                         recoil = recoil * 0.4
--                     end
--                 end

--                 if rifle then
--                     recoil = recoil * 0.4
--                 end

--                 local rightleft = math.random(4)
--                 local h = GetGameplayCamRelativeHeading()
--                 local hf = math.random(10,20+MovementSpeed)/100

--                 if Vehicled then
--                     hf = hf * 2.0
--                 end

--                 if rightleft == 1 then
--                     SetGameplayCamRelativeHeading(h+hf)
--                 elseif rightleft == 2 then
--                     SetGameplayCamRelativeHeading(h-hf)
--                 end 
            
--                 local set = p+recoil

--                 SetGameplayCamRelativePitch(set,0.8)   
--             end 	       	
--         end
        
-- 	end
-- end)

-- --[[ DUMPED USING COMPOSER DEVIL ]]--