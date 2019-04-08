local ChangeHistoryService = game:GetService("ChangeHistoryService")
local RunService = game:GetService("RunService")
local TestService = game:GetService("TestService")

local runUnitTests ={}

function runUnitTests.start()
	ChangeHistoryService:SetWaypoint("unitTests")
	RunService:Run()
	TestService:Run()
	RunService:Stop()
	runUnitTests.resetDatamodel()
end

function runUnitTests.resetDatamodel()
	ChangeHistoryService:Undo()
end

return runUnitTests