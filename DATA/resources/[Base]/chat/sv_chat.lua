RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('_chat:messageEnteredP')
RegisterServerEvent('_chat:messageEnteredM')
RegisterServerEvent('_chat:messageEnteredG')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')
RegisterServerEvent('chat:tb')

-- ESX = nil 

-- Citizen.CreateThread(function()
--     while ESX == nil do 
--         Wait(1)
--         TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--     end
-- end)

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end
    local nghe =nil
    local xPlayer = exports.esx_scoreboard:getPlayer(source)
    local job = xPlayer.job
    if job == 'ambulance' then
        nghe = '^1[Ngành] ' 
    elseif job == 'police' then
        nghe ='^5[👮Công An] '
    elseif job == 'mechanic' then
        nghe = '^3[🔧Cứu hộ] '
    elseif xPlayer.job2Name ~= 'nogang' and xPlayer.job2Name ~= 'police' and xPlayer.job2Name ~= 'ambulance' and xPlayer.job2Name ~= 'mechanic' then
        nghe = ('^0[%s]'):format(xPlayer.job2)
    else
        nghe = '^0['..xPlayer.label..'] '
    end
    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        --TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
        TriggerClientEvent('chatMessage', -1, "",  { 255, 255, 255 }, nghe..'^3['..author..']: ^0'..message)
    end
end)

AddEventHandler('_chat:messageEnteredP', function(author, color, message)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then 
        if not message or not author then
            return
        end
    
        TriggerEvent('chatMessageP', source, author, message)
    
        if not WasEventCanceled() then
            TriggerClientEvent('chatMessageP', -1, author,  { 255, 255, 255 }, message)
        end
    
      --  print(author .. '^7: ' .. message .. '^7')
    else 
        --[[ xPlayer.triggerEvent('esx:showNotification', 'Bạn không có quyền chat trong kênh này') ]]
        TriggerClientEvent('chat:addMessageP', source, { args = { '^1SYSTEM', 'Bạn không có quyền chat trong kênh này.' } })
        --[[ TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Bạn không có quyền chat trong kênh này.' } }) ]]
    end
end)

AddEventHandler('_chat:messageEnteredM', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessageM', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessageM', -1, author,  { 255, 255, 255 }, message)
    end

   -- print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('_chat:messageEnteredG', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessageG', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessageG', -1, author,  { 255, 255, 255 }, message)
    end

   -- print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- player join messages
AddEventHandler('chat:init', function()
    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' đã vào trận.')
end)

AddEventHandler('playerDropped', function(reason)
    TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' đã rời trận (' .. reason .. ')')
end)

