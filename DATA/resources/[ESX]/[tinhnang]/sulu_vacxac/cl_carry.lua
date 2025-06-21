
local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49, --49
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33, --33
	}
}
local time = 0
local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

RegisterNetEvent('CarryPeople:sended')
AddEventHandler('CarryPeople:sended', function()
	if not carry.InProgress then
        if time <= 0 then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer and closestDistance < 2 then
                if GetEntityHealth(GetPlayerPed(closestPlayer)) == 101 then
                    local targetSrc = GetPlayerServerId(closestPlayer)
                    if targetSrc ~= -1 then
                        TriggerServerEvent("CarryPeople:send",targetSrc)
                    else
                        ESX.ShowNotification("~r~Không có ai ở gần bạn")
                    end
                else
                    ESX.ShowNotification("~r~Người này không chết")
                end
            else
                ESX.ShowNotification("~r~Không có ai ở gần bạn")
            end
        else
            ESX.ShowNotification(("~r~Bạn phải chờ %s giây để sử dụng chức năng này"):format(time))
        end
	else
		carry.InProgress = false
		ClearPedSecondaryTask(PlayerPedId())
        DisablePlayerFiring(PlayerPedId(), false)
		DetachEntity(PlayerPedId(), true, false)
		TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
		carry.targetSrc = 0
	end
end)


RegisterNetEvent('CarryPeople:send')
AddEventHandler('CarryPeople:send', function( source)
    local alert = lib.alertDialog({
        header = 'Có người muốn bế bạn đi bạn có đồng ý trao thân không?',
        centered = true,
        cancel = true,
        labels ={
            cancel = 'Không',
            confirm = 'Đi luôn'
        }
    })
    if alert=='confirm' then
        TriggerServerEvent("CarryPeople:sync", source)
    end
end)

RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
    TriggerEvent('sulu_vacxac:doing', true)
    Wait(100)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
    if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
		TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, -1, carry.personCarried.flag, 0, false, false, false)
	end
	carry.type = "carrying" 
end)

RegisterNetEvent("CarryPeople:syncTargetSource")
AddEventHandler("CarryPeople:syncTargetSource", function(targetSrc)
	carry.type = "beingcarried"
    carry.InProgress = true
    carry.targetSrc = targetSrc
    ensureAnimDict(carry.personCarrying.animDict)
    if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
        TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, -1, carry.personCarrying.flag, 0, false, false, false)
    end
    time = 300
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        local heal = GetEntityHealth(player)
        local armor = GetPedArmour(player)
        while  carry.InProgress do
            Wait(1)
            DisablePlayerFiring(player, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            if heal ~= GetEntityHealth(player) or armor ~=  GetPedArmour(player) or IsPedInAnyVehicle(player) then
                carry.InProgress = false 
                DisablePlayerFiring(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                DetachEntity(PlayerPedId(), true, false)
                TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
                carry.targetSrc = 0
            end
        end
    end)
end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
    TriggerEvent('sulu_vacxac:doing', false)
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)


local vacxac = lib.addKeybind({
    name = 'huyvacxac',
    description = 'Huy vac xac',
    defaultKey = 'x',
    onPressed = function(self)
        if carry.InProgress and carry.type == "beingcarried" then
            carry.InProgress = false 
            DisablePlayerFiring(PlayerPedId(), false)
		    ClearPedSecondaryTask(PlayerPedId())
		    DetachEntity(PlayerPedId(), true, false)
		    TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
		    carry.targetSrc = 0
        end
    end,
})

Citizen.CreateThread(function()
    while  true do
        if time > 0 then
            time = time - 1
        end
        Citizen.Wait(1000)
    end
end)