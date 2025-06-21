function LoadPlayerData(playerId) 
    local xPlayer = nil

    while xPlayer == nil do
        xPlayer = ESX.GetPlayerFromId(playerId)
        Wait(100)

    end
      
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier},
    function(result)
            if result[1] ~= nil then
                playersData['id:'..playerId] =  {
                    identifier = xPlayer.identifier,
                    playerId   = playerId,
                    point      = result[1].eventpoint,
                    premium    = result[1].eventpremium,
                    mainData   = json.decode(result[1].eventdata),
                    dailyData  = json.decode(result[1].eventdaily)
                }
            end

            if playersData['id:'..playerId].mainData == nil or playersData['id:'..playerId].mainData == {} or playersData['id:'..playerId].mainData.items == nil then LoadDefaultData(playerId) 
            elseif tonumber(playersData['id:'..playerId].dailyData.missiondate) ~= os.date("*t").day then  GetMissionDaily(playerId) end

            return
    end)

    
end


function GetPlayerData(playerId)

    if playerId == nil or GetPlayerName(playerId) == nil then return nil end

    if  playersData['id:'..playerId] == nil  then LoadPlayerData(playerId) end 

    while playersData['id:'..playerId] == nil do   
        Wait(10)
    end

    return playersData['id:'..playerId]
end

function SavePlayerData(playerId, saveTime) 

    if playersData['id:'..playerId] ~= nil then
        MySQL.Async.execute('UPDATE users SET eventpoint = @eventpoint, eventpremium = @eventpremium, eventdata = @eventdata, eventdaily = @eventdaily WHERE identifier = @identifier', {
            ['@eventpoint'] = playersData['id:'..playerId].point ,
            ['@eventpremium'] = playersData['id:'..playerId].premium,  
            ['@eventdata'] = json.encode(playersData['id:'..playerId].mainData),
            ['@eventdaily'] = json.encode(playersData['id:'..playerId].dailyData),
            ['@identifier'] = playersData['id:'..playerId].identifier
        })

        if saveTime then
            MySQL.Async.execute('UPDATE users SET eventtime = @eventtime WHERE identifier = @identifier', {
                ['@eventtime'] = os.time() ,
                ['@identifier'] = playersData['id:'..playerId].identifier
            })
        end
    end

end

function LoadDefaultData(playerId) 
    
    
    --[[ 
===== Template For Data ====

mainData = {
    itemrewarded    = {
        {
            type = "free",
            level = 1
        }
        {
            type = 'premium',
            level  = 2 
        },
        {
            type = 'free',
            level = 3
        }
    },
    missionrewarded = {
        {
            mission = 1,
            rank    = 1
        },
        {
            mission = 4,
            rank    = 1
        }
    },
    items  = {
        ['wood_th'] = 123,
        ['uncut_rubise'] =12
    }
}

dailyData = {
    missiondate = 12,
    missiondata = {
        {
            mission = 1,
            rank    = 1
        },
    },
    missionrewarded = {
        {
            mission = 1,
            rank    = 1
        },
        {
            mission = 4,
            rank    = 1
        }
    },
    items  = {
        ['wood_th'] = 123,
        ['uncut_rubise'] =12
    }
    
}
============================ ]]


    defaultitems = {}

    for k,v in ipairs(Config.Missions) do
        defaultitems[v.item] = 0
    end

    playersData['id:'..playerId].mainData = {
        itemrewarded    = {},
        missionrewarded = {},
        items  = defaultitems
    }


    playersData['id:'..playerId].dailyData = {
        missiondate = 0 ,
        missiondata = {},
        missionrewarded = {},
        items  = defaultitems
    }

    GetMissionDaily(playerId);
end


