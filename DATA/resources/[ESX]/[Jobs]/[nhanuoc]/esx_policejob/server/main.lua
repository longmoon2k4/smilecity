--ESX = nil
local webhook1 = 'https://discord.com/api/webhooks/tatwebhooks/967981917846786099/7d8MXcDTFfwHOmeG2tuErJxr3uAqm3Z7kO11gM8w2COpb_ODlpCVIyBnjBe__vJN-W0n'
local webhook2 = 'https://discord.com/api/webhooks/tatwebhooks/967981917846786099/7d8MXcDTFfwHOmeG2tuErJxr3uAqm3Z7kO11gM8w2COpb_ODlpCVIyBnjBe__vJN-W0n'
local webhook = 'https://discord.com/api/webhooks/tatwebhooks/1052045575241076756/Y6hiL7iw65iumpoZ2WerheeyRnZif1cjTRwVwQxoVbn__vkS8l8D-BOXDcQg0mFLoyNH'
local webhookCA = 'https://discord.com/api/webhooks/tatwebhooks/1098481765082988554/64J7RV78CsaejdAfGvK1pBzW4tAiLlakMvXky91i5-a2YLSdCGfHaz6S335SpYxELhoz'
local key = { ["repairkit"]= 1 ,["access_key"]=1, ["alive_chicken"]=40, ["armor3"]=5, ["armorcashshop"]=2, ["armorpolice"]=5, ["armorpolicexin"]=1, ["bandage"]=30, ["banthietkear"]=99, ["banthietkeshotgun"]=99,["banthietkesmg"]=99,
["beer"]=50, ["blowpipe"]=10, ["blowtorch"]=10, ["boombox"]=10, ["boong"]=10, ["boxbig"]=100, ["bread"]=50, ["burnerphone"]=1, ["c4_bank"]=10, ["cannabis"]=15, ["carokit"]=10, ["carotool"]=10, ["casino_chips"]=9999999999, ["casino_ticket"]=100,
["clothe"]=40, ["coca_leaf"]=20, ["coin0"] =100, ["coin1"] =100, ["coin2"] =100, ["coin3"] =100, ["coin4"] =100, ["coin5"] =100, ["coke1g"]=10, ["contract"]=10, ["copper"]=100, ["cutted_wood"]=40, ["dabo"]=40, ["dausungar"]=99, ["dausungshotgun"]=99,
["dausungsmg"]=99, ["diamond"]=100, ["dien_lan"]=20, ["dragon"]=99, ["duoisungar"]=99, ["duoisungshotgun"]=99, ["duoisungsmg"]=99, ["essence"]=40, ["extraweight"]=10	, ["fabric"]=40, ["fish"]=40, ["fishingrod"]=40,["fixkit"]=20, ["fixtool"]=10,
["flashlight"]=1, ["gacha_01"]=99, ["gacha_02"]=99, ["gazbottle"]=1, ["giaysunglienthanh"]=1, ["gold"]=100, ["golf"]=20, ["grip"]=10, ["heroin"]=10, ["hifi"]=10, ["hommayman"]=99, ["hydrochloric_acid"]=20, ["iron"]=100, ["jewels"]=100, ["khungsungar"]=99, ["khungsungshotgun"]=99, ["khungsungsmg"]=99, ["LaundryCard"]=100,
["lighters"]=10, ["lockpick"]=10, ["marijuana"]=15, ["mayrungtim"]=10, ["medikit"]=20, ["medikitlangbam"]=20, ["medlangbam"]=10, ["meth1g"]=20, ["oxygenmask"]=10, ["packaged_chicken"]=40, ["packaged_plank"]=40, ["petrol"]=40, ["petrol_raffin"]=40,
["phone"]=1, ["plastic"]=30, ["poppyresin"]=30, ["premium_pass"]=10, ["radio"]=1, ["raspberry"]=10, ["repairkit"]=10, ["roll"]=10, ["scope"]=10, ["shark"]=10, ["skin"]=99, ["skin_vandal"]=99, ["skinakprime"]=99, ["skinakt1"]=99, ["sking3t1"]=99,
["skinm4hh"]=100, ["skinuzias"]=100, ["slaughtered_chicken"]=40, ["sniper_clip"]=1, ["spray"]=10, ["spray_remover"]=10, ["stones"]=40, ["thansungar"]=99, ["thansungsmg"]=99, ["thep"]=10, ["trash"]=10, ["turtle"]=40, ["turtlebait"]=50, ["tyrekit"]=10,
["uvlight"]=10, ["vaccine"]=10,["washedstones"]=40, ["water"]=50, ["wood"]=40, ["wool"]=40, ["fashion_angelring"]=99, ["fashion_angelwing"]=99, ["fashion_angelwing19"]=99, ["fashion_angelwing2"]=99, ["fashion_angelwing3"]=99, ["fashion_anglewing"]=99,["fashion_arcadeahri"]=99, ["fashion_bearhat"]=99,
["fashion_birdcooper"]=99, ["fashion_chii"]=99, ["fashion_demonwing"]=99, ["fashion_heartpink"]=99, ["fashion_hellwing"]=99, ["fashion_pcube2"]=99, ["fashion_pcube22"]=99, ["fashion_pcube222"]=99, ["fashion_pcube2222"]=99, ["fashion_sunglasses"]=99, ["fashion_wingsrender"]=99, ["mamuang_acc_cat_perched"]=99,
["mamuang_acc_hatcat"]=99, ["Seal"]=99, ["ammo_rifle"] = 9999,["ammo_smg"] = 9999, ["ammo_pistol"] = 9999,["ammo_shotgun"] = 9999,["hopkim"] = 20,["hopden"] = 20, ["thunggo"] = 20,["khovai"] = 20,["homlaprap"] = 20,["phidau"] = 20,
}
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
	end
