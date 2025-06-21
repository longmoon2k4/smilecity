-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getGradeJob(job, cb)
    MySQL.Async.fetchAll("SELECT * FROM job_grades WHERE job_name = @job_name", {
        ["@job_name"] = job
    }, function(result)
        if result then
            cb(result)
        end
    end)
end

function loadOffline(job, cb)
    MySQL.Async.fetchAll("SELECT u.identifier, u.name, u.job2, u.job2_grade,j.label  FROM users u LEFT JOIN job_grades j ON u.job2_grade =  j.grade   WHERE u.job2  = @job AND j.job_name = @job2", {
        ["@job"] = job,
        ["@job2"] = job
    }, function(result)
        if result then
            cb(result)
        end
    end)
end

function setJobOff(identifier, role)
    MySQL.Async.execute('UPDATE users SET `job2_grade` = @job_grade WHERE identifier = @identifier', {
		['@job_grade'] = role,
		['@identifier'] = identifier,
	}, function(rowsChanged)
	end)
end

function kickJobOff(identifier)
    MySQL.Async.execute('UPDATE users SET `job2_grade` = @job_grade, `job2` = @job WHERE identifier = @identifier', {
		['@job_grade'] = 0,
        ['@job'] = 'nogang',
		['@identifier'] = identifier,
	}, function(rowsChanged)
	end)
end

ESX.RegisterServerCallback('sulu_member_job2:server:getData', function(source, cb, job)
    getGradeJob(job, function(callback)
        loadOffline(job, function(xPlayerOff)   
        Wait(100)
        local players = {}
        local xPlayers = ESX.GetPlayers()
        local xPlayerInJob = ESX.GetPlayerFromId(source)
        local inJob = xPlayerInJob.job2.name
       
       if xPlayerInJob.getJob2().grade_name == "boss" then
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer ~= nil then
                    if xPlayer.job2.name == job then
                        table.insert(players, {
                            source = xPlayers[i],
                            idCard =  xPlayers[i],
                            identifier = xPlayer.identifier,
                            name = GetPlayerName(xPlayers[i]),
                            job = xPlayer.getJob2(),
                            status = 'Online'
                        })
                    end
                end
            end
            for i=1, #xPlayerOff, 1 do
                table.insert(players, {
                    source = 'off',
                    idCard =  'off',
                    identifier = tostring(xPlayerOff[i].identifier),
                    name = xPlayerOff[i].name,
                    job = {
                        grade_label = xPlayerOff[i].label,
                        name = xPlayerOff[i].job2,
                        grade = xPlayerOff[i].job2_grade
                    },
                    status = 'Offline'
                })
            end
            local seenValues = {}
            for i = 1, #players, 1 do
                if players[i] ~= nil then
                    if seenValues[players[i].identifier] then
                        table.remove(players, i)
                    else
                        seenValues[players[i].identifier] = true
                    end
                end
            end
            cb(players, callback, inJob)
        else
            cb(false)
        end
    end)
    end)
end)

ESX.RegisterServerCallback("sulu_member_job2:server:setJob", function(source, cb, data, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromIdentifier(data.identifier)
    if data.status == "Online" then
        if xPlayer.source == tPlayer.source then
            cb({msg = "Bạn không thể làm việc này cho bản thân.", status = "error"})
            return 
        end
        if  xPlayer.getJob2().grade_name == "boss" then
            if tPlayer then
                if action == "set" then
                    tPlayer.setJob2(xPlayer.job2.name, data.role)
                    tPlayer.showNotification("Cấp bậc của bạn đã được thay đổi.")
                    cb({msg = "Thành công.", status = "success"})
                elseif action == "kick" then
                    tPlayer.setJob2("nogang", 0)
                    tPlayer.showNotification("Bạn đã bị đuổi ra khỏi gang.")
                    cb({msg = "Bạn đã tống người này ra khỏi danh sách thành viên.", status = "success"})
                end
            else
                cb({msg = "Không tìm thấy người chơi này.", status = "error"})
            end
        else
            cb({msg = "Không đủ quyền hạn để làm việc này.", status = "error"})
        end
    else
        if  xPlayer.getJob2().grade_name == "boss" then
            if action == "set" then
                setJobOff(data.identifier, data.role)
                -- tPlayer.setJob2(xPlayer.job2.name, data.role)
                -- tPlayer.showNotification("Cấp bậc của bạn đã được thay đổi.")
                cb({msg = "Thành công.", status = "success"})
            elseif action == "kick" then
                kickJobOff(data.identifier)
                -- tPlayer.setJob2("nogang", 0)
                -- tPlayer.showNotification("Bạn đã bị đuổi ra khỏi gang.")
                cb({msg = "Bạn đã tống người này ra khỏi danh sách thành viên.", status = "success"})
            end
        else
            cb({msg = "Không đủ quyền hạn để làm việc này.", status = "error"})
        end
    end
end)

ESX.RegisterServerCallback("sulu_member_job2:server:Invite", function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(data.number)
    if xPlayer.source == tPlayer.source then
        cb({msg = "Bạn không thể làm việc này cho bản thân.", status = "error"})
        return 
    end
    if xPlayer.getJob2().grade_name == "boss" then
        if tPlayer and tPlayer.job2.name =='nogang' then
            tPlayer.setJob2(data.job, 0)
            tPlayer.showNotification("Bạn đã được tuyển dụng vào gang.")
            cb({msg = "Thành công.", status = "success"})
        else
            cb({msg = "Không tìm thấy người chơi này. Hoac nguoi choi dang o gang khac", status = "error"})
        end
    else
        cb({msg = "Không đủ quyền hạn để làm việc này.", status = "error"})
    end
end)




