
RegisterServerEvent("sulu_maidam:send")
AddEventHandler("sulu_maidam:send", function (target, trai, gai, anim, sync, heading)
    -- TriggerClientEvent('sulu_maidam:givenF',source, gai, anim, sync, target, heading)
    -- TriggerClientEvent('sulu_maidam:givenM',target, trai, anim)
    TriggerClientEvent('sulu_maidam:accept', target, trai, gai, anim, sync, heading, source)
end)

RegisterServerEvent("sulu_maidam:acepted")
AddEventHandler("sulu_maidam:acepted", function (trai, gai, anim, sync, heading, target)
    TriggerClientEvent('sulu_maidam:givenF',target, gai, anim, sync, source, heading)
    TriggerClientEvent('sulu_maidam:givenM',source, trai, anim)
end)

