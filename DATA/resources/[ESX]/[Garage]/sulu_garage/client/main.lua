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

--ESX = nil
blip = nil
rt = nil
Garages = {}
Garages.__index = Garages
vehicleList = {}
function check(plate)
	for k,v in pairs(vehicleList) do
		if plate == v.plate then
			if v.time >= 0 then
				return false
			else
				
				return true
			end
		end
	end
end

function checkEx(plate)
	for k,v in pairs(vehicleList) do
		if v.plate == plate then
			return true
		end
	end
end

function getTime(plate)
	for k,v in pairs(vehicleList) do
		if v.plate == plate then
			return v.time
		end
	end
end

function noSpace(str)

	local normalisedString = string.gsub(str, "%s+", "")
  
	return normalisedString
  
  end

Citizen.CreateThread( function()
	while true do
		if(vehicleList ~= nil) then
			Wait(1)
			for k,v in pairs(vehicleList) do
				if v.time >= 0 then
					v.time = v.time - 1
				else
					table.remove(vehicleList,k)
				end
			end
		end
		Citizen.Wait(999)
	end
end)

function Garages:Create()
	
	local obj = {}
	setmetatable(obj, Garages)
	obj.garages = {}
	obj.blips = {}
	obj.PlayerData = ESX.GetPlayerData()
	obj.curAction = nil
	obj.shouldShowHelp = true
	obj.curGarage = nil
	obj.curGarageType = ''
	obj.isUIOpen = false
	obj.allHousing = nil
	return obj
end

function Garages:AddGarage(type, name, data)
	self.garages[name] = data
	if data.car == 'aircraft' and data.Gang == nil then
		local blip = AddBlipForCoord(data.GaragePoint.x, data.GaragePoint.y, data.GaragePoint.z)
		SetBlipSprite(blip, 43)
		SetBlipScale(blip, 0.65)
		SetBlipColour(blip, 33)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('CUSTOM_STRING')
		AddTextComponentSubstringPlayerName("<FONT FACE='arial font'>Gara Máy bay")
		EndTextCommandSetBlipName(blip)
		table.insert(self.blips, blip)
	elseif data.car == 'car'and data.Gang == nil then
		local blip = AddBlipForCoord(data.GaragePoint.x, data.GaragePoint.y, data.GaragePoint.z)
		SetBlipSprite(blip, 290)
		SetBlipScale(blip, 0.65)
		SetBlipColour(blip, 38)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('CUSTOM_STRING')
		AddTextComponentSubstringPlayerName("<FONT FACE='arial font'>Gara Công Cộng")
		EndTextCommandSetBlipName(blip)
		table.insert(self.blips, blip)
    elseif data.car == 'boat' and data.Gang == nil then
        local blip = AddBlipForCoord(data.GaragePoint.x, data.GaragePoint.y, data.GaragePoint.z)
		SetBlipSprite(blip, 356)
		SetBlipScale(blip, 0.65)
		SetBlipColour(blip, 3)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('CUSTOM_STRING')
		AddTextComponentSubstringPlayerName("<FONT FACE='arial font'>Gara Thuyền")
		EndTextCommandSetBlipName(blip)
		table.insert(self.blips, blip)
	end
end

function Garages:CheckPos()
	for k, v in pairs(self.garages) do 
		if not v.Gang or v.Gang == self.PlayerData.job2.name or v.Gang == self.PlayerData.job.name then
			if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) <= 1.0 then 
				self.curGarage = k
				self.curAction = 'GaragePoint'
				self.curGarageType = v.car
				return
			elseif GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) <= 5.0 then
				self.curGarage = k
				self.curAction = 'DeletePoint'
				self.curGarageType = v.car
				return
			end
		end
	end
	self.curAction = nil
	return
end

function Garages:DrawMarker()
	for k, v in pairs(self.garages) do 
		if not v.Gang or v.Gang == self.PlayerData.job2.name or v.Gang == self.PlayerData.job.name  then
			if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) <= 20.0  then 
				DrawMarker(6, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 2.0, 2.0, 2.0, 22, 199, 154, 150, false, false, 2, nil, nil, false)
				self.sleep = true
				return
			end
			if v.Type and v.Type == 14 then 
				if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) <= 100.0 and IsPedInAnyVehicle(self.ped, false) then
					DrawMarker(6, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 30.0, 30.0, 30.0, 189, 32, 0, 150, false, false, 2, nil, nil, false)
					self.sleep = true
					return
				end
			else
				if GetDistanceBetweenCoords(self.pedCoords.x, self.pedCoords.y, self.pedCoords.z, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) <= 20.0 and IsPedInAnyVehicle(self.ped, false) then
					DrawMarker(6, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 0.99, 0.0, 0.0, 0.0, 270.0, 0.0, 0.0, 8.0, 8.0, 8.0, 189, 32, 0, 150, false, false, 2, nil, nil, false)
					self.sleep = true
					return
				end
			end
		end
	end
	self.sleep = false
	return
