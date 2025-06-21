function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(100)
	end
end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		if IsControlJustPressed(1, Keys['K']) and IsControlPressed(1, Keys['LEFTSHIFT']) then
--             local ped = cache.ped
--            if not IsPedInAnyVehicle(ped,true) then
--                if ( DoesEntityExist( ped ) and not IsEntityDead( ped )) then 
--                    loadAnimDict( "random@arrests" )
--                    loadAnimDict( "random@arrests@busted" )
--                    if ( IsEntityPlayingAnim( ped, "random@arrests@busted", "idle_a", 3 ) ) then 
--                        TaskPlayAnim( ped, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
--                        Wait (3000)
--                        TaskPlayAnim( ped, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
--                    else
--                        TaskPlayAnim( ped, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
--                        Wait (4000)
--                        TaskPlayAnim( ped, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
--                        Wait (500)
--                        TaskPlayAnim( ped, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
--                        Wait (1000)
--                        TaskPlayAnim( ped, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
--                    end     
--                end
--            end
-- 		end
      
-- 	end
-- end)
-- local k = false

local keybindK = lib.addKeybind({
    name = 'shiftk_k',
    description = 'K',
    defaultKey = 'K',
    onPressed = function(self)
        if not IsPedInAnyVehicle(cache.ped,true) and k == true then
            local ped = cache.ped
            if DoesEntityExist( ped ) then 
                loadAnimDict( "random@arrests" )
                loadAnimDict( "random@arrests@busted" )
                if ( IsEntityPlayingAnim( ped, "random@arrests@busted", "idle_a", 3 ) ) then 
                    TaskPlayAnim( ped, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                    Wait (3000)
                    TaskPlayAnim(ped, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
                else
                    TaskPlayAnim( ped, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                    Wait (4000)
                    TaskPlayAnim( ped, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                    Wait (500)
                    TaskPlayAnim( ped, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                    Wait (1000)
                    TaskPlayAnim( ped, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
                end     
            end
        end
    end,
    --onReleased = function(self)
    --    k = false
    --end
})

local keybindShift = lib.addKeybind({
    name = 'shiftk_shift',
    description = 'Shift',
    defaultKey = 'LSHIFT',
    onPressed = function(self)
        k = true
        
    end,
    onReleased = function(self)
        k = false
    end
})

local crouched = false

-- Citizen.CreateThread( function()
--    while true do 
--        Citizen.Wait( 1 )
--        local ped = cache.ped
--        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
--            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

--            if ( not IsPauseMenuActive() ) then 
--                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
--                    RequestAnimSet( "move_ped_crouched" )

--                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
--                        Citizen.Wait( 100 )
--                    end 
--                    if ( crouched == true ) then 
--                        ResetPedMovementClipset( ped, 0 )
--                        crouched = false 
--                    elseif ( crouched == false ) then
--                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
--                        crouched = true 
--                    end 
--                end
--            end 
--        end 
--    end
-- end )


local crouchedBind = lib.addKeybind({
    name = 'ngoi',
    description = 'croucher',
    defaultKey = 'LCONTROL',
    onPressed = function(self)
        if cache.vehicle == false then
            local ped = cache.ped
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
                --DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

                if ( not IsPauseMenuActive() ) then 
                    --if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                        RequestAnimSet( "move_ped_crouched" )

                        while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                            Citizen.Wait( 100 )
                        end 
                        if ( crouched == true ) then 
                            ResetPedMovementClipset( ped, 0 )
                            crouched = false 
                        elseif ( crouched == false ) then
                            SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                            crouched = true 
                        end 
                    --end
                end 
            end 
        end
    end,
    --onReleased = function(self)
    --    k = false
    --end
})

