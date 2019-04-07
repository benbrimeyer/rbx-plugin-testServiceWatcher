local ServerStorage = game:GetService("ServerStorage")

local modules = script.Parent.modules
local findTag = require(modules.findTag)
local watchDatamodel = require(modules.watchDatamodel)
local runUnitTests = require(modules.runUnitTests)
local decodeWatcherJsonForRoots = require(modules.decodeWatcherJsonForRoots)

while (not findTag(ServerStorage)) do
	wait()
end

local watcherTag = findTag(ServerStorage)
print("Watcher started...")

local roots = decodeWatcherJsonForRoots(game, watcherTag.Value)

local signal = Instance.new("BindableEvent")
signal.Event:Connect(runUnitTests.start)

local watcher = watchDatamodel.new(roots):withSignal(signal)


watcher:start()