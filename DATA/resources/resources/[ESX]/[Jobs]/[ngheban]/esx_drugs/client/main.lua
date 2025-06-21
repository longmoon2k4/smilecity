Keys = {
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
local menuOpen = false
local wasOpen = false



Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(-11111)

-- 		if isProcessing == true then
-- 			DisableAllControlActions(0)
-- 		end
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		local coords = GetEntityCoords(PlayerPedId())
		if #(coords - Config.CircleZones.DrugDealer.coords) < 20.0 then
			time = 1
			DrawMarker(20, Config.CircleZones.DrugDealer.coords, 0, 0, 0, 0, 0, 90, 1.0, 1.0, 1.0, 0, 153, 255, 150, true, true, 2, true, false, false, false)
		end
		if #(coords - Config.CircleZones.DrugDealer.coords) < 1.50 then
			
			if not menuOpen then
				ESX.ShowHelpNotification(_U('dealer_prompt'))

				if IsControlJustReleased(0, Keys['E']) then
				       wasOpen = true
					   OpenDrugShop()
				end
			else
				Citizen.Wait(500)
			end
			else
			if wasOpen then
				wasOpen = false
				menuOpen = false
				ESX.UI.Menu.CloseAll()
			end
		end
		Citizen.Wait(time)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(PlayerPedId())

-- 		if GetDistanceBetweenCoords(coords, Config.CircleZones.DrugDealer.coords, true) < 1.50 then
-- 			if not menuOpen then
-- 				ESX.ShowHelpNotification(_U('dealer_prompt'))

-- 				if IsControlJustReleased(0, Keys['E']) then
				
-- 				    --[[if ESX.GetPlayerData().job.name == 'ambulance' or
-- 				       ESX.GetPlayerData().job.name == 'police' or
-- 				       ESX.GetPlayerData().job.name == 'mechanic' then
-- 				       ESX.ShowNotification("Nghề của bạn ~r~không~s~ thể ~y~làm việc~s~ này")
-- 			        else]]
-- 				       wasOpen = true
-- 					   OpenDrugShop()
-- 				    --end
					
-- 				end
-- 			else
-- 				Citizen.Wait(500)
-- 			end
-- 			else
-- 			if wasOpen then
-- 				wasOpen = false
-- 				menuOpen = false
-- 				ESX.UI.Menu.CloseAll()
-- 			end
-- 			Citizen.Wait(500)
-- 		end
-- 	end
-- end)

function OpenDrugShop()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.DrugDealerItems[v.name]
		local price2 = Config.DrugDealerItemsEngough[v.name]
		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s / %s</span>'):format(v.label, _U('dealer_item', ESX.Math.GroupDigits(price)), _U('dealer_item', ESX.Math.GroupDigits(price2))),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = v.count,
				min = 1,
				max = v.count
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
		title    = _U('dealer_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		-- exports["WaveShield"]:TriggerServerEvent("esx_illegal:sellDrug", data.current.name, data.current.value)
		TriggerServerEvent('esx_illegal:sellDrug', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

function OpenBuyLicenseMenu(licenseName)
	menuOpen = true
	local license = Config.LicensePrices[licenseName]

	local elements = {
		{
			label = _U('license_no'),
			value = 'no'
		},

		{
			label = ('%s - <span style="color:green;">%s</span>'):format(license.label, _U('dealer_item', ESX.Math.GroupDigits(license.price))),
			value = licenseName,
			price = license.price,
			licenseName = license.label
		}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_shop', {
		title    = _U('license_title'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value ~= 'no' then
			ESX.TriggerServerCallback('esx_illegal:buyLicense', function(boughtLicense)
				if boughtLicense then
					ESX.ShowNotification(_U('license_bought', data.current.licenseName, ESX.Math.GroupDigits(data.current.price)))
				else
					ESX.ShowNotification(_U('license_bought_fail', data.current.licenseName))
				end
			end, data.current.value)
		else
			menu.close()
		end

	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

-- Display markers
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)

-- 		local coords = GetEntityCoords(PlayerPedId())

-- 		for k,v in pairs(Config.Zones) do
-- 			if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
-- 				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
-- 			end
-- 		end
-- 	end
-- end)

--[[function CreateBlipCircle(coords, text, radius, color, sprite)	
	local blip = AddBlipForRadius(coords, radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)
	-- create a blip in the middle
	blip = AddBlipForCoord(coords)
	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("CUSTOM_TEXT")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end


Citizen.CreateThread(function()
	for k,zone in pairs(Config.CircleZones) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
end)--]]
