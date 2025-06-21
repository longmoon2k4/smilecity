Config = {}

Config.Framework = "newEsx" -- esx or newEsx
Config.sql = "oxmysql" -- dont forget to change fxmanifest.lua! |ghmattimysql - oxmysql - mysql-async

Config.Settings = {
    ["canOpenWithCommand"] = true, -- CAN THE MENU BE OPENED BY COMMAND
    ["menuOpenCommand"] = "fishmenu", 
    ["addXP"] = {min = 20, max = 30}, -- The amount of xp to be given after fishing
    ["addxpafterXcatch"] = 3, -- How many successful catch after exp awards will be given
    ["needxpforlevelup"] = 1000, -- How Many xp needed to level up
    ["addTrashWithoutBait"] = 90, -- HOW MANY MORE TRASH ITEMS WILL APPEAR WITHOUT FISH Bait
    ["rodBrokeChanceWhenUpgrade"] = 50, -- WHAT IS THE CHANCE OF BREAKING THE FISHING ROD DURING LEVEL UPGRADING?
    ["eatBaitChance"] = 90, -- WHAT PERCENTAGE CHANCE THAT THE BAIT WILL DISAPPEAR AFTER FISHING
    ["illegalBaitName"] = "illegal", -- TYPE OF BAIT REQUIRED TO CATCH ILLEGAL FISH
    ["tasksResetDay"] = 3, -- HOW MANY DAYS AFTER THE TASK IS RECEIVED WILL IT BE RESET (EVEN IF 1 TASK IS RECEIVED, ALL TASKS WILL BE DELETED AFTER THE WRITTEN DAY)
}

Config.Language = {
    ["eatBaitText"] = "Bạn đã làm mất mồi câu cá.",
    ["catchFish"] = "Bạn đã bị bắt!",
    ["youCantFishHere"] = "Bạn không thể câu cá ở đây!",
    ["somethingStoppingFish"] = "Có điều gì đó đang ngăn bạn câu cá",
    ["movementOnRod"] = "Có chuyển động trên cần câu của bạn!",
    ["missedFish"] = "Bạn đã bỏ lỡ con cá",
    ["noLeftBait"] = "Không còn mồi ở đầu cần câu!",
    ["fishingHBStopped"] = "Việc câu cá đã bị dừng",
    ["illegalCant"] = "Bạn không thể đánh bắt cá bất hợp pháp ở khu vực này!",
    ["useBaitNotFishing"] = "Bạn phải có cần câu trong tay để làm mồi!",
    ["youDontHaveItemUPGRADE"] = "Bạn không có vật phẩm cần thiết để nâng cấp!",
    ["upgradedRod"] = "Cần câu của bạn đã được nâng cấp lên cấp độ tiếp theo!",
    ["brokenRod"] = "Cần câu của bạn bị hỏng!",
    ["youDontHave"] = "Bạn không có!",
    ["youDontHaveMoney"] = "Bạn không có đủ tiền!",
    ["youDontHaveEnoughSpace"] = "Bạn không có đủ không gian để mang vật phẩm!",
    ["youDontHaveWantSell"] = "Bạn không có mặt hàng bạn muốn bán!",
    ["succesBuy"] = "Bạn đã mua: ",
    ["succesSold"] = "Bạn đã bán: ",
}

Config.Customize = {
    title  = "Shop cá",
    fishAreaTitle  = "Cá",
    taskAreaTitle  = "Nhiệm vụ của bạn",
    currentXP  = "XP hiện tại:",
    requiredXP  = "XP bắt buộc:",
}

Config.FishLevels = { -- ALL FISH THAT CAN BE KEPT ATTACHED IN THE FISHING SYSTEM AND FISH LEVELS (THIS AREA NOT FISHINGROD LEVEL) (ALL FISH MUST BE ATTACHED)
    ["anchovy"] = 1,
    ["smallbluefish"] = 2,
    ["bluefish"] = 5,
    ["bonitosfish"] = 9,
    ["garfish"] = 11,
    ["perch"] = 13,
    ["carettacaretta"] = 15,
    -- ["pantfish"] = 18,
    ["sharkfish"] = 20,
    ["whitepearl"] = 1,
    ["bluepearl"] = 1,
    ["redpearl"] = 1,
    ["greenpearl"] = 1,
    ["yellowpearl"] = 1,
}

