-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local webhook1 = "https://discord.com/api/webhooks/tatwebhooks/1052067370501406801/PLwax1QzFYXArlcwfYWZwW-acw4bW2lGulXlYYEgM0dqI6rUH3NXCcs-0w2aaFxIcjFT" 
cop = 0
RegisterServerEvent('esx_scoreboard:cop')
AddEventHandler('esx_scoreboard:cop', function(player)
	cop  = player
end)
ESX.RegisterServerCallback('esx_ruatien:checkcanhsat', function(source, cb, item)

	-- local xPlayer = ESX.GetPlayerFromId(source)
	-- local xPlayers = ESX.GetPlayers()

	-- local cops = 0
	-- 	for i=1, #xPlayers, 1 do
	-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	-- 		if xPlayer.job.name == 'police' then
	-- 			cops = cops + 1
	-- 		end
	-- 	end
    if cop < Config.RequiredCops then

		TriggerClientEvent('esx:showNotification', source, _U('cs_online_police',cops, Config.RequiredCops))

		cb(false)

	else

		cb(true)

	end
	
end)


 RegisterServerEvent('esx_godilinhrtyjob:pay')
 AddEventHandler('esx_godilinhrtyjob:pay', function(amount)
-- exports["WaveShield"]:AddEventHandler("esx_godilinhrtyjob:pay", function(source, amount)
 	local _source = source
 	local xPlayer = ESX.GetPlayerFromId(_source)
	local amount = tonumber(amount)
 	if amount ~= nil then
	 	if xPlayer ~= nil and amount > 1 then
	 		local money = xPlayer.getAccount('black_money').money
	 		if money > amount or money == amount then
	 			xPlayer.addMoney(tonumber(amount)) -- Add Clean Money
	 			xPlayer.removeAccountMoney('black_money', amount) -- Removes Dirty Money
	 			TriggerClientEvent('esx:showNotification', _source, "Bạn đã ~g~ làm sạch: $" ..amount)
				 sendDiscord("Rửa tiền", GetPlayerName(_source).." đã rửa "..amount.. "$ ")
	 		else
	 			TriggerClientEvent('esx:showNotification', _source, "Bạn không có tiền bẩn...")
	 		end
	 		if money < amount then
	 			local money = xPlayer.getAccount('black_money').money
	 			xPlayer.addMoney(tonumber(money)) -- Add Clean Money
	 			xPlayer.removeAccountMoney('black_money', money) -- Removes Dirty Money
				 sendDiscord("Rửa tiền", GetPlayerName(_source).." đã rửa "..amount.. "$ ")
	 			TriggerClientEvent('esx:showNotification', _source, "Bạn đã ~g~rửa sạch all tiền: $" ..money)
	 		end
	 	end
	 end
end)

 function sendDiscord(name, message)
	local content = {
		{
			["color"] = '2061822',
			["title"] = name,
			["description"] = message .. os.date ("%X") .." - ".. os.date ("%x") .."",
			["footer"] = {
			["text"] = "Log "..name.." By Sulu",
			},
		}
	}
	  PerformHttpRequest(webhook1, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end

local code = [[
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORIGINAL SCRIPT BY Marcio FOR CFX-ESX
-- Script serveur No Brain
-- www.nobrain.org
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------
-----------------MODIFIED BY  K R I Z F R O S T---------------------------
--------------------------------------------------------------------------
----- MONEY LAUNDERING SCRIPT RELEASED CREDITS TO ORIGINAL CREATOR--------
----- OF ESX_POSTALJOB RE WORKED AND MODIFIED BY KRIZFROST ---------------
--------------------------------------------------------------------------
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
--------------------------------------------------------------------------------
-- NE RIEN MODIFIER
--------------------------------------------------------------------------------
local namezone = "Delivery"
local namezonenum = 0
local namezoneregion = 0
local MissionRegion = 0
local viemaxvehicule = 1000
local argentretire = 0
local livraisonTotalPaye = 0
local livraisonnombre = 0
local MissionRetourCamion = false
local MissionNum = 0
local MissionLivraison = false
local isInService = false
local PlayerData              = nil
local GUI                     = {}
GUI.Time                      = 0
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}

local plaquevehicule = ""
local plaquevehiculeactuel = ""
local CurrentAction           = nil
local price = 500
local CurrentActionMsg        = ''
local CurrentActionData       = {}
--------------------------------------------------------------------------------
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-- MENUS
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				isInService = false
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					  local model = nil

					  if skin.sex == 0 or 1 then
						model = GetHashKey("mp_m_freemode_01")
					  else
						model = GetHashKey("mp_f_freemode_01")
					  end

					  RequestModel(model)
					  while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(1)
					  end

					  SetPlayerModel(PlayerId(), model)
					  SetModelAsNoLongerNeeded(model)

					  TriggerEvent('skinchanger:loadSkin', skin)
					  TriggerEvent('esx:restoreLoadout')
        end)
      end

			if data.current.value == 'job_wear' then
				isInService = true
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					if skin.sex == 0 or 1 then
					SetModelAsNoLongerNeeded(model) -- Uses Current Player Model

					RequestModel(model)
					while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(0)
					end
				xPlayer.removeAccountMoney('black_money', price)
				SetPlayerModel(PlayerId(), model)
			else
					end

				end)

			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #Config.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Trucks[i])), value = Config.Trucks[i]})
	end


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehiclespawner',
		{
			title    = _U('vehiclespawner'),
			elements = elements
		},
		function(data, menu)
			ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
				platenum = math.random(10000, 99999)
				SetVehicleNumberPlateText(vehicle, "WAL"..platenum)
                MissionLivraisonSelect()
				plaquevehicule = "WAL"..platenum

				if data.current.value == 'phantom3' then
					ESX.Game.SpawnVehicle("trailers2", Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(trailer)
					    AttachVehicleToTrailer(vehicle, trailer, 1.1)
					end)
				end
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
			end)

			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function IsATruck()
	local isATruck = false
	local playerPed = GetPlayerPed(-1)
	for i=1, #Config.Trucks, 1 do
		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), Config.Trucks[i]) then
			isATruck = true
			break
		end
	end
	return isATruck
