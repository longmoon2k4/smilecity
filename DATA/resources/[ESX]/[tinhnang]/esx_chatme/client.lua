Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/me', 'Để nói chuyện mà admin không check đc.')
end)

local nbrDisplaying = 1
local mesending = false

RegisterCommand('me', function(source, args, raw)
    local text = '*'
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' *'
    TriggerServerEvent('3dme:shareDisplay', text)
    TriggerServerEvent('chatme', GetPlayerName(PlayerId()).. ' đã chat ' ..text.. ' ')
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.15)
    Display(GetPlayerFromServerId(source), text, offset)
end)

function Display(mePlayer, text, offset)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(10000)
        displaying = false
    end)
    
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        if mePlayer ~= -1 then
            while displaying do
                Wait(0)
                local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
                local coords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist2(coordsMe, coords)
                if dist < 150 then
                     DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset-1.250, text)
                end
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    -- DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    DrawRect(0.0, 0.0+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)
    ClearDrawOrigin()
end