Config.fishingRods = { -- FISHING RODS, ITEM NAMES AND LEVELS
    {itemName = "fishingrod1", level = 1},
    {itemName = "fishingrod2", level = 2},
    {itemName = "fishingrod3", level = 3},
    {itemName = "fishingrod4", level = 4},
    {itemName = "fishingrod5", level = 5},
}

Config.fishBaits = { -- FISH BAITS AND FEED TYPES
    {itemName = "fishbait", baitType = "fish", label = "Mồi Câu Cá"},
    {itemName = "illegalfishbait", baitType = "illegal", label = "Mồi Câu Cá Lậu"},
}

-- MUST START WITH TABLE 1 - TABLE 1 ACTUALLY POINTS TO LEVEL 2 FISHING ROD
Config.upgradeRodPrices = { -- PRICE LIST FOR FISHING ROD UPGRADE
    [1] = 50000, -- LEVEL 2 
    [2] = 100000, -- LEVEL 3
    [3] = 200000, -- LEVEL 4 
    [4] = 500000, -- LEVEL 5
}

Config.fishMenuArea = { -- GO NEXT TO IT AND PRESS E TO OPEN THE /FISH MENU
    {
        pedName = "AKAY", 
        pedHash = 0x0B881AEE, 
        pedCoord = vector3(-1818.09, -1215.68, 12.017),
        drawText = "[E] - Ngư dân",
        h = 54,
        blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
            blip = true,
            blipName = "Ngư dân",
            blipIcon = 68,
            blipColour = 3,
        },
    },
    -- {
    --     pedName = "AKAY", 
    --     pedHash = 0x0B881AEE, 
    --     pedCoord = vector3(-3055.97, 16.07758, 4.4954),
    --     drawText = "[E] - Ngư dân",
    --     h = 230,
    --     blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
    --         blip = false,
    --         blipName = "Fisher Man",
    --         blipIcon = 68,
    --         blipColour = 3,
    --     },
    -- },
}

Config.upgradeRodArea = { -- ROD LEVEL UPGRADE AREAS
    {
        pedName = "AKAY", 
        pedHash = 0x1EEC7BDC, 
        pedCoord = vector3(-1820.26, -1220.52, 12.017), 
        drawText = "[E] - Nâng cấp cần câu",
        h = 54,
        blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
            blip = true,
            blipName = "Upgrade Rod",
            blipIcon = 68,
            blipColour = 3,
        },
    },
    -- {
    --     pedName = "AKAY", 
    --     pedHash = 0x1EEC7BDC, 
    --     pedCoord = vector3(-3058.65, 12.83765, 4.4954), 
    --     drawText = "[E] - Nâng cấp cần câu",
    --     h = 230,
    --     blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
    --         blip = false,
    --         blipName = "Upgrade Rod",
    --         blipIcon = 68,
    --         blipColour = 3,
    --     },
    -- },
}

Config.marketArea = { -- MARKET AREAS (BUYING AND SELLING)
    {
        pedName = "AKAY", 
        pedHash = 0xAE5BE23A, 
        pedCoord = vector3(-1814.30, -1213.02, 12.017), 
        drawText = "[E] - Shop câu cá",
        h = 54,
        blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
            blip = true,
            blipName = "Shop câu cá",
            blipIcon = 68,
            blipColour = 3,
        },
    },
    -- {
    --     pedName = "AKAY", 
    --     pedHash = 0xAE5BE23A, 
    --     pedCoord = vector3(-3061.26, 9.376700, 4.4954), 
    --     drawText = "[E] -Shop câu cá",
    --     h = 230,
    --     blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
    --         blip = false,
    --         blipName = "Fish Shop",
    --         blipIcon = 68,
    --         blipColour = 3,
    --     },
    -- },
}

Config.buyMarketItems = { -- LIST OF ITEMS SOLD IN THE FISH MARKET (BUY MENU)
    {itemId = 1, itemName = "fishingrod1", itemLabel = "Cần cầu lv1", itemPrice = 10000, image = './css/imgs/fishingrod.png'},
    {itemId = 2, itemName = "fishbait", itemLabel = "Mồi câu cá", itemPrice = 500, image = './css/imgs/fishbait.png'},
    {itemId = 3, itemName = "illegalfishbait", itemLabel = "Mồi Câu Cá Lậu", itemPrice = 1500, image = './css/imgs/illegalFishBait.png'},
}