function GetMissionDaily(playerId)

    if  playersData['id:'..playerId] == nil  then LoadPlayerData(playerId) end 

    while playersData['id:'..playerId] == nil do   
        Wait(10)
    end


    playersData['id:'..playerId].dailyData.items = {}
    
    for k,v in ipairs(Config.Missions) do
        playersData['id:'..playerId].dailyData.items[v.item] = 0
    end


    playersData['id:'..playerId].dailyData.missiondate = os.date("*t").day

    playersData['id:'..playerId].dailyData.missionrewarded  = {}


    local miss = { -1, -1 , -1};
    local index = 1;

    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    while index <= 3 do 
        local random =  math.random(1, #Config.Missions - 3);
        if random ~= miss[1] and random ~= miss[2] and random ~= miss[3] then
            miss[index] = random
            index = index + 1
        end
    end


    playersData['id:'..playerId].dailyData.missiondata = {
        { mission = miss[1], rank = 1 },
        { mission = miss[2], rank = 2 },
        { mission = miss[3], rank = 3 }
    }

    TriggerClientEvent('reward_event:senddata', playerId , GetPlayerData(playerId))
end


function AddItemCount(playerId, item, count)  

    if  playersData['id:'..playerId] == nil  then LoadPlayerData(playerId) end 

    while playersData['id:'..playerId] == nil do   
        Wait(10)
    end

    if  playersData['id:'..playerId].mainData.items[item] ~= nil then
        playersData['id:'..playerId].mainData.items[item] = playersData['id:'..playerId].mainData.items[item] + count
    else 
        playersData['id:'..playerId].mainData.items[item] = count
    end

    if  playersData['id:'..playerId].dailyData.items[item] ~= nil then
        playersData['id:'..playerId].dailyData.items[item] = playersData['id:'..playerId].dailyData.items[item] + count
    else 
        playersData['id:'..playerId].dailyData.items[item] = count
    end

    TriggerClientEvent('reward_event:updateitem', playerId , item , playersData['id:'..playerId].mainData.items[item] , playersData['id:'..playerId].dailyData.items[item] )
end


function UpdateDailyMissons()

    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local playerId = xPlayers[i]

        if GetPlayerName(playerId) ~= nil then
            GetMissionDaily(playerId)
        end

    end
end


function RewardMission(type, playerId, mission, rank, cb)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local missionData =  Config.Missions[mission]

    if missionData == nil then 
        print("reward_event:WARNINGG Reward Mission NULL")
        cb("Có lỗi xảy ra.", false)
        return
    end

    if type == 'main' then
        table.insert(playersData['id:'..playerId].mainData.missionrewarded,{mission = mission , rank = rank})
    elseif type =='daily' then
        table.insert(playersData['id:'..playerId].dailyData.missionrewarded,{mission = mission , rank = rank})
    end

    playersData['id:'..playerId].point = playersData['id:'..playerId].point + missionData.data[rank].point

    TriggerClientEvent('reward_event:senddata', playerId , GetPlayerData(playerId))

    SendDiscordMessage("**"..xPlayer.name.."("..xPlayer.identifier..")** đã hoàn thành nhiệm vụ `"..type.."` loại `"..missionData.item.."` bậc`"..rank.."` nhận lại ***"..missionData.data[rank].point.." điểm***.")
    cb("Chúc mừng bạn đã hoàn thành nhiệm vụ và nhận lại cho mình "..missionData.data[rank].point.." điểm.", true)

    SavePlayerData(playerId, true)
end


function PremiumAblePlayer(playerId)
    playersData['id:'..playerId].premium = 1
    SavePlayerData(playerId)
    TriggerClientEvent('reward_event:premium' , playerId)
end


function SendDiscordMessage(message) 
    local wh = 'https://discord.com/api/webhooks/tatwebhooks/1173234704388997140/E50VzFZGbKyjWUeSkLCE5oDxtzeCXs3HyRrK7gGVDwpuLlBIeJ59GlHegQd4D66G53FQ'
    PerformHttpRequest(wh, function(err, text, headers) end, 'POST', json.encode({content = message.." `"..os.date("%H:%M:%S - %d/%m/%Y").."`"}), { ['Content-Type'] = 'application/json' })

end


function LoadTopPlayers()

    MySQL.Async.fetchAll("SELECT `identifier`, `name`, `eventpoint`, `eventtime`  FROM `users` ORDER BY `eventpoint` DESC, `eventtime` LIMIT 40;", {},
    function(result)
            local index = 1
            local data = {}
            while index <= 20 and result[index] ~= nil and result[index].eventpoint ~= 0 and result[index].eventtime ~= 0 do
                table.insert(data, { name = result[index].name, point = result[index].eventpoint } )
                index = index + 1
            end

            topPlayers = data
    end)

end

