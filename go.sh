#!/bin/bash

# Amount of time to stay on each image, in seconds
mintimeout=3
randtimeout=3

X &
sleep 2

#images=$(ls -1 /usr/src/app/images)
images=($(ls -1 images))

while true
do
	image=${images[$RANDOM % ${#images[@]} ]}
	DISPLAY=:0 /usr/bin/xloadimage -fullscreen -onroot -center "/usr/src/app/images/$image"
	timeout=$[($RANDOM % $randtimeout) + $mintimeout]
	sleep $timeout
done
