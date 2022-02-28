sudo docker rm -f sim2real_server

sudo docker run -id --gpus all --name sim2real_server --network host \
	--privileged -v /dev:/dev -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 \
	-v /dev/bus/usb:/dev/bus/usb \
        -v /dev/video0:/dev/video0 \
        -v /dev/video1:/dev/video1 \
        -v /dev/video2:/dev/video2 \
        -v /dev/video3:/dev/video3 \
        -v /dev/video4:/dev/video4 \
        -v /dev/video5:/dev/video5 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $HOME/Desktop/shared:/shared \
	rmus2022/server:v1.0.0

sudo xhost +
