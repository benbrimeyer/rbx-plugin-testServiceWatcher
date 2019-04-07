return function()
	local findTag = require(script.Parent.findTag)

	it("should return true if tag is present in given container", function()
		local folder = Instance.new("Folder")
		local tag = Instance.new("StringValue")
		tag.Name = "__watcher"
		tag.Parent = folder

		expect(findTag(folder)).to.equal(tag)

		folder:Destroy()
	end)

	it("should return false if there is nothing in the container", function()
		local folder = Instance.new("Folder")

		expect(findTag(folder)).to.equal(nil)

		folder:Destroy()
	end)

	it("should return false if there are children in the container, but none match the name of the tag", function()
		local folder = Instance.new("Folder")
		local tag = Instance.new("StringValue")
		tag.Name = "foo-whatever"
		tag.Parent = folder

		expect(findTag(folder)).to.equal(nil)

		folder:Destroy()
	end)

	it("should return false if there are children in the container, but none are a string value", function()
		local folder = Instance.new("Folder")
		local tag = Instance.new("Folder")
		tag.Name = "__watcher"
		tag.Parent = folder

		expect(findTag(folder)).to.equal(nil)

		folder:Destroy()
	end)

end