end

function Garages:EventHandler()
	RegisterNetEvent("esx:playerLoaded")
	AddEventHandler("esx:playerLoaded", function(xPlayer)
		self.PlayerData = xPlayer
	end)
	RegisterNetEvent("esx:setJob")
	AddEventHandler("esx:setJob", function(job)
		self.PlayerData.job = job
	end)
	RegisterNetEvent("esx:setJob2")
	AddEventHandler("esx:setJob2", function(job)
		self.PlayerData.job2 = job

	end)
	RegisterNUICallback('escape', function(data, cb)
		self.isUIOpen = false
		self.shouldShowHelp = true
		-- if self.allHousing ~= nil then
		-- 	self.allHousing = nil
		-- end
		SetNuiFocus(false, false)
		SendNUIMessage({
			type = "close",
		})
	end)
	RegisterNUICallback('spawnVehicle', function(data)
		self:SpawnVehicle(data.vehicle, data.plate, data.vehBody, data.vehEngine)
	end)
	RegisterNUICallback('returnVehicle', function(data)
		self:ReturnVehicle(data.vehicle, data.plate, data.vehBody, data.vehEngine)
	end)
	RegisterNUICallback("changeName", function(data, cb)
        local input = lib.inputDialog('Đổi tên xe', { {type = 'input', label = 'Nhập tên',  required = true, min = 4, max = 32},})
        if input[1] then
            TriggerServerEvent("esx_advancedgarage:changeName", data.plate, input[1])
        end
		hasAlreadyEnteredMarker = false
	end)
	RegisterNUICallback("deleteVehicle", function(data, cb)
        local alert = lib.alertDialog({
            header = 'Bạn có chắc muốn xóa xe '..data.name..' với biển số '..data.plate,
            centered = true,
            cancel = true,
            labels ={
                cancel = 'Hủy',
                confirm = 'Xác nhận'
            }
        })
        if alert=='confirm' then
		    TriggerServerEvent("sulu_garage:server:deleteVehicle", data.plate)
        end
	end)
	RegisterNUICallback("Unimpound", function(data, cb)
		ESX.TriggerServerCallback("sulu_garage:callback:getImpoundData", function(result)
			cb(result)
		end, data)
	end)
    RegisterNUICallback("unimpoundVehice", function(data, cb)
        ESX.TriggerServerCallback("sulu_garage:callback:getImpoundData", function(result,dateTable)
            local alert = lib.alertDialog({
                header = 'Chuộc xe ',
                content = 'Xe của bạn với biển số: '..result.plate..'  \n Bị giam bởi: '..result.officer..' \n Với lý do: '..result.reason..' \n Ngày hết hạn: '..dateTable.day..'/'..dateTable.month..'/'..dateTable.year..' \n Giá: '..result.fine,
                centered = true,
                cancel = true,
                labels ={
                    cancel = 'Hủy',
                    confirm = 'Chuộc'
                }
            })
            if alert=='confirm' then
                ESX.TriggerServerCallback("sulu_garage:callback:unimpound", function(result1)
                    if result1 == true then 
                        self:SpawnVehicle(data.vehicle, data.plate, data.vehBody, data.vehEngine)
                    end
                end, data.plate)
            end
		end, data)
	end)
	AddEventHandler("sulu_garage:allhousingGarage", function(coords)
		self.allHousing = coords
		self.curGarageType = 'car'
		self:OpenGarage()
	end)
end

