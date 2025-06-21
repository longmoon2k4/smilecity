
RegisterNetEvent('roll:Display')
AddEventHandler('roll:Display', function(source)
	
    random = math.random(1,12)

    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    ClearPedTasks(GetPlayerPed(-1))
    TriggerServerEvent('3dme:shareDisplay', 'Con số may mắn là: '.. random)
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end

--Written by ZacFierce and MrFunBeard
--Any alteration and addition can be made and posted as long as credits are given :)