function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)

    if playerData == nil then   TriggerServerEvent("reward_event:getdata") end
   
    while playerData == nil do 
        Wait(10)
    end

    SendNUIMessage({
        type = "ui",
        status = bool,
        currentXp = playerData.point;
        premium = playerData.premium;
        configItems = Config.Events;
        ConfigXp = Config.Xp;
        ConfigMission = Config.Missions;
        mainData = playerData.mainData;
        dailyData = playerData.dailyData;
    })
end


function UpdateData()
    SendNUIMessage({
        type = "update",
        currentXp = playerData.point;
        premium = playerData.premium;
        configItems = Config.Events;
        ConfigXp = Config.Xp;
        ConfigMission = Config.Missions;
        mainData = playerData.mainData;
        dailyData = playerData.dailyData;
    })
end


function SendMessage(message)
    SendNUIMessage({
        type = "response",
        text = message;
    })
end


function ShowPyro(bool)
    if bool then
        SendNUIMessage({
            type = "pyro"
        })
    end
end

function UpdateTopPlayers(topPlayers)
    SendNUIMessage({
        type = "top",
        data = topPlayers;
    })
end

