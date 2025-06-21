
-- ESX = nil 

-- Citizen.CreateThread(function()
--     while ESX == nil do 
--         Wait(1)
--         TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--     end
-- end)

RegisterCommand("thongbao", function(source, args, rawCommand)
  -- local xPlayer = ESX.GetPlayerFromId(source) 
  -- if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
    local str = ''
    local dem = 0
    for k,v in ipairs(args) do
      str = str .. v .. ' '
      dem = dem + 1
    end
    TriggerClientEvent('nui:on', -1, str)
    Citizen.Wait((dem+4)*2200)
    TriggerClientEvent('nui:off', -1)
  -- end
end, true)
RegisterCommand("_thongbao", function(source, args, rawCommand)
  
  if source==0 then
    local str = ''
    local dem = 0
    for k,v in ipairs(args) do
      str = str .. v .. ' '
      dem = dem + 1
    end
    TriggerClientEvent('nui:on', -1, str)
    Citizen.Wait((dem+4)*2200)
    TriggerClientEvent('nui:off', -1)
  end
end)
RegisterServerEvent('esx_Tbao:thongbao')
AddEventHandler('esx_Tbao:thongbao',function(text)
  Citizen.CreateThread(function()
    local dem = _demtext(text)
    TriggerClientEvent('nui:on', -1, text)
    Citizen.Wait((dem+3)*5200)
    TriggerClientEvent('nui:off', -1)
  end)
end)
function _demtext(str)
  local dem = 0
  for i in string.gmatch(str, "%S+") do
    dem = dem + 1
  end
  return dem
end