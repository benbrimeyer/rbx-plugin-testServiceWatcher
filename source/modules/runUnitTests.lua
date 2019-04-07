local ChangeHistoryService = game:GetService("ChangeHistoryService")
local RunService = game:GetService("RunService")
local TestService = game:GetService("TestService")

local runUnitTests ={}

local function isNextUndoRun()
	local canUndo, nextUndo = ChangeHistoryService:GetCanUndo()

	return canUndo == false or nextUndo == "Run"
end

function runUnitTests.start()
	RunService:Run()
	TestService:Run()
	RunService:Stop()
	runUnitTests.resetDatamodel()
end

function runUnitTests.resetDatamodel()
	while (isNextUndoRun()) do
		ChangeHistoryService:Undo()
	end
end

return runUnitTests