XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

xhost +local:root

sudo docker run --gpus all -it \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    \
    --workdir="/container_ws/" \
    --volume="/home/leo/usman_ws/:/container_ws/" \
    --name="ros" \
    docker2-ros-melodic-vins /bin/bash
