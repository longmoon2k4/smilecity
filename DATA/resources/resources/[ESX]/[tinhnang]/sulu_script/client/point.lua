local function startPointing()
    if IsPedArmed(cache.ped,4) or IsPedArmed(cache.ped, 1) then
        SetCurrentPedWeapon(cache.ped, GetHashKey('WEAPON_UNARMED'), true)
    end
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(cache.ped, 0, 1, 1, 1)
    SetPedConfigFlag(cache.ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, cache.ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    if IsPedArmed(cache.ped, 4) or IsPedArmed(cache.ped, 1) then
        SetCurrentPedWeapon(cache.ped, GetHashKey('WEAPON_UNARMED'), true)
    end
    Citizen.InvokeNative(0xD01015C7316AE176, cache.ped, "Stop")
    if not IsPedInjured(cache.ped) then
        ClearPedSecondaryTask(cache.ped)
    end
    if not IsPedInAnyVehicle(cache.ped, 1) then
        SetPedCurrentWeaponVisible(cache.ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(cache.ped, 36, 0)
    ClearPedSecondaryTask(cache.ped)
end


RegisterCommand('actionPoint', function() 
    isPoint = not isPoint

    if isPoint then
        startPointing()
    else
        stopPointing()
    end
end)

RegisterKeyMapping('actionPoint', 'Hanh Dong Chi tay', 'keyboard', 'b')

Citizen.CreateThread(function()

    while true do
        local sleep = 1000
        if isPoint then
            local ped = cache.ped
            local camPitch = GetGameplayCamRelativePitch()
            if camPitch < -70.0 then
                camPitch = -70.0
            elseif camPitch > 42.0 then
                camPitch = 42.0
            end
            camPitch = (camPitch + 70.0) / 112.0
    
            local camHeading = GetGameplayCamRelativeHeading()
            local cosCamHeading = Cos(camHeading)
            local sinCamHeading = Sin(camHeading)
            if camHeading < -180.0 then
                camHeading = -180.0
            elseif camHeading > 180.0 then
                camHeading = 180.0
            end
            camHeading = (camHeading + 180.0) / 360.0
    
            local blocked = 0
            local nn = 0
    
            local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
            local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
            nn,blocked,coords,coords = GetRaycastResult(ray)
    
            Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
            Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
            Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
            Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
            sleep = 1
        end
        Wait(sleep)
    end
end)