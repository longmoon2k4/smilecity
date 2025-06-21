-- ESX = nil
-- Citizen.CreateThread(function()
--     while ESX == nil do
--        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--        Citizen.Wait(0)
--     end 
-- end)

local IsTeam,nameteam,member,IsTeamGang,memberGang = false,nil,{}, false,{}

function _RemoveBlip(id)
    local id = GetPlayerFromServerId(id)
    local pedUser = GetPlayerPed(id)
    local blip = GetBlipFromEntity(pedUser)
    if DoesBlipExist(blip) then
        if pedUser ~= GetPlayerPed(-1) then
            RemoveBlip(blip)
        end
    end
end

function _CreateBlip(id)
    local id = GetPlayerFromServerId(id)
    local pedUser = GetPlayerPed(id)
    local blip = GetBlipFromEntity(pedUser)
    if not DoesBlipExist(blip) then
        if pedUser ~= GetPlayerPed(-1) then
            local blipPoli = AddBlipForEntity(pedUser)
            SetBlipSprite(blipPoli, 1)
            Citizen.InvokeNative( 0x5FBCA48327B914DF, blipPoli, true)
            SetBlipAsShortRange(blipPoli, false)
            SetBlipColour(blipPoli, 27)
            SetBlipScale(blipPoli, 0.75)
            SetBlipNameToPlayerName(blipPoli, id)
        end
    end
end

RegisterCommand("team",function()
    _OpenMenuTeam()
end)

function OpenParameterDialog(length)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP", "", "", "", "", "", length)
    while UpdateOnscreenKeyboard()==0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if GetOnscreenKeyboardResult() then return GetOnscreenKeyboardResult() end
end

function _createteam()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'createteam', {
        title    = "Tạo Team",
        align    = 'bottom-right',
        elements = {
            {label = "Tên Team: " , action = "nameteam", value = "", key = 1},
            {label = "Password Team: " , action = "pwdteam", value = "", key = 2},
            {label = "Tạo Team" , action = "create", value = ""},
        }
    }, function(data, menu)
        if data.current.action == 'nameteam' then
            data.current.value = OpenParameterDialog(255)
            data.current.label = "Tên Team: "..data.current.value
        elseif data.current.action == 'pwdteam' then
            data.current.value = OpenParameterDialog(255)
            data.current.label = "Password Team: "..data.current.value
        elseif data.current.action == 'create' then
            TriggerServerEvent("teamblip:createteam",menu.data.elements[1].value,menu.data.elements[2].value)
            ESX.UI.Menu.CloseAll()
        end
        if data.current.key~=nil then 
            menu.setElement(data.current.key, "label", data.current.label); 
            menu.setElement(data.current.key, "value", data.current.value); 
            menu.refresh() 
        end
    end, function(data, menu)
        menu.close()
    end)
end

function _jointeam()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jointeam', {
        title    = "Tham Gia Team",
        align    = 'bottom-right',
        elements = {
            {label = "Tên Team: " , action = "nameteam", value = "", key = 1},
            {label = "Password Team: " , action = "pwdteam", value = "", key = 2},
            {label = "Tham Gia Team" , action = "join", value = ""},
        }
    }, function(data, menu)
        if data.current.action == 'nameteam' then
            data.current.value = OpenParameterDialog(255)
            data.current.label = "Tên Team: "..data.current.value
        elseif data.current.action == 'pwdteam' then
            data.current.value = OpenParameterDialog(255)
            data.current.label = "Password Team: "..data.current.value
        elseif data.current.action == 'join' then
            TriggerServerEvent("teamblip:jointeam",menu.data.elements[1].value,menu.data.elements[2].value)
            ESX.UI.Menu.CloseAll()
        end
        if data.current.key~=nil then 
            menu.setElement(data.current.key, "label", data.current.label); 
            menu.setElement(data.current.key, "value", data.current.value); 
            menu.refresh() 
        end
    end, function(data, menu)
        menu.close()
    end)
end

function _PointWay(id)
    --print(id)
end

function _dsteam()
    local elements = {}
    for k,v in ipairs(member) do
        table.insert(elements, {label = v.name .. "[" .. v.id .. "]", value = v.id})
    end
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dsteam', {
        title    = "Tham Gia Team",
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)
        _PointWay(data.current.value)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

