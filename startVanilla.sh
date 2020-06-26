#!/bin/bash

# Uncomment the next line to disable
# exit 0

# [[ -f ./worlds_backup.tar.gz ]] && rm worlds_backup.tar.gz
# [[ -f ./worlds.tar.gz ]] && mv worlds.tar.gz worlds_backup.tar.gz
# [[ -d ./world ]] && tar -czvf worlds.tar.gz world*

screen -dmS minecraft-server-screen java -Xms8G -Xmx8G -XX:+UseConcMarkSweepGC -jar minecraft_server.1.14.jar nogui
