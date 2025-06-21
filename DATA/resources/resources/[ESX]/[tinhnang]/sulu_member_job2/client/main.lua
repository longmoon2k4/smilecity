MEMBER = {}

function MEMBER:Init()
    local o = {}
    setmetatable(o, {__index = MEMBER})
    o.PlayerData = {}
    if ESX.IsPlayerLoaded() then 
        o.PlayerData = ESX.GetPlayerData()
    end
    o:EventHandler()
    o:Main()
    return o
end

function MEMBER:Open()

end

function MEMBER:EventHandler()
    RegisterNetEvent('sulu_member_job2:client:open', function()
        self:Open()
    end)

    RegisterNetEvent("esx:playerLoaded", function(xPlayer)
		self.PlayerData = xPlayer
	end)

    RegisterNetEvent("esx:setJob2", function(job)
    --print(ESX.DumpTable(job))
        self.PlayerData.job2 = job
    end)


    RegisterNUICallback("close", function()
        self:Close()
    end)

    RegisterNUICallback("setJob", function(data, cb)
        ESX.TriggerServerCallback("sulu_member_job2:server:setJob", function(callback) 
            if callback then
                self:Open()
            end
            cb(callback)
        end, data, data.action)
    end)

    RegisterNUICallback("Invite", function(data, cb)
        ESX.TriggerServerCallback("sulu_member_job2:server:Invite", function(callback) 
            if callback then
                self:Open()
            end
            cb(callback)
        end, data)
    end)
end

function MEMBER:Main()

end

function MEMBER:Open()
   -- print(ESX.DumpTable(self.PlayerData.job.name))
    ESX.TriggerServerCallback("sulu_member_job2:server:getData",function(data, jobGrade, job)
        --print(ESX.DumpTable(data))
        if job then
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "display",
                job = job,
                result = data,
                jobGrade = jobGrade
            })
        end
    end, self.PlayerData.job2.name)
end

function MEMBER:Close()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hide",
    })
end

--ESX = nil

Citizen.CreateThread(function()
    -- while ESX == nil do
    --     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --     Citizen.Wait(0)
    -- end
    Wait(5000)
    MEMBER:Init()
end)