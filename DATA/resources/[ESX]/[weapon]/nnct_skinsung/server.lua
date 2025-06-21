local tensung = {
    --Pistol
	[GetHashKey('WEAPON_PISTOL')] = "Súng Lục",
	-- Smg
	[GetHashKey('WEAPON_MICROSMG')] = "MICRO SMG",
	[GetHashKey('WEAPON_SMG')] = "SMG",
	[GetHashKey('WEAPON_SMG_MK2')] = "SMG MK2",
	[GetHashKey('WEAPON_COMBATPDW')] = "PDW",
    -- Ngành
	[GetHashKey('WEAPON_ASSAULTSMG')] = "ASSAULT SMG",
	[GetHashKey('WEAPON_ADVANCEDRIFLE')] = "AUG",

	-- AK
	[GetHashKey('WEAPON_ASSAULTRIFLE')] = "AKM",
	[GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = "AK-MK2",
	[GetHashKey('WEAPON_AK47')] = "AK-47",
	[GetHashKey('WEAPON_HEAVYRIFLE')] = "HEAVY RIFLE",
	[GetHashKey('WEAPON_G36C')] = "G36C",
	[GetHashKey('WEAPON_AK12')] = "AK12",
	[GetHashKey('WEAPON_ASGARD')] = "ASGARD",
	[GetHashKey('WEAPON_AKCSGO_1')] = "AK ADM",
	[GetHashKey('WEAPON_CARBINERIFLE_MK2')] = "Carbinerifle mk2",
	[GetHashKey('WEAPON_COMPACTRIFLE')] = "Ak cut",
    --M4
    
	[GetHashKey('WEAPON_CARBINERIFLE')] = "M4A1",
	[GetHashKey('WEAPON_BULLPUPRIFLE')] = "BULLPUP",
    [GetHashKey('WEAPON_SCARH')] = "SCAR-H",
    [GetHashKey('WEAPON_MILITARYRIFLE')] = "Military",
	[GetHashKey('WEAPON_M4A4')] = "M4A4",
	[GetHashKey('WEAPON_DRAGUNITE')] = "M4 Dragunite",
	[GetHashKey('WEAPON_BORNBEAST')] = "M4 B.Beast",

	--shotgun 
	[GetHashKey('WEAPON_ASSAULTSHOTGUN')] = "Shotgun lien thanh",
	[GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = "sawn off shotgun",

	-- sniper
	[GetHashKey('WEAPON_MARKSMANRIFLE')] = "Marksman Rifle",
}

local tableDamage = {
    --Pistol
	[GetHashKey('WEAPON_PISTOL')] = 8,
	[GetHashKey('WEAPON_PISTOL_MK2')] = 8,

	-- Smg
	[GetHashKey('WEAPON_MICROSMG')] = 11,
	[GetHashKey('WEAPON_SMG')] = 10,
	[GetHashKey('WEAPON_SMG_MK2')] = 12,
	[GetHashKey('WEAPON_COMBATPDW')] = 15,
	
    -- Ngành
	[GetHashKey('WEAPON_ASSAULTSMG')] = 9,
	[GetHashKey('WEAPON_ADVANCEDRIFLE')] = 9,

	-- AK
	[GetHashKey('WEAPON_ASSAULTRIFLE')] = 12,
	[GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = 11,
	[GetHashKey('WEAPON_AK47')] = 14,
	[GetHashKey('WEAPON_HEAVYRIFLE')] = 17,
	[GetHashKey('WEAPON_G36C')] = 22,
	[GetHashKey('WEAPON_AK12')] = 25,
	[GetHashKey('WEAPON_ASGARD')] = 28,
	[GetHashKey('WEAPON_AKCSGO_1')] = 31,
	[GetHashKey('WEAPON_CARBINERIFLE_MK2')] = 15,
	[GetHashKey('WEAPON_COMPACTRIFLE')] = 8,
    --M4

	[GetHashKey('WEAPON_CARBINERIFLE')] = 12,
	[GetHashKey('WEAPON_BULLPUPRIFLE')] = 14,
    [GetHashKey('WEAPON_SCARH')] = 14,
    [GetHashKey('WEAPON_MILITARYRIFLE')] = 16,
	[GetHashKey('WEAPON_M4A4')] = 20,
	[GetHashKey('WEAPON_DRAGUNITE')] = 22,
	[GetHashKey('WEAPON_BORNBEAST')] = 24,

	-- shotgun
	[GetHashKey('WEAPON_ASSAULTSHOTGUN')] = 45,
	[GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = 11,

	-- sniper
}

function sendToWebhook(tenlog, webhook, content)
    local connect = {
  {
      ["color"] = "23295",
      ["title"] = tenlog,
      ["description"] = content,
      ["footer"] = {
          ["text"] = "Log  - "..os.date("%x %X"),
      },
  }
}
PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Log Damage", embeds = connect}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("nnct:logdame")
AddEventHandler("nnct:logdame", function(logdame)
    local count = 0
    for i, j in pairs(logdame) do
        count = count + 1
    end

    if count > 0 then
        local strDame = GetPlayerName(source)
        for k, v in pairs(logdame) do
            local dame = tableDamage[v.weapon]
            if dame ~= nil then
                --if v.dmg ~= dame then
                    if v.bonehash == 31086 then
                        strDame = strDame.."\n Damage: "..v.dmg.."hp, "..tensung[v.weapon].." ("..dame.."), khoảng cách: "..math.floor(v.dist).."m, On Head"
                    elseif v.bonehash == 0 then
                        strDame = strDame.."\n Damage: "..v.dmg.."hp, "..tensung[v.weapon].." ("..dame.."), khoảng cách: "..math.floor(v.dist).."m, On Root"
                    else
                        strDame = strDame.."\n Damage: "..v.dmg.."hp, "..tensung[v.weapon].." ("..dame.."), khoảng cách: "..math.floor(v.dist).."m"
                    end
                --end
            end
        end
        if strDame ~= GetPlayerName(source) then
            sendToWebhook("Log Damage", "https://discord.com/api/webhooks/tatwebhooks/1101500574630957116/Hm8C0nyakME6CKWqn6CtJvEjfmPtGwYlpmVlmG2TITU3nc73HOY2cy8KiR7LaZmDb9YO", strDame)
        end
    end
end)

-- Damage: 23hp, weapon_assaultrifle, on head, 10/04/21 21:25:31 PM

