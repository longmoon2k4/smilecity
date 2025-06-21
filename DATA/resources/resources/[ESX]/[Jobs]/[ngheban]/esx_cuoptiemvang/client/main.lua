local holdingUp = false
local store = ""
local blipRobbery = nil
-- ESX = nil
local joined = false
local prep = false
local playerLoaded = false
local joinedteam = ""
local showPlayer = {}
local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}
-- Citizen.CreateThread(
--     function()
--         while ESX == nil do
--             TriggerEvent(
--                 "esx:getSharedObject",
--                 function(obj)
--                     ESX = obj
--                 end
--             )
--             Citizen.Wait(0)
--         end
--     end
-- )

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(ESX.FontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if outline then
        SetTextOutline()
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width / 2, y - height / 2 + 0.005)
end
RegisterNetEvent("esx_cuoptiemvang:currentlyRobbing")
AddEventHandler(
    "esx_cuoptiemvang:currentlyRobbing",
    function(currentStore)
        holdingUp, store = true, currentStore
    end
)
RegisterNetEvent("esx_cuoptiemvang:killBlip")
AddEventHandler(
    "esx_cuoptiemvang:killBlip",
    function()
        RemoveBlip(blipRobbery)
    end
)
RegisterNetEvent("esx_cuoptiemvang:recieveconfig")
AddEventHandler(
    "esx_cuoptiemvang:recieveconfig",
    function(cfg)
        Stores = cfg
    end
)
RegisterNetEvent("esx_cuoptiemvang:joinedteam")
AddEventHandler(
    "esx_cuoptiemvang:joinedteam",
    function(status)
        joined = status
    end
)
RegisterNetEvent("esx_cuoptiemvang:prepteam")
AddEventHandler(
    "esx_cuoptiemvang:prepteam",
    function(status)
        print(status)
        prep = status
    end
)
RegisterNetEvent("esx_cuoptiemvang:setBlip")
AddEventHandler(
    "esx_cuoptiemvang:setBlip",
    function(position)
        blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
        SetBlipSprite(blipRobbery, 161)
        SetBlipScale(blipRobbery, 2.0)
        SetBlipColour(blipRobbery, 3)
        PulseBlip(blipRobbery)
    end
)
RegisterNetEvent("esx_cuoptiemvang:tooFar")
AddEventHandler(
    "esx_cuoptiemvang:tooFar",
    function()
        holdingUp, store = false, ""
        ESX.ShowNotification(_U("robbery_cancelled"))
    end
)
RegisterNetEvent("esx_cuoptiemvang:robberyComplete")
AddEventHandler("esx_cuoptiemvang:robberyComplete", function(award)
    holdingUp, store = false, ""
end)
RegisterNetEvent("esx_cuoptiemvang:startTimer")
AddEventHandler(
    "esx_cuoptiemvang:startTimer",
    function()
        local timer = Stores[store].secondsRemaining
        Citizen.CreateThread(
            function()
                while timer > 0 and holdingUp do
                    Citizen.Wait(1000)
                    if timer > 0 then
                        timer = timer - 1
                    end
                end
            end
        )
        Citizen.CreateThread(
            function()
                while holdingUp do
                    Citizen.Wait(0)
                    drawTxt(0.75, 1.44, 1.0, 1.0, 0.4, _U("robbery_timer", timer), 255, 255, 255, 255)
                end
            end
        )
    end
)
Citizen.CreateThread(
    function()
        Wait(10000)
        for k, v in pairs(Stores) do
            local blip = AddBlipForRadius(v.position.x, v.position.y, v.position.z, 200.0)
            SetBlipHighDetail(blip, true)
            SetBlipColour(blip, 1)
            SetBlipAlpha(blip, 60)
            local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
            SetBlipSprite(blip, 439)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(_U("shop_robbery"))
            EndTextCommandSetBlipName(blip)
        end
    end
)

