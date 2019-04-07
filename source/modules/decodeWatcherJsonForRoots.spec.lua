return function()
	local decodeWatcherJsonForRoots = require(script.Parent.decodeWatcherJsonForRoots)

	it("should take json and return as an array one level deep", function()
		local folder = Instance.new("Folder")
		local target1 = Instance.new("Folder", folder)
		target1.Name = "target1"

		local roots = decodeWatcherJsonForRoots(folder, '["target1"]')

		expect(roots).to.be.ok()
		expect(roots[1]).to.equal(target1)
	end)

	it("should take json and return as an array two levels deep", function()
		local folder = Instance.new("Folder")
		local target1 = Instance.new("Folder", folder)
		target1.Name = "target1"
		local target2 = Instance.new("Folder", target1)
		target2.Name = "target2"

		local roots = decodeWatcherJsonForRoots(folder, '["target1", "target2"]')

		expect(roots).to.be.ok()
		expect(roots[1]).to.equal(target1)
		expect(roots[2]).to.equal(target2)
	end)

end