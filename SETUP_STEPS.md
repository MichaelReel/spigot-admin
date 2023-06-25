# Setting up a minecraft spigot server

## Check Java Version

```sh
java --version
```

If java is not installed, or the version is not up to date. Check the requires on the
[spigot homepage](https://www.spigotmc.org/) and install the appropriate version.

On Ubuntu the normal openjdk apt repo should work:

```sh
sudo apt install openjdk-19-jre-headless
java --version
```

## Make sure `screen` is installed

```sh
sudo apt install screen
```

## Create a special user

```sh
sudo adduser mc
```

Fill in password and details.

## Switch to the new user

```sh
su mc
```

Enter password.

```sh
cd
```

To return to the root of the new user.

## Clone the admin tools to a new folder

Using 1 of the following 2 methods:

### 1. With no intention of pushing upstream:

This is simpliest and likely use case of most folks:

```sh
git clone https://github.com/MichaelReel/spigot-admin.git mc_server
```

### 2. Alternatively, fork the `spigot-admin` repo

This is only required where the user wants to record any local changes to the scripts.

First create a fork of the `spigot-admin` repo in your own user space.

Create a new SSH key for the spigot user:

```sh
ssh-keygen -t ed25519 -C "<your_email@example.com>"
```

Add the SSH key to your github account. Instructions can be found
[here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).
The TL;DR is to go to github user `Settings` then `SSH and GPG keys`,
click `New SSH Key`, give the key a title `Spigot Setup User` and copy the contents of
the `~/.ssh/id_ed25519.pub` into the `Key` field. Click `Add SSH key`.

Then clone the repo:

```sh
git clone git@github.com:<your_user>/spigot-admin.git mc_server
```

Response with `yes` when asked if you want to continue connecting.

## Set the version

Change to the server directory:

```sh
cd mc_server
```

Edit the version file using whatever tool you want and change the version to the latest
__spigot__ version (check [here](https://www.spigotmc.org/)).

```sh
vim version
```

## Download and run the spigot build tool

This is were the scripts in the repo start to come into use:

```sh
./updateBuildTools.sh
```

This might take some time, it downloads a bunch of things, then pulls apart the
minecraft code so that spigot can hook in plugins, etc.

Once complete, a bunch of new directories and files will exist.

## Run spigot without screen to check it's working

Change the version here if required:

```sh
java -Xms8G -Xmx8G -XX:+UseG1GC -jar spigot-1.20.1.jar
```

### EULA

You might get the text:

```text
[ServerMain/INFO]: You need to agree to the EULA in order to run the server. Go to eula.txt for more info.
```

Edit the eula.txt file:

```sh
vim eula.txt
```

And change the line `eula=false` to `eula=TRUE`.

### Stop the server

If spigot is now running, stop it

```sh
> stop
```

## Configure the server

There are a number files to edit to configure the server,
each of these are already documented:

- [server.properties](http://minecraft.gamepedia.com/Server.properties)
- [bukkit.yml](https://bukkit.fandom.com/wiki/Bukkit.yml)
- [spigot.yml](https://www.spigotmc.org/wiki/spigot-configuration/)
- [Server Icons](https://www.spigotmc.org/wiki/server-icon/)

It's also recommended to add some plugins for passwords or admin tooling. These might
require some research.

Make sure to also setup appropriate port forwarding.

## Setup server to run on startup using systemd

### Create a systemd unit file

```sh
sudo vim /lib/systemd/system/minecraft.service
```

And give it the content to configure it as a service:

```conf
[Unit]
Description=Run minecraft as the mc user
Wants=network.target
After=network.target

[Service]
Type=forking
User=mc
Group=mc
WorkingDirectory=/home/mc/mc_server/
ExecStart=/home/mc/mc_server/startSpigot.sh
ExecStop=/home/mc/mc_server/stopSpigot.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

```

### Enable minecraft to start on boot

From a sudoer user (probably not the `mc` user), refresh the systemd configuration files

```sh
sudo systemctl daemon-reload
```

Then enable the service to start automatically at boot:

```sh
sudo systemctl enable minecraft.service
```

### Test the systemd configuration

Start the service and connect to make sure it works:

```sh
sudo systemctl start minecraft.service
```

Stop the service and make sure you can no longer connect:

```sh
sudo systemctl stop minecraft.service
```
