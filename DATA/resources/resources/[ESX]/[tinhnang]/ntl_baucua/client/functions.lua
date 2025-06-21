SpawnObject = function(object, coords, cb, networked)
	local model = type(object) == 'number' and object or GetHashKey(object)
	local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
	networked = networked == nil and true or networked

	Citizen.CreateThread(function()
		RequestModelLoad(model)

		local obj = CreateObject(model, vector.xyz, networked, false, true)
		if cb then
			cb(obj)
		end
	end)
end

SpawnLocalObject = function(object, coords, cb)
	SpawnObject(object, coords, cb, false)
end
function RequestModelLoad(modelHash, cb)

	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))



	if not HasModelLoaded(modelHash) then

		RequestModel(modelHash)



		while not HasModelLoaded(modelHash) do

			Citizen.Wait(1)

		end

	end



	if cb ~= nil then

		cb()

	end

end