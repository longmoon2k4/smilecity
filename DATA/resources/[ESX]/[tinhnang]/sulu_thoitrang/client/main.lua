
    local onSpawn = false
    local HandObject = nil
    RegisterNetEvent('sulu_thoitrang:SPAWN')
    AddEventHandler('sulu_thoitrang:SPAWN', function(CurrentZone)
        if not onSpawn then
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            HandObject = CreateObject(GetHashKey(CurrentZone.Model), x, y, z, true, true, true)
            AttachEntityToEntity(HandObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), CurrentZone.Bone), CurrentZone.xPos, CurrentZone.yPos, CurrentZone.zPos, CurrentZone.xRot, CurrentZone.yRot,CurrentZone.zRot, true, true, false, true, 1, true)
            onSpawn = true
        else
            DeleteObject(HandObject)
            onSpawn = false
        end
    end)


AddEventHandler('playerDropped', function()
    if onSpawn then
        DeleteObject(HandObject)
        onSpawn = false
    end
end)
function DelProp()
	for _, v in pairs(GetGamePool('CObject')) do
		if IsEntityAttachedToEntity(PlayerPedId(), v) then
			SetEntityAsMissionEntity(v, true, true)
			DeleteObject(v)
		end
	end
end

RegisterCommand("xoaprop", function()
	DelProp()
end, false)
	