local ReplicatedStorage = game:GetService("ReplicatedStorage")
local testEz = require(script.Parent.TestEZ)
local TestBootstrap = testEz.TestBootstrap
local Reporter = testEz.Reporters.TextReporterQuiet

TestBootstrap:run({ReplicatedStorage}, Reporter, {})