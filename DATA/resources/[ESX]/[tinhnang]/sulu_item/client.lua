local binoculars = false

RegisterNetEvent('sulu_item:armor')
AddEventHandler('sulu_item:armor', function()
    local ped = PlayerPedId()
   TriggerEvent('ox_inventory:busy',true)
    if IsPedInAnyVehicle(PlayerPedId()) then
            TriggerEvent(
                "mythic_progbar:client:progress",
                {
                    name = "giapnang",
                    duration = 5000,
                    label = "Đang Mặc Giáp...",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    --animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"}
                -- prop = {model = "prop_bodyarmour_02"}
                },
                function(status)
                    if not status then
                        SetPedComponentVariation(ped, 9, 11, 1, 0)
                    -- AddArmourToPed(ped, 100)
                    SetPedArmour(ped, 100)
                    TriggerEvent('ox_inventory:busy',false)
                    end
                end
            )
      
    else
      
            TriggerEvent(
                "mythic_progbar:client:progress",
                {
                    name = "giapnang",
                    duration = 5000,
                    label = "Đang Mặc Giáp...",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"}
                -- prop = {model = "prop_bodyarmour_02"}
                },
                function(status)
                    if not status then
                        SetPedComponentVariation(ped, 9, 11, 1, 0)
                    -- AddArmourToPed(ped, 100)
                    SetPedArmour(ped, 100)
                    TriggerEvent('ox_inventory:busy',false)
                    end
                end
            )
       
    end

end)

RegisterNetEvent('sulu_item:armorpolice')
AddEventHandler('sulu_item:armorpolice', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPedId()) then
            TriggerEvent(
                "mythic_progbar:client:progress",
                {
                    name = "giapnang",
                    duration = 5000,
                    label = "Đang Mặc Giáp...",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    --animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"}
                -- prop = {model = "prop_bodyarmour_02"}
                },
                function(status)
                    if not status then
                        SetPedComponentVariation(ped, 9, 11, 1, 0)
                    -- AddArmourToPed(ped, 100)
                    SetPedArmour(ped, 100)
                    end
                end
            )
      
    else
      
            TriggerEvent(
                "mythic_progbar:client:progress",
                {
                    name = "giapnang",
                    duration = 5000,
                    label = "Đang Mặc Giáp...",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"}
                -- prop = {model = "prop_bodyarmour_02"}
                },
                function(status)
                    if not status then
                        SetPedComponentVariation(ped, 9, 11, 1, 0)
                    -- AddArmourToPed(ped, 100)
                    SetPedArmour(ped, 100)
                    end
                end
            )
       
    end

end)


RegisterNetEvent('sulu_item:bandage')
AddEventHandler('sulu_item:bandage', function()
    local ped =PlayerPedId()
    local health = GetEntityHealth(ped)
    local maxHealth = GetEntityMaxHealth(ped)
    local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 7))
    if IsPedInAnyVehicle(PlayerPedId()) then
        TriggerEvent(
            "mythic_progbar:client:progress",
            {
                name = "hoimau",
                duration = 5000,
                label = "Đang hồi máu...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                },
               -- animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"}
                
            },
            function(status)
                if not status then
                    SetEntityHealth(ped, newHealth)
                end
            end
        )
    else
        TriggerEvent(
            "mythic_progbar:client:progress",
            {
                name = "hoimau",
                duration = 5000,
                label = "Đang hồi máu...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {animDict = "rcmfanatic3", anim = "kneel_idle_a"}
                
            },
            function(status)
                if not status then
                    SetEntityHealth(ped, newHealth)
                end
            end
        )
    end

    
end)

-- Start of Binoculars
local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0
local binoculars = false
local fov = (fov_max+fov_min)*0.5

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)

	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
	HideHudComponentThisFrame(19) -- weapon wheel
end

function HandleZoom(cam)
	local playerPed = GetPlayerPed(-1)

	if not (IsPedSittingInAnyVehicle(playerPed)) then
		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end

		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end

		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end

		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end

		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
		end

		local current_fov = GetCamFov(cam)

		if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end

		SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(playerPed)

		if binoculars then
			binoculars = true
			if not (IsPedSittingInAnyVehicle(playerPed)) then
				Citizen.CreateThread(function()
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BINOCULARS", 0, 1)
					PlayAmbientSpeech1(GetPlayerPed(-1), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
				end)
			end

			Wait(2000)

			-- SetTimecycleModifier("default")
			-- SetTimecycleModifierStrength(0.3)

			local scaleform = RequestScaleformMovie("BINOCULARS")

			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end

			local playerPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(playerPed)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, playerPed, 0.0,0.0,1.0, true)
			SetCamRot(cam, 0.0,0.0,GetEntityHeading(playerPed))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			while binoculars and not IsEntityDead(playerPed) and (GetVehiclePedIsIn(playerPed) == vehicle) and true do
				if IsControlJustPressed(0, 322) then -- Toggle binoculars
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					ClearPedTasks(GetPlayerPed(-1))
					binoculars = false
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam, zoomvalue)

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				Citizen.Wait(5)
			end

			binoculars = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
        else
            Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('sulu_item:binoculars')
AddEventHandler('sulu_item:binoculars', function()
	binoculars = not binoculars
end)

