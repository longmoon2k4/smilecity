--ESX = nil
local connectedPlayers = {}
local playerJobs = {}
local cop  = 0
local med = 0
--local qy = 0
local ch = 0
--local copHud = 0
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local nameTagNganh = {
    ['police'] = '[~HUD_COLOUR_BLUE~CA~HUD_COLOUR_PURE_WHITE~]  ',
    ['mechanic'] = '[~HUD_COLOUR_ORANGE~CH~HUD_COLOUR_PURE_WHITE~]  ',
    ['ambulance'] = '[~HUD_COLOUR_RED~MED~HUD_COLOUR_PURE_WHITE~]  ',
}  
local nameTagGang = {
	['gangmg'] = '[~HUD_COLOUR_PURPLE~MG~HUD_COLOUR_PURE_WHITE~]  ',
	['gangma'] = '[~HUD_COLOUR_GOLF_P4~Magic~HUD_COLOUR_PURE_WHITE~]  ',
	['gangptg'] = '[~HUD_COLOUR_RED~PTG~HUD_COLOUR_PURE_WHITE~]  ',
	['gangunc'] = '[~HUD_COLOUR_WHITE~UNC~HUD_COLOUR_PURE_WHITE~]  ',
	['gangmxc'] = '[~HUD_COLOUR_GREY~MFA~HUD_COLOUR_PURE_WHITE~]  ',
	['gangfr'] = '[~HUD_COLOUR_YELLOW~Fruit King~HUD_COLOUR_PURE_WHITE~]  ',
	['gangctb'] = '[~HUD_COLOUR_BLUELIGHT~CTB~HUD_COLOUR_PURE_WHITE~]  ',
	['gangdv'] = '[~HUD_COLOUR_GREEN~Crew Devil~HUD_COLOUR_PURE_WHITE~]  ',
}
ESX.RegisterServerCallback('esx_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

exports('data', function()
    return connectedPlayers
end)

exports('nganh', function()
    return {police = cop, med = med, ch = ch}
end)

exports('getPlayer', function(source)
    if connectedPlayers[source] then
        return connectedPlayers[source]
    end
    return 
end)

function checkJob2(job)
    for k,v in pairs(nameTagGang) do
        if v == job then
            return true
        end
    end
    return false
end

function checkJob(job)
    for k,v in pairs(nameTagNganh) do
        if v == job then
            return true
        end
    end
    return false
end

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name
	connectedPlayers[playerId].label = job.label
	connectedPlayers[playerId].grade_name = job.grade_name
    connectedPlayers[playerId].nameTag = nameTagNganh[job.name] ~= nil and nameTagNganh[job.name] or (connectedPlayers[playerId].nameTag ~= '' and (checkJob2(connectedPlayers[playerId].nameTag) == true and connectedPlayers[playerId].nameTag or '') or '' )
	if job.name =='police' or job.name =='ambulance' or job.name =='mechanic' or lastJob.name =='police' or lastJob.name =='ambulance' or lastJob.name =='mechanic'  then
		Count(connectedPlayers)
	end
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('esx:setJob2', function(playerId, job2, lastJob)
	connectedPlayers[playerId].job2 = job2.label
    connectedPlayers[playerId].job2Name = job2.name
    connectedPlayers[playerId].nameTag = nameTagGang[job2.name] ~= nil and nameTagGang[job2.name] or (connectedPlayers[playerId].nameTag ~= '' and (checkJob(connectedPlayers[playerId].nameTag) == true and connectedPlayers[playerId].nameTag or '') or '' )
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		if xPlayer~= nil then
			AddPlayerToScoreboard(xPlayer, false)
		end
	end
	-- TriggerEvent("esx:restoredLoadout")
	
end)

AddEventHandler('esx:playerLoaded', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		AddPlayerToScoreboard(xPlayer, true)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil
	Count(connectedPlayers)
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)

end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5000)
-- 		UpdatePing()
-- 	end
-- end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source
	if playerId ~= nil then
		connectedPlayers[playerId] = {}
		--connectedPlayers[playerId].ping = GetPlayerPing(playerId)
		connectedPlayers[playerId].id =xPlayer.source -- playerId
		connectedPlayers[playerId].name = GetPlayerName(playerId)
		connectedPlayers[playerId].job = xPlayer.job.name
		connectedPlayers[playerId].grade_name = xPlayer.job.grade_name
		connectedPlayers[playerId].label = xPlayer.job.label
		connectedPlayers[playerId].job2 = xPlayer.job2.label
        connectedPlayers[playerId].job2Name = xPlayer.job2.name
        connectedPlayers[playerId].nameTag = nameTagNganh[xPlayer.job.name] or nameTagGang[xPlayer.job2.name] or ''
		if update then
			Count(connectedPlayers)
			--TriggerClientEvent('esx_scoreboard:updateConnectedPlayers2', -1, connectedPlayers)
			TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
		end
	end
end

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		if xPlayer ~= nil then
			AddPlayerToScoreboard(xPlayer, false)
		end
	end
	--TriggerClientEvent('esx_scoreboard:updateConnectedPlayers2', -1, connectedPlayers)
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end

-- function UpdatePing()
-- 	for k,v in pairs(connectedPlayers) do
-- 		v.ping = GetPlayerPing(k)
-- 	end

-- 	TriggerClientEvent('esx_scoreboard:updatePing', -1, connectedPlayers)
-- end

TriggerEvent('es:addGroupCommand', 'screfresh', 'admin', function(source, args, user)
	AddPlayersToScoreboard()
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Refresh esx_scoreboard names!"})

TriggerEvent('es:addGroupCommand', 'sctoggle', 'admin', function(source, args, user)
	TriggerClientEvent('esx_scoreboard:toggleID', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Toggle ID column on the scoreboard!"})


function Count(player)
	cop = 0
	med = 0
	ch = 0
	--qy = 0
	--copHud = 0
	for k,v in pairs(player) do
		if v.job == 'police' then
			--if v.grade_name == 'quany' then
			--	qy = qy + 1
				cop = cop + 1
			--else
			--	cop = cop + 1
			--	copHud = copHud + 1
			--end
		elseif v.job == 'ambulance' then
			if v.grade_name == 'quany' then
				cop = cop + 1
			else
				med = med + 1
			end
		elseif v.job == 'mechanic' then
			ch = ch + 1
		end
	end
	TriggerEvent('esx_scoreboard:med',med)
	TriggerEvent('esx_scoreboard:cop',cop)
	TriggerEvent('esx_scoreboard:ch',ch)
	--TriggerClientEvent('esx_scoreboard:count',-1,med,copHud,ch)
end