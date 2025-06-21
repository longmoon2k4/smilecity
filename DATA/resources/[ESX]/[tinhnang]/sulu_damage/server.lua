RegisterNetEvent('wais:s:writehit', function(attackerid, victim, hit, victimDied, bonehash)
    TriggerClientEvent('wais:c:writehit', attackerid, victim, hit, victimDied, bonehash)
end)