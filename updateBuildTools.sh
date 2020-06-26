#!/bin/sh

read SPIGOT_VERSION < version

wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar 

java -jar BuildTools.jar --rev ${SPIGOT_VERSION}
