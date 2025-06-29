-- local QBCore = exports['qb-core']:GetCoreObject()
local Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}


local labels = {}
local craftingQueue = {}
local job = ""
local grade = 0


        -- while QBCore.Functions.GetPlayerData().job == nil do
        --     Citizen.Wait(10)
        -- end

        -- job = QBCore.Functions.GetPlayerData().job.name
        -- grade = QBCore.Functions.GetPlayerData().job.grade

       

        -- for _, v in ipairs(Config.Workbenches) do
        --     if v.blip then
        --         local blip = AddBlipForCoord(v.coords)

        --         SetBlipSprite(blip, Config.BlipSprite)
        --         SetBlipScale(blip, 0.8)
        --         SetBlipColour(blip, Config.BlipColor)
        --         SetBlipAsShortRange(blip, true)

        --         BeginTextCommandSetBlipName("STRING")
        --         AddTextComponentString(Config.BlipText)
        --         EndTextCommandSetBlipName(blip)
        --     end
        -- end
    
-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
--     -- ESX.TriggerCallback("core_crafting:getItemNames", function(info)  end)
--     ESX.TriggerServerCallback('core_crafting:getItemNames', function(info)
--         labels = info
--     end)
-- end)

RegisterNetEvent('core_crafting:open')
AddEventHandler('core_crafting:open', function()
    openWorkbench()
end)

-- function isNearWorkbench()
--     local ped = PlayerPedId()
--     local coords = GetEntityCoords(ped)
--     local near = false

--     for _, v in ipairs(Config.Workbenches) do
--         local dst = #(coords - v.coords)
--         if dst < v.radius then
--             near = true
--         end
--     end

--     if near then
--         return true
--     else
--         return false
--     end
-- end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            if craftingQueue[1] ~= nil then
                --if not Config.CraftingStopWithDistance or (Config.CraftingStopWithDistance and isNearWorkbench()) then
                    craftingQueue[1].time = craftingQueue[1].time - 1

                    SendNUIMessage(
                        {
                            type = "addqueue",
                            item = craftingQueue[1].item,
                            time = craftingQueue[1].time,
                            id = craftingQueue[1].id
                        }
                    )

                    if craftingQueue[1].time == 0 then
                        -- exports["WaveShield"]:TriggerServerEvent("core_crafting:itemCrafted", craftingQueue[1].item, craftingQueue[1].count)
                       TriggerServerEvent("core_crafting:itemCrafted", craftingQueue[1].item, craftingQueue[1].count)
                        table.remove(craftingQueue, 1)
                    end
               -- end
            end
        end
end)

function openWorkbench()
    ESX.TriggerServerCallback('core_crafting:getData', function(data)
            SetNuiFocus(true, true)
            --TriggerScreenblurFadeIn(1000)
            local inv = {}
            for i=1, #data, 1 do
                if data[i] ~= nil then
                    inv[data[i].name] = data[i].count
                end
            end
			
            local recipes = {}
            recipes = Config.Recipes
	
            SendNUIMessage(
                {
                    type = "open",
                    recipes = recipes,
                    names = labels,
                    level = 1000,
                    inventory = inv,
                    job = job,
                    grade = grade,
					ingredient = Config.Ingredients,
                    hidecraft = Config.HideWhenCantCraft,
                    categories = Config.Categories
                }
            )
    end)
end

-- Citizen.CreateThread( function()
-- 	while true do
-- 		Citizen.Wait(1)

-- 		local ped = PlayerPedId()
-- 		local coords = GetEntityCoords(ped)

-- 		for _, v in ipairs(Config.Workbenches) do
-- 			local dst = #(coords - v.coords)
-- 			if dst < 3 then
-- 				DrawText3D(v.coords[1], v.coords[2], v.coords[3] - 0.8, Config.Text["workbench_hologram"])
-- 			end
-- 			if dst < 2 then
-- 				if IsControlJustReleased(0, Keys["E"]) then
-- 					local open = false
-- 					if QBCore.Functions.GetPlayerData().job.name == v.jobs then
-- 						open = true
-- 					end

-- 					if open or #v.jobs == 0 then
-- 						openWorkbench(v)
-- 					else	
-- 						SendTextMessage(Config.Text["wrong_job"])
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

RegisterNetEvent("core_crafting:craftStart")
AddEventHandler("core_crafting:craftStart", function(item, count)
        local id = math.random(000, 999)
        table.insert(craftingQueue, {time = Config.Recipes[item].Time, item = item, count = 1, id = id})

        SendNUIMessage(
            {
                type = "crafting",
                item = item
            }
        )

        SendNUIMessage(
            {
                type = "addqueue",
                item = item,
                time = Config.Recipes[item].Time,
                id = id
            }
        )
end)

RegisterNetEvent("core_crafting:sendMessage")
AddEventHandler("core_crafting:sendMessage", function(msg)
        SendTextMessage(msg)
end)

RegisterNUICallback("close", function(data)
        TriggerScreenblurFadeOut(1000)
        SetNuiFocus(false, false)
end)

RegisterNUICallback("craft", function(data)
    Citizen.Wait(2000)
        local item = data["item"]
        TriggerServerEvent("core_crafting:craft", item, false)
        -- exports["WaveShield"]:TriggerServerEvent("core_crafting:craft", item, false)
end)

-- function DrawText3D(x, y, z, text)
--     local onScreen, _x, _y = World3dToScreen2d(x, y, z)
--     local px, py, pz = table.unpack(GetGameplayCamCoord())
--     local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

--     local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

--     if onScreen then
--         SetTextColour(255, 255, 255, 255)
--         SetTextScale(0.0 * scale, 0.35 * scale)
--         SetTextFont(4)
--         SetTextProportional(1)
--         SetTextCentre(true)

--         SetTextDropshadow(1, 1, 1, 1, 255)

--         BeginTextCommandWidth("STRING")
--         AddTextComponentString(text)
--         local height = GetTextScaleHeight(0.55 * scale, 4)
--         local width = EndTextCommandGetWidth(4)

--         SetTextEntry("STRING")
--         AddTextComponentString(text)
--         EndTextCommandDisplayText(_x, _y)
--     end
-- end
