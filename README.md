Docker Image Name | Description | Build | Projects
---------|----------|---------|--------
`Dockerfile` | Cuda 11/9, OpenCV3, python3, rosmelodic, ceres-solver, cmake, ubuntu18 | `docker build -t docker2-ros-melodic-vins .` | [ROS](http://wiki.ros.org/docker/Tutorials/Docker)
`opencv3-py3-cuda11-torch` | Cuda 11/9, OpenCV, python3 | `docker build -t opencv3-py3-cuda11-torch - < Dockerfile-py3-cuda` | OpenIBO 

## Build Image

If you didn't have docker install, please [follow](#install-docker-on-ubuntu-2004) 

```sh
#docker build -t my_first_image [location of your dockerfile]
git clone https://github.com/UsmanMaqbool/nvidia-docker2-melodic-vins
cd nvidia-docker2-melodic-vins
docker build -t docker2-ros-melodic-vins .
# or try
docker build -t opencv3-py3-cuda11-torch - < Dockerfile-py3-cuda
```




## Creating container from image

simple way

```sh

chmod a+x run.sh
xhost +local:root

./run.sh
```

Advanace Mode

```sh
xhost +local:root

sudo docker run --gpus all -it \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --runtime=nvidia \
    --publish=8001:8888 \
    --publish=6001:6006 \
    \
    --workdir="/container_ws/" \
    --volume="/home/leo/usman_ws/:/container_ws/" \
    --volume="/mnt/ssd/usman_ws/datasets/place-recognition/ :/dataset/" \
    --name="maqbool" \
    \
    py3-opencv3-cuda11-torch /bin/bash

```

**To Start**
```sh
docker exec -it ros /bin/bash
```

## VINS Mono

```sh
cd PATH-TO-CATKIN_WS/src
git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git
cd ../ && catkin_make
```

## AR Demo




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