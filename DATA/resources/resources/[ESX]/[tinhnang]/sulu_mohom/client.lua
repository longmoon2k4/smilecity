-- Hack kieu gi bay gio
-- ⠄⠄⠄⠄⠄⠄⠄⠄⢀⣀⣤⣤⣤⣤⣤⣤⣤⣀⣀⠄⠄⠄⠄⠄⠄⠄⠄
-- ⠄⠄⠄⠄⠄⠄⢠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⡀⠄⠄⠄⠄
-- ⠄⠄⠄⠄⠄⣰⣿⣿⡟⠻⣿⠟⠻⣿⣿⠛⢻⣿⡿⠻⣿⣿⣿⣦⡀⠄⠄
-- ⠄⠄⠄⠄⣰⣿⡿⠋⠤⢤⡉⢰⡀⡈⢁⠄⠄⣙⡁⢀⡘⢿⢿⣿⣿⡄⠄
-- ⠄⠄⠄⢠⣿⣿⠁⠄⠄⠄⢳⡀⢉⡀⣼⠄⠄⢨⠞⠉⠄⣀⡀⢿⣿⣿⠄
-- ⠄⠄⣠⣼⣿⠇⠄⢀⡴⣒⢲⣷⠲⠇⠻⢧⣴⣿⢺⡙⣦⡌⠁⠄⣿⣿⣇
-- ⠄⡞⠁⠄⡼⠄⠄⢹⡧⣉⠊⡟⠂⠄⠄⠄⠈⡇⣏⡷⣸⠁⠄⠄⢹⣿⢡
-- ⠄⡇⠄⡀⠃⠄⠄⠄⠃⠩⠘⠂⢖⣛⠙⡦⠐⠛⠬⠕⠛⠃⠄⠄⠘⠃⢾
-- ⠄⠳⣴⠃⠈⠚⠄⢠⠄⠄⠄⠄⠄⣹⣉⣀⣀⠄⠄⠄⡀⢢⣠⠄⠄⠄⡀
-- ⠄⠄⡟⠄⠄⠄⠄⠘⢦⡤⠤⠖⠋⠉⠄⠄⠉⠉⠙⠲⡌⠃⠁⠄⠄⠄⣿
-- ⠄⠄⡇⠄⠄⠄⢆⡄⢸⣇⣠⠖⠚⠩⠟⠉⠉⠙⠓⢢⡇⠄⠄⠄⠄⠄⣿
-- ⠄⠄⡇⠄⠄⠄⠈⠄⠄⠙⢤⣤⠤⠖⠒⡒⠒⠒⠚⠁⠄⠐⡄⡀⠄⢀⡇
-- ⠄⠄⢹⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠉⠁⠄⠄⠄⠄⠄⠄⠉⠠⢆⡞⠄
-- ⠄⠄⠄⠱⣄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣠⠴⠋⠄⠄
-- ⠄⠄⠄⠄⠈⠓⠒⠒⠒⠒⠒⠒⠛⠉⠉⠉⠉⠉⠉⠉⠉⠉⠄⠄⠄⠄


-- ESX = nil

-- Citizen.CreateThread(function()
--     while ESX == nil do
--         TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--         Citizen.Wait(0)
--     end
-- end)

function toggle(state,send)
    SetNuiFocus(state, state)
    if send then
        SendNUIMessage({
            type = "toggle",
            state = state
        })
    end
end

RegisterNUICallback("toggle", function(data,cb)
    toggle(data.state,false)
end)

RegisterNetEvent('ace_mohom:nhanhom')
AddEventHandler('ace_mohom:nhanhom', function(result)
    local items = result
    if items.status then
        SendNUIMessage({type="mohom", seed = items.seed, pick = items.pick, list = items.list, crate = items.crate, label = items.label})
        toggle(true,true)
    end
end)

-- RegisterCommand("nuidebug",function(a,b,c) SetNuiFocus(false,false) end, false)