local pInfo = {
    health = 0,
    armour = 0
}

CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = cache.ped
        pInfo.health = GetEntityHealth(player)
        pInfo.armour = GetPedArmour(player)
    end
end)

AddEventHandler('gameEventTriggered', function(name, data)
    if name == "CEventNetworkEntityDamage" then
        victim = tonumber(data[1])
        attacker = tonumber(data[2])
        victimDied = tonumber(data[6]) == 1 and true or false 
        weaponHash = tonumber(data[7])
        isMeleeDamage = tonumber(data[10]) ~= 0 and true or false 
        vehicleDamageTypeFlag = tonumber(data[11]) 
        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
        local bonehash = -1 
        if FoundLastDamagedBone then
            bonehash = tonumber(LastDamagedBone)
        end
        local PPed = cache.ped
        -- local distance = IsEntityAPed(attacker) and #(GetEntityCoords(attacker) - GetEntityCoords(victim)) or -1
        local isplayer = IsPedAPlayer(attacker)
        local attackerid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)) or tostring(attacker==-1 and " " or attacker)
        -- local deadid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)) or tostring(victim==-1 and " " or victim)
        -- local victimName = GetPlayerName(PlayerId())

        if victim == attacker or victim ~= PPed or not IsPedAPlayer(victim) or not IsPedAPlayer(attacker) then return end

        local hit = {
            health = 0,
            armour = 0,
        }

        if pInfo.armour > GetPedArmour(PPed) then
            hit.armour = pInfo.armour - GetPedArmour(PPed)
        else
            hit["armour"] = nil
        end

        if pInfo.health > GetEntityHealth(PPed) then
            hit.health = pInfo.health - GetEntityHealth(PPed)
        else
            hit["health"] = nil
        end
        
        TriggerServerEvent('wais:s:writehit', attackerid, victim, hit, victimDied, bonehash)
    end

end)

RegisterNetEvent('wais:c:writehit', function(victim, victimInfo, victimDied, Bone)
    if victimInfo.armour then
        OnEntityHealthChange('armor', victimInfo.armour)
    end
    if victimInfo.health then
        if victimInfo.health < 100 then
             OnEntityHealthChange('heal', victimInfo.health)
        else
            OnEntityHealthChange('heal', victimInfo.health - 100)
            OnEntityHealthChange('heal', 'die')
        end
    end
end)

OnEntityHealthChange = function(type12, value)
    SendNUIMessage({
        type = type12,
        number = value,
    })
end