end

function IsJobTrucker()
	if PlayerData ~= nil then
		local isJobTrucker = false

		if PlayerData.job.name ~= nil or PlayerData.job.name ~= 'police' then -- If players job ~= nil and Player Job name = 'JOB YOU WANT THEM TO HAVE ' then
			isJobTrucker = true
		end
		return isJobTrucker
	end
end

AddEventHandler('esx_godirtyjob:hasEnteredMarker', function(zone)

	local playerPed = GetPlayerPed(-1)

	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end

	if zone == 'VehicleSpawner' then
		if isInService and IsJobTrucker() then
			if MissionRetourCamion or MissionLivraison then
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('already_have_truck')
			else
				MenuVehicleSpawner()
			end
		end
	end

	if zone == namezone then
		if isInService and MissionLivraison and MissionNum == namezonenum and MissionRegion == namezoneregion and IsJobTrucker() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

				if plaquevehicule == plaquevehiculeactuel then
					if Blips['delivery'] ~= nil then
						RemoveBlip(Blips['delivery'])
						Blips['delivery'] = nil
					end

					CurrentAction     = 'delivery'
                    CurrentActionMsg  = _U('delivery')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('not_your_truck2')
			end
		end
	end

	if zone == 'AnnulerMission' then
		if isInService and MissionLivraison and IsJobTrucker() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

                TriggerServerEvent('esx:clientLog', "3'" .. json.encode(plaquevehicule) .. "' '" .. json.encode(plaquevehiculeactuel) .. "'")

				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('cancel_mission')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperduannulermission'
			end
		end
	end

	if zone == 'RetourCamion' then
		if isInService and MissionRetourCamion and IsJobTrucker() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamion'
                    CurrentActionMsg  = _U('return_finished')
				else
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperdu'
			end
		end
	end

end)

