import mcpi.minecraft as minecraft
import mcpi.block as block
from math import *
import time
import sys

# This program remakes https://www.dropbox.com/s/k29ms42nzvgehjk/rainbow.py?dl=0
# For more examples, see https://www.stuffaboutcode.com/p/minecraft.html

colors = [14, 1, 4, 5, 3, 11, 10]

SERVER_IP = sys.argv[1] if len(sys.argv) > 1 and sys.argv[1] else "localhost"
SERVER_PORT = int(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[2] else 4711
print("Server IP is {ip}, Port is {port}".format(ip=SERVER_IP, port=SERVER_PORT))

mc = minecraft.Minecraft.create(SERVER_IP, SERVER_PORT)
height = 60

mc.setBlocks(-64,0,0,64,height + len(colors),0,0)
for x in range(0, 128):
	for colourindex in range(0, len(colors)):
		y = sin((x / 128.0) * pi) * height + colourindex
		mc.setBlock(x - 64, y, 0, block.WOOL.id, colors[len(colors) - 1 - colourindex])

mc.postToChat("Hello Minecraft World")
time.sleep(5)

print("End of Program")
