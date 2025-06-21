-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)   -- dùng để sử dụng hàm trong esx khác

local team,member,memberGang = {},{},{}
local gang = {'gangmg','gangma','gangptg','gangunc', 'gangmxc',  'gangctb', 'gangfr', 'gangdv', 'gangop'}
local police = {'police'}
function _CheckTeamExist(name)
    for k,v in ipairs(team) do
        if v.name == name then
            return true
        end
    end
    return false
end

function _CheckPassWordExist(name, pwd)
    for k,v in ipairs(team) do
        if v.name == name then
            if v.password == pwd then
                return true
            end
        end
    end
    return false
end

RegisterServerEvent("teamblip:createteam")
AddEventHandler("teamblip:createteam",function(name,pwd)
    if not _CheckTeamExist(name) then
        table.insert(team,{name = name, password = pwd})
        member[name] = {}
        table.insert(member[name],{id = source,name = GetPlayerName(source)})
        TriggerClientEvent("teamblip:updatemember",source, name, member[name])
        TriggerClientEvent('esx:showNotification', source, "Bạn đã tạo team thành công!")
    else
        TriggerClientEvent('esx:showNotification', source, "Tên Team Đã Tồn Tại!!")
    end
end)

RegisterServerEvent("teamblip:jointeam")
AddEventHandler("teamblip:jointeam",function(name,pwd)
    if _CheckTeamExist(name) then
        if _CheckPassWordExist(name,pwd) then
            table.insert(member[name],{id = source,name = GetPlayerName(source)})
            for k,v in ipairs(member[name]) do
                TriggerClientEvent("teamblip:updatemember",v.id, name, member[name])
                TriggerClientEvent('esx:showNotification', v.id, "~r~" .. GetPlayerName(source) .. "~s~ vừa tham gia vào team !")
            end
        else
            TriggerClientEvent('esx:showNotification', source, "Sai Password Của Team!!")
        end
    else
        TriggerClientEvent('esx:showNotification', source, "Tên Team Không Tồn Tại!!")
    end
end)

function _outteam(source,name)
    for k,v in ipairs(member[name]) do
        if v.id == source then
            table.remove(member[name],k)
        end
    end 
    for k,v in ipairs(member[name]) do
        TriggerClientEvent("teamblip:updatemember",v.id, name, member[name])
        TriggerClientEvent('esx:showNotification', v.id, "~r~" .. GetPlayerName(source) .. " ~s~Đã Rời Team!!")
    end
    TriggerClientEvent('esx:showNotification', source, "Rời Team Thành Công!!!")
    if #member[name] == 0 then
        member[name] = {}
        for k,v in ipairs(team) do
            if v.name == name then
                table.remove(team,k)
            end
        end
        TriggerClientEvent('esx:showNotification', source, "Đã Xóa Team Vì Bạn Là Người Cuối Cùng!!!")
    end
end

RegisterServerEvent("teamblip:outteam")
AddEventHandler("teamblip:outteam",function(name)
    _outteam(source,name)
end)

AddEventHandler('playerDropped', function(reason)
    for k,v in ipairs(team) do
        for k1,v1 in ipairs(member[v.name]) do
            if v1.id == source then
                _outteam(source,v.name)
            end
        end
    end
end)

function checkGang(name)
    for k,v in ipairs(gang) do
        if name == v then
            return true
        end
    end
    return false
end

function checkPolice(name, grade)
    for k,v in ipairs(police) do
        if name == v then
            return true
        end
    end
    if grade == 'quany' then
        return true
    end
    return false
end

function checkId(id, array)
    for k,v in ipairs(array) do
        if id == v.id then
            return true
        end
    end
    return false
end

 function createTeam()
     for k,v  in ipairs(police) do
         memberGang[v] ={}
     end
     for k,v  in ipairs(gang) do
         memberGang[v] ={}
     end
 end
 createTeam()
 RegisterNetEvent('teamblip:joinTem')
 AddEventHandler('teamblip:joinTem', function(job, job2)
    local source = source
     local checkGang = checkGang(job2)
     local checkPolice = checkPolice(job.name, job.grade_name)
     if checkGang==true or checkPolice==true then
         local nameGangPolice = checkGang == true and job2 or (job.name == 'ambulance' and 'police' or job.name)
         table.insert( memberGang[nameGangPolice], {id = source,name = GetPlayerName(source)})
         for k,v in ipairs(memberGang[nameGangPolice]) do 
             TriggerClientEvent('teamblip:updatemember2',v.id, memberGang[nameGangPolice])
         end
     end
 end)

 AddEventHandler('esx:playerDropped', function(playerId, reason)
    local key123
     for key, values in pairs(memberGang) do
         for i, value in ipairs(values) do
             if value.id == playerId then
                 table.remove(memberGang[key], i) -- Xóa giá trị khỏi mảng
                 key123 = key
                 break
             end
         end
     end
     if key123~= nil then
        for k,v in ipairs(memberGang[key123]) do 
            TriggerClientEvent('teamblip:updatemember2',v.id, memberGang[key123])
        end
     end
 end)

 AddEventHandler('esx:setJob', function(playerId, job, lastJob)
 	local check = checkPolice(job.name, job.grade_name)
     local checkLast = checkPolice(lastJob.name,  lastJob.grade_name)
     if job.name ~= lastJob.name then
        local jobAccept = job.name == 'ambulance' and 'police' or job.name
        local jobLastAccept = lastJob.name == 'ambulance' and 'police' or lastJob.name
        if check == true then
            table.insert(memberGang[jobAccept], {id = playerId,name = GetPlayerName(playerId)})
            for k,v in ipairs(memberGang[jobAccept]) do 
                TriggerClientEvent('teamblip:updatemember2',v.id, memberGang[jobAccept])
            end
        end
        if checkLast == true then
            for k,v in ipairs(memberGang[jobLastAccept]) do
                if v.id == playerId then
                    table.remove( memberGang[jobLastAccept],k)
                    break
                end
            end
            for k,v in ipairs(memberGang[jobLastAccept]) do 
                TriggerClientEvent('teamblip:updatemember2',v.id, memberGang[jobLastAccept])
            end
            TriggerClientEvent('teamblip:updatemember2',playerId, nil)
        end
    end
 end)

 AddEventHandler('esx:setJob2', function(playerId, job, lastJob)
 	local check = checkGang(job.name)
     local checkLast = checkGang(lastJob.name)
     if job.name ~= lastJob.name then
        if check == true then
            table.insert( memberGang[job.name], {id = playerId,name = GetPlayerName(playerId)})
            for k,v in ipairs(memberGang[job.name]) do 
                TriggerClientEvent('teamblip:updatemember2',v.id, memberGang[job.name])
            end
        end
        if checkLast == true then
            for k,v in ipairs(memberGang[lastJob.name]) do
                if v.id == playerId then
                   table.remove(memberGang[lastJob.name],k)
                    break
                end
            end
            for k,v in ipairs(memberGang[lastJob.name]) do 
                TriggerClientEvent('teamblip:updatemember2',v.id, memberGang[lastJob.name])
            end
            TriggerClientEvent('teamblip:updatemember2',playerId, nil)
        end
    end
 end)