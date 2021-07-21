Official Documention [ROS](http://wiki.ros.org/docker/Tutorials/Docker)

## Build Image

If you didn't have docker install, please [follow](#install-docker-on-ubuntu-2004) 

```sh
#docker build -t my_first_image [location of your dockerfile]
git clone https://github.com/UsmanMaqbool/nvidia-docker2-melodic-vins
cd nvidia-docker2-melodic-vins
docker build -t docker2-vins-melodic .
```



## Creating container from image

simple way

```sh
chmod a+x run.sh
./sh
```

Advanace Mode

```sh
xhost +local:root

sudo docker run --gpus all -it \
    --volume="~/usman_ws:/home/leo/" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix 
    --env DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    --name ros \
    ros-melodic-vins /bin/bash

```

## Install docker on Ubuntu 20.04
[link](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

```sh
# Setting up Docker
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker
# Setting up NVIDIA Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

curl -s -L https://nvidia.github.io/nvidia-container-runtime/experimental/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list

sudo apt-get update

# Install nvidia-docker2
sudo apt-get install -y nvidia-docker2

sudo usermod -aG docker USERNAME

# Verify
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```