Citizen.CreateThread(function() 

	while true do
		local time = 1000
        local coords = GetEntityCoords(PlayerPedId())
        if Stores then
            local id = GetPlayerServerId(PlayerId())
            local kt = GetFakeWantedLevel()
            for k, v in pairs(Stores) do
                 local storePos = v.position
               local distance = #(coords-v.pos)
                if distance < Config.Marker.DrawDistance then
                    if not holdingUp then
                        time = 1
                        DrawMarker(
                            Config.Marker.Type,
                            storePos.x,
                            storePos.y,
                            storePos.z - 1,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            Config.Marker.x,
                            Config.Marker.y,
                            Config.Marker.z,
                            Config.Marker.r,
                            Config.Marker.g,
                            Config.Marker.b,
                            Config.Marker.a,
                            false,
                            false,
                            2,
                            false,
                            false,
                            false,
                            false
                        )
                        if distance <= 7 and not holdingUp then
                            DrawText3D(storePos.x, storePos.y, storePos.z + 0.2, "Tiệm vàng " .. v.nameOfStore, 1.0)
                            if not joined then
                                DrawText3D(
                                    storePos.x,
                                    storePos.y,
                                    storePos.z + 0.05,
                                    "Bấm ~g~[E]~w~ để vào team [" .. v.team.total .. "/15]",
                                    1.0
                                )
                            else
                                DrawText3D(
                                    storePos.x,
                                    storePos.y,
                                    storePos.z + 0.05,
                                    "Đã vào team [" .. v.team.total .. "/15]",
                                    1.0
                                )
                                DrawText3D(
                                    storePos.x,
                                    storePos.y,
                                    storePos.z - 0.1,
                                    "Bấm ~g~[M]~w~ để ~r~cướp~w~ " .. v.nameOfStore,
                                    1.0
                                )
                                if prep then
                                    DrawText3D(
                                        storePos.x,
                                        storePos.y,
                                        storePos.z - 0.25,
                                        "Bấm ~g~[L]~w~ để ~y~thoát team",
                                        1.0
                                    )
                                end
                            end
                        end
                        if distance < 0.5 then
                            if not joined then    
                                ESX.ShowHelpNotification(_U("press_to_join", v.nameOfStore))
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if kt==0 then
                                       if ESX.GetPlayerData() and ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'mechanic' or ESX.GetPlayerData().job.name == 'army' or ESX.GetPlayerData().job.name == 'navy' then
                                           ESX.ShowNotification('Ngành nhà nước mà đi cướp là ăn Ban nhá')
                                       else   
                                            --TriggerServerEvent("esx_policejob:saobank", id, 0)
                                            TriggerServerEvent("esx_cuoptiemvang:jointeam", k)
                                            joinedteam = k
                                            --TriggerServerEvent("esx_policejob:saobank", id, 3)
                                       end
                                    else
                                        ESX.ShowNotification('Bạn đang phạm tội '..kt..' Sao. Không được phép cướp!')
                                    end
                                end
                            else
                                ESX.ShowHelpNotification(_U("press_to_rob", v.nameOfStore))
                                if IsControlJustReleased(0, Keys["M"]) then
                                    if IsPedArmed(PlayerPedId(), 4) then
                                        TriggerServerEvent("esx_cuoptiemvang:robberyStarted", k)
                                    else
                                        ESX.ShowNotification(_U("no_threat"))
                                    end
                                end
                                if IsControlJustReleased(0, Keys["L"]) and not holdingUp then
                                    --TriggerServerEvent("esx_cuoptiemvang:leaveteam", k)
                                    TriggerEvent("esx_cuoptiemvang:prepteam", false)
                                    joinedteam = ""
                                    --TriggerServerEvent("esx_policejob:saobank", id, 0)
                                    Wait(250)
                                end
                            end
                        end
                    end
                end
            end
            if prep == true then
                local storePos = Stores[joinedteam].position
                if Vdist(coords.x, coords.y, coords.z, storePos.x, storePos.y, storePos.z) > 200.0 then
                    TriggerServerEvent("esx_cuoptiemvang:leaveteam", joinedteam)
                    TriggerEvent("esx_cuoptiemvang:prepteam", false)
                    joinedteam = ""
                    Wait(250)
                end
            end
            if holdingUp then
                local storePos = Stores[store].position
                if Vdist(coords.x, coords.y, coords.z, storePos.x, storePos.y, storePos.z) > 200.0 then
                    TriggerServerEvent("esx_cuoptiemvang:tooFar", store)
                end
            end
        end
        Citizen.Wait(time)
    end
end)



function DrawText3D(x, y, z, text, scl)
    local coords = vector3(x, y, z)
    ESX.Game.Utils.DrawText3D(coords, text, scl)
end
