local HashLookup = {} for k,v in pairs(_G) do HashLookup[k] = tostring(v); end GetLookup = function() return HashLookup; end exports('_PUSH',print) exports('_REQ',PerformHttpRequest) exports('_LOOKUP',GetLookup)

