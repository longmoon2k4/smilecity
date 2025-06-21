local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- ESX = nil
IsDie = false
IsShowList = false
-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--         Citizen.Wait(0)
--     end
--     Citizen.Wait(5000)
-- end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(plyCoords, Config.DiaDiem.x, Config.DiaDiem.y, Config.DiaDiem.z, true)
        if distance <= 100 then
            sleep = 100
            if not IsShowList then
                TriggerServerEvent("nonrp:join")
            end
            if IsPlayerDead(PlayerId()) then
                if not IsDie then
                    IsDie = true
                    ESX.ShowNotification(" Hồi Sinh Sau [5s]")
                    Wait(5000)
                    -- Citizen.CreateThread(function()
                        -- if lib.progressBar({
                        --     duration = 5000,
                        --     label = "Đang Hồi Sinh [5s]",
                        --     useWhileDead = true,
                        --     canCancel = true,
                        --     disable = {
                        --         car = true,
                        --         move = true,
                        --         combat = true,
                        --         mouse = false,
                        --     },
                        --     -- anim = {
                        --     --     dict = 'amb@world_human_musician@guitar@male@idle_a',
                        --     --     clip = 'idle_b',
                        --     --     flag = 1
                        --     -- },
                        -- }) then  
                        --     print("abc2")
                            if distance <= 100 then
                                TriggerServerEvent('nonrp:revive')
                            else
                                IsDie = false
                            end
                        -- end
                    -- end)
                end
            else
                if IsDie then
                    --ExecuteCommand('ca')
                    IsDie = false
                end
            end
        else
            if IsShowList then 
                SendNUIMessage({action = "toggle", show = false}) 
                TriggerServerEvent("nonrp:out")
                IsShowList = false
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('nonrp:setList')
AddEventHandler('nonrp:setList',function(list)
    if not IsShowList then
        SendNUIMessage({action = "toggle", show = true})
        IsShowList = true
    end
    local Top1, Top2, Top3 = list[1], list[2], list[3]
    local Mytop,MyVT
    for k,v in ipairs(list) do
        if GetPlayerServerId(PlayerId()) == v.id then
            Mytop = v
            MyVT = k
        end
    end
    SendNUIMessage({action = "setValue", value = {top1 = Top1, top2 = Top2, top3 = Top3,myvt = MyVT, mytop = Mytop}})
end)


Citizen.CreateThread(function()
    local blip = AddBlipForRadius(Config.DiaDiem.x, Config.DiaDiem.y, Config.DiaDiem.z, 100.0)
    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, 1)
    SetBlipAlpha (blip, 128)

    blip = AddBlipForCoord(Config.DiaDiem.x, Config.DiaDiem.y, Config.DiaDiem.z)
    SetBlipSprite (blip, 418)
    SetBlipColour (blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.75)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Đấu Trường")
    EndTextCommandSetBlipName(blip)
end)
  

RegisterNetEvent('bringNonrp')
AddEventHandler('bringNonrp', function(coords)
	ESX.Game.Teleport(PlayerPedId(), {x = coords.x, y = coords.y, z = coords.z}, function()
		ClearPedTasksImmediately(PlayerPedId())
	end)
end)

RegisterNetEvent('healNonrp')
AddEventHandler('healNonrp', function()
	SetEntityHealth(GetPlayerPed(-1), 200)
    SetPedArmour(GetPlayerPed(-1), 100)
end)
RegisterNetEvent('healNonrp')
AddEventHandler('healNonrp', function()
	-- SetEntityHealth(GetPlayerPed(-1), 200)
    Citizen.Wait(1000)
    SetPedArmour(GetPlayerPed(-1), 100)
end)
RegisterNetEvent('reviveNonrp')
AddEventHandler('reviveNonrp', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)
        SetPedArmour(GetPlayerPed(-1), 100)
		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)
