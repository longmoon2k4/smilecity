-- ESX = nil
-- TriggerEvent(Config.ESXEvent, function(obj) ESX = obj end)
Players = {}

AddEventHandler("esx:playerLoaded", function(playerId, xPlayer)
    Players[playerId] = {}
    Players[playerId].source = playerId
    Players[playerId].name = xPlayer.name
    Players[playerId].grade_name = xPlayer.job.grade_name
    Players[playerId].job = xPlayer.job.name 
    Players[playerId].job2 = xPlayer.job2.name
    Players[playerId].identifier = xPlayer.identifier
end)

AddEventHandler("esx:playerDropped", function(playerId)
    Players[playerId] = nil
end)

AddEventHandler("esx:setJob", function(playerId, job)
    Players[playerId].job = job.name
    Players[playerId].grade_name = job.grade_name
end)

AddEventHandler("esx:setJob2", function(playerId, job2)
    Players[playerId].job2 = job2.name
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			local players = ESX.GetPlayers()
            for i=1, #players, 1 do
                local xPlayer = ESX.GetPlayerFromId(players[i])
                local playerId = xPlayer.source
                Players[playerId] = {}
                Players[playerId].source = playerId
                Players[playerId].name = xPlayer.name
                Players[playerId].grade_name = xPlayer.job.grade_name
                Players[playerId].job = xPlayer.job.name 
                Players[playerId].job2 = xPlayer.job2.name
                Players[playerId].identifier = xPlayer.identifier
            end
		end)
	end
end)

function GetPlayerByIdentifier(identifier)
    for k, v  in pairs(Players) do 
        if v.identifier == identifier then 
            return v 
        end
    end
    return false
end

function GetPlayerByJob(jobName)
    local pList = {}
    for k,v in pairs(Players) do 
        if v.job == jobName then 
            table.insert(pList, v.source)
        end
    end
    return pList
end