end



RegisterNetEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, name, amount, label, slot)
	local _source = source
	if itemType =='item_weapon' then
		-- local fromInventory = exports.ox_inventory:GetInventory(target)
		-- local toInventory =  exports.ox_inventory:GetInventoryItems("police", false)
		--  local slotInv = exports.ox_inventory:GetEmptySlot('police')
		-- exports.ox_inventory:SwapSlots(target, 'police', slot, slotInv)
		TriggerClientEvent("esx_policejob:callbackthudo",target,_source,slot,amount)
	else
		if exports.ox_inventory:RemoveItem(target, name, tonumber(amount)) then
			exports.ox_inventory:AddItem('police', name, tonumber(amount))
		end
	end
	--TriggerClientEvent("esx_policejob:callbackthudo",target,_source,slot,amount)
	sendDiscord(webhook,"Thu đồ", '***'..GetPlayerName(_source).. ' thu ' ..amount..' ' ..label.. ' cua ' ..GetPlayerName(target)..' ')
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:handcuff', target)
	else
		print(('esx_policejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:drag', target, source)
	else
		print(('esx_policejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	else
		print(('esx_policejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	else
		print(('esx_policejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, inventoryItem.name))
				TriggerEvent("DiscordBot:LogDiscord",webhook1,'***'..GetPlayerName(_source).. '*** đã lấy  ' .. count.. ' với ' ..inventoryItem.name )
			else
				xPlayer.showNotification(_U('quantity_invalid'))
			end
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)

RegisterNetEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, inventoryItem.name))
		 TriggerEvent("DiscordBot:LogDiscord",webhook2,'***'..GetPlayerName(source).. '*** đã cất ' ..count.. ' với ' ..inventoryItem.name)
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)

-- ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target, notify)
-- 	local xPlayer = ESX.GetPlayerFromId(target)

-- 	if notify then
-- 		xPlayer.showNotification(_U('being_searched'))
-- 	end
-- 	xPlayer.showNotification('~r~'..GetPlayerName(source).." ~s~đang lục soát người bạn.")
-- 	if xPlayer then
-- 		local xPlayer = ESX.GetPlayerFromId(target)

-- 		local data = {
-- 			name       = GetPlayerName(target),
-- 			job        = xPlayer.getJob(),
-- 			inventory  = xPlayer.getInventory(),
-- 			accounts   = xPlayer.getAccounts(),
-- 			weapons    = xPlayer.loadout
-- 		}

-- 		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
-- 			if status then
-- 				data.drunk = math.floor(status.percent)
-- 			end
-- 		end)

-- 		TriggerEvent('esx_license:getLicenses', target, function(licenses)
-- 			data.licenses = licenses
-- 		end)

-- 		cb(data)
-- 	end
-- end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target, notify)
	TriggerClientEvent('esx:showNotification',target,'~r~'..GetPlayerName(source).." ~s~đang lục soát người bạn.")
	cb(exports.ox_inventory:GetInventoryItems(target))
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)

			-- is the owner online?
			if xPlayer then
				retrivedInfo.owner = xPlayer.getName()
				cb(retrivedInfo)
			elseif Config.EnableESXIdentity then
				MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
					['@identifier'] = result[1].owner
				}, function(result2)
					if result2[1] then
						retrivedInfo.owner = ('%s %s'):format(result2[1].firstname, result2[1].lastname)
						cb(retrivedInfo)
					else
						cb(retrivedInfo)
					end
				end)
			else
				cb(retrivedInfo)
			end
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_policejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_policejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)
			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('esx_policejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_policejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_policejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for k,v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

ESX.RegisterServerCallback('esx_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

-- AddEventHandler('playerDropped', function()
-- 	-- Save the source in case we lose it (which happens a lot)
-- 	local playerId = source

-- 	-- Did the player ever join?
-- 	if playerId then
-- 		local xPlayer = ESX.GetPlayerFromId(playerId)

-- 		-- Is it worth telling all clients to refresh?
-- 		if xPlayer and xPlayer.job.name == 'police' then
-- 			Citizen.Wait(5000)
-- 			--TriggerClientEvent('esx_policejob:updateBlip', -1)
-- 		end
-- 	end
-- end)

-- RegisterNetEvent('esx_policejob:spawned')
-- AddEventHandler('esx_policejob:spawned', function()
-- 	local xPlayer = ESX.GetPlayerFromId(playerId)

-- 	if xPlayer and xPlayer.job.name == 'police' then
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_policejob:updateBlip', -1)
-- 	end
-- end)

ESX.RegisterServerCallback('esx_poilicejob:addLicense', function(source, cb, id)
		-- TriggerEvent('esx_license:addLicense', id, 'weapon', function()
		-- 	cb(true)
		-- end)
		local xPlayer = ESX.GetPlayerFromId(id)
		if xPlayer.getInventoryItem("access_key").count == 0 then
			xPlayer.addInventoryItem("access_key", 1)
			cb(true)
		elseif xPlayer.getInventoryItem("access_key").count == 1 then
			cb(false)
		end
end)


ESX.RegisterServerCallback('esx_poilicejob:checkLicense', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(id)
		if xPlayer.getInventoryItem("access_key").count == 0 then
			cb(false)
		elseif xPlayer.getInventoryItem("access_key").count == 1 then
			cb(true)
		end
end)
-- RegisterNetEvent('esx_poilicejob:addLicense')
-- AddEventHandler('esx_poilicejob:addLicense', function()
-- 	TriggerEvent('esx_license:addLicense', source, 'weapon')--, function()
-- 	-- 	cb(true)
-- 	-- end)
-- end)
-- RegisterNetEvent('esx_policejob:forceBlip')
-- AddEventHandler('esx_policejob:forceBlip', function()
-- 	TriggerClientEvent('esx_policejob:updateBlip', -1)
-- end)

-- AddEventHandler('onResourceStart', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_policejob:updateBlip', -1)
-- 	end
-- end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterNetEvent('esx_policebuyarmor',function()

	local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
	if exports.ox_inventory:Search(_source, 'count', 'money') >= Config.ArmorPrice then
		if exports.ox_inventory:CanCarryItem(_source, "armorpolice", 1) then
			exports.ox_inventory:AddItem(_source, 'armorpolice', 1)
			exports.ox_inventory:RemoveItem(_source, 'money', Config.ArmorPrice)
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Bạn không đủ tiền!")
	end
	
end)

RegisterNetEvent('esx_policebuybandage',function()

	local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
	if exports.ox_inventory:Search(_source, 'count', 'money') >= Config.BandagePrice then
		if exports.ox_inventory:CanCarryItem(_source, "bandagepolice", 1) then
			exports.ox_inventory:AddItem(_source, 'bandagepolice', 1)
			exports.ox_inventory:RemoveItem(_source, 'money', Config.BandagePrice)
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Bạn không đủ tiền!")
	end
	
end)

RegisterServerEvent('esx_police:setVehicleOwned')
AddEventHandler('esx_police:setVehicleOwned', function (vehicleProps, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@type']    = 'police'
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, "Bạn đã mua chiếc xe ~y~"..vehicleProps.plate.." ~s~với giá ~g~"..price)
		xPlayer.removeMoney(price)
	end)
end)

ESX.RegisterServerCallback('esx_police:checkVehicles', function(source, cb, model)
	local xPlayer = ESX.GetPlayerFromId(source)
	for k, v in pairs(Config.Vehicles) do 
		if model == v.model then
			cb(v.price < xPlayer.getMoney())
		end
	end
end)

RegisterServerEvent('esx_police:buyWeapon')
AddEventHandler('esx_police:buyWeapon', function (model)
	local _source = source
	local amount 
	for k, v in pairs(Config.Weapon) do 
		if model == v.model then
			amount=v.price
		end
	end

	if exports.ox_inventory:Search(_source, 'count', 'money') >= amount then
		exports.ox_inventory:AddItem(_source, model, 1)
		exports.ox_inventory:RemoveItem(_source, 'money', amount)
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Bạn không đủ tiền!")
	end
end)

RegisterNetEvent('esx_policejob:revive')
AddEventHandler('esx_policejob:revive', function(target)
	TriggerClientEvent('esx_ambulancejob:revive',target)
end)

RegisterNetEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target,text)
	TriggerClientEvent('esx:showNotification',target,text)
	TriggerClientEvent('esx_policejob:removeLicense',target)
end)

RegisterNetEvent('esx_policejob:addLicense')
AddEventHandler('esx_policejob:addLicense', function(target)
    TriggerClientEvent('esx_policejob:addLicense',target)
end)

local cacheGrade = {}

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	cacheGrade[tonumber(playerId)] = tonumber(job.grade)
end)

function getGrade(id)
    if cacheGrade[id] then
        return cacheGrade[id]
    else
        if  ESX.GetPlayerFromId(id) ~=nil then
            cacheGrade[id] = ESX.GetPlayerFromId(id).job.grade
            return cacheGrade[id] 
        end
        return 0
    end
end

local stash = {
    id = 'police',
    label = 'Kho công an',
    slots = 100,
    weight = 100000000,
    owner = false
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner)
    end
end)

local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
    --print(json.encode(payload, { indent = true })) 
    if getGrade(payload.source) < 4  then
        if payload.fromType =='player' and payload.action ~= 'swap' then
            return true
        end
        return false
    end
    return true
end, {
    print = false,
    --itemFilter = {
    --    --money = true,
    --},
    inventoryFilter = {
        '^police',
    }
})

function sendDiscord(webhookurl,name, message)
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
  	PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end