Config.Zones = { -- FISHING AREAS
    -- { -- Motel
    --     coords = vector3(-4419.705566, 961.595581, -0.291626), -- FISHING AREA COORDINATES
    --     radius = 150, -- RADIUS LEVEL OF THE ABOVE COORDINATE 
    --     blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
    --         blip = true,
    --         blipAlpha = true,
    --         blipName = "Khu vực câu bến thuyền",
    --         blipIcon = 68,
    --         blipColour = 3,
    --         blipAlphaColour = 2,
    --     },
    --     trashChance = 10, -- WHAT PERCENTAGE OF TRASH ITEMS WILL BE GIVEN WHILE FISHING IN THIS COORDINATE
    --     rareChance = 0, -- WHAT PERCENTAGE OF VALUABLE ITEMS WILL BE GIVEN WHEN FISHING IN THIS COORDINATE
    --     illegal = false, -- CAN AN ILLEGAL ITEM BE HELD IN THIS COORDINATE?
    --     items = { -- ITEMS THAT WILL APPEAR WHILE FISHING IN THIS COORDINATION
    --         trashItems = {"cainit"}, -- TRASH ITEMS
    --         rare = { -- RARE ITEMS
    --             rodLevel = {
    --                 [1] = {"whitepearl"}, -- WHAT CAN BE CAUGHT WITH 1 LEVEL FISHING ROD
    --                 [2] = {"whitepearl", "bluepearl"}, -- WHAT CAN BE CAUGHT WITH 2 LEVEL FISHING ROD
    --                 [3] = {"whitepearl", "bluepearl","redpearl"}, -- WHAT CAN BE CAUGHT WITH 3 LEVEL FISHING ROD
    --                 [4] = {"whitepearl", "bluepearl","redpearl","yellowpearl"}, -- WHAT CAN BE CAUGHT WITH 4 LEVEL FISHING ROD
    --                 [5] = {"whitepearl", "bluepearl","redpearl","yellowpearl","greenpearl"}, -- WHAT CAN BE CAUGHT WITH 5 LEVEL FISHING ROD
    --             },
    --         },
    --         normal = { -- NORMAL ITEMS 
    --             rodLevel = {
    --                 [1] = {"anchovy"}, -- WHAT CAN BE CAUGHT WITH 1 LEVEL FISHING ROD
    --                 [2] = {"anchovy", "smallbluefish","anchovy","anchovy"}, -- WHAT CAN BE CAUGHT WITH 2 LEVEL FISHING ROD 
    --                 [3] = {"anchovy", "smallbluefish", "bluefish","bonitosfish", "smallbluefish"}, -- WHAT CAN BE CAUGHT WITH 3 LEVEL FISHING ROD
    --                 [4] = {"anchovy", "smallbluefish", "bluefish","bonitosfish","garfish", "smallbluefish"}, -- WHAT CAN BE CAUGHT WITH 4 LEVEL FISHING ROD
    --                 [5] = {"anchovy", "smallbluefish", "bluefish","bonitosfish","garfish","perch","anchovy", "smallbluefish", "bluefish",}, -- WHAT CAN BE CAUGHT WITH 5 LEVEL FISHING ROD
    --             },
    --         },
    --         illegal = { -- ILLEGAL ITEMS
    --             rodLevel = {
    --                 [1] = {"anchovy"}, -- WHAT CAN BE CAUGHT WITH 1 LEVEL FISHING ROD
    --                 [2] = {"anchovy", "smallbluefish", "anchovy", "anchovy"}, -- WHAT CAN BE CAUGHT WITH 2 LEVEL FISHING ROD
    --                 [3] = {"anchovy", "smallbluefish", "bluefish","bonitosfish",  "bluefish"}, -- WHAT CAN BE CAUGHT WITH 3 LEVEL FISHING ROD
    --                 [4] = {"carettacaretta", "pantolobaligi", "anchovy","smallbluefish", "bluefish","bonitosfish" }, -- WHAT CAN BE CAUGHT WITH 4 LEVEL FISHING ROD
    --                 [5] = {"carettacaretta", "pantolobaligi","sharkfish",  "anchovy", "smallbluefish", "bluefish","bonitosfish"}, -- WHAT CAN BE CAUGHT WITH 5 LEVEL FISHING ROD
    --             },
    --         },
    --     },
    -- }, 

    { -- ILLEGAL AREA
        coords = vector3(-3747.00, -1919.14, -0.234), -- FISHING AREA COORDINATES
        radius = 300, -- RADIUS LEVEL OF THE ABOVE COORDINATE 
        blipSettings = { -- https://docs.fivem.net/docs/game-references/blips/
            blip = true,
            blipAlpha = true,
            blipName = "Khu vực câu lậu",
            blipIcon = 68,
            blipColour = 3,
            blipAlphaColour = 2,
        },
        trashChance = 10, -- WHAT PERCENTAGE OF TRASH ITEMS WILL BE GIVEN WHILE FISHING IN THIS COORDINATE
        rareChance = 2, -- WHAT PERCENTAGE OF VALUABLE ITEMS WILL BE GIVEN WHEN FISHING IN THIS COORDINATE
        illegal = true, -- CAN AN ILLEGAL ITEM BE HELD IN THIS COORDINATE?
        items = { -- ITEMS THAT WILL APPEAR WHILE FISHING IN THIS COORDINATION
            trashItems = {"cainit"}, -- TRASH ITEMS
            rare = { -- RARE ITEMS
                rodLevel = {
                    [1] = {"whitepearl"}, -- WHAT CAN BE CAUGHT WITH 1 LEVEL FISHING ROD
                    [2] = {"whitepearl", "bluepearl"}, -- WHAT CAN BE CAUGHT WITH 2 LEVEL FISHING ROD
                    [3] = {"whitepearl", "bluepearl","redpearl"}, -- WHAT CAN BE CAUGHT WITH 3 LEVEL FISHING ROD
                    [4] = {"whitepearl", "bluepearl","redpearl","yellowpearl"}, -- WHAT CAN BE CAUGHT WITH 4 LEVEL FISHING ROD
                    [5] = {"whitepearl", "bluepearl","redpearl","yellowpearl","greenpearl"}, -- WHAT CAN BE CAUGHT WITH 5 LEVEL FISHING ROD
                },
            },
            normal = { -- NORMAL ITEMS 
                rodLevel = {
                    [1] = {"anchovy"}, -- WHAT CAN BE CAUGHT WITH 1 LEVEL FISHING ROD
                    [2] = {"anchovy", "smallbluefish","anchovy","anchovy"}, -- WHAT CAN BE CAUGHT WITH 2 LEVEL FISHING ROD 
                    [3] = {"anchovy", "smallbluefish", "bluefish","bonitosfish", "smallbluefish"}, -- WHAT CAN BE CAUGHT WITH 3 LEVEL FISHING ROD
                    [4] = {"anchovy", "smallbluefish", "bluefish","bonitosfish","garfish", "smallbluefish"}, -- WHAT CAN BE CAUGHT WITH 4 LEVEL FISHING ROD
                    [5] = {"anchovy", "smallbluefish", "bluefish","bonitosfish","garfish","perch","smallbluefish", "bluefish",}, -- WHAT CAN BE CAUGHT WITH 5 LEVEL FISHING ROD
                },
            },
            illegal = { -- ILLEGAL ITEMS
                rodLevel = {
                    [1] = {"anchovy"}, -- WHAT CAN BE CAUGHT WITH 1 LEVEL FISHING ROD
                    [2] = {"anchovy", "smallbluefish", "anchovy",}, -- WHAT CAN BE CAUGHT WITH 2 LEVEL FISHING ROD
                    [3] = {"anchovy", "smallbluefish", "bluefish","bonitosfish", "smallbluefish",  "bluefish", "anchovy"}, -- WHAT CAN BE CAUGHT WITH 3 LEVEL FISHING ROD
                    [4] = {"carettacaretta", "pantolobaligi", "anchovy","smallbluefish", "bluefish","bonitosfish","perch","garfish","smallbluefish","anchovy","bluefish"}, -- WHAT CAN BE CAUGHT WITH 4 LEVEL FISHING ROD
                    [5] = {"carettacaretta", "pantolobaligi","sharkfish",  "anchovy", "smallbluefish", "bluefish","bonitosfish","perch", "bluefish","bonitosfish","garfish","smallbluefish","anchovy","bluefish"}, -- WHAT CAN BE CAUGHT WITH 5 LEVEL FISHING ROD
                },
            },
        },
    },
}

