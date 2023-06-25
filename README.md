# spigot-admin
Some short scripts I use for managing a spigot server

[Here](SETUP_STEPS.md) are some notes on setting up a server to use these scripts.

| File                | Description                                                                                             |
| ------------------- | ------------------------------------------------------------------------------------------------------- |
| version             | File containing the version to which to update spigot/run. Used by updateBuildTools.sh and startSpigot. |
| updateBuildTools.sh | Downloads the latest build tools for spigot and runs it for the version given in the `version` file.    |
| startSpigot.sh      | Makes a backup of the current world files, then starts the spigot server under a screen session.        |
| stopSpigot.sh       | Stops the spigot server.                                                                                |
| attachMinecraft.sh  | Attaches to the screen session to allow viewing the output and entering admin commands.                 |
