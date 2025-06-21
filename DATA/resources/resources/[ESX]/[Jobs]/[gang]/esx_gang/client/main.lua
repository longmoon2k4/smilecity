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
local colors = { ["GREEN"] = '<span style="color:green;">', ["RED"] = '<span style="color:red;">', ["END"] = '</span>' }
local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

--ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
  -- while ESX == nil do
  --   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  --   Citizen.Wait(0)
  -- end
  
    if ESX.IsPlayerLoaded() then
    PlayerData = ESX.GetPlayerData()
    end  
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
  PlayerData = response
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
  PlayerData.job2 = job2
end)

Citizen.CreateThread(function()

  for k,v in pairs(Config.Gangs) do
    if v.JobName ~= nil then
      TriggerServerEvent('esx_gangScript:registerSocieties', v.JobName)
    end
    if v.Blip ~= nil then
      if v.gang ==true then
        local blip = AddBlipForRadius(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z, 100.0)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, v.Blip.Colour)
        SetBlipAlpha(blip, 60)
      end
      
      local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)
      SetBlipSprite (blip, v.Blip.Sprite)
      SetBlipDisplay(blip, v.Blip.Display)
      SetBlipScale  (blip, v.Blip.Scale)
      SetBlipColour (blip, v.Blip.Colour)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(v.Blip.Name)
      EndTextCommandSetBlipName(blip)
    end
  end

  while true do
    local sleepThread = 1000
    local isInMarker     = false
    local currentStation = nil
    local currentPart    = nil
    local currentPartNum = nil
    local hasExited = false   
    for k,v in pairs(Config.Gangs) do
      if PlayerData.job2 ~= nil and PlayerData.job2.name == v.JobName then
        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)
        
        if v.Armories ~= nil then 
          for i=1, #v.Armories, 1 do
            if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
              sleepThread = 1
            end
            
            if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'Armory'
              currentPartNum = i
            end         
          end
        end

        -- if v.Cloakrooms ~= nil then
        --             for i=1, #v.Cloakrooms, 1 do
        --     if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
        --       DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
        --       sleepThread = 5
        --     end
            
        --     if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
        --       isInMarker     = true
        --       currentStation = k
        --       currentPart    = 'Cloakrooms'
        --       currentPartNum = i
        --     end         
        --   end
        -- end 

        if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then
          if
            (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
            (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
          then
            TriggerEvent('esx_gangScript:hasExitedMarker', LastStation, LastPart, LastPartNum)
            hasExited = true
          end
          
          HasAlreadyEnteredMarker = true
          LastStation             = currentStation
          LastPart                = currentPart
          LastPartNum             = currentPartNum        
          TriggerEvent('esx_gangScript:hasEnteredMarker', currentStation, currentPart, currentPartNum)  
        end

        if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
          HasAlreadyEnteredMarker = false
          TriggerEvent('esx_gangScript:hasExitedMarker', LastStation, LastPart, LastPartNum)
        end
        
        if CurrentAction ~= nil then
          ESX.ShowHelpNotification(CurrentActionMsg)
          -- SetTextComponentFormat('STRING')
          -- AddTextComponentString(CurrentActionMsg)
          -- DisplayHelpTextFromStringLabel(0, 0, 1, -1)

          if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 150 then
            if CurrentAction == 'menu_armory' then
              if GetFakeWantedLevel() <= 0 then
                OpenArmoryMenu(CurrentActionData.station, v.JobName)
              else
                ESX.ShowNotification("~r~Bạn đang bị truy nã không thể mở kho!")
              end
            elseif CurrentAction == 'menu_boss_actions' then    
              ESX.UI.Menu.CloseAll()
              TriggerEvent('esx_society:openBoslinhSocsMenu2', v.JobName, function(data, menu)
              menu.close()
              CurrentAction     = 'menu_boss_actions'
              CurrentActionMsg  = _U('open_bossmenu')
              CurrentActionData = {}
              end, {grades = false})
            elseif CurrentAction == 'menu_vehicle_spawner' then
              OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum, v.JobName)
            elseif CurrentAction == 'delete_vehicle' then
              ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
            elseif CurrentAction == 'menu_Cloakrooms' then
              Cloakroomsthaydo(v.JobName)
            end 
          CurrentAction = nil
          GUI.Time      = GetGameTimer()
          end
        end     
      end
    end
    Citizen.Wait(sleepThread)
  end
end)