Config.Tasks = { -- TASKS APPEARING ON THE FISH MENU
    {
        taskId = 1, -- TASK NUMBER (ALL TASKS MUST BE NUMBERED DIFFERENTLY AND SEQUENTIALLY)
        taskName = "Bắt 40 con cá xanh nhỏ", -- NAME OF THE TASK AS IT APPEARS IN THE MENU
        itemName = "smallbluefish", -- ITEM OF TASK
        moneyRewards = 2000, -- TASK'S PRIZE MONEY
        xpRewards = 500, -- TASK'S XP REWARD
        requiredCount = 40, -- NUMBER OF FISH CATCHES REQUIRED TO COMPLETE THE TASK
        taskDescription = "Receive your reward after successfully completing the mission.",
    },
    {
        taskId = 2, -- TASK NUMBER (ALL TASKS MUST BE NUMBERED DIFFERENTLY AND SEQUENTIALLY)
        taskName = "Bắt 30 con cá xanh", -- NAME OF THE TASK AS IT APPEARS IN THE MENU
        itemName = "bluefish", -- ITEM OF TASK
        moneyRewards = 3000, -- TASK'S PRIZE MONEY
        xpRewards = 500, -- TASK'S XP REWARD
        requiredCount = 30, -- NUMBER OF FISH CATCHES REQUIRED TO COMPLETE THE TASK
        taskDescription = "Receive your reward after successfully completing the mission.",
    },
    {
        taskId = 3, -- TASK NUMBER (ALL TASKS MUST BE NUMBERED DIFFERENTLY AND SEQUENTIALLY)
        taskName = "Bắt 20 cá ngừ", -- NAME OF THE TASK AS IT APPEARS IN THE MENU
        itemName = "bonitosfish", -- ITEM OF TASK
        moneyRewards = 4000, -- TASK'S PRIZE MONEY
        xpRewards = 500, -- TASK'S XP REWARD
        requiredCount = 20, -- NUMBER OF FISH CATCHES REQUIRED TO COMPLETE THE TASK
        taskDescription = "Receive your reward after successfully completing the mission.",
    },
    {
        taskId = 4, -- TASK NUMBER (ALL TASKS MUST BE NUMBERED DIFFERENTLY AND SEQUENTIALLY)
        taskName = "Bắt 15 con cá Garfish", -- NAME OF THE TASK AS IT APPEARS IN THE MENU
        itemName = "garfish", -- ITEM OF TASK
        moneyRewards = 5000, -- TASK'S PRIZE MONEY
        xpRewards = 500, -- TASK'S XP REWARD
        requiredCount = 15, -- NUMBER OF FISH CATCHES REQUIRED TO COMPLETE THE TASK
        taskDescription = "Receive your reward after successfully completing the mission.",
    },
    {
        taskId = 5, -- TASK NUMBER (ALL TASKS MUST BE NUMBERED DIFFERENTLY AND SEQUENTIALLY)
        taskName = "Bắt 10 con cá rô", -- NAME OF THE TASK AS IT APPEARS IN THE MENU
        itemName = "perch", -- ITEM OF TASK
        moneyRewards = 6000, -- TASK'S PRIZE MONEY
        xpRewards = 500, -- TASK'S XP REWARD
        requiredCount = 10, -- NUMBER OF FISH CATCHES REQUIRED TO COMPLETE THE TASK
        taskDescription = "Receive your reward after successfully completing the mission.",
    },
    {
        taskId = 6, -- TASK NUMBER (ALL TASKS MUST BE NUMBERED DIFFERENTLY AND SEQUENTIALLY)
        taskName = "Bắt 20 con cá mụp", -- NAME OF THE TASK AS IT APPEARS IN THE MENU
        itemName = "sharkfish", -- ITEM OF TASK
        moneyRewards = 15000, -- TASK'S PRIZE MONEY
        xpRewards = 500, -- TASK'S XP REWARD
        requiredCount = 20, -- NUMBER OF FISH CATCHES REQUIRED TO COMPLETE THE TASK
        taskDescription = "Receive your reward after successfully completing the mission.",
    },
}

