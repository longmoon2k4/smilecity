--[[ 
	Release Script Discord Webhook
	author:Sompong
	Mydiscord:https://discord.gg/aCMFgND
]]

Config = {}

Config['Send_basic'] = {
	['chat'] = {webhook = "https://discord.com/api/webhooks/tatwebhooks/1052046324788375572/euG1I1Nj8drdcGGzLfYpdJ21yK0Peah1nceU1nPMAPTDACoO6vUkBNEFNoweIjpBRb2D", color = 16777215},
	['connecting'] = {webhook = "https://discord.com/api/webhooks/tatwebhooks/1052046127429603408/gid4DAWtKq7yHVNTUo91V2IJSyQ9FlQCI-WWbtKegdo17pgzMmDAU-MWTdpVy6wIvTaT", color = 65280},
	['player_drop'] = {webhook = "https://discord.com/api/webhooks/tatwebhooks/1052046250834411520/mvqk5W_B2H18MhnZCn-ZA_Jhz7-kG42o-9Q2LL3ylYmBYau6MgEgmjYPaj6Bzn9uZJcp", color = 16711680}
}

-- Web color Use ( Decimal color)
-- https://convertingcolors.com/

--[[ 
	You can add logdiscord in file server.lua all script
	EX.
		local massage = "Player ".. xPlayer.name .." BuyItem ".. itemname .." price ".. price .." $"
		TriggerEvent('sm-discord-log:senddiscord', massage , color, source, "Your Webhook discord")

	EX2. add color
		local massage = "Player ".. xPlayer.name .." BuyItem ".. itemname .." price ".. price .." $"
		TriggerEvent('sm-discord-log:senddiscord', massage , 16711680, source, "Your Webhook discord")
]]