function Cloakroomsthaydo(societyName)
  local elements = {}
  table.insert(elements, {label = 'Áo quần gangster' , value = 'gang'}) 
  table.insert(elements, {label = 'Áo quần của bạn' , value = 'bth'}) 
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'thaydo_vehicle',
    {
      title    = 'Phòng thay đồ',
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)
    if data.current.value == 'gang' then
      setUniform(societyName, GetPlayerPed(-1))
      menu.close()
    elseif data.current.value == 'bth' then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
            TriggerEvent('skinchanger:loadSkin', skin) 
        end)
            menu.close()
    end
  end,
  function(data, menu)
  menu.close()
    end)  
end

function setUniform(job2, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      if Config.Uniforms[job2].male then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job2].male)
      else
        ESX.ShowNotification('không tìm thấy')
      end
    else
      if Config.Uniforms[job2].female then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job2].female)
      else
        ESX.ShowNotification('không tìm thấy')
      end
    end
  end)
end


function OpenVehicleSpawnerMenu(station, partNum, societyName)
  local elements = {}
  table.insert(elements, {label = 'Xe Gang' , value = 'faggio3'}) 
  table.insert(elements, {label = 'Xe Gang 2' , value = 'btype3'})
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'spawn_vehicle',
    {
      title    = 'Gara xe',
      align    = 'bottom-right',
      elements = elements,
    },
    function(data, menu)
      menu.close()
      SpawnVehicle(data.current.value, station, partNum)
    end,
    function(data, menu)
      menu.close()
    end
  ) 
end

function SpawnVehicle(vehicle, station, garageNumber)
  ESX.Game.SpawnVehicle(vehicle, Config.Gangs[station].Vehicles[garageNumber].SpawnPoint, Config.Gangs[station].Vehicles[garageNumber].Heading, function(vehicle)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
  end)
end
function OpenArmoryMenu(station, societyName)
    local elements = {}

  -- table.insert(elements, {label = 'Kho súng', value = 'buy_weapon'})
  table.insert(elements, {label = 'Kho đồ',  value = 'khodo'})  

  ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'bottom-right',
        elements = elements,
      },
      function(data, menu)
    if data.current.value == 'khodo' then
      --TriggerEvent('esx_inventoryhud:openGangInventory')
      exports.ox_inventory:openInventory('stash', societyName)
    --  exports.ox_inventory:openInventory('gang', {id=societyName,name='kho '..societyName,weight=1000000000})
    end
    menu.close()
      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
    end)
end


function OpenBuyWeaponsMenu(societyName)
  local elements = {}
      for k,v in pairs(Config.AuthorizedWeapons[societyName]) do
        table.insert(elements, {label = v.label, value = v.weapon, giatien = v.price}) 
      end
  ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'shopwweapon',
      {
        title    = 'Súng Gangster',
    align    = 'bottom-right',    
        elements = elements
      },
      function(data, menu)
        menu.close()
        local weaponmua = data.current.value
        local weapongiatien = data.current.giatien
        TriggerServerEvent('esx_gang:Scriptbuyweapona', weaponmua, weapongiatien)
    end,
    function(data2, menu2)
    menu2.close()
    end)
end

AddEventHandler('esx_gangScript:hasEnteredMarker', function(station, part, partNum)
  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end


  if part == 'VehicleDeleter' then
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    if IsPedInAnyVehicle(playerPed,  false) then
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end
    end
  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

  if part == 'Cloakrooms' then
    CurrentAction     = 'menu_Cloakrooms'
    CurrentActionMsg  = 'open_Cloakrooms'
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_gangScript:hasExitedMarker', function(station, part, partNum)

  ESX.UI.Menu.CloseAll()
  exports.ox_inventory:closeInventory()
  CurrentAction = nil
end)