Config.Fishes = { -- /FISH MENU SETTINGS
    {
        id = 1, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá cơm", -- THE APPARENT NAME OF THE FISH
        itemName = "anchovy", -- ITEM NAME OF THE FISH
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 1, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 1500, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Legal", -- TYPE OF FISH
        image = "./css/imgs/anchovyMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngay trên bến tàu, bạn cần có cần câu cấp độ 1 trở lên mới bắt được cá nhé!"
    },
    {
        id = 2, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá xanh nhỏ", -- THE APPARENT NAME OF THE FISH
        itemName = "smallbluefish", -- ITEM NAME OF THE FISH
        requiredLevel = 2, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 2, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 2000, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Legal", -- TYPE OF FISH
        image = "./css/imgs/smallbluefishMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngay trên bến tàu, bạn cần có cần câu cấp độ 2 trở lên mới bắt được cá nhé!"
    },
    {
        id = 3, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá xanh", -- THE APPARENT NAME OF THE FISH
        itemName = "bluefish", -- ITEM NAME OF THE FISH
        requiredLevel = 5, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 3, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 3000, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Legal", -- TYPE OF FISH
        image = "./css/imgs/bluefishMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngay trên bến tàu, bạn cần có cần câu cấp độ 3 trở lên mới bắt được cá nhé!"
    },
    {
        id = 4, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá ngừ", -- THE APPARENT NAME OF THE FISH
        itemName = "bonitosfish", -- ITEM NAME OF THE FISH
        requiredLevel = 9, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 3, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 5000, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Legal", -- TYPE OF FISH
        image = "./css/imgs/bonitosfishMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngay trên bến tàu, bạn cần có cần câu cấp độ 3 trở lên mới bắt được cá nhé!"
    },
    {
        id = 5, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá Garfish", -- THE APPARENT NAME OF THE FISH
        itemName = "garfish", -- ITEM NAME OF THE FISH
        requiredLevel = 11, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 4, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 7000, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Legal", -- TYPE OF FISH
        image = "./css/imgs/garfishMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngay trên bến tàu, bạn cần có cần câu cấp độ 4 trở lên mới bắt được cá nhé!"
    },
    {
        id = 6, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá rô", -- THE APPARENT NAME OF THE FISH
        itemName = "perch", -- ITEM NAME OF THE FISH
        requiredLevel = 13, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 5, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 9000, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Legal", -- TYPE OF FISH
        image = "./css/imgs/perchMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngay trên bến tàu, bạn cần có cần câu cấp độ 5 trở lên mới bắt được cá nhé!"
    },
    {
        id = 7, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Rùa", -- THE APPARENT NAME OF THE FISH
        itemName = "carettacaretta", -- ITEM NAME OF THE FISH
        requiredLevel = 15, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 4, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 7000, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Illegal", -- TYPE OF FISH
        image = "./css/imgs/carettaMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngoài khơi, để câu được loài cá này bạn cần có cần câu cấp độ 4 trở lên!"
    },
    {
        id = 8, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá quần", -- THE APPARENT NAME OF THE FISH
        itemName = "pantfish", -- ITEM NAME OF THE FISH
        requiredLevel = 18, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 4, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 10, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Illegal", -- TYPE OF FISH
        image = "./css/imgs/pantfishMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngoài khơi, để câu được loài cá này bạn cần có cần câu cấp độ 4 trở lên!"
    },
    {
        id = 9, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        fishName = "Cá mập", -- THE APPARENT NAME OF THE FISH
        itemName = "sharkfish", -- ITEM NAME OF THE FISH
        requiredLevel = 20, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        requiredRodLvl = 5, -- FISHING ROD LEVEL AND ABOVE THAT SHOULD BE USED TO CATCH THE FISH
        fishPrice = 30000, -- SALE PRICE OF FISH
        onFishMenu = true, -- /FISH APPEARS OR DOES NOT APPEAR ON THE MENU - TRUE: APPEARS _ FALSE: DOES NOT APPEAR
        fishType = "Illegal", -- TYPE OF FISH
        image = "./css/imgs/sharkMiddle.png", -- PICTURE OF THE FISH ON THE FISH MENU
        description = "Bạn có thể câu được loài cá này ngoài khơi, để câu được loài cá này bạn cần có cần câu cấp độ 5 trở lên!"
    },      
}

