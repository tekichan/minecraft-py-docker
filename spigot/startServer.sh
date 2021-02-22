#!/bin/sh
###
# Run Minecraft Spigot Server with Rasberry Juice
# in Docker
#
# Working Folder: /data
# Application Folder: /opt/minecraft_spigot
#
# Author: Teki Chan
###

# Refer the application source folder
APP_FOLDER=/opt/minecraft_spigot

# Copy essential files to the working folder
echo "eula=true" >./eula.txt
[ ! -e ./server.properties ] && cp ${APP_FOLDER}/server.properties ./server.properties
[ ! -e ./log4j2.xml ] && cp ${APP_FOLDER}/log4j2.xml ./log4j2.xml
[ ! -e ./plugins ] && mkdir plugins
[ ! -e ./plugins/raspberryjuice.jar ] && cp ${APP_FOLDER}/plugins/raspberryjuice.jar ./plugins/raspberryjuice.jar

# Set the environment variables
export JVM_XX_OPTS="-XX:+UseG1GC" 
export MEMORY="1G"
export TYPE=VANILLA
export VERSION=LATEST
export FORGEVERSION=RECOMMENDED
export SPONGEBRANCH=STABLE
export SPONGEVERSION= 
export FABRICVERSION=LATEST
export LEVEL=world
export PVP=true
export DIFFICULTY=easy
export ENABLE_RCON=true
export RCON_PORT=25575
export RCON_PASSWORD=minecraft
export LEVEL_TYPE=DEFAULT
export SERVER_PORT=25565
export ONLINE_MODE=TRUE
export SERVER_NAME="Dedicated Server"
export ENABLE_AUTOPAUSE=false
export AUTOPAUSE_TIMEOUT_EST=3600
export AUTOPAUSE_TIMEOUT_KN=120
export AUTOPAUSE_TIMEOUT_INIT=600
export AUTOPAUSE_PERIOD=10
export AUTOPAUSE_KNOCK_INTERFACE=eth0

# Execute Spigot server with no GUI
java -jar ${APP_FOLDER}/spigot.jar nogui