function Garages:SpawnVehicle(vehicle, plate,body, engine)
	local vinBody = tonumber(body) + 0.0
	local vinEngine = tonumber(engine) + 0.0
	TriggerServerEvent("sulu_garage:server:removeOldVehicle", plate)
	--table.insert(vehicleList,{plate = plate, time = 5})
	Wait(1500)
	if  self.allHousing == nil then
		if ESX.Game.IsSpawnPointClear(self.garages[self.curGarage].SpawnPoint, 3.0) then
			ESX.Game.SpawnVehicle(vehicle.model, {
				x = self.garages[self.curGarage].SpawnPoint.x,
				y = self.garages[self.curGarage].SpawnPoint.y,
				z = self.garages[self.curGarage].SpawnPoint.z
			}, self.garages[self.curGarage].SpawnPoint.h, function(cbVeh)
				ESX.Game.SetVehicleProperties(cbVeh, vehicle)
				TriggerEvent('sulu_keycar:acceptData',string.gsub(vehicle.plate, "%s+", ""))
				SetVehRadioStation(cbVeh, "OFF")
				TaskWarpPedIntoVehicle(self.ped, cbVeh, -1)
				SetVehicleFuelLevel(cbVeh, vehicle.fuelLevel + 0.0)
				SetVehicleEngineHealth(cbVeh, vinEngine)
				SetVehicleBodyHealth(cbVeh, vinBody)
				TriggerServerEvent("sulu_garage:server:setState", plate, false)
				if blip~= nil then
					RemoveBlip(blip)
					blip = nil
				end
				blip = AddBlipForEntity(cbVeh)
				SetBlipSprite(blip,162)
				SetBlipColour(blip,2)
				SetBlipAsShortRange(blip,false)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Xe của bạn")
				EndTextCommandSetBlipName(blip)
			end)
		else
			ESX.ShowNotification("~r~Có phương tiện đang đậu tại chỗ đậu vui lòng thử lại !")
		end
	else
		ESX.Game.SpawnVehicle(vehicle.model, {
			x = self.allHousing.x,
			y = self.allHousing.y,
			z = self.allHousing.z
		}, self.allHousing.w, function(cbVeh)
			ESX.Game.SetVehicleProperties(cbVeh, vehicle)
			SetVehRadioStation(cbVeh, "OFF")
				TaskWarpPedIntoVehicle(self.ped, cbVeh, -1)
				SetVehicleFuelLevel(cbVeh, vehicle.fuelLevel + 0.0)
				SetVehicleEngineHealth(cbVeh, vinEngine)
				SetVehicleBodyHealth(cbVeh, vinBody)
				self.allHousing = nil
				TriggerServerEvent("sulu_garage:server:setState", plate, false)
				if blip~= nil then
					RemoveBlip(blip)
					blip = nil
				end
				blip = AddBlipForEntity(cbVeh)
				SetBlipSprite(blip,162)
				SetBlipColour(blip,2)
				SetBlipAsShortRange(blip,false)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("Xe của bạn")
				EndTextCommandSetBlipName(blip)
		end)
	end
end

function Garages:ReturnVehicle(vehicle, plate,body, engine)
	-- local check = check(plate)
	-- if check == true or check == nil then
	if self.allHousing == nil then
		if ESX.Game.IsSpawnPointClear(self.garages[self.curGarage].SpawnPoint, 3.0) then
			ESX.TriggerServerCallback("sulu_garage:server:returnVehicle", function(canReturn)
				if canReturn then 
					 ESX.ShowNotification(("Bạn đã trả ~g~%s$~w~ để chuộc phương tiện ~y~[%s]~w~"):format(Config.ReturnPrice, plate))
					 self:SpawnVehicle(vehicle, plate,body, engine)
				else
					ESX.ShowNotification(("Bạn không đủ ~g~%s$~w~ để chuộc phương tiện ~y~[%s]~w~"):format(Config.ReturnPrice, plate))
				end
			end)
		else
			ESX.ShowNotification("~r~Có phương tiện đang đậu tại chỗ đậu vui lòng thử lại !")
		end
	else
		ESX.TriggerServerCallback("sulu_garage:server:returnVehicle", function(canReturn)
			if canReturn then 
				ESX.ShowNotification(("Bạn đã trả ~g~%s$~w~ để chuộc phương tiện ~y~[%s]~w~"):format(Config.ReturnPrice, plate))
				self:SpawnVehicle(vehicle, plate,body, engine)
			else
				ESX.ShowNotification(("Bạn không đủ ~g~%s$~w~ để chuộc phương tiện ~y~[%s]~w~"):format(Config.ReturnPrice, plate))
			end
		end)
	end
	-- else
	-- 	ESX.ShowNotification("~r~Còn "..getTime(plate).."giây nữa để chuộc phương tiện! ")
	-- end
end

