# Define arguments which may change later
ARG IMAGE_TAG=adoptopenjdk/openjdk8:alpine-jre

# Java Image with minimal footprint
FROM ${IMAGE_TAG}

LABEL org.opencontainers.image.authors="Teki Chan <tekichan@gmail.com>" 

# upgrade all packages since alpine jre8 base image tops out at 8u282
RUN apk -U --no-cache upgrade

# Expose 25565 (Minecraft Server), 25575 (Minecraft RCON) and 4711 (RaspberryJuice Plugin)
EXPOSE 25565 25575 4711

# Create program folder
ARG APP_FOLDER=/opt/minecraft_spigot
RUN mkdir ${APP_FOLDER}
RUN mkdir ${APP_FOLDER}/plugins

# Minecraft Server Properties file
COPY spigot/server.properties ${APP_FOLDER}/server.properties

# Java Log4J2 Configuration
COPY spigot/log4j2.xml ${APP_FOLDER}/log4j2.xml

# Execute Script
COPY spigot/startServer.sh ${APP_FOLDER}/startServer.sh
RUN chmod +x ${APP_FOLDER}/startServer.sh

# Copy minecraft server files
COPY spigot/server.jar ${APP_FOLDER}/server.jar
COPY spigot/spigot.jar ${APP_FOLDER}/spigot.jar
COPY spigot/plugins/raspberryjuice.jar ${APP_FOLDER}/plugins/raspberryjuice.jar

# Define volume for persistent storage
VOLUME ["/data"]

# Set the working directory for all the subsequent Dockerfile instructions
WORKDIR /data

# Execute Java to run the server
ENV APP_FOLDER ${APP_FOLDER}
CMD ${APP_FOLDER}/startServer.sh