-- Start of Oxygen Mask
RegisterNetEvent('sulu_item:oxygenmask')
AddEventHandler('sulu_item:oxygenmask', function()
	local playerPed = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)
	local boneIndex = GetPedBoneIndex(playerPed, 12844)

	SetPedDiesInWater(playerPed, false)
	
	ESX.ShowNotification("bạn đã sử dụng ~y~1x~s~ ~b~mặt nạ oxy~s~")
	Citizen.Wait(50000)
	ESX.ShowNotification('Còn lại  ~b~oxygen~y~ 50%~w~')
	Citizen.Wait(25000)
	ESX.ShowNotification('Còn lại  ~b~oxygen~y~ 25%~w~')
	Citizen.Wait(25000)
	ESX.ShowNotification('Còn lại  ~b~oxygen~y~ 0%~w~')
	SetPedDiesInWater(playerPed, true)
	ClearPedSecondaryTask(playerPed)

end)

RegisterNetEvent('sulu_item:latxe')
AddEventHandler('sulu_item:latxe', function()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)
    VehicleData = ESX.Game.GetClosestVehicle()
    local dist = #(pedcoords - GetEntityCoords(VehicleData))
    if dist <= 3  and IsVehicleOnAllWheels(VehicleData) == false then
        local carCoords = GetEntityRotation(VehicleData, 2)
        SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
        SetVehicleOnGroundProperly(VehicleData)
    end
end)

local baloCheck=false
RegisterNetEvent('sulu_item:balo')
AddEventHandler('sulu_item:balo', function()
    baloCheck = not baloCheck
    TriggerServerEvent('sulu_item:balo')
end)

RegisterNetEvent('sulu_item:checkBalo')
AddEventHandler('sulu_item:checkBalo', function()
    if baloCheck then 
        TriggerServerEvent('sulu_item:checkBalo')
    end
end)

RegisterNetEvent('sulu_item:refreshBalo')
AddEventHandler('sulu_item:refreshBalo', function(check)
    baloCheck=check 
end)

RegisterNetEvent('sulu_item:thetp')
AddEventHandler('sulu_item:thetp', function() 
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
    {
        title = 'menutele',
        align = 'bottom-right',
        elements = {
            {label = "gara trung tâm", value = '1'},
            {label = "gara sa mạc", value = '2'},
            {label = "gara 9 giờ", value = '3'},
            {label = "gara nấu đá", value = '4'},
            {label = "gara 12 giờ", value = '5'},
            {label = "gara máy bay sa mạc", value = '6'},
            {label = "gara máy ảnh", value = '7'},
            {label = "gara máy bay coca", value = '8'},
            {label = "gara máy bay thành phố", value = '9'},
        }
    }, function(data, menu)
        menu.close()
        if data.current.value == '1' then 
            SetEntityCoords(PlayerPedId(),215.670334, -809.828552, 30.728882, false, false, false, false)
        elseif data.current.value == '2' then
            SetEntityCoords(PlayerPedId(),1737.151611, 3712.364746, 34.115723, false, false, false, false)
        elseif data.current.value == '3' then
            SetEntityCoords(PlayerPedId(),-3154.839600, 1089.296753, 20.703247, false, false, false, false)
        elseif data.current.value == '4' then
            SetEntityCoords(PlayerPedId(),923.696716, -1564.628540, 30.712036, false, false, false, false)
        elseif data.current.value == '5' then
            SetEntityCoords(PlayerPedId(),105.349457, 6613.582520, 32.397095, false, false, false, false)
        elseif data.current.value == '6' then
            SetEntityCoords(PlayerPedId(),1715.617554, 3261.850586, 41.125244, false, false, false, false)
        elseif data.current.value == '7' then
            SetEntityCoords(PlayerPedId(),-1513.173584, -437.182404, 35.430054, false, false, false, false)
        elseif data.current.value == '8' then
            SetEntityCoords(PlayerPedId(),2132.940674, 4814.927246, 41.192627, false, false, false, false)
        elseif data.current.value == '9' then
            SetEntityCoords(PlayerPedId(),-1278.923096, -3378.738525, 13.929688, false, false, false, false)
            
        end

    end, function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('sulu_item:loadBalo')
  end)

local upgrades = 
    {
        modEngine = 3,
        modBrakes = 2,
        modTransmission = 2,
        modSuspension = 3,
        modArmor = true,
        windowTint = 1,
        modTurbo = 1,
    }


  RegisterNetEvent('sulu_item:thespamxe')
AddEventHandler('sulu_item:thespamxe', function(model)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	local playerHeading = GetEntityHeading(playerPed)


    ESX.Game.SpawnVehicle(model, {
        x = playerCoords.x,
        y = playerCoords.y,
        z = playerCoords.z
    }, playerHeading, function(cbVeh)
        ESX.Game.SetVehicleProperties(cbVeh, upgrades)
        SetVehRadioStation(cbVeh, "OFF")
        TaskWarpPedIntoVehicle(playerPed, cbVeh, -1)
        SetVehicleFuelLevel(cbVeh, 100 + 0.0)
       
        --SetVehicleEngineHealth(callback_vehicle, vehicle.engineHealth + 0.0)
        SetVehicleEngineHealth(cbVeh, 1000.0)
        SetVehicleBodyHealth(cbVeh, 1000.0)
    end)
end)

