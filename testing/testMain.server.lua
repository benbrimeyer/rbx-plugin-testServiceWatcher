local ReplicatedStorage = game:GetService("ReplicatedStorage")
local testEz = require(game.testez)
local TestBootstrap = testEz.TestBootstrap
local Reporter = testEz.Reporters.TextReporterQuiet

TestBootstrap:run({ReplicatedStorage}, Reporter, {})