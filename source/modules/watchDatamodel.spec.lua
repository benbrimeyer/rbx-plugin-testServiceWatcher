return function()
	local watchDatamodel = require(script.Parent.watchDatamodel)

	local function find(table, value)
		return table[value] ~= nil
	end

	describe("return value", function()
		it("should return a table", function()
			expect(watchDatamodel).to.be.ok()
			expect(type(watchDatamodel)).to.equal("table")
		end)
	end)

	describe("new", function()
		it("should require a root", function()
			expect(function()
				watchDatamodel.new()
			end).to.throw()

			expect(function()
				watchDatamodel.new({})
			end).to.never.throw()
		end)
	end)

	describe("withSignal", function()
		it("should return the original object", function()
			local watcher = watchDatamodel.new({})
			expect(watcher:withSignal()).to.equal(watcher)
		end)
	end)

	describe("findOldScripts", function()
		it("should scan a list of script objects given roots", function()
			local folder = Instance.new("Folder")
			local watcher = watchDatamodel.new({folder})
			watcher:findOldScripts()

			expect(watcher).to.be.ok()
			watcher:destruct()
			folder:Destroy()
		end)

		it("should gather module scripts only", function()
			local folder = Instance.new("Folder")
			local module1 = Instance.new("ModuleScript", folder)
			local folder2 = Instance.new("Folder", folder)
			local script1 = Instance.new("LocalScript", folder)
			local watcher = watchDatamodel.new({folder})
			watcher:findOldScripts()

			expect(watcher).to.be.ok()
			expect(find(watcher:getModuleCache(), module1)).to.equal(true)
			expect(find(watcher:getModuleCache(), folder2)).to.equal(false)
			expect(find(watcher:getModuleCache(), script1)).to.equal(false)
			watcher:destruct()
			folder:Destroy()
			script1:Destroy()
			folder2:Destroy()
			module1:Destroy()
		end)
	end)

	describe("watchForNewScripts", function()
		it("should fire when a new script is added to a root", function()
			local folder = Instance.new("Folder")
			local watcher = watchDatamodel.new({folder})

			watcher:watchForNewScripts()
			local folder2 = Instance.new("Folder", folder)
			expect(find(watcher:getModuleCache(), folder2)).to.equal(false)

			local module = Instance.new("ModuleScript", folder)
			expect(find(watcher:getModuleCache(), module)).to.equal(true)

			watcher:destruct()
			folder:Destroy()
			folder2:Destroy()
			module:Destroy()
		end)
	end)

	describe("start", function()
		it("should execute without issue", function()
			local folder = Instance.new("Folder")
			local watcher = watchDatamodel.new({folder})

			watcher:start()

			folder:Destroy()
			watcher:destruct()
		end)

		it("should add a new script to cache and fire when the source changes", function()
			local folder = Instance.new("Folder")
			local signal = Instance.new("BindableEvent")
			local watcher = watchDatamodel.new({folder}):withSignal(signal)

			local sum = 0
			signal.Event:Connect(function()
				sum = sum + 1
			end)

			watcher:start()
			expect(sum).to.equal(0)
			local module = Instance.new("ModuleScript", folder)
			expect(sum).to.equal(0)
			expect(find(watcher:getModuleCache(), module)).to.equal(true)
			module.Source = "return true"
			expect(sum).to.equal(1)
			module.Source = "return false"
			expect(sum).to.equal(2)

			signal:Destroy()
			folder:Destroy()
			watcher:destruct()
		end)
	end)
end