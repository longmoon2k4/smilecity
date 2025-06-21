BlackList = {}
BlackList.__index = BlackList
function BlackList:Init()
    local o = {}
    setmetatable(o, BlackList)
    o.PlayerData = {}
    if ESX.IsPlayerLoaded() then 
        o.PlayerData = ESX.GetPlayerData()
    end
    o.weaponList = {
        --{ name = 'WEAPON_ADVANCEDRIFLE', job = "police", job2 =  "quany" },
        --{ name = 'WEAPON_RPG', job = "police", job2 =  "quany" },
        -- { name = 'WEAPON_AK12', job = "police", job2 = "police" },
         { name = 'WEAPON_CARBINERIFLE', job = "police", job2 = "ambulance" },
        { name = 'WEAPON_HEAVYRIFLE', job = "police", job2 = "ambulance" },
        -- { name = 'WEAPON_BZGAS', job = "police", job2 = "ambulance" },
        { name = 'WEAPON_PETROLCAN', job = "mechanic", job2 = "ambulance" },
        -- { name = 'WEAPON_SVD', job = "police", job2 = "ambulance" },
        --{ name = 'WEAPON_ASSAULTSMG', job = "police", job2 = "quany" },
    } 
    o.vehicleList = {
        { name = GetHashKey('cuuho')},
        { name = GetHashKey('vinfastlux20')},
        { name = GetHashKey('polmav')},
        { name = GetHashKey('buzzard2')},
        { name = GetHashKey('sjcop1')},
        { name = GetHashKey('aripolice')},
        { name = GetHashKey('mk4polit')},
        { name = GetHashKey('oppressor2')},
        { name = GetHashKey('politlm')},
        { name = GetHashKey('lambf')},
        { name = GetHashKey('quany')},
    }
    o:Vehicle()
    o:EventHandler()
    
    return o
end

function BlackList:Vehicle()
    AddEventHandler('gameEventTriggered', function (name, args)
        if name == 'CEventNetworkPlayerEnteredVehicle' then 
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                local player = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(player, false)
                local driver = GetPedInVehicleSeat(vehicle, -1)
                local model = GetEntityModel(vehicle)
                for k, v in pairs(self.vehicleList) do
                    if model == v.name and driver == player then
                      --  if self.PlayerData.job.name == "unemployed" or self.PlayerData.job.name == "tailor" or self.PlayerData.job.name == "giaoga" or self.PlayerData.job.name == "miner" or self.PlayerData.job.name == "langbam" or self.PlayerData.job.name == "lumberjack" or self.PlayerData.job.name == "daumo"  then
                      if  self.PlayerData.job.name ~= "police" and self.PlayerData.job.name ~= "mechanic" and self.PlayerData.job.name ~= "ambulance" then 
                            ESX.ShowNotification("~r~Bạn không được lên xe ngành~s~")
                            TaskLeaveVehicle(player, vehicle, 0)
                        end
                    end
                end
            end
        end
    end)
end

function BlackList:EventHandler()
    -- self.haveLicense = true
    RegisterNetEvent("esx:playerLoaded", function(xPlayer)
        self.PlayerData = xPlayer
        self.haveLicense = false
        ESX.TriggerServerCallback('esx_license:checkLicense', function(bought)
            self.haveLicense = bought
        end, GetPlayerServerId(PlayerId()),'weapon')
    end)

    RegisterNetEvent("esx:setJob", function(Job)
        self.PlayerData.job = Job
    end)
    RegisterNetEvent("esx_policejob:removeLicense")
    AddEventHandler('esx_policejob:removeLicense', function() 
        self.haveLicense = false
    end)

    RegisterNetEvent("esx_policejob:addLicense")
    AddEventHandler('esx_policejob:addLicense', function() 
        self.haveLicense = true
    end)

    AddEventHandler('ox_inventory:currentWeapon', function(weapon) 
        local check = false
        local checkLicense = false
        if weapon ~= nil then 
            for k, v in pairs(self.weaponList) do
                if v.name == weapon.name and self.PlayerData.job.name ~= v.job and self.PlayerData.job.name ~= v.job2 then
                    check = true
                    break
                end
            end 
            if check == false then
                if weapon.name ~= 'WEAPON_PETROLCAN' and  self.haveLicense == false then
                    checkLicense = true
                end
            end
            if check then
                ESX.ShowNotification('~r~Vũ khí chuyên dụng không thể sử dụng.~s~')
                Wait(1000)
                --SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
                TriggerEvent('ox_inventory:disarm')
            end
            if checkLicense then
                ESX.ShowNotification('~r~Bạn không có giấy phép sử dụng súng.~s~')
                Wait(1000)
                --SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
                TriggerEvent('ox_inventory:disarm')
            end
        end
    end)
end

-- ESX = nil
Citizen.CreateThread(function()
    -- while ESX == nil do
    --     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --     Citizen.Wait(0)
    -- end
    BlackList:Init()
end)