# rbx-plugin-testServiceWatcher
⚡

## Heavy WIP
This plugin waits for an instance named `__watcher` (with two underscores) to be added to ServerStorage

After that, any source changes of any modules scripts in ReplicatedFirst/ReplicatedStorage/ServerStorage/ServerScriptService will cause any scripts in TestService to run

Now this means I can write tests and edit code without having to go back and forth between vscode and studio.