function _OpenMenuTeam()
    ESX.UI.Menu.CloseAll()
    if not IsTeam then
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuTeam', {
            title    = "TEAM",
            align    = 'bottom-right',
            elements = {
                {label = "Tạo Team" , action = "create"},
                {label = "Tham Gia Team" , action = "join"},
            }
        }, function(data, menu)
            if data.current.action == 'create' then
                _createteam()
            elseif data.current.action == 'join' then
                _jointeam()
            end
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
    else
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'MenuTeam', {
			title    = "TEAM",
			align    = 'bottom-right',
			elements = {
                {label = "Tên Team: " .. nameteam , action = ""},
                {label = "Danh Sách Thành Viên" , action = "dsteam"},
                {label = "Rời Khỏi Team" , action = "outteam"},
            }
		}, function(data, menu)
            if data.current.action == 'outteam' then
                for k,v in ipairs(member) do
                    _RemoveBlip(v.id)
                end
                TriggerServerEvent("teamblip:outteam",nameteam)
                IsTeam,nameteam,member = false,nil,{}     
            elseif data.current.action == 'dsteam' then
                _dsteam()
            end
			menu.close()
		end, function(data, menu)
			menu.close()
        end)
    end
end

local blipGang = {}
local IsBlip = {}
local IsBlipGang = {}
function createBlipGang(id)
    local id = GetPlayerFromServerId(id)
    local pedUser = GetPlayerPed(id)
    local blip = GetBlipFromEntity(pedUser)
    if not DoesBlipExist(blip) then
        if pedUser ~= cache.ped then
            local blipPoli = AddBlipForEntity(pedUser)
            SetBlipSprite(blipPoli, 1)
            Citizen.InvokeNative( 0x5FBCA48327B914DF, blipPoli, true)
            SetBlipColour(blipPoli, 27)
            SetBlipScale(blipPoli, 0.75)
            SetBlipNameToPlayerName(blipPoli, id)
            SetBlipAsShortRange(blipPoli, true)
            table.insert(blipGang, blipPoli)
        end
    end
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Wait(20000)
    TriggerServerEvent('teamblip:joinTem', xPlayer.job, xPlayer.job2.name)
end)

RegisterNetEvent("teamblip:updatemember")
AddEventHandler("teamblip:updatemember",function(name,member1)
    for k,v in ipairs(member) do
        _RemoveBlip(v.id)
        IsBlip = {}
    end
    IsTeam,nameteam,member = true,name,member1
end)

RegisterNetEvent("teamblip:updatemember2")
AddEventHandler("teamblip:updatemember2",function(member123, abc)
    for k, existingBlip in ipairs(blipGang) do
		RemoveBlip(existingBlip)
	end
    blipGang = {}
    IsBlipGang = {}
    memberGang = member123
    if member123 ~= nil then
        IsTeamGang = true
        --for k,v in ipairs(member123) do
        --    createBlipGang(v.id)
        --end
    else
        IsTeamGang = false
    end
end)

function _CheckIsBlip(id)
    for k,v in ipairs(IsBlip) do
        if v.id == id then
            return true
        end
    end
    return false
end

function _CheckIsBlipGang(id)
    for k,v in ipairs(IsBlipGang) do
        if v.id == id then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if IsTeam then
            --print("step 1")
            for k,v in ipairs(member) do       
                local check = NetworkIsPlayerActive(GetPlayerFromServerId(v.id))
                --print("step 2: id " .. v.id .. ",network: " .. tostring(check) .. ", checkblip: ".. tostring(_CheckIsBlip(v.id)))
                if check and _CheckIsBlip(v.id) == false then
                    --print("step 3: id " .. v.id .. ", SHOW BLIP")
                    _CreateBlip(v.id)
                    table.insert(IsBlip, {id = v.id})
                elseif not check and _CheckIsBlip(v.id) == true then
                    --print("step 3: id " .. v.id .. ", Remove BLIP")
                    for k1,v1 in ipairs(IsBlip) do
                        if v1.id == v.id then
                            table.remove(IsBlip, k1)
                        end
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if IsTeamGang then
            --print("step 1")
            for k,v in ipairs(memberGang) do       
                local check = NetworkIsPlayerActive(GetPlayerFromServerId(v.id))
                --print("step 2: id " .. v.id .. ",network: " .. tostring(check) .. ", checkblip: ".. tostring(_CheckIsBlip(v.id)))
                if check and _CheckIsBlipGang(v.id) == false then
                    --print("step 3: id " .. v.id .. ", SHOW BLIP")
                    createBlipGang(v.id)
                    table.insert(IsBlipGang, {id = v.id})
                elseif not check and _CheckIsBlipGang(v.id) == true then
                    --print("step 3: id " .. v.id .. ", Remove BLIP")
                    for k1,v1 in ipairs(IsBlipGang) do
                        if v1.id == v.id then
                            table.remove(IsBlipGang, k1)
                        end
                    end
                end
            end
        end
    end
end)