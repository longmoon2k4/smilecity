local carrying = {}
--carrying[source] = targetSource, source is carrying targetSource
local carried = {}
--carried[targetSource] = source, targetSource is being carried by source

--RegisterServerEvent("CarryPeople:sync")
--AddEventHandler("CarryPeople:sync", function(targetSrc)
--	local source = source
--	local sourcePed = GetPlayerPed(source)
--   	local sourceCoords = GetEntityCoords(sourcePed)
--	local targetPed = GetPlayerPed(targetSrc)
--        local targetCoords = GetEntityCoords(targetPed)
--	if #(sourceCoords - targetCoords) <= 3.0 then 
--		TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
--		carrying[source] = targetSrc
--		carried[targetSrc] = source
--	end
--end)

RegisterServerEvent("CarryPeople:sync")
AddEventHandler("CarryPeople:sync", function(targetSrc)
    local targetSrc1 = source
	local source1 = targetSrc
	local sourcePed = GetPlayerPed(source1)
   	local sourceCoords = GetEntityCoords(sourcePed)
	local targetPed = GetPlayerPed(targetSrc1)
        local targetCoords = GetEntityCoords(targetPed)
	if #(sourceCoords - targetCoords) <= 3.0 then 
		TriggerClientEvent("CarryPeople:syncTarget", targetSrc1, source1)
        TriggerClientEvent('CarryPeople:syncTargetSource',source1, targetSrc1)
		carrying[source1] = targetSrc1
		carried[targetSrc1] = source1
	end
end)

RegisterServerEvent("CarryPeople:send")
AddEventHandler("CarryPeople:send", function(targetSrc)
    TriggerClientEvent("CarryPeople:send", targetSrc, source)
end)

RegisterServerEvent("CarryPeople:stop")
AddEventHandler("CarryPeople:stop", function(targetSrc)
	local source = source 

	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])			
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)