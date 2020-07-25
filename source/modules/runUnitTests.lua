local RunService = game:GetService("RunService")
local TestService = game:GetService("TestService")

local runUnitTests ={}

function runUnitTests.start()
	RunService:Run()
	TestService:Run()
	RunService:Stop()
end

return runUnitTests
