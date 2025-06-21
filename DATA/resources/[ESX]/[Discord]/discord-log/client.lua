-- NOTW4018



local prevtime = GetGameTimer()
local prevframes = GetFrameCount()
local fps = -1
local player =0
-- CreateThread(function()
--   while not NetworkIsPlayerActive(PlayerId()) or not NetworkIsSessionStarted() do         
--     Wait(500)
--     prevframes = GetFrameCount()
--     prevtime = GetGameTimer()            
--     end

--   while true do         
--     curtime = GetGameTimer()
--       curframes = GetFrameCount()       
        
--       if((curtime - prevtime) > 1000) then
--           fps = (curframes - prevframes) - 1                
--           prevtime = curtime
--           prevframes = curframes
--       end      
--     Wait(350)
--   end    
-- end)
RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
  player = 0
	for k,v in pairs(connectedPlayers) do	
	
		if v.name ~= nil then
			player = player + 1	
		end
	end
end)
function players()
  local players = {}

  for i = 0, 62 do
      if NetworkIsPlayerActive(i) then
          table.insert(players, i)
      end
  end

  return players
end

function SetRP()
 -- local name = GetPlayerName(PlayerId())
 -- local id = GetPlayerServerId(PlayerId())

  SetDiscordAppId(1116366562715258960)
  SetDiscordRichPresenceAsset('logo')
  --SetDiscordRichPresenceAssetSmall("small")
end

Citizen.CreateThread(function()
  while true do

  Citizen.Wait(3000)
    SetRP()
    SetDiscordRichPresenceAssetText('STABLE')
      -- players = {}
      -- for i = 0, 128 do
      --     if NetworkIsPlayerActive( i ) then
      --         table.insert( players, i )
      --     end
      -- end
    SetRichPresence("Người chơi: " ..player.. " | Tên: " ..GetPlayerName(PlayerId()) )

    SetDiscordRichPresenceAction(0, "Discord!", "https://discord.gg/stablecity")
   -- SetDiscordRichPresenceAction(1, "FiveM!", "https://cfx.re/join/gjab4o")
end
end)