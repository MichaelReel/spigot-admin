#!/bin/bash

screen -S minecraft-server-screen -p 0 -X stuff "stop^M"

./attachMinecraft.sh
