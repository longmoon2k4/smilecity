local PlayerData              = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterKeyMapping('maidam', 'menu maidam', 'keyboard', "f6")
RegisterCommand('maidam', function()
	if PlayerData.job ~= nil and PlayerData.job.name == 'maidam' then
		OpenMaiDamMenu()
	end
end, false)

local IsBusy = false
function OpenMaiDamMenu()
    ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_langbam_actions', {
		title    = 'Mai dam',
		align    = 'bottom-right',
		elements = {
			{label = 'Buscu trên xe', value = 'blowCar'},
            {label = 'Chơi nhau tới nái trên xe', value = 'sexCar'},
            {label = 'Buscu ngoài trời', value = 'blowOutside'},
            {label = 'Chó đái bờ rào', value = 'sexOutside'},
            {label = 'La hán đẩy xe bò', value = 'xebo'},
		}
	}, function(data, menu)
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if data.current.value == 'blowCar' then
            if IsPedInAnyVehicle(cache.ped, true) then
                local veh = GetVehiclePedIsIn(cache.ped,false)   
                local inFront = (GetPedInVehicleSeat(veh,0) == cache.ped)
                local driving = GetPedInVehicleSeat(veh,0)
                if inFront == true then  
                    if driving ~= 0 then
                        TriggerServerEvent('sulu_maidam:send',GetPlayerServerId(closestPlayer), 'bj_loop_male', 'bj_loop_prostitute', 'mini@prostitutes@sexnorm_veh', 0, nil)
                    else
                        ESX.ShowNotification('Không có ai để chịch')
                    end
                else
                    ESX.ShowNotification('Bạn phải ngồi ghế trước')
                end
            else
                ESX.ShowNotification('Bạn phải ngồi trên xe')
            end
            menu.close()
        elseif data.current.value == 'sexCar' then
            if IsPedInAnyVehicle(cache.ped, true) then
                local veh = GetVehiclePedIsIn(cache.ped,false)   
                local inFront = (GetPedInVehicleSeat(veh,0) == cache.ped)
                local driving = GetPedInVehicleSeat(veh,0)
                if inFront == true then
                    if driving ~= 0 then
                        TriggerServerEvent('sulu_maidam:send',GetPlayerServerId(closestPlayer), 'sex_loop_male', 'sex_loop_prostitute', 'mini@prostitutes@sexnorm_veh', 0, nil)
                    else
                        ESX.ShowNotification('Không có ai để chịch')
                    end
                else
                    ESX.ShowNotification('Bạn phải ngồi ghế trước')
                end
            else
                ESX.ShowNotification('Bạn phải ngồi trên xe')
            end
            menu.close()
        elseif data.current.value == 'blowOutside' then
            TriggerServerEvent('sulu_maidam:send',GetPlayerServerId(closestPlayer), 'pimpsex_punter', 'pimpsex_hooker', 'misscarsteal2pimpsex',  0.605, false)
            menu.close()
        elseif data.current.value == 'sexOutside' then
            TriggerServerEvent('sulu_maidam:send',GetPlayerServerId(closestPlayer), 'shagloop_pimp', 'shagloop_hooker', 'misscarsteal2pimpsex',  0.055, false)
            menu.close()
        elseif data.current.value == 'xebo' then
            TriggerServerEvent('sulu_maidam:send',GetPlayerServerId(closestPlayer), 'shag_loop_a', 'shag_loop_poppy', 'rcmpaparazzo_2',  0.005, true)
            menu.close()
        end
	end, function(data, menu)
		menu.close()
	end)
end

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function playerAnim(ped, animDictionary, animationName)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        loaddict(animDictionary)
        TaskPlayAnim(ped, animDictionary, animationName, 1.0, -1.0, -1, 1, 0, false, false, false)
    end
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

RegisterNetEvent('sulu_maidam:givenF')
AddEventHandler('sulu_maidam:givenF', function(anim, animDict, sync, source, sameHeading)
    local ped = cache.ped
    if sync == 0 then
        playerAnim(ped, animDict,  anim)
        Citizen.Wait(30000)
        ClearPedTasks(ped)
    else
        local pedInFront = GetPlayerPed(GetClosestPlayer())

        local heading = GetEntityHeading(pedInFront)
        local coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, sync, 0.0)
        if sameHeading == true then
            SetEntityHeading(ped, heading )
        else
            SetEntityHeading(ped, heading - 180.1)
        end
        SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, 0)
        playerAnim(ped, animDict,  anim)
        Citizen.Wait(30000)
        ClearPedTasks(ped)
    end
end)

RegisterNetEvent('sulu_maidam:givenM')
AddEventHandler('sulu_maidam:givenM', function(anim, animDict)
    playerAnim(cache.ped, animDict,  anim)
    Citizen.Wait(30000)
    ClearPedTasks(cache.ped)
end)

RegisterNetEvent('sulu_maidam:accept')
AddEventHandler('sulu_maidam:accept', function(trai, gai, anim, sync, heading, source)
    local alert = lib.alertDialog({
        header = 'Bạn có muốn phê pha tý không ?',
        centered = true,
        cancel = true,
        labels ={
            cancel = 'Hủy',
            confirm = 'Xác nhận'
        }
    })
    if alert=='confirm' then
        TriggerServerEvent("sulu_maidam:acepted",trai, gai, anim, sync, heading, source)
    end
end)