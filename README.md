# Docker Images

Docker Image Name | Description | Build Image | Projects
---------|----------|---------|--------
`Dockerfile` | Cuda 11/9, OpenCV3, python3, rosmelodic, ceres-solver, cmake, ubuntu18 | `docker build -t docker2-ros-melodic-vins .` | [ROS](http://wiki.ros.org/docker/Tutorials/Docker)
`opencv3-py3-cuda11-torch` | Cuda 11/9, OpenCV, python3 | `docker build -t opencv3-py3-cuda11-torch - < Dockerfile-py3-cuda` | OpenIBO 
`ubuntu18-nocuda-slam:latest` | NoCUDA, OpenCV, python3 | `docker build -t ubuntu18-nocuda-slam - < Dockerfile-nocuda-slam` | OpenIBO 


## Creating container from image

> If you didn't have docker install, please [follow](#install-docker-on-ubuntu-2004) 

### simple way

```sh

chmod a+x run.sh
xhost +local:root

./run.sh
```

### Advanace Mode

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
    --volume="/mnt/ssd/usman_ws/datasets/maqbool-datasets/datasets-place-recognition/:/dataset/" \
    --volume="/mnt/ssd/usman_ws/datasets/place-recognition/:/results/" \
    --name="maqbool" \
    \
    opencv3-py3-cuda11-torch /bin/bash

xhost +local:root

sudo docker run -it \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --publish=8002:8888 \
    --publish=6002:6006 \
    \
    --workdir="/container_ws/" \
    --volume="/home/leo/usman_ws/:/container_ws/" \
    --name="nocuda-slam2" \
    \
    ubuntu18-nocuda-slam2:latest /bin/bash
```

**To Start**
```sh
docker exec -it ros /bin/bash
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