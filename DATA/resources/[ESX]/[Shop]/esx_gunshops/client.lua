-- ESX = nil
local inmenu,currentw,cam,weapon = false,nil,0,0
local oldwep = nil
local currentLoc = nil
-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
--     end
-- end)

WarMenu.CreateMenu("main",Config.menu.main.title)
WarMenu.SetSubTitle("main", Config.menu.main.subtitle)
WarMenu.SetTitleColor("main", table.unpack(Config.menu.main.titlecolor))
WarMenu.SetTitleBackgroundColor("main",table.unpack(Config.menu.main.backcolor))
WarMenu.SetMenuY("main", Config.menu.main.y)
WarMenu.SetMenuX("main", Config.menu.main.x)

WarMenu.CreateMenu("weapon",Config.menu.weapon.title:format(""))
WarMenu.SetSubTitle("weapon",Config.menu.weapon.subtitle:format(""))
WarMenu.SetTitleColor("weapon", table.unpack(Config.menu.weapon.titlecolor))
WarMenu.SetTitleBackgroundColor("weapon",table.unpack(Config.menu.weapon.backcolor))
WarMenu.SetMenuY("weapon", Config.menu.weapon.y)
WarMenu.SetMenuX("weapon", Config.menu.weapon.x)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if WarMenu.IsAnyMenuOpened() then
            time = 1
            if not DoesCamExist(cam) then
                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                SetEntityVisible(GetPlayerPed(-1),false)
                FreezeEntityPosition(GetPlayerPed(-1), true)
                --SetEntityCollision(GetPlayerPed(-1),false,false)
                SetCamCoord(cam, Config.marker[currentLoc].cam_coords)
                SetCamActive(cam, true)
                RenderScriptCams(true, false, 0, true, true)
                PointCamAtCoord(cam, Config.marker[currentLoc].cam_point_coords)
                oldwep = GetSelectedPedWeapon(GetPlayerPed(-1))
            end
            if DoesEntityExist(weapon) then SetEntityHeading(weapon,GetEntityHeading(weapon)+0.2) end
            HideHudAndRadarThisFrame()
        elseif not WarMenu.IsAnyMenuOpened() and DoesCamExist(cam) then
            time = 1
            SetCamActive(cam,false)
            RenderScriptCams(false,false,0,true,true)
            DestroyCam(cam, false)
            SetCurrentPedWeapon(GetPlayerPed(-1), oldwep~=nil and oldwep or GetSelectedPedWeapon(GetPlayerPed(-1)), true)
            SetEntityVisible(GetPlayerPed(-1),true)
            --SetEntityCollision(GetPlayerPed(-1), true, true)
            ActivatePhysics(GetPlayerPed(-1))
            FreezeEntityPosition(GetPlayerPed(-1), false)
            if DoesEntityExist(weapon) then DeleteEntity(weapon) end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = GetPlayerPed(-1)
        for k, v in pairs(Config.marker) do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), v.pos, false)<30.0 and not WarMenu.IsAnyMenuOpened() then
                time = 1
                DrawMarker(1, v.pos.x, v.pos.y, v.pos.z, 0, 0, 0, 0, 0, 0, v.size.x, v.size.y, v.size.z, v.color.r, v.color.g, v.color.b, v.color.a, 0, 0, 0, false)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), v.pos, false)<v.size.x then
                    ESX.ShowHelpNotification(Config.lang.marker_text)
                    currentLoc = k
                    if IsControlJustPressed(0, 51) then 
                        ESX.TriggerServerCallback('esx_license:checkLicense', function(check)
                            if check then
                                WarMenu.OpenMenu("main")
                            else
                                ESX.ShowNotification("Bạn không có ~r~bằng súng!")
                            end
                        end, GetPlayerServerId(PlayerId()), 'weapon')
                    end
                end
            end
        end
        if WarMenu.IsMenuOpened('main') then
            time = 1
            for _,w in ipairs(Config.weapons) do
                if not HasPedGotWeapon(ped, GetHashKey(w.weapon), 0) then
                    if w.price then
                        if WarMenu.Button(w.label,Config.price_format:format(w.price)) then
                            ESX.TriggerServerCallback("fn_weaponshop:buyWeapon",function(can)
                                if can then GiveWeaponToPed(ped, GetHashKey(w.weapon), 0, false, true) else ESX.ShowNotification(Config.lang.not_enough_money) end
                            end, w.weapon)
                        end
                    end
                else
                    if WarMenu.MenuButton(w.label,"weapon",Config.lang.owned) then
                        currentw = w
                        WarMenu.SetTitle("weapon",Config.menu.weapon.title:format(w.label))
                        WarMenu.SetSubTitle("weapon",Config.menu.weapon.subtitle:format(w.label))
                        if DoesEntityExist(weapon) then DeleteEntity(weapon) end
                        local weaponAsset = GetHashKey(w.weapon)
                        RequestWeaponAsset(weaponAsset, 31, 0)
                        while not HasWeaponAssetLoaded(weaponAsset) do
                            Wait(0)
                        end
                        if w.upgrades~=nil and #w.upgrades>0 then
                            local hadbefore = {}
                            for k,v in ipairs(w.upgrades) do hadbefore[k]=HasPedGotWeaponComponent(ped,weaponAsset,GetHashKey(v.hash)) end
                            for k,v in ipairs(w.upgrades) do
                                if not hadbefore[k] then GiveWeaponComponentToPed(ped,weaponAsset,GetHashKey(v.hash)); RemoveWeaponComponentFromPed(ped, weaponAsset, GetHashKey(v.hash)) end
                            end
                            for k,v in ipairs(w.upgrades) do if hadbefore[k] and not HasPedGotWeaponComponent(ped,weaponAsset,GetHashKey(v.hash)) then GiveWeaponComponentToPed(ped,weaponAsset,GetHashKey(v.hash)) end end -- fucking magazines :)
                        end -- my cheeky way of loading components into memory >:)
                        SetCurrentPedWeapon(ped, weaponAsset, true)
                        weapon = CreateWeaponObject(weaponAsset, 0, Config.marker[currentLoc].weapon_coords, true, 0, 0)
                    end
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened("weapon") then
            time = 1
            local weaponhash = GetHashKey(currentw.weapon)
            if currentw.can_buy_ammo and currentw.ammo_count and currentw.ammo_price then
                if WarMenu.Button(Config.lang.ammo:format(currentw.ammo_count),Config.price_format:format(currentw.ammo_price)) then
                    ESX.TriggerServerCallback("fn_weaponshop:buyAmmo",function(can)
                        if not can then 
                            --AddAmmoToPed(ped, weaponhash, currentw.ammo_count) 
                          ESX.ShowNotification(Config.lang.not_enough_money)
                         end
                    end, currentw.weapon)
                end
            end
            if currentw.upgrades and #currentw.upgrades>0 then
                for _,upgrade in ipairs(currentw.upgrades) do
                    --if not upgrade.hash:match("_CLIP_") then
                        local upgradehash = GetHashKey(upgrade.hash)
                        if not HasModelLoaded(upgradehash) then RequestModel(upgradehash) end
                        if HasPedGotWeaponComponent(ped,weaponhash,upgradehash) and not HasWeaponGotWeaponComponent(weapon, upgradehash) then GiveWeaponComponentToWeaponObject(weapon, upgradehash) elseif not HasPedGotWeaponComponent(ped, weaponhash, upgradehash) and HasWeaponGotWeaponComponent(weapon, upgradehash) then RemoveWeaponComponentFromWeaponObject(weapon, upgradehash) end
                        if WarMenu.GetSelected()==(currentw.can_buy_ammo and 1 or 0)+_ then if not HasWeaponGotWeaponComponent(weapon, upgradehash) then GiveWeaponComponentToWeaponObject(weapon,upgradehash) elseif not HasPedGotWeaponComponent(ped,weaponhash,upgradehash) then RemoveWeaponComponentFromWeaponObject(weapon, upgradehash) end end
                        if WarMenu.Button(upgrade.label,HasPedGotWeaponComponent(ped, weaponhash, upgradehash) and Config.lang.equipped or (upgrade.price<=0 and Config.lang.free or Config.price_format:format(upgrade.price))) then
                            if not HasPedGotWeaponComponent(ped, weaponhash, upgradehash) then
                                ESX.TriggerServerCallback("fn_weaponshop:buyWeaponComponent",function(can)
                                   -- if can then GiveWeaponComponentToPed(ped, weaponhash, upgradehash) else ESX.ShowNotification(Config.lang.not_enough_money) end
                                    if not can then
                                        ESX.ShowNotification(Config.lang.not_enough_money)
                                    end
                                end, currentw.weapon, upgrade.name)
                            else
                                --TriggerServerEvent("fn_weaponshop:removeWeaponComponent",currentw.weapon, upgrade.hash)
                               --TriggerEvent("weapon_system:removeComponentGunshop",currentw.weapon, upgrade.name)
                               TriggerEvent('ox_inventory:buyComponentGunshop','removeComponent',upgrade.hash,upgrade.name)
                            end
                        end
                   --end
                end
            end
            if currentw.tints and #currentw.tints>0 then
                for _,tint in ipairs(currentw.tints) do
                    if WarMenu.GetSelected()==(currentw.upgrades~=nil and #currentw.upgrades or 0)+_+(currentw.can_buy_ammo and 1 or 0) and GetWeaponObjectTintIndex(weapon)~=tint.index then SetWeaponObjectTintIndex(weapon,tint.index) end
                    if WarMenu.Button(tint.label,GetPedWeaponTintIndex(GetPlayerPed(-1),GetHashKey(currentw.weapon))==tint.index and Config.lang.equipped or (tint.price<=0 and Config.lang.free or Config.price_format:format(tint.price))) then
                        ESX.TriggerServerCallback("fn_weaponshop:buyWeaponTint",function(can)
                            --if can then SetPedWeaponTintIndex(ped, weaponhash, tint.index) else ESX.ShowNotification(Config.lang.not_enough_money) end
                            if not can then
                                ESX.ShowNotification(Config.lang.not_enough_money)
                            end
                        end, currentw.weapon, tint.index)
                    end
                end
            end
            if (WarMenu.GetSelected()<=(currentw.upgrades~=nil and #currentw.upgrades or 0)+(currentw.can_buy_ammo and 1 or 0) or WarMenu.GetSelected()>(currentw.upgrades~=nil and #currentw.upgrades or 0)+(currentw.tints~=nil and #currentw.tints or 0)+(currentw.can_buy_ammo and 1 or 0)) and GetWeaponObjectTintIndex(weapon)~=GetPedWeaponTintIndex(ped, weaponhash) then SetWeaponObjectTintIndex(weapon,GetPedWeaponTintIndex(ped, weaponhash)) end
            if WarMenu.MenuButton("Back","main") then DeleteEntity(weapon) end
            WarMenu.Display()
        end
        Citizen.Wait(time)
    end
end)


Citizen.CreateThread(function()
    for k,v in ipairs(Config.marker) do
        local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
		SetBlipSprite(blip, 110)
		SetBlipScale(blip, 0.65)
		SetBlipColour(blip, 81)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('CUSTOM_STRING')
		AddTextComponentSubstringPlayerName("<FONT FACE='arial font'>Shop súng")
		EndTextCommandSetBlipName(blip)
    end
end)