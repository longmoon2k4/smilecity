local posText = vec3(-260.82, -965.0, 32.22)
local pos = vec3(-260.82, -965.0, 31.22)
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(pos)
	SetBlipScale(blip,  1.0)
	SetBlipDisplay(blip, 4)
	SetBlipSprite(blip, 304)
	SetBlipColour(blip,  3)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Nhận quà newbie")
    EndTextCommandSetBlipName(blip)
    while true do
        
        local time = 1000
        local pedCoords1 = GetEntityCoords(PlayerPedId())
        if #(pedCoords1- pos) < 10 then
           time = 1
		     DrawMarker(22, pos , 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
			--Draw3DText(posText, "  Quà tặng tân thủ 🎀 ", 1, 0.1, 0.1)
        end
        if #(pedCoords1- pos) < 1 then
            ESX.ShowHelpNotification("Nhấn [E] để nhận quà newbie")
            if IsControlJustReleased(0, 51) then
                Citizen.Wait(1000)
				ESX.TriggerServerCallback("sulu_newbie:check", function(check)
                    if check then
                        ESX.Game.SpawnVehicle('kiastinger', vec3(-243.68, -999.9, 29.13), 16.94, function (vehicle)
                           --
                           if DoesEntityExist(vehicle) then
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                local newPlate     = exports['d3x_vehicleshop']:GeneratePlate()
                                local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                                vehicleProps.plate = newPlate
                                SetVehicleNumberPlateText(vehicle, newPlate)
                                TriggerEvent('sulu_keycar:acceptData',string.gsub(newPlate, "%s+", ""))
                                TriggerServerEvent('sulu_newbie:setVehicleOwned', vehicleProps )
                           else
                                ESX.ShowNotification("~r~ một lỗi vô tình xảy ra lúc nhận xe vui lòng nhận lại quà")
                           end
                        end)
                        ESX.Game.Teleport(PlayerPedId(), {x = -248.09, y=-997.6, z=29.2}, function()
                            SetEntityHeading(PlayerPedId(), 16.94)
                        end)
                    else
                        ESX.ShowNotification("~r~ Bạn đã nhận phần quà này rồi")
                    end
                end)
			end
         end
        Citizen.Wait(time)
    end
end)