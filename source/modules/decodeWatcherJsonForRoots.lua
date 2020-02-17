--fff
local HttpService = game:GetService("HttpService")

return function(parent, jsonString)
	local success, valueArray = pcall(function()
		return HttpService:JSONDecode(jsonString)
	end)
	if not success then
		warn("Error parsing JSON")
		return {}
	end

	local roots = {}

	for _, entry in ipairs(valueArray) do
		local path = string.split(entry, ".")
		local finalResult = parent
		for _, object in ipairs(path) do
			local nextResult = finalResult:FindFirstChild(object)
			if nextResult then
				finalResult = nextResult
			else
				break
			end
		end
		print("Watching:", finalResult:GetFullName())
		table.insert(roots, finalResult)
	end

	return roots
end
