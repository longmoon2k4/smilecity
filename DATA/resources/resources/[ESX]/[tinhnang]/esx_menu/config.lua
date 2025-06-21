local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isDead = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
local PlayerData = {}

--ESX                           = nil

Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
	PlayerData.job2 = job
end)

rootMenuConfig =  {
	---------------------------------------------------------------------------
	--------------- DÂN THƯỜNG
	---------------------------------------------------------------------------	
	{
        id = "Dáng Đi",
        displayName = "Dáng Đi",
        icon = "#walking",
        enableMenu = function()
            return (not isDead and IsPedOnFoot(GetPlayerPed(-1)))
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },
	
    {
        id = "Biểu Cảm",
        displayName = "Biểu Cảm",
        icon = "#expressions",
        enableMenu = function()
            return (not isDead and IsPedOnFoot(GetPlayerPed(-1)))
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },

    {
        id = "Bảng Điều Khiển",
        displayName = "Bảng Điều Khiển",
        icon = "#bangdieukhien",
        functionName = "carcontrol:open",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(GetPlayerPed(-1), false))
        end
    },

   
    
    {
        id = "vacxac",
        displayName = "Vác xác",
        icon = "#vacxac",
        functionName = "CarryPeople:sended",
        enableMenu = function()
            return not isDead
        end,
    },

   

    -- {
    --     id = "Admin",
    --     displayName = "Admin",
    --     icon = "#admin",
    --     enableMenu = function()
    --         return (PlayerData.job.name == 'admin' and not isDead and IsPedOnFoot(GetPlayerPed(-1)))
    --     end,
    --     subMenus = { "admin:debug" }
    -- },

    

    {
        id = "Black list",
        displayName = "Black list",
        icon = "#blacklist",
        functionName = "black_list:open",
        enableMenu = function()
            return (PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'mechanic' ) and (PlayerData.job.grade_name == "boss" or PlayerData.job.grade_name == "lieutenant" or  PlayerData.job.grade_name == "phogiamdoc") and not isDead
        end
    },

    {
        id = "keycar",
        displayName = "Đứa chìa khóa",
        icon = "#givekey",
        functionName = "sulu_keycar:getPlate2",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(GetPlayerPed(-1), false))
        end
    },

    {
        id = "more",
        displayName = "Khác",
        icon = "#animation-more",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "rwevent", "chetao", "nhanquaonline", "rankgang"}
    },

    {
        id = "Quản Lý ",
        displayName = "Quản Lý ",
        icon = "#quanlymem",
        functionName = "sulu_member:client:open",
        enableMenu = function()
            return PlayerData.job.grade_name == "boss" or PlayerData.job.grade_name == "lieutenant" or  PlayerData.job.grade_name == "phogiamdoc" and not isDead
        end,
    },

    {
        id = "Quản Lý Gang",
        displayName = "Quản Lý Gang",
        icon = "#quanlymemgang",
        functionName = "sulu_member_job2:client:open",
        enableMenu = function()
            return PlayerData.job2.grade_name == "boss" and not isDead
        end,
    },

}












