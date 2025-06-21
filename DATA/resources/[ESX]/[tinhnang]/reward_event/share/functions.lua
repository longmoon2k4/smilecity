function GetLevelFromXp(xp) 
    local currentXp = tonumber(xp)
    local level = 0;
    while level < 30 and currentXp >= Config.Xp[level+1]  do
        level= level + 1;
    end

    return level;
end

function String(text, count) 
    return tostring(string.format(text, tostring(count)))
end


function IsInclude(mainData, data) 

    for k,v in ipairs(mainData) do

        local bool = true

            for k2,v2 in pairs(data) do   
                if v[k2] ~= v2 then
                    bool =  false
                    break
                end
            end

        if bool then return true end

    end

    return false
end