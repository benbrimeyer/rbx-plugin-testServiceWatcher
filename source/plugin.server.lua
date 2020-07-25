local TestService = game:GetService("TestService")

local modules = script.Parent.modules
local findTag = require(modules.findTag)
local watchDatamodel = require(modules.watchDatamodel)
local runUnitTests = require(modules.runUnitTests)
local decodeWatcherJsonForRoots = require(modules.decodeWatcherJsonForRoots)

print("Watching TestService for config")
while (not findTag(TestService)) do
	wait()
end

local watcherTag = findTag(TestService)
print("Watcher started...")

local signal = Instance.new("BindableEvent")
signal.Event:Connect(runUnitTests.start)

local function startWatcher(value)
	local roots = decodeWatcherJsonForRoots(game, value)
	local watcher = watchDatamodel.new(roots):withSignal(signal)
	watcher:start()

	return function()
		watcher:destruct()
	end
end

local cleanup = startWatcher(watcherTag.Value)
watcherTag.Changed:Connect(function(value)
	print("Watcher updated!")
	if cleanup then
		cleanup()
	end

	cleanup = startWatcher(value)
end)