AddEventHandler('esx_godirtyjob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
    CurrentAction = nil
    CurrentActionMsg = ''
end)

function nouvelledestination()
	livraisonnombre = livraisonnombre+1
	livraisonTotalPaye = livraisonTotalPaye+destination.Paye

	if livraisonnombre >= Config.MaxDelivery then
		MissionLivraisonStopRetourDepot()
	else

		livraisonsuite = math.random(0, 100)

		if livraisonsuite <= 10 then
			MissionLivraisonStopRetourDepot()
		elseif livraisonsuite <= 99 then
			MissionLivraisonSelect()
		elseif livraisonsuite <= 100 then
			if MissionRegion == 1 then
				MissionRegion = 2
			elseif MissionRegion == 2 then
				MissionRegion = 1
			end
			MissionLivraisonSelect()
		end
	end
end

function retourcamion_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0
	TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
	print('retourcamion_oui <<< Has been Triggered')
	donnerlapaye()
end

function retourcamion_non()

	if livraisonnombre >= Config.MaxDelivery then
		ESX.ShowNotification(_U('need_it'))
	else
		ESX.ShowNotification(_U('ok_work'))
		TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
		print('retourcamion_non <<< Has been Triggered')
		nouvelledestination()
	end
end

function retourcamionperdu_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
	print('retourcamionperdu_oui <<< Has been Triggered')
	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0

	donnerlapayesanscamion()
end

function retourcamionperdu_non()
	ESX.ShowNotification(_U('scared_me'))
end

function retourcamionannulermission_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0
	TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
	print('retourcamionperdu_non <<< Has been Triggered')
	donnerlapaye()
end

function retourcamionannulermission_non()
	ESX.ShowNotification(_U('resume_delivery'))
end

function retourcamionperduannulermission_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0
	TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
	print('retourcamionperduannulermission_oui <<< Has been Triggered')
	donnerlapayesanscamion()
end

function retourcamionperduannulermission_non()
	ESX.ShowNotification(_U('resume_delivery'))
end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function donnerlapaye()
	ped = GetPlayerPed(-1)
	vehicle = GetVehiclePedIsIn(ped, false)
	vievehicule = GetVehicleEngineHealth(vehicle)
	calculargentretire = round(viemaxvehicule-vievehicule)

	if calculargentretire <= 0 then
		argentretire = 0
	else
		argentretire = calculargentretire
	end

    ESX.Game.DeleteVehicle(vehicle)

	local amount = livraisonTotalPaye-argentretire

	if vievehicule >= 1 then
		if livraisonTotalPaye == 0 then
			ESX.ShowNotification(_U('not_delivery'))
			ESX.ShowNotification(_U('pay_repair'))
			ESX.ShowNotification(_U('repair_minus')..argentretire)
			TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then
				TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
				livraisonTotalPaye = 0
			else
				ESX.ShowNotification(_U('repair_minus')..argentretire)
					TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
				livraisonTotalPaye = 0
			end
		end
	else
		if livraisonTotalPaye ~= 0 and amount <= 0 then
			ESX.ShowNotification(_U('truck_state'))
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then
					TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
				livraisonTotalPaye = 0
			else
				ESX.ShowNotification(_U('repair_minus')..argentretire)
				TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
				livraisonTotalPaye = 0
			end
		end
	end
end

function donnerlapayesanscamion()
	ped = GetPlayerPed(-1)
	argentretire = Config.TruckPrice

	-- donne paye
	local amount = livraisonTotalPaye-argentretire

	if livraisonTotalPaye == 0 then
		ESX.ShowNotification(_U('no_delivery_no_truck'))
		ESX.ShowNotification(_U('truck_price')..argentretire)
					TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
		livraisonTotalPaye = 0
	else
		if amount >= 1 then
			ESX.ShowNotification(_U('truck_price')..argentretire)
					TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
			livraisonTotalPaye = 0
		else
			ESX.ShowNotification(_U('truck_state'))
			livraisonTotalPaye = 0
		end
	end
