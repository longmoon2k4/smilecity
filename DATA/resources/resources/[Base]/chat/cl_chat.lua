local isRDR = not TerraingridActivate and true or false
local isMute = false
local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false
local delayChat = 0
local isBanChat = false
local timeBanChat = 0 
local delayChat = 0
AddEventHandler('onClientResourceStart', function(name)
  print(name)
end)
RegisterNetEvent('chatMessage')
RegisterNetEvent('chatMessageP')
RegisterNetEvent('chatMessageM')
RegisterNetEvent('chatMessageG')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addMessageP')
RegisterNetEvent('chat:addMessageM')
RegisterNetEvent('chat:addMessageG')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

RegisterCommand("muteall", function()
	isMute = not isMute
	print(isMute)
end)
AddEventHandler('esx:playerLoaded', function(xPlayer)
	TriggerServerEvent("chat:banChat")
end)
--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
   -- author = '<span style: color: rgb(253, 132, 31)>[' .. author  .. ']</span>'
    table.insert(args, 1, author)
  end
	if isMute == false then 
		SendNUIMessage({
			type = 'ON_MESSAGE',
			message = {
			  color = color,
			  multiline = true,
			  args = args
			}
		  }) 
	end
end)

AddEventHandler('chatMessageP', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
	if isMute == false then 
		SendNUIMessage({
			type = 'ON_MESSAGEP',
			message = {
			  color = color,
			  multiline = true,
			  args = args
			}
		  }) 
	end
end)

AddEventHandler('chatMessageM', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
	if isMute == false then 
		SendNUIMessage({
			type = 'ON_MESSAGEM',
			message = {
			  color = color,
			  multiline = true,
			  args = args
			}
		  }) 
	end
end)

AddEventHandler('chatMessageG', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
	if isMute == false then 
		SendNUIMessage({
			type = 'ON_MESSAGEG',
			message = {
			  color = color,
			  multiline = true,
			  args = args
			}
		  }) 
	end
  
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  print(msg)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      templateId = 'print',
      multiline = true,
      args = { msg }
    }
  })
end)

AddEventHandler('chat:addMessage', function(message)
	if isMute == false then 
		  SendNUIMessage({
			type = 'ON_MESSAGE',
			message = message
		  })
	end
end)

AddEventHandler('chat:addMessageP', function(message)
  if isMute == false then 
		  SendNUIMessage({
			type = 'ON_MESSAGEP',
			message = message
		  })
	end
end)

AddEventHandler('chat:addMessageM', function(message)
  if isMute == false then 
		  SendNUIMessage({
			type = 'ON_MESSAGEM',
			message = message
		  })
	end
end)

AddEventHandler('chat:addMessageG', function(message)
  if isMute == false then 
		  SendNUIMessage({
			type = 'ON_MESSAGEG',
			message = message
		  })
	end
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false, false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      if delayChat <= 0 and not isBanChat then
        delayChat=5
        TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
      else
        if isBanChat then
          TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn bị cấm chat trong '..timeBanChat..'phút')
        else
          TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn phải đợi '..delayChat..'giây')
        end
      end
    end
  end

  cb('ok')
end)

RegisterNUICallback('chatResultP', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false, false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEnteredP', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)

RegisterNUICallback('chatResultM', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false, false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEnteredM', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)

RegisterNUICallback('chatResultG', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false, false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEnteredG', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if delayChat > 0 then
      delayChat = delayChat - 1
    end
  end
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(60000)
      if isBanChat then
          TriggerServerEvent("chat:banChat")
      end
  end
end)

RegisterNetEvent("chat:banChat")
AddEventHandler("chat:banChat", function(time,bool)
    timeBanChat = time
    isBanChat = bool
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false, false)

  -- while true do
  --   Wait(0)

  --   if not chatInputActive then
  --     if IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
  --       chatInputActive = true
  --       chatInputActivating = true
  --       --SetNuiFocus(true, true)
  --       SendNUIMessage({
  --         type = 'ON_OPEN'
  --       })
  --     end
  --   end

  --   if chatInputActivating then
  --     if not IsControlPressed(0, isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245) then
  --       SetNuiFocus(true, true)

  --       chatInputActivating = false
  --     end
  --   end

  --   if chatLoaded then
  --     local shouldBeHidden = false

  --     if IsScreenFadedOut() or IsPauseMenuActive() then
  --       shouldBeHidden = true
  --     end

  --     if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
  --       chatHidden = shouldBeHidden

  --       SendNUIMessage({
  --         type = 'ON_SCREEN_STATE_CHANGE',
  --         shouldHide = shouldBeHidden
  --       })
  --     end
  --   end
  -- end
end)

RegisterCommand('lagui', function()
    if chatInputActive then
        chatInputActive = false
        SetNuiFocus(false, false)
        SendNUIMessage({
           type = 'lag_ui',
           shouldHide = shouldBeHidden         
        })
    end
end)

RegisterCommand('clearchat', function()
    SendNUIMessage({
        type = 'ON_CLEAR'
      })
end)

RegisterCommand('tb', function(source, args, rawCommand)
  if delayChat <= 0 and not isBanChat then
    delayChat=5
    local playerName = GetPlayerName(PlayerId())
    local msg = rawCommand:sub(4)
    TriggerServerEvent('chat:tb',playerName,msg )
  else
    if isBanChat then
      TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn bị cấm chat trong'..timeBanChat..'phút')
    else
      TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn phải đợi'..delayChat..'giây')
    end
  end
end, false)

RegisterCommand('n1', function(source, args, rawCommand)
    if delayChat <= 0 and not isBanChat then
        delayChat=5
        local playerName = GetPlayerName(PlayerId())
        local msg = rawCommand:sub(4)
        TriggerServerEvent('chat:chatNganh',playerName,msg)
    else
        if isBanChat then
          TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn bị cấm chat trong '..timeBanChat..'phút')
        else
          TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn phải đợi '..delayChat..'giây')
        end
      end
end, false)

RegisterCommand('n2', function(source, args, rawCommand)
    if delayChat <= 0 and not isBanChat then
        delayChat=5
        local playerName = GetPlayerName(PlayerId())
        local msg = rawCommand:sub(4)
        TriggerServerEvent('chat:chatGang',playerName,msg)
    else
        if isBanChat then
          TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn bị cấm chat trong '..timeBanChat..'phút')
        else
          TriggerEvent('chatMessage', "",  { 179, 19, 18 },'Bạn phải đợi '..delayChat..'giây')
        end
      end
end, false)
RegisterKeyMapping('chat', 'Chat', 'keyboard', "t")
RegisterCommand('chat', function(source, args, rawCommand)
    if not chatInputActive then
        chatInputActive = true
        chatInputActivating = true
        --SetNuiFocus(true, true)
        SendNUIMessage({
          type = 'ON_OPEN'
        })
    end

    if chatInputActivating then
      
        SetNuiFocus(true, true)

        chatInputActivating = false
    
    end

    if chatLoaded then
      local shouldBeHidden = false

      if IsScreenFadedOut() or IsPauseMenuActive() then
        shouldBeHidden = true
      end

      if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
        chatHidden = shouldBeHidden

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          shouldHide = shouldBeHidden
        })
      end
    end
  
  
end, false)