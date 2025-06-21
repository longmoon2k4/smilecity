--[[ 
	Release Script Discord Webhook
	author:Sompong
	Mydiscord:https://discord.gg/aCMFgND
]]

function sanitize(string)
    return string:gsub('%@', '')
end

AddEventHandler('chatMessage', function(source, name, msg)
    if msg:sub(1, 1) ~= '/' then
        sendDiscord(Config['Send_basic']['chat'].webhook,"chat",'***'..GetPlayerName(source).. '*** đã chat '..msg )
        -- sendToDiscord(sanitize(GetPlayerName(source)).." đã chat [ ".. msg .." ]", Config['Send_basic']['chat'].color, source, Config['Send_basic']['chat'].webhook)
    end
end)

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    -- sendToDiscord(sanitize(GetPlayerName(source)).." đang vào server", Config['Send_basic']['connecting'].color, source,  "https://discord.com/api/webhooks/tatwebhooks/1119286045264064613/B64gBgWp32hWnxQtduvo4CFpSZ1z40lA798upt0NFNfjo9B7KLPO8tE-57lr8n-RTzjS")
    sendToDiscord(sanitize(GetPlayerName(source)).." đang vào server", Config['Send_basic']['connecting'].color, source, Config['Send_basic']['connecting'].webhook)

end)

AddEventHandler('playerDropped', function(reason)
    sendToDiscord(sanitize(GetPlayerName(source)).." mới out server. Lí do: ".. reason .."", Config['Send_basic']['player_drop'].color, source, Config['Send_basic']['player_drop'].webhook)
        -- sendToDiscord(sanitize(GetPlayerName(source)).." mới out server. Lí do: ".. reason .."", Config['Send_basic']['player_drop'].color, source, "   https://discord.com/api/webhooks/tatwebhooks/1119286045264064613/B64gBgWp32hWnxQtduvo4CFpSZ1z40lA798upt0NFNfjo9B7KLPO8tE-57lr8n-RTzjS")
end)

RegisterServerEvent('sm-discord-log:senddiscord')
AddEventHandler('sm-discord-log:senddiscord', function(text, color, src, discord_webhook)
    sendToDiscord(text, color, src, discord_webhook)
end)

--RegisterServerEvent('discord:giveitem')
AddEventHandler('discord:giveitem', function(source, name, count)
    local source = tonumber(source)
    local count = tonumber(count)
    exports.ox_inventory:AddItem(source, name, count)
    
end)

function sendDiscord(webhook,name, message)
	local content = {
		{
			["color"] = '2061822',
			["title"] = name,
			["description"] = message .. os.date ("%X") .." - ".. os.date ("%x") .."",
			["footer"] = {
			["text"] = "Log "..name.." By Sulu",
			},
		}
	}
	  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscord(name, color, src, discord_webhook)
    local identifiers = {
        steam = "chua dang nhap",
        ip = "",
        discord = "khong co",
        license = "khong co",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end
    local hwid = {}
    for i=0, GetNumPlayerTokens(src), 1 do
        table.insert(hwid,GetPlayerToken(src,i))
    end
    local ids = ExtractIdentifiers(src)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = "Identifier:** ".. identifiers.steam .."**\nLink Steam: **https://steamcommunity.com/profiles/".. (tonumber(ids.steam:gsub("steam:", ""),16) or " chua dang nhap") .."**\n Rockstar: **".. identifiers.license .."**\n Discord: <@".. ids.discord:gsub("discord:", "") .."> |  Discord ID: **".. identifiers.discord .."** \n IP Address: **".. GetPlayerEndpoint(src) .."** \n Id o dia: **"..json.encode(hwid).."**",
              ["footer"] = {
                  ["text"] = "Thời gian: ".. os.date ("%X") .." - ".. os.date ("%x") .."",
              },
          }
      }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end



function ExtractIdentifiers(src)
    local identifiers = {
        steam = "chua dang nhap",
        ip = "",
        discord = "khong co",
        license = "khong co",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end