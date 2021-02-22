# Minecraft Python Docker
[![License](https://img.shields.io/badge/license-MIT-green.svg)](/LICENSE) 

This is a repository to instruct how to build a docker image with Minecraft Server which supports Python coding. You can utilize Docker to ease the setup of Minecraft Server for Python coding.

![Minecraft Rainbow](/docs/minecraft_rainbow.png)
*I coded in Python to create a rainbow in a world of Minecraft Java edition*

# Introduction

Minecraft is one of the most popular games amongst teenagers. They enjoy building their own worlds with blocks and start adventure there. 

Interestingly there is a special build for [Raspberry Pi](https://www.raspberrypi.org/) called [Minecraft Pi Edition](https://www.minecraft.net/en-us/edition/pi/). With this edition, you could code in Python to interact with your Minecraft world. Yet this edition requires you a Rasberry Pi.

Thanking [RaspberryJuice](https://dev.bukkit.org/projects/raspberryjuice) plugin with [Spigot Minecraft server](https://www.spigotmc.org/), on the other hand, you can code in Python with your typical Minecraft Java edition.

You could follow this article to learn how to set them step by step in your computer. In addition, in order to make the whole setup portable, I will also suggest building a [Docker](https://www.docker.com/) image to contain them together.

# Perquisite

1. Purchase [Minecraft Java edition](https://www.minecraft.net/en-us/store/minecraft-java-edition/) account
2. Install Minecraft and Docker in your computer.
3. Install [Python 3](https://www.python.org/)
4. Install [Java 8](https://www.oracle.com/hk/java/technologies/javase/javase-jdk8-downloads.html) or above if you want to run Minecraft Server without Docker
5. In this article, the commands are for Mac OS X. They are available for Linux as well. If you use Windows, you could just do the command's result with Windows mean.

# Setup Procedure

1. Create your working folder `minecraft_py` and a sub-folder `spigot` for a Spigot server.

```shell
mkdir minecraft_py; cd minecraft_py; mkdir spigot; cd spigot
```

2. Download Minecraft Server

- Visit [the official Minecraft Server website](https://minecraft.net/en-us/download/server/)
- Check the URL of **server.jar** of your targeted version
e.g. https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar
- Execute a command to download: `curl [SERVER JAR URL] --output server.jar` or download directly to save the file as `server.jar` to **spigot** sub-folder. e.g.

```shell
curl https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar --output server.jar
```

3. Download SPIGOT Server

- Visit [Spigot MC download page](https://getbukkit.org/download/spigot)
- Check the URL of spigot JAR file of your targeted version
e.g. https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar
- Execute a command to download: `curl [SPIGOT JAR URL] --output spigot.jar` or download directly to save the file as `spigot.jar` to **spigot** sub-folder. e.g. 

```shell
curl https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar --output spigot.jar
```

- Create a text file `eula.txt` to agree to **End User License Agreement**. You can create it by a text editor to contain a line `eula=true` or run a command `echo eula=true > eula.txt`

- Download properties files: `log4j2.xml`, `server.properties` and scripts `startServer.sh`, `testLocalServer.sh` from this repository to your **spigot** sub-folder. Ensure executable for the script files: `chmod +x *.sh`.

4. Download RaspberryJuice

- Create **plugins** sub-folder

```shell
mkdir plugins; cd plugins
```

- Visit [RaspberryJuice download page](https://dev.bukkit.org/projects/raspberryjuice)
- Check the URL of the latest version Raspberry Juice JAR file
e.g. https://dev.bukkit.org/projects/raspberryjuice/files/2496319/download
- Execute a command to download: `curl [RASPBERRY JUICE JAR URL] --output raspberryjuice.jar` or download directly to save the file as `raspberryjuice.jar` to **plugins** sub-folder. e.g.

```shell
curl https://dev.bukkit.org/projects/raspberryjuice/files/2496319/download --output raspberryjuice.jar
```

5. Download MCPI module and create Python coding sub-folder

- Go back the root of your working folder

```shell
cd ../..
```

- Create a local server folder **data**: `mkdir data`

- Execute a command to download the source: `git clone https://github.com/zhuowei/RaspberryJuice.git` or directly download the whole folder from [RaspberryJuice's repository](https://github.com/zhuowei/RaspberryJuice)
- Create a sub-folder `py` for our Python coding: `mkdir py`
- Copy MCPI module from **RaspberryJuice** to **py** folder. You could run a command:

```shell
cp -r RaspberryJuice/src/main/resources/mcpi/api/python/modded/mcpi py/
```

or directly copy the whole `RaspberryJuice/src/main/resources/mcpi/api/python/modded/mcpi` folder to `py` folder.

6. First test-run (Optional)

- Start the Minecraft server: `cd data; ../spitgot/testLocalServer.sh`

- Open Minecraft, select Multiplayers and join the **localhost** server

![Connect in Minecraft](/docs/minecraft_localhost.png)

- Open a new terminal, go to **py** folder, run the testing code: `python3 rainbow.py`. Then you can see the rainbow in the world as shown in the beginning of this article.

- You could stop here if you are happy with localhost server instance and do not want to build a Docker image.

7. Build a Docker image

- Download **Dockerfile** from this repository to the root of your working folder.

- Build a Docker image `docker build -t "[your account]/[your repository]" .`: e.g. 

```shell
docker build -t "tekichan/minecraft-py-server" .
```

- Check your Docker images: `docker images`

8. Run the Docker image

- Empty **data** folder if you use it with local server instance before.

- Create a Docker volume **spigot-data**: `docker volume create spigot-data`

- Inspect the Docker volume: `docker inspect spigot-data`

- Run the Docker image: `docker run --name minecraft-spigot -d -v spigot-data:/data -p 4711:4711 -p 25565:25565 -p 25575:25575 [your account]/[your repository]`. e.g.

```shell
docker run --name minecraft-spigot -d -v spigot-data:/data -p 4711:4711 -p 25565:25565 -p 25575:25575 tekichan/minecraft-py-server
```

9. Test-run with the Docker image

- Open Minecraft, select Multiplayers and join the **localhost** server

- Open a new terminal, go to **py** folder, run the testing code: `python3 rainbow.py`. Then you can see the rainbow in the world as shown in the beginning of this article.

10. Clean-up (after you finish playing in Minecraft)

- Stop the container: `docker container stop minecraft-spigot`
- Remove the container: `docker container rm minecraft-spigot`
- If you do not want to reserve the game setting, you could remove the volume as well: `docker volume rm spigot-data` and empty **data** folder.

# References

- [Code Minecraft with Python on Mac OSX](https://gist.github.com/noahcoad/fc9d3984a5d4d61648269c0a9477c622)

- [Docker image that provides a Minecraft Server that will automatically download selected version at startup](https://github.com/itzg/docker-minecraft-server)

# Authors
- Teki Chan *tekichan@gmail.com*