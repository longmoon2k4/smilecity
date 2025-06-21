-- ESX                     = nil
-- Citizen.CreateThread(function()
--   while ESX == nil do
--     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 	Citizen.Wait(60000)

--   end
-- end)

isBusy = false

local count = 0
-- Citizen.CreateThread(function()
--   while true do
--     Wait(1000)
--     count = count - 1
--   end
-- end)

-- RegisterCommand("reloadskin",function()
-- 	if count <= 0 then
-- 		isBusy = true
-- 		ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)

-- 			local pedModel = appearance.ped
-- 			local pedComponents = appearance.components
-- 			local pedProps = appearance.props
-- 			local playerPed = PlayerPedId()
-- 			-- exports['fivem-appearance']:setPlayerAppearance(appearance)
-- 			exports['fivem-appearance']:setPedProps(playerPed, pedProps)
-- 			exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
-- 		end)
-- 		isBusy = false
-- 		count = 5
--   	else
-- 		TriggerEvent("dopeNotify:SendNotification",{
-- 			text = 'Hệ Thống</span></b></br><span style="color: red;"> chờ '..count..' để thay quần áo <span style="color: #ffffff;">!',
-- 			type = "error",
-- 			timeout = 3000,
-- 			layout = "centerRight",
-- 		})
--   	end
-- end)
-- function OpenActionMenuInteraction(target)
-- 	local elements = {}
-- 	table.insert(elements, {label = ('Mặc Lại Quần Áo'), value = 'ubie'})
--   		ESX.UI.Menu.CloseAll()	
-- 	ESX.UI.Menu.Open(
-- 		'default', GetCurrentResourceName(), 'action_menu',
-- 		{
-- 			title    = ('Clothes'),
-- 			align    = 'bottom-right',
-- 			elements = elements
-- 		},
--     function(data, menu)
-- 		if data.current.value == 'ubie' then			
-- 			if count <= 0 then
--                 ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)

--                     local pedModel = appearance.ped
--                     local pedComponents = appearance.components
--                     local pedProps = appearance.props
--                     local playerPed = PlayerPedId()
--                     -- exports['fivem-appearance']:setPlayerAppearance(appearance)
--                     exports['fivem-appearance']:setPedProps(playerPed, pedProps)
--                     exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
--                 end)
-- 				count = 5
-- 			else
-- 			--   TriggerEvent("dopeNotify:SendNotification",{
-- 			-- 	  text = 'Hệ Thống</span></b></br><span style="color: red;"> chờ '..count..' để thay quần áo <span style="color: #ffffff;">!',
-- 			-- 	  type = "error",
-- 			-- 	  timeout = 3000,
-- 			-- 	  layout = "centerRight",
-- 			--   })
-- 			end
-- 			ESX.UI.Menu.CloseAll()	
-- 	elseif data.current.value == 'mu' then
-- 		TriggerEvent('smerfikubrania:mu')
-- 		ESX.UI.Menu.CloseAll()
-- 		elseif data.current.value == 'tul' then
-- 		TriggerEvent('smerfikubrania:koszulka')
-- 		ESX.UI.Menu.CloseAll()	
-- 		elseif data.current.value == 'spo' then
-- 		TriggerEvent('smerfikubrania:spodnie')
-- 		ESX.UI.Menu.CloseAll()	
-- 		elseif data.current.value == 'but' then
-- 		TriggerEvent('smerfikubrania:buty')
-- 		ESX.UI.Menu.CloseAll()	
-- 	  end
-- 	end)
-- end


-- AddEventHandler('son:thaydo', function()
-- 	OpenActionMenuInteraction()
-- end)

-- Citizen.CreateThread(function()
--   while true do
--     Citizen.Wait(0)
--     if IsControlJustReleased(0,246) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
-- 		OpenActionMenuInteraction()
--     end
--   end
-- end)

local crouched = false
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )
        local ped = GetPlayerPed( -1 )
        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
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
                end
            end 
        end 
    end
end )


-- RegisterCommand('croucher', function()

--     if DoesEntityExist(cache.ped) and not IsEntityDead(cache.ped) then 

--         DisableControlAction( 0, 36, true )
--         if not IsPauseMenuActive() then 
--             if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
--                 RequestAnimSet( "move_ped_crouched" )
--                 while not HasAnimSetLoaded("move_ped_crouched") do 
--                     Citizen.Wait(100)
--                 end 
--                 if isCroucher then 
--                     ResetPedMovementClipset(cache.ped, 0)
--                     isCroucher = false 
--                 elseif ( crouched == false ) then
--                     SetPedMovementClipset(cache.ped, "move_ped_crouched", 0.25)
--                     isCroucher = true 
--                 end 
--             end
--         end 
--     end
-- end, false)

-- RegisterKeyMapping('croucher', 'Ngoi', 'keyboard', 'LCONTROL')



-- RegisterCommand("quanao",function()
-- 	OpenActionMenuInteraction()
-- end)