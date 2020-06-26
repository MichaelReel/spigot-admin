#!/bin/bash

# Uncomment the next line to disable
# exit 0

unset DISPLAY
read SPIGOT_VERSION < version

[[ -f ./Archive/worlds_backup.tar.gz ]] && rm Archive/worlds_backup.tar.gz
[[ -f ./Archive/worlds.tar.gz ]] && mv Archive/worlds.tar.gz Archive/worlds_backup.tar.gz
[[ -d ./world ]] && tar -czvf Archive/worlds.tar.gz world*

screen -dmS minecraft-server-screen java -Xms8G -Xmx8G -XX:+UseConcMarkSweepGC -jar spigot-${SPIGOT_VERSION}.jar