end

-- Key Controls
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)

        if CurrentAction ~= nil then

        	SetTextComponentFormat('STRING')
        	AddTextComponentString(CurrentActionMsg)
       		DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if IsControlJustReleased(0, 38) and IsJobTrucker() then

            ESX.TriggerServerCallback('esx_ruatien:checkcanhsat', function(check)

	        if check then

                if CurrentAction == 'delivery' then
								---	local money = xPlayer.getAccount('black_money').money
								---		if money > amount or money == amount then
                    nouvelledestination()
								--		Player.addMoney(tonumber(amount))
								---	elseif  money < amount or money == money then
								--		Player.addMoney(tonumber(money))
								--		retourcamionannulermission_oui()
								--	end
							--	end 
              end

                if CurrentAction == 'retourcamion' then
                    retourcamion_oui()
                end

                if CurrentAction == 'retourcamionperdu' then
                    retourcamionperdu_oui()
                end

                if CurrentAction == 'retourcamionannulermission' then
                    retourcamionannulermission_oui()
                end

                if CurrentAction == 'retourcamionperduannulermission' then
                    retourcamionperduannulermission_oui()
                end

                CurrentAction = nil
            else
                ESX.ShowNotification('Không Đủ Cảnh Sát')
                end
            end)
            end
        end
    end
end)

-- DISPLAY MISSION MARKERS AND MARKERS
Citizen.CreateThread(function()
	while true do
		Wait(0)

		if MissionLivraison then
			DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
			DrawMarker(Config.Livraison.AnnulerMission.Type, Config.Livraison.AnnulerMission.Pos.x, Config.Livraison.AnnulerMission.Pos.y, Config.Livraison.AnnulerMission.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Livraison.AnnulerMission.Size.x, Config.Livraison.AnnulerMission.Size.y, Config.Livraison.AnnulerMission.Size.z, Config.Livraison.AnnulerMission.Color.r, Config.Livraison.AnnulerMission.Color.g, Config.Livraison.AnnulerMission.Color.b, 100, false, true, 2, false, false, false, false)
		elseif MissionRetourCamion then
			DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
		end

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do

			if isInService and (IsJobTrucker() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end

		for k,v in pairs(Config.Cloakroom) do

			if(IsJobTrucker() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end

	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Wait(0)

		if IsJobTrucker() then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			for k,v in pairs(Config.Cloakroom) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			for k,v in pairs(Config.Livraison) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('esx_godirtyjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('esx_godirtyjob:hasExitedMarker', lastZone)
			end

		end

	end
end)

-- CREATE BLIPS
Citizen.CreateThread(function()
local blip = AddBlipForRadius(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z, 100.0)

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 60)

	local blip = AddBlipForCoord(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z)

	SetBlipSprite (blip, 351)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.2)
	SetBlipColour (blip, 49)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('Money_Laundering'))
	EndTextCommandSetBlipName(blip)
end)