newSubMenus = {	
    -- {
    --     id = "Chế Tạo",
    --     displayName = "Chế Tạo",
    --     icon = "#chetao",
    --     -- functionName = "crafting:toggle",
    --     functionName = "core_crafting:open",
    --     enableMenu = function()
    --         return not isDead
    --     end
    -- },
    -- {
    --     id = "Nhận Quà Online",
    --     displayName = "Nhận Quà Online",
    --     icon = "#giftonline",
    --     functionName = "esx_nhanquaonline",
    --     enableMenu = function()
    --         return not isDead 
    --     end
    -- },

    -- {
    --     id = "rankgang",
    --     displayName = "Bảng xếp hạng gang",
    --     icon = "#bangxephanggang",
    --     functionName = "sulu_occupation:Ui",
    --     enableMenu = function()
    --         return not isDead 
    --     end
    -- },
    ['rwevent'] = {
        title = "Sổ sứ mệnh",
        icon = "#rwevent",
        functionName = "reward_event:openUI"
    },
    ['chetao'] = {
        title = "Chế Tạo",
        icon = "#chetao",
        functionName = "core_crafting:open"
    },
    ['nhanquaonline'] = {
        title = "Nhận Quà Online",
        icon = "#giftonline",
        functionName = "esx_nhanquaonline"
    },

    ['rankgang'] = {
        title = "Bảng xếp hạng gang",
        icon = "#bangxephanggang",
        functionName = "sulu_occupation:Ui"
    },
    ---------------------------------------------------------------------------
    ----------------------------- Admin ---------------------------------------
    ---------------------------------------------------------------------------
    ['admin:debug'] = {
        title = "Debug",
        icon = "#debug",
        functionName = "hud:enabledebug"
    },

    ---------------------------------------------------------------------------
    ----------------------------- Giải Trí ------------------------------------
    ---------------------------------------------------------------------------
    -- ['baucua:open'] = {
    --     title = "Bầu Cua",
    --     icon = "#vnrp-cashshop",
    --     functionName = "baucua:open"
    -- },
	
	---------------------------------------------------------------------------
	--------------- ANIMATIONS
	---------------------------------------------------------------------------
	
    ['animations:brave'] = {
        title = "Dũng Cảm",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },

    ['animations:hurry'] = {
        title = "Vội Vàng",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },

    ['animations:business'] = {
        title = "Doanh Nhân",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },

    ['animations:tipsy'] = {
        title = "Say",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },

    ['animations:injured'] = {
        title = "Bị Thương",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },

    ['animations:tough'] = {
        title = "Cục Súc",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },

    ['animations:sassy'] = {
        title = "Hỗn Láo",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },

    ['animations:sad'] = {
        title = "Buồn",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },

    ['animations:posh'] = {
        title = "Sang Trọng",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },

    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },

    ['animations:hobo'] = {
        title = "Vô Gia Cư",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    
    ['animations:money'] = {
        title = "Khệnh 1",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },

    ['animations:swagger'] = {
        title = "Khệnh 2",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },

    ['animations:shady'] = {
        title = "Khệnh 3",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },

    ['animations:maneater'] = {
        title = "Con Bóng 1",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },

    ['animations:chichi'] = {
        title = "Con Bóng 2",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },

    ['animations:default'] = {
        title = "Bình Thường",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
	
	
	---------------------------------------------------------------------------
	--------------- BIỂU  CẢM
	---------------------------------------------------------------------------
	
    ["expressions:angry"] = {
        title="Giận Dữ",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Say",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Ngu Ngốc",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Bị Điện Giật",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Càu Nhàu",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Vui Vẻ",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Bị Đau",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Tận Hưởng",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Há Mồm",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Bình Thường",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="Một Mắt",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shock",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Buồn Ngủ",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Tự Mãn",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Quan Sát",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Căng Thẳng",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Hờn Dỗi",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Ngáo 1",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Ngáo 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    }
	
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ambulance" then isMedic = false end
    if isPolice and job ~= "police" then isPolice = false end
    if isDoctor and job ~= "doctor" then isDoctor = false end
    if isNews and job ~= "reporter" then isNews = false end
    if job == "police" then isPolice = true end
    if job == "ambulance" then isMedic = true end
    if job == "reporter" then isNews = true end
    if job == "doctor" then isDoctor = true end
    myJob = job
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
    isDead = false
end)

RegisterNetEvent("drivingInstructor:instructorToggle")
AddEventHandler("drivingInstructor:instructorToggle", function(mode)
    if myJob == "driving instructor" then
        isInstructorMode = mode
    end
end)

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

trainstations = {
    {-547.34057617188,-1286.1752929688,25.3059978411511},
    {-892.66284179688,-2322.5168457031,-13.246466636658},
    {-1100.2299804688,-2724.037109375,-8.3086919784546},
    {-1071.4924316406,-2713.189453125,-8.9240007400513},
    {-875.61907958984,-2319.8686523438,-13.241264343262},
    {-536.62890625,-1285.0009765625,25.301458358765},
    {270.09558105469,-1209.9177246094,37.465930938721},
    {-287.13568115234,-327.40936279297,8.5491418838501},
    {-821.34295654297,-132.45257568359,18.436864852905},
    {-1359.9794921875,-465.32354736328,13.531299591064},
    {-498.96591186523,-680.65930175781,10.295949935913},
    {-217.97073364258,-1032.1605224609,28.724565505981},
    {113.90325164795,-1729.9976806641,28.453630447388},
    {117.33223724365,-1721.9318847656,28.527353286743},
    {-209.84713745117,-1037.2414550781,28.722997665405},
    {-499.3971862793,-665.58514404297,10.295639038086},
    {-1344.5224609375,-462.10494995117,13.531820297241},
    {-806.85192871094,-141.39852905273,18.436403274536},
    {-302.21514892578,-327.28854370117,8.5495929718018},
    {262.01733398438,-1198.6135253906,37.448017120361},
    {2072.4086914063,1569.0856933594,76.712524414063},
    {664.93090820313,-997.59942626953,22.261747360229},
    {190.62687683105,-1956.8131103516,19.520135879517},
    {2611.0278320313,1675.3806152344,26.578210830688},
    {2615.3901367188,2934.8666992188,39.312232971191},
    {2885.5346679688,4862.0146484375,62.551517486572},
    {47.061096191406,6280.8969726563,31.580261230469},
    {2002.3624267578,3619.8029785156,38.568252563477},
    {2609.7016601563,2937.11328125,39.418235778809}
}