function Garages:OpenGarage(_type)
	ESX.TriggerServerCallback("sulu_garage:server:getOwnedVehicles", function(result)
		if #result == 0 then 
			ESX.ShowNotification("Bạn không có phương tiện nào ")
			self.shouldShowHelp = true
		else
			-- if GetFakeWantedLevel() <= 0 then
				local data = {}
				for k, v in pairs(result) do 
					if _type ~= nil then
						-- if tonumber(v.type) == tonumber(_type) then
							--print(v.plate)
							local vehModel = v.vehicle.model
							local vehName = v.customName or GetDisplayNameFromVehicleModel(vehModel)
							local vehPlate = v.plate
							table.insert(data, {value = v, vehicle = v.vehicle,vehEngine = v.vehicle.engineHealth, vehBody = v.vehicle.bodyHealth, name = vehName, plate = vehPlate, stored = v.stored,  soluong = v.soluong, impound = v.impound, type=v.type})
						-- end
					else
						-- if tonumber(v.type) ~= 14 and tonumber(v.type) ~= 15 and tonumber(v.type) ~= 16 and tonumber(v.type) ~= 19 then
							local vehModel = v.vehicle.model
							local vehName = v.customName or GetDisplayNameFromVehicleModel(vehModel)
							local vehPlate = v.plate
							table.insert(data, {value = v, vehicle = v.vehicle, vehEngine = v.vehicle.engineHealth, vehBody = v.vehicle.bodyHealth, name = vehName, plate = vehPlate, stored = v.stored, soluong = v.soluong, impound = v.impound, type=v.type})
						-- end
					end
				end
				SetNuiFocus(true, true)
				SendNUIMessage({
					type = "shop",
					result = data,
					pos = "getVehicle",
				})
				self.isUIOpen = true
			-- else
			-- 	ESX.ShowNotification("~r~Bạn đang bị truy nã không thể mở garage!")
			-- end
		end
	end, self.curGarageType)
end

function Garages:ParkVehicle()
	local veh = GetVehiclePedIsIn(self.ped, false)
	if GetPedInVehicleSeat(veh, -1) ~= self.ped then 
		return
	end
	local vehProps = ESX.Game.GetVehicleProperties(veh)
	local vehPlate = GetVehicleNumberPlateText(veh)
	ESX.TriggerServerCallback("sulu_garages:server:parkVehicle", function(result)
		-- if GetFakeWantedLevel() <= 0 then
			if result == true then 
				ESX.Game.DeleteVehicle(veh)
				-- for k,v in pairs (vehicleList) do
				-- 	if noSpace(vehPlate) == v.plate  then
				-- 		table.remove(vehicleList,k)
				-- 	end
				-- end
				if self.garages[self.curGarage].tp then 
					ESX.Game.Teleport(PlayerPedId(), self.garages[self.curGarage].TelePoint)
				end
				ESX.ShowNotification(("Phương tiện ~y~[%s]~w~ đã được cất vào GARAGE"):format(vehPlate))
			else
				ESX.ShowNotification("~r~Đây không phải là phương tiện của bạn")
			end
		-- else
		-- 	ESX.ShowNotification("~r~Bạn đang bị truy nã không thể cất xe!")
		-- end
	end, vehPlate, vehProps)
end

function Garages:MainThread()
	Citizen.CreateThread(function()
		while true do 
			self.ped = PlayerPedId()
			self.player = PlayerId()
			coroutine.yield(0)
			self.pedCoords = GetEntityCoords(self.ped)
			self:CheckPos()
			self:DrawMarker()
			if self.sleep==false then
				Citizen.Wait(1000)
			end
			if self.curGarage ~= nil and self.curAction ~= nil then 
				if self.shouldShowHelp then 
					ESX.ShowHelpNotification(Config.HelpNotification[self.curAction])
					if IsControlJustReleased(0, 38)  then 
						if GetFakeWantedLevel() <= 0 then
							if self.curAction == 'GaragePoint' and not self.isUIOpen then 
								self.shouldShowHelp = false
								self:OpenGarage(self.garages[self.curGarage].Type)
							elseif self.curAction == 'DeletePoint' then
								self:ParkVehicle()
							end
						else
							ESX.ShowNotification("~r~Bạn đang bị truy nã không thể thao tác!")
						end
					end
				end
			end
		end
	end)
end

Citizen.CreateThread(function()

	while not ESX.IsPlayerLoaded() do 
		Wait(0)
	end
	rt = Garages:Create()
	for k, v in pairs(Config.Garages) do 
		rt:AddGarage('default', k, v)
	end
	rt:EventHandler()
	rt:MainThread()
    -- exports.ox_target:addGlobalVehicle({
    --     {
    --         name = 'car',
    --         icon = 'fa-solid fa-cart-flatbed-suitcase',
    --         label = "Lụm ve chai",
    --         distance = 2.5,
    --         onSelect = function(data)
    --             lum(data.entity)
    --         end
    --     },
    -- })
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local veh = GetVehiclePedIsIn(ped, false)
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			local vehPlate = GetVehicleNumberPlateText(veh)
			local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
			TriggerServerEvent('setXeSync',vehPlate, vehProps, model)
		end
	end
end)

function lum(entity)
    if IsVehicleDriveable(entity, true)  then
        ESX.ShowNotification("~r~Xe đã hư đâu mà nhặt ve chai ní!")
    else
        if DoesEntityExist(entity) then
            TriggerServerEvent('sulu_garage:nhatvechai',NetworkGetNetworkIdFromEntity(entity))
        end
    end
end


