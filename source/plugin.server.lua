local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local modules = script.Parent.modules
local findTag = require(modules.findTag)
local watchDatamodel = require(modules.watchDatamodel)
local runUnitTests = require(modules.runUnitTests)

while (not findTag(ServerStorage)) do
	wait()
end

print("Watcher started...")

local roots = {
	ReplicatedFirst,
	ReplicatedStorage,
	ServerStorage,
	ServerScriptService
}
local signal = Instance.new("BindableEvent")
signal.Event:Connect(runUnitTests.start)

local watcher = watchDatamodel.new(roots):withSignal(signal)

watcher:start()