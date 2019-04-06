local watchDatamodel = {}
watchDatamodel.__index = watchDatamodel

local function isInteresting(object)
	return object:IsA("ModuleScript")
end

function watchDatamodel.new(roots)
	assert(roots)
	local self = setmetatable({}, watchDatamodel)

	self.connections = {}
	self.cache = {}
	self.roots = roots

	return self
end

function watchDatamodel:withSignal(signal)
	self.signal = signal
	return self
end

function watchDatamodel:findOldScripts()
	for _, root in pairs(self.roots) do
		for _, object in pairs(root:GetDescendants()) do
			if isInteresting(object) then
				self:listenTo(object)
			end
		end
	end
end

function watchDatamodel:getModuleCache()
	return self.cache
end

function watchDatamodel:watchForNewScripts()
	for _, root in pairs(self.roots) do
		table.insert(self.connections, root.DescendantAdded:Connect(function(object)
			if isInteresting(object) then
				self:listenTo(object)
			end
		end))
	end
end

function watchDatamodel:listenTo(object)
	self.cache[object] = object:GetPropertyChangedSignal("Source"):Connect(function()
		self.signal:Fire()
	end)
end

function watchDatamodel:start()
	self:findOldScripts()
	self:watchForNewScripts()
end

function watchDatamodel:destruct()
	for _, connection in pairs(self.connections) do
		connection:Disconnect()
	end
	self.connections = {}
end

return watchDatamodel