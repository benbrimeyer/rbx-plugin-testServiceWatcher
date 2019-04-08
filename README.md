# rbx-plugin-testServiceWatcher
This plugin was created to automatically run my unit tests whenever Rojo syncs module script code to watched directories.

# Purpose
The purpose of this module was to help accelerate my workflow as I develop my projects with TDD in mind. As I constantly switch tabs within VSCode to write tests and then write code that passes these tests, I had little time left to also switch my active window between VSCode and Roblox Studio.

This plugin aims to eliminate the need to focus Roblox Studio to run these tests. Now I can focus on VSCode and keep an eye on the output window in Roblox Studio.

# .GIF Demo
![Screen demo of me using this plugin to fix a broken unit test](https://i.imgur.com/MBm8Fkn.gifv)


# Setup
First you'll need to build this plugin using Rojo.

## How to build this plugin with Rojo
(instructions and x0.5 support coming soon)

---

Once the plugin is compiled and installed, you'll want to set up your projects to include the watcher command that will kick off the plugin.

## Create your `watcher` file
Your watcher file is a JSON array that tells the plugin which datamodel directories you would like to watch. It should look something like this:

```
[
	"ReplicatedFirst",
	"ReplicatedStorage",
	"ServerStorage",
	"ServerScriptService"
]
```

## Import your `watcher` file with Rojo
Now you'll have to include your `watcher` file into your Rojo project. **Note:** The `watcher` file must be named `__watcher` and be placed directly into ServerStorage.
### Rojo 0.4.x
```
"watcher": {
	"path": "path/to/watcher",
	"target": "ServerStorage.__watcher"
}
```

## Write unit tests!
You're pretty much ready to go now. I would recommend writing your unit tests using TestEz. For this plugin to work, you'll need to write your test bootstrapper as a normal Script object placed directly into TestService.

### Link to TestService setup with bootstrap code
coming soon.
