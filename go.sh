#!/bin/bash

# Amount of time to stay on each image, in seconds
mintimeout=4
randtimeout=5

# Set up attached display framebuffer
if [ ! -c /dev/fb1 ]; then
  modprobe spi-bcm2708
  modprobe fbtft_device name=pitft verbose=0 rotate=0

  sleep 1

  mknod /dev/fb1 c $(cat /sys/class/graphics/fb1/dev | tr ':' ' ')
fi

FRAMEBUFFER=/dev/fb1 X &
sleep 2

images=(/usr/src/app/images_small/*)

while true
do
	image=${images[$RANDOM % ${#images[@]} ]}
	#image=eye.png
	DISPLAY=:0 /usr/bin/xloadimage -fullscreen -onroot -center "$image"
	timeout=$[($RANDOM % $randtimeout) + $mintimeout]
	sleep $timeout
done
