--ESX = nil 
LR = {}
LR.__index = LR

function LR:Init()
    local o = {}
    setmetatable(o, LR)
    o.PlayerData = {}
    o.isBusy = false
    if ESX.IsPlayerLoaded() then 
        o.PlayerData = ESX.GetPlayerData()
    end

    o:EventHandler()
    return o
end

function LR:EventHandler()
    RegisterNetEvent("sulu_impound:client:openImpoundMenu", function()
        if self.PlayerData.job.name == "ambulance" then 
            self:OpenMenu()
        end
    end)
    AddEventHandler("onResourceStop", function(rsName)
        if rsName == GetCurrentResourceName() then 
            SetNuiFocus(false, false)
        end
    end)
    RegisterNUICallback("Close", function(data, cb)
        self:Close()
    end)
    RegisterNUICallback("Impound", function(data, cb)
        self:Close()
        TriggerServerEvent("sulu_impound:server:impound", data)
       -- local playerPed = PlayerPedId()

			-- if IsPedSittingInAnyVehicle(playerPed) then
			-- 	local vehicle = GetVehiclePedIsIn(playerPed, false)

			-- 	if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			-- 		--ESX.ShowNotification("Xe đã được xóa")
			-- 		ESX.Game.DeleteVehicle(vehicle)
			-- 	-- else
			-- 	-- 	ESX.ShowNotification("Bạn phải đứng gần để xóa nó")
			-- 	end
			-- else
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					--ESX.ShowNotification("Xe đã được xóa")
					ESX.Game.DeleteVehicle(vehicle)
				-- else
				-- 	ESX.ShowNotification("Bạn phải đứng gần để xóa nó")
				end
			-- end
        -- local vehicle = ESX.Game.GetVehicleInDirection()
        -- ESX.Game.DeleteVehicle(vehicle)
    end)
    RegisterNetEvent("esx:playerLoaded", function(xPlayer)
        self.PlayerData = xPlayer
    end)
    RegisterNetEvent("esx:setJob", function(job)
        self.PlayerData.job = job
    end)
end

function LR:Close()
    self.isBusy = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        event = "toggle",
        data = false
    })
end

function LR:OpenMenu()
    local vehicle = ESX.Game.GetVehicleInDirection()
    if DoesEntityExist(vehicle) then 
        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
        ESX.TriggerServerCallback("sulu_impound:callback:getVehicleOwner", function(data)
            if data then 
                SetNuiFocus(true, true)
                SendNUIMessage({
                    event = "toggle",
                    data = true
                })
                SendNUIMessage({
                    event = "init",
                    data = data
                })
            else
                self.isBusy = false
                ESX.ShowNotification("Phương tiện này không có chủ sở hữu ")
            end
        end, plate)
    else
        self.isBusy = false
        ESX.ShowNotification("Không có phương tiện nào gần đây")
    end
end

Citizen.CreateThread(function()
    -- while ESX == nil do 
    --     Wait(1)
    --     TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    -- end
    LR:Init()
end)

-- RegisterCommand("open", function()
--     TriggerEvent("sulu_impound:client:openImpoundMenu")
-- end)