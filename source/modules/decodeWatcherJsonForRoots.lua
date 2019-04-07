local HttpService = game:GetService("HttpService")

return function(parent, jsonString)
	local valueArray = HttpService:JSONDecode(jsonString)
	local roots = {}

	for _, entry in ipairs(valueArray) do
		table.insert(roots, parent:FindFirstChild(entry, true))
	end

	return roots
end
