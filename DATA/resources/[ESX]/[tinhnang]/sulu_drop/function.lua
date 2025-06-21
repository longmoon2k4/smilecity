blip = nil
blip2 = nil
function CreateBlip(coords)
	blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	
	SetBlipSprite(blip, 568)
	SetBlipScale(blip, 1.2)
	SetBlipColour(blip, 31)
	SetBlipAsShortRange(blip, true)
	
	BeginTextCommandSetBlipName('CUSTOM_STRING')
	AddTextComponentSubstringPlayerName('Đây có thể là kho báu')
	EndTextCommandSetBlipName(blip)
	--table.insert(blipTable, blip)
end
	
function CreateBlip2(coords)
	 blip2 = AddBlipForRadius(coords.x, coords.y, coords.z, 150.0)
	SetBlipHighDetail(blip2, true)
	SetBlipColour(blip2, 1)
	SetBlipAlpha(blip2, 60)
end