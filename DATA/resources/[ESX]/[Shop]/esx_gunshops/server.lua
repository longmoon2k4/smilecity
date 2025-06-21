-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent("fn_weaponshop:removeWeaponComponent")
    AddEventHandler("fn_weaponshop:removeWeaponComponent",function(weaponname,weaponcomponent)
    -- local xPlayer = ESX.GetPlayerFromId(source)
    -- xPlayer.removeWeaponComponent(weaponname,weaponcomponent)
    TriggerClientEvent('ox_inventory:buyComponentGunshop',source,'removeComponent',weaponcomponent)
end)


ESX.RegisterServerCallback("fn_weaponshop:buyWeapon",function(source,cb,weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
   -- if xPlayer.getInventoryItem('access_key').count >= 1 then
        for k,v in ipairs(Config.weapons) do
            if v.weapon==weapon then
                cb(xPlayer.getMoney()>=v.price)
                if xPlayer.getMoney()>=v.price then 
                    xPlayer.removeMoney(v.price) 
                   -- xPlayer.addWeapon(weapon, 200)
                    --TriggerEvent("weapon_system:server:addWeapon", source, weapon)
                    TriggerClientEvent('esx:showNotification', source, "~g~Mua thanh cong")
                end
            end
        end
    -- else
    --     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Bạn không có giấy phép sử dụng súng'})
    -- end
end)

ESX.RegisterServerCallback("fn_weaponshop:buyWeaponTint",function(source,cb,weapon,tint)
    local xPlayer = ESX.GetPlayerFromId(source)
    --if xPlayer.getInventoryItem('access_key').count >= 1 then
        for k,v in ipairs(Config.weapons) do
            if v.weapon==weapon then
                for kk,vv in ipairs(v.tints) do
                    if vv.index==tint then
                        cb(xPlayer.getMoney()>=vv.price)
                        if xPlayer.getMoney()>=vv.price then 
                            xPlayer.removeMoney(vv.price) 
                            TriggerClientEvent('ox_inventory:buyComponentGunshop',source,'addTint',tint)
                            --TriggerClientEvent('weapon_system:buyTintGunshop',source,weapon,tint)
                           -- xPlayer.setWeaponTint(weapon, tint)
                        end
                    end
                end
            end
        end
  -- else
        --TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Bạn không có giấy phép sử dụng súng'})
   -- end
end)

ESX.RegisterServerCallback("fn_weaponshop:buyAmmo",function(source,cb,weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    --if xPlayer.getInventoryItem('access_key').count >= 1 then
        for k,v in ipairs(Config.weapons) do
            if v.weapon==weapon then
                cb(xPlayer.getMoney()>=v.ammo_price)
                if xPlayer.getMoney()>=v.ammo_price then 
                    --xPlayer.addWeaponAmmo(weapon, 60)
                    xPlayer.removeMoney(v.ammo_price) 
                    TriggerClientEvent('ox_inventory:buyComponentGunshop',source,'addAmmo',v.ammo_count)
                    break
                end
            end
        end
   -- else
     --   TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Bạn không có giấy phép sử dụng súng'})
   -- end
end)

ESX.RegisterServerCallback("fn_weaponshop:buyWeaponComponent",function(source,cb,weapon,component)
    local xPlayer = ESX.GetPlayerFromId(source)
    --if xPlayer.getInventoryItem('access_key').count >= 1 then
        for k,v in ipairs(Config.weapons) do
            if v.weapon==weapon then
                for kk,vv in ipairs(v.upgrades) do
                    if vv.name==component then
                        cb(xPlayer.getMoney()>=vv.price)
                        if xPlayer.getMoney()>=vv.price then 
                            xPlayer.removeMoney(vv.price) 
                           -- xPlayer.addWeaponComponent(weapon, component)
                           --TriggerClientEvent('weapon_system:buyComponentGunshop',source,weapon,component)
                           TriggerClientEvent('ox_inventory:buyComponentGunshop',source,'addComponent',vv.hash, vv.name)
                        end
                    end
                end
            end
        end
    --else
       -- TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Bạn không có giấy phép sử dụng súng'})
   -- end
end)