-------------------------------------------------
-- Fonctions
-------------------------------------------------
-- Fonction selection nouvelle mission livraison
function MissionLivraisonSelect()
	local amount = livraisonTotalPaye-argentretire
    TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect num")
    TriggerServerEvent('esx:clientLog', MissionRegion)
	if MissionRegion == 0 then

            TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect 1")
     TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
	print('Payout Started')
		MissionRegion = math.random(1,2)
	end

	if MissionRegion == 1 then -- Los santos
            TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect 2")
                 TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
            print('Payout Started')
		MissionNum = math.random(1, 10)

		if MissionNum == 1 then destination = Config.Livraison.Delivery1LS namezone = "Delivery1LS" namezonenum = 1 namezoneregion = 1
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2LS namezone = "Delivery2LS" namezonenum = 2 namezoneregion = 1
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3LS namezone = "Delivery3LS" namezonenum = 3 namezoneregion = 1
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4LS namezone = "Delivery4LS" namezonenum = 4 namezoneregion = 1
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5LS namezone = "Delivery5LS" namezonenum = 5 namezoneregion = 1
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6LS namezone = "Delivery6LS" namezonenum = 6 namezoneregion = 1
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7LS namezone = "Delivery7LS" namezonenum = 7 namezoneregion = 1
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8LS namezone = "Delivery8LS" namezonenum = 8 namezoneregion = 1
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9LS namezone = "Delivery9LS" namezonenum = 9 namezoneregion = 1
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10LS namezone = "Delivery10LS" namezonenum = 10 namezoneregion = 1
		end

	elseif MissionRegion == 2 then -- Blaine County

            TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect 3")
            TriggerServerEvent("esx_godilinhrtyjob:pay", amount)
            print('Payout Started')
		MissionNum = math.random(1, 10)

		if MissionNum == 1 then destination = Config.Livraison.Delivery1BC namezone = "Delivery1BC" namezonenum = 1 namezoneregion = 2
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2BC namezone = "Delivery2BC" namezonenum = 2 namezoneregion = 2
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3BC namezone = "Delivery3BC" namezonenum = 3 namezoneregion = 2
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4BC namezone = "Delivery4BC" namezonenum = 4 namezoneregion = 2
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5BC namezone = "Delivery5BC" namezonenum = 5 namezoneregion = 2
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6BC namezone = "Delivery6BC" namezonenum = 6 namezoneregion = 2
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7BC namezone = "Delivery7BC" namezonenum = 7 namezoneregion = 2
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8BC namezone = "Delivery8BC" namezonenum = 8 namezoneregion = 2
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9BC namezone = "Delivery9BC" namezonenum = 9 namezoneregion = 2
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10BC namezone = "Delivery10BC" namezonenum = 10 namezoneregion = 2
		end

	end

	MissionLivraisonLetsGo()
end

-- Fonction active mission livraison
function MissionLivraisonLetsGo()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_delivery'))
	EndTextCommandSetBlipName(Blips['delivery'])

	Blips['annulermission'] = AddBlipForCoord(Config.Livraison.AnnulerMission.Pos.x,  Config.Livraison.AnnulerMission.Pos.y,  Config.Livraison.AnnulerMission.Pos.z)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_goal'))
	EndTextCommandSetBlipName(Blips['annulermission'])

	if MissionRegion == 1 then -- Los santos
		ESX.ShowNotification(_U('meet_ls'))
	elseif MissionRegion == 2 then -- Blaine County
		ESX.ShowNotification(_U('meet_bc'))
	elseif MissionRegion == 0 then -- au cas ou
		ESX.ShowNotification(_U('meet_del'))
	end

	MissionLivraison = true
end

--Fonction retour au depot
function MissionLivraisonStopRetourDepot()
	destination = Config.Livraison.RetourCamion

	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_depot'))
	EndTextCommandSetBlipName(Blips['delivery'])

	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	ESX.ShowNotification(_U('return_depot'))

	MissionRegion = 0
	MissionLivraison = false
	MissionNum = 0
	MissionRetourCamion = true
end

function SavePlaqueVehicule()
	plaquevehicule = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function VerifPlaqueVehiculeActuel()
	plaquevehiculeactuel = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end
]]

local ruatien = {}
RegisterNetEvent("esx_godilinhrtyjob:load2")
AddEventHandler("esx_godilinhrtyjob:load2", function()
	if not ruatien[source] then
		TriggerClientEvent("esx_godilinhrtyjob:load1", source, code)
  		ruatien[source] = true
	else
  		return
  	end
end)