Config.sellMenuItems = { -- FISH ON THE FISH SALE MENU
    {
        id = 1, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá nhỏ", -- THE APPARENT NAME OF THE FISH
        itemName = "fish", -- ITEM NAME OF THE FISH
        fishPrice = 1500, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/fish.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 2, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá cơm", -- THE APPARENT NAME OF THE FISH
        itemName = "anchovy", -- ITEM NAME OF THE FISH
        fishPrice = 1500, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/anchovy.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 3, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 2, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá xanh nhỏ", -- THE APPARENT NAME OF THE FISH
        itemName = "smallbluefish", -- ITEM NAME OF THE FISH
        fishPrice = 2000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/smallbluefish.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 4, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 5, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá xanh", -- THE APPARENT NAME OF THE FISH
        itemName = "bluefish", -- ITEM NAME OF THE FISH
        fishPrice = 3000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/bluefish.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 5, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 9, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá ngừ", -- THE APPARENT NAME OF THE FISH
        itemName = "bonitosfish", -- ITEM NAME OF THE FISH
        fishPrice = 5000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/bonitosfish.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 6, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 11, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá Garfish", -- THE APPARENT NAME OF THE FISH
        itemName = "garfish", -- ITEM NAME OF THE FISH
        fishPrice = 7000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/garfish.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 7, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 13, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá rô", -- THE APPARENT NAME OF THE FISH
        itemName = "perch", -- ITEM NAME OF THE FISH
        fishPrice = 9000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/perch.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 8, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 15, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Rùa", -- THE APPARENT NAME OF THE FISH
        itemName = "carettacaretta", -- ITEM NAME OF THE FISH
        fishPrice = 7000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/carettacaretta.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 9, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 18, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá quần", -- THE APPARENT NAME OF THE FISH
        itemName = "pantfish", -- ITEM NAME OF THE FISH
        fishPrice = 250, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/pantfish.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 10, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 20, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Cá mập", -- THE APPARENT NAME OF THE FISH
        itemName = "sharkfish", -- ITEM NAME OF THE FISH
        fishPrice = 30000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/sharkfish.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 11, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Ngọc trai trắng", -- THE APPARENT NAME OF THE FISH
        itemName = "whitepearl", -- ITEM NAME OF THE FISH
        fishPrice = 20000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/whitepearl.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },    
    {
        id = 12, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Ngọc trai xanh", -- THE APPARENT NAME OF THE FISH
        itemName = "bluepearl", -- ITEM NAME OF THE FISH
        fishPrice = 25000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/bluepearl.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },   
    {
        id = 13, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Ngọc trai đỏ", -- THE APPARENT NAME OF THE FISH
        itemName = "redpearl", -- ITEM NAME OF THE FISH
        fishPrice = 30000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/redpearl.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },   
    {
        id = 14, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Ngọc trai vàng", -- THE APPARENT NAME OF THE FISH
        itemName = "yellowpearl", -- ITEM NAME OF THE FISH
        fishPrice = 35000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/yellowpearl.png", -- PICTURE OF THE FISH ON THE SALES MENU
    },
    {
        id = 15, -- FISH ID (ID OF ALL FISH MUST BE DIFFERENT AND SEQUENTIAL)
        requiredLevel = 1, -- DESIRED LEVEL TO KEEP THE FISH (DON'T FORGET TO CHANGE FROM Config.FishLevels)
        fishName = "Ngọc trai xanh", -- THE APPARENT NAME OF THE FISH
        itemName = "greenpearl", -- ITEM NAME OF THE FISH
        fishPrice = 40000, -- SALE PRICE OF FISH
        shopImage = "./css/imgs/greenpearl.png", -- PICTURE OF THE FISH ON THE SALES MENU
    }, 
}