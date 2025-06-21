if not Framework.ESX() then return end
local loadingScreenFinished = false
local client = client
local firstSpawn = false

AddEventHandler("esx_skin:resetFirstSpawn", function()
    firstSpawn = true
end)

AddEventHandler('esx:loadingScreenOff', function()
    loadingScreenFinished = true
end)


AddEventHandler("esx_skin:playerRegistered", function()
    --if(firstSpawn) then
    while not loadingScreenFinished do Wait(100) end
    InitializeCharacter(Framework.GetGender(true))
        --OpenSurgeonShop()
    --end
end)

RegisterNetEvent("skinchanger:loadSkin2", function(ped, skin)
    if not skin.model then skin.model = "mp_m_freemode_01" end
    client.setPedAppearance(ped, skin)
    Framework.CachePed()
end)

RegisterNetEvent("skinchanger:loadDefaultModel", function(ped, skin)
    local model 
    if ped then 
        model = "mp_m_freemode_01"
    else
        model = "mp_f_freemode_01"
    end
    --if not skin.model then skin.model = "mp_m_freemode_01" end
    client.setPlayerModel123(model)
    Framework.CachePed()
end)

RegisterNetEvent("skinchanger:getSkin", function(cb)
    while not Framework.PlayerData do
        Wait(1000)
    end
    lib.callback("illenium-appearance:server:getAppearance", false, function(appearance)
        cb(appearance)
        Framework.CachePed()
    end)
end)

RegisterNetEvent("skinchanger:loadSkin", function(skin, cb)
    if skin.model then
        client.setPlayerAppearance(skin)
    else -- add validation invisible when failed registration (maybe server restarted when apply skin)
        SetInitialClothes(Config.InitialPlayerClothes[Framework.GetGender(true)])
    end
    if Framework.PlayerData and Framework.PlayerData.loadout then
        TriggerEvent("esx:restoreLoadout")
    end
    Framework.CachePed()
	if cb ~= nil then
		cb()
	end
end)

RegisterNetEvent("skinchanger:loadSkin3", function(skin, cb)
    --if skin.model then
        client.setPlayerAppearance2(skin)
    --else -- add validation invisible when failed registration (maybe server restarted when apply skin)
        --SetInitialClothes(Config.InitialPlayerClothes[Framework.GetGender(true)])
    --end
    --if Framework.PlayerData and Framework.PlayerData.loadout then
    --    TriggerEvent("esx:restoreLoadout")
    --end
    Framework.CachePed()
	--if cb ~= nil then
	--	cb()
	--end
end)

RegisterNetEvent("skinchanger:loadClothes", function(_, clothes)
    local components = Framework.ConvertComponents(clothes, client.getPedComponents(cache.ped))
    local props = Framework.ConvertProps(clothes, client.getPedProps(cache.ped))

    client.setPedComponents(cache.ped, components)
    client.setPedProps(cache.ped, props)
end)

RegisterNetEvent("esx_skin:openSaveableMenu", function(onSubmit, onCancel)
    InitializeCharacter(Framework.GetGender(true), onSubmit, onCancel)
end)
