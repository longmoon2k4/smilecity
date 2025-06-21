local webhook = "https://discord.com/api/webhooks/tatwebhooks/1052047813330075731/n63RIgvmyMMrJnY_E-Fk8Z3ENoC8yvAVojWdyBfOxf3HJMCZ2dZlOeaKHifsd4GrWpOB"

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
	sendDiscord(webhook,"Chat me", GetPlayerName(source).." đã chat "..text)
end)

function sendDiscord(webhookurl,name, message)
	local content = {
        {
        	["color"] = '2061822',
            ["title"] = name,
            ["description"] = message ..  os.date ("%X") .." - ".. os.date ("%x") .."",
            ["footer"] = {
            ["text"] = "Log "..name.." By Sulu",
            },
        }
    }
  	PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end
