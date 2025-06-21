
local rob = false
local robbers = {}
local team = {}
local lastrob = 0
local wantedPlayers = {}
local cop = 0
-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('esx_scoreboard:cop')
AddEventHandler('esx_scoreboard:cop', function(player)
	cop  = player
	
end)
RegisterServerEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function(currentStore)
	local _source = source
	rob = false
	--local xPlayers = ESX.GetExtendedPlayers() -- Returns all xPlayers
	--for _, xPlayer in pairs(xPlayers) do
		TriggerClientEvent('esx:showNotification', -1, _U('robbery_cancelled_at', Stores[currentStore].nameOfStore))
		TriggerClientEvent('esx_holdup:killBlip', -1)
 --  end

	if robbers[_source] then
		TriggerClientEvent('esx_holdup:tooFar', _source)
		robbers[_source] = nil
		TriggerClientEvent('esx:showNotification', _source, _U('robbery_cancelled_at', Stores[currentStore].nameOfStore))
	end
end)

RegisterServerEvent('esx_holdup:robberyStarted')
AddEventHandler('esx_holdup:robberyStarted', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	--local xPlayers = ESX.GetExtendedPlayers()
	-- if  Stores[currentStore].team.total >= 3 then
		if Stores[currentStore] then
			local store = Stores[currentStore]

			if (os.time() - store.lastRobbed) < Config.TimerBeforeNewRob and store.lastRobbed ~= 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lastRobbed)))
				return
			end

			-- local cops = 0
			-- for _, xPlayer in pairs(xPlayers) do
			-- 	if xPlayer.job.name == 'police' then
			-- 		cops = cops + 1
			-- 	end
			-- end
			if not rob then

				if cop >= Config.PoliceNumberRequired then
					if lastrob <= os.time() then

						rob = true
						--for _, xPlayer in pairs(xPlayers) do
							TriggerClientEvent('esx:showNotification', -1, _U('rob_in_prog',Stores[currentStore].team.total, store.nameOfStore))
							TriggerClientEvent('esx_holdup:setBlip', -1, Stores[currentStore].position)
						--end
	
						TriggerClientEvent('esx:showNotification', _source, _U('started_to_rob', store.nameOfStore))
						TriggerClientEvent('esx:showNotification', _source, _U('alarm_triggered'))
						
						TriggerClientEvent('esx_holdup:currentlyRobbing', _source, currentStore)
						TriggerClientEvent('esx_holdup:startTimer', _source)

						for k, v in pairs(Stores[currentStore].team.members) do 
							--TriggerEvent('ata_wanted:addwanted', v.playerId, 3)
							TriggerEvent('PlayersName:SetTruyNa', v.playerId, 15,3)
						end
						
						Stores[currentStore].lastRobbed = os.time()
						robbers[_source] = currentStore

						SetTimeout(store.secondsRemaining * 1000, function()
							if robbers[_source] then
								rob = false
								if xPlayer then
									TriggerClientEvent('esx_holdup:robberyComplete', _source, store.reward)
									lastrob = os.time() + 600 --1200

									if Config.GiveBlackMoney then
										xPlayer.addAccountMoney('black_money', store.reward)
									else
										xPlayer.addMoney(store.reward)
									end
									
									-- local xPlayers = ESX.GetExtendedPlayers()
									-- for _, xPlayer in pairs(xPlayers) do
										TriggerClientEvent('esx:showNotification', -1, _U('robbery_complete_at',GetPlayerName(_source), store.nameOfStore))
										TriggerClientEvent('esx_holdup:killBlip', -1)
									--end
								end
							end
						end)
				    else 
				    	TriggerClientEvent('esx:showNotification', _source, 'Bạn phải đợi '..lastrob-os.time()..' nữa để có thể cướp')
				    end
				else
					TriggerClientEvent('esx:showNotification', _source, _U('min_police', Config.PoliceNumberRequired))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('robbery_already'))
			end
		end
	-- else
	-- 	TriggerClientEvent('esx:showNotification', _source, 'Chưa đủ người để cướp 3')
	-- end
end)

RegisterServerEvent('esx_holdup:jointeam')
AddEventHandler('esx_holdup:jointeam', function(teamName)
	local _source  = source
	--local xPlayer  = ESX.GetPlayerFromId(_source)

	if Stores[teamName].team.total < 5 then

	    Stores[teamName].team.total = Stores[teamName].team.total + 1
	    table.insert(Stores[teamName].team.members, {playerId = _source, playerName = GetPlayerName(_source)})
	    TriggerClientEvent('esx_holdup:recieveconfig', -1, Stores)
	    TriggerClientEvent('esx_holdup:joinedteam', _source, true)
	    TriggerClientEvent('esx_holdup:prepteam', _source, true)
	    TriggerClientEvent('esx:showNotification', _source, "Bạn Đã Vào Team Cướp !")
    else
	    TriggerClientEvent('esx:showNotification', _source, "Team cướp đã đủ người rùi !")
    end

end)

RegisterServerEvent('esx_holdup:leaveteam')
AddEventHandler('esx_holdup:leaveteam', function(teamName)

	local _source = source

	--local xPlayer = ESX.GetPlayerFromId(_source)

		for k, v in pairs(Stores[teamName].team.members) do 

			if v.playerId == _source then

				TriggerClientEvent('esx_holdup:joinedteam', _source, false)

				Stores[teamName].team.total = Stores[teamName].team.total - 1

				table.remove(Stores[teamName].team.members, k)

				TriggerClientEvent('esx_holdup:recieveconfig', -1, Stores)

				TriggerClientEvent('esx:showNotification', _source, "Bạn Đã Thoát Khỏi Team Cướp !")

			end
		end
end)
