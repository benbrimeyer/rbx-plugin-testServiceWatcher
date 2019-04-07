return function(parent)
	local object = parent:FindFirstChild("__watcher")
	if object and object:IsA("StringValue") then
		return object
	end
end