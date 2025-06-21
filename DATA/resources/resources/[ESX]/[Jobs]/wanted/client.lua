--ESX = nil
playerDistances = {}
local hideName = {}
--ESX = exports["es_extended"]:getSharedObject()
local connectedPlayerss = {}

-- Citizen.CreateThread(function()
-- 	--while ESX == nil do
-- 	--	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 	--	Citizen.Wait(0)
--    -- end
--     Citizen.Wait(2000)
--     ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
--         --UpdatePlayerTable(connectedPlayers)
--         connectedPlayerss = connectedPlayers
--        -- local dumped = ESX.DumpTable(connectedPlayers)
--        -- print(dumped)
--         --print(connectedPlayers[test].job2)
--     end)
-- end)

 RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
 AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
 	connectedPlayerss = connectedPlayers
 end)
function inArray(source)
    for _, v in pairs(hideName) do
        if v == source then
            return true
        end
    end
    return false
end

function removeArray(source)
    for k, v in pairs(hideName) do
        if v == source then
            table.remove(hideName, k)
            break
        end
    end
    return false
end


AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent("PlayersName:truyna", true)
    ESX.TriggerServerCallback("getListHide", function(data)
       hideName = data
    end)
    ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
        connectedPlayerss = connectedPlayers
    end)
end)

RegisterNetEvent("PlayersName:HideName")
AddEventHandler("PlayersName:HideName", function(id)
    if not inArray(id) then
        table.insert(hideName, id)
    end
end)

RegisterNetEvent("PlayersName:ShowName")
AddEventHandler("PlayersName:ShowName", function(id)
    if inArray(id) then
        removeArray(id)
    end
end)

local disPlayerNames = 70
local TimeTruyNa = 0
local IsTruyNa = false

--====
local PlayerPed = PlayerPedId()
local PlayerId = PlayerId()

RegisterNetEvent("PlayersName:noclip")
AddEventHandler("PlayersName:noclip", function(source)
    

end)

Citizen.CreateThread(function()
    Citizen.Wait(10000)
    while true do

            PlayerPed = PlayerPedId()
            for _, player in ipairs(GetActivePlayers()) do
                if player ~= PlayerId then
                    local wanted = GetPlayerFakeWantedLevel(player)
                    local ped = GetPlayerPed(player)
                    local id = tonumber(GetPlayerServerId(player))
                    if connectedPlayerss[id] ~= nil then
                        --x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPed, true))
                        --x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
                        x1 = GetEntityCoords(PlayerPed, true)
                        x2 = GetEntityCoords(ped, true)
                        distance = math.floor(#(x1 - x2))
                        --distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                        playerDistances[player] = {distance = distance, wanted = wanted, id =GetPlayerServerId(player) , name = GetPlayerName(player), ped = ped, nameTag = connectedPlayerss[id].nameTag}
                         if inArray(playerDistances[player].id) then
                             playerDistances[player]= nil
                         end
                    end
                end
            end

        Citizen.Wait(3000)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(15000)
	while true do
        Citizen.Wait(1)

            local cansee = false
            local text = ""
            for _, player in ipairs(GetActivePlayers()) do
                if playerDistances[player] ~= nil then
                    if player ~= PlayerId then
                    --if true then
                        if playerDistances[player].distance < disPlayerNames and HasEntityClearLosToEntity(PlayerPed, playerDistances[player].ped, 17) then                 
                            cansee,truyna = true,""
                            Coordsped = GetEntityCoords(playerDistances[player].ped)
                            wanted = playerDistances[player].wanted
                            if wanted ~= 0 then local x,logo = 0,'' while x < wanted do logo = logo .. '⭐ '  x = x + 1 end truyna = truyna .. logo end
                            -- if NetworkIsPlayerTalking(player) then 
                            --     text = truyna .. "~n~~g~[" .. playerDistances[player].id  .. "]  ".. playerDistances[player].nameTag .. playerDistances[player].name  .. " 🎙️" 
                            -- else
                                text = truyna .. "~n~[" .. playerDistances[player].id .. "]  ".. playerDistances[player].nameTag  .. playerDistances[player].name
                            -- end
                            DrawText3D(Coordsped["x"], Coordsped["y"], Coordsped["z"]+1.25, text)
                        end
                    end	
                end
            end
            if cansee == false then
            Wait(500)
            end

	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if IsTruyNa then
            TriggerServerEvent("PlayersName:truyna")
        end
    end
end)

RegisterNetEvent("PlayersName:truyna")
AddEventHandler("PlayersName:truyna", function(time,bool, sao)
    TimeTruyNa = time
    IsTruyNa = bool
    if IsTruyNa then
        if TimeTruyNa > 0 then
            if GetFakeWantedLevel() <= 0 then
                SetFakeWantedLevel(sao)
            end
            --TriggerServerEvent('chatMessage', 'Thời gian truy nã còn '..time..' Phút')
            ESX.ShowNotification("Thời gian truy nã còn ~r~"..time.."~s~ Phút")
        elseif TimeTruyNa == 0 then
            ESX.ShowNotification("~r~Bạn đã hết truy nã")
           -- TriggerServerEvent("vuotnguc:xoads")
            SetFakeWantedLevel(0)
            IsTruyNa = false
        end
    end
end)

RegisterNetEvent("TruyNa")
AddEventHandler('TruyNa', function(time,sao)
    TimeTruyNa = time
    IsTruyNa = true
    SetFakeWantedLevel(sao)
end)

RegisterFontFile("OpenSans")
fontId = RegisterFontId("OpenSans")

function DrawText3D(x, y, z, text) 
    local coords = vector3(x, y, z)
    local camCoords = GetGameplayCamCoords()
    local dist = GetDistanceBetweenCoords(camCoords, x, y, z, 1)

    if not size then size = 1 end
    
    local scale = (4.00001 / dist) * 0.3
    if scale < 0.08 then
        scale = 0.08
    end
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(scale, scale)
    SetTextFont(fontId)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)

    SetDrawOrigin(coords, 0)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

TriggerEvent('chat:addSuggestion', '/truyna', 'Truy nã', {
	{ name="id", help="Id người chơi" },
    { name="Time", help="Thời gian" },
    { name="Sao", help="Số sao" }
})