-- RegisterCommand('say', function(source, args, rawCommand)
--     TriggerClientEvent('chatMessage', -1, (source == 0) and '^1THÔNG BÁO' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
-- end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)
RegisterNetEvent('chat:tb')
AddEventHandler('chat:tb', function(name, msg)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= 50000 then
        
       -- TriggerClientEvent('chat:addTemplate', 'tb', '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>')
        --TriggerEvent('chat:addMessage', { templateId = 'tb', multiline = true, args = { name, msg} })
       -- TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Bạn không đủ tiền.' } })
        --TriggerClientEvent('chat:addMessage', { templateId = 'tb', multiline = true, args = { name, msg} })
        TriggerClientEvent('chat:addMessage', -1, { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 12px;">     <i class="fas fa-globe"></i> {0}:<br> {1}</div>', args = { '^0'..name, '^0'..msg} })
        -- TriggerClientEvent('chat:addTemplate','tb',temp)
        -- TriggerClientEvent('chat:addMessage', { templateId = 'tb', multiline = true, args = { 'Blu', 'tianshee was mean to me today 🙁' } })
        xPlayer.removeMoney(50000)
      
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Bạn không đủ tiền.' } })
    end
    
   
end)
local cacheJob = {}
local cacheJob2 = {}
local gang = {'gangmg','gangma','gangptg','gangunc', 'gangmxc', 'ganghome', 'gangctb', 'gangfr', 'gangdv', 'gangop', }
AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	cacheJob[tonumber(playerId)] = job.name
end)

AddEventHandler('esx:setJob2', function(playerId, job, lastJob)
	cacheJob2[tonumber(playerId)] = job.name
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if cacheJob[playerId] ~= nil then
        cacheJob[playerId] = nil
    end
    if cacheJob2[playerId] ~= nil then
        cacheJob2[playerId] = nil
    end
end)

function getJob(id)
    if cacheJob[id] then
        return cacheJob[id]
    else
        if ESX.GetPlayerFromId(id) ~= nil then
            cacheJob[id]=  ESX.GetPlayerFromId(id).job.name
            return cacheJob[id]
        else
            return "not"
        end
    end
end

function getJob2(id)
    if cacheJob2[id] then
        return cacheJob2[id]
    else
        if ESX.GetPlayerFromId(id) ~= nil then
            cacheJob2[id]=  ESX.GetPlayerFromId(id).job2.name
            return cacheJob2[id]
        else
            return "not"
        end
    end
end

function checkGang(name)
    for k,v in ipairs(gang) do
        if name == v then
            return true
        end
    end
    return false
end

RegisterNetEvent('chat:chatNganh')
AddEventHandler('chat:chatNganh', function(name, msg)
   -- local xPlayer = ESX.GetPlayerFromId(source)
    local source = source
    local jobChat = getJob(tonumber(source))
    local xPlayers = ESX.GetPlayers()
    if jobChat == 'police' or jobChat == 'ambulance' or jobChat == 'mechanic' then
        for i=1, #xPlayers, 1 do
            -- local xPlayerNhan = ESX.GetPlayerFromId(xPlayers[i])
            -- local job = xPlayerNhan.job.name
            if getJob(tonumber(xPlayers[i])) ==jobChat then
                TriggerClientEvent('chat:addMessage', xPlayers[i], { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: #567fe8; color: white; border-radius: 12px;"> {0}: {1}</div>',  args = { name, '^0'..msg} })
            elseif getJob(tonumber(xPlayers[i])) ==jobChat then
                TriggerClientEvent('chat:addMessage', xPlayers[i], { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: #f2f066; color: black; border-radius: 12px; "> {0}: {1}</div>',  args = {name, '^0'..msg} })
            elseif getJob(tonumber(xPlayers[i])) ==jobChat then
                TriggerClientEvent('chat:addMessage', xPlayers[i], { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: #d47cde; color: black; border-radius: 12px;"> {0}: {1}</div>',  args = { name, '^0'..msg} })
            end
        end
    end
end)

RegisterNetEvent('chat:chatGang')
AddEventHandler('chat:chatGang', function(name, msg)
   -- local xPlayer = ESX.GetPlayerFromId(source)
    local source = source
    local jobChat = getJob2(tonumber(source))
    local xPlayers = ESX.GetPlayers()
    local check = checkGang(jobChat)
    if check == true  then
        for i=1, #xPlayers, 1 do
            -- local xPlayerNhan = ESX.GetPlayerFromId(xPlayers[i])
            -- local job = xPlayerNhan.job.name
            if getJob2(tonumber(xPlayers[i])) ==jobChat then
                TriggerClientEvent('chat:addMessage', xPlayers[i], { template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: #567fe8; color: white; border-radius: 12px;"> {0}: {1}</div>',  args = { name, '^0'..msg} })
           end
        end
    end
end)

RegisterServerEvent("chat:banChat")
AddEventHandler("chat:banChat", function()
	local src = source
	local camchattime=0
	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier
	MySQL.Async.fetchAll("SELECT camchat FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
        camchattime = tonumber(result[1].camchat)
        if camchattime ~= nil then
            if camchattime > 0 then
                MySQL.Async.execute(
                    "UPDATE users SET camchat = @newcamchat WHERE identifier = @identifier",
                    {
                        ['@identifier'] = Identifier,
                        ['@newcamchat'] = camchattime - 1
                    }
                )
            end
            TriggerClientEvent("chat:banChat",src,camchattime - 1,camchattime > 0 and true or false)
        end
    end)
end)

RegisterCommand('mutechat', function(source, args, rawCommand)
    if args[1]~=nil and  args[2]~=nil then
        if GetPlayerName(tonumber(args[1])) ~= nil then
            local xPlayer1 = ESX.GetPlayerFromId(tonumber(args[1]))
                local Identifier = xPlayer1.identifier
                MySQL.Async.fetchAll("SELECT camchat FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
                    MySQL.Async.execute(
                        "UPDATE users SET camchat = @newcamchat WHERE identifier = @identifier",
                        {
                            ['@identifier'] = Identifier,
                            ['@newcamchat'] = tonumber(args[2])
                        }
                    )
                end)
                TriggerClientEvent("chat:banChat",tonumber(args[1]),tonumber(args[2]),true)
        end
    end
end,true)

RegisterServerEvent("chat:banChatBot")
AddEventHandler("chat:banChatBot", function(souce, tiem)
    local xPlayer1 = ESX.GetPlayerFromId(tonumber(souce))
    local Identifier = xPlayer1.identifier
    MySQL.Async.fetchAll("SELECT camchat FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
        MySQL.Async.execute(
            "UPDATE users SET camchat = @newcamchat WHERE identifier = @identifier",
            {
                ['@identifier'] = Identifier,
                ['@newcamchat'] = tonumber(tiem)
            }
        )
    end)
    TriggerClientEvent("chat:banChat",tonumber(souce),tonumber(tiem),true)
end)