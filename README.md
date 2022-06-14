# FFmpeg

`FFmpeg` is a free and open-source collection of tools for handling multimedia files. It contains a set of shared audio and video libraries such as libavcodec, libavformat, and libavutil. With `FFmpeg`, you can convert between various video and audio formats, set sample rates, capture streaming audio/video, and resize videos.

* Check the ffmpeg version

```bash
ffmpeg -version
```

## Basic conversion

* Convert a video file from mp4 to webm

```bash
ffmpeg -i input.mp4 output.webm
```

* Convert an audio file from mp3 to ogg

```bash
ffmpeg -i input.mp3 output.ogg
```

* Extract Audio from a Video File

```bash
ffmpeg -i video_file.mp4 -vn audio_file.mp3
```

## Create Docker image

```bash
docker build -t akhilrajmailbox/ffmpeg:4.2 -f Dockerfile .
```

## Docker Compose Deployment

### Prerequisites

* We are using `devops-network` docker network for all devops deployment.
* You need at least Docker Engine 17.06.0  and docker-compose 1.18 for this to work.

```bash
docker --version
docker-compose --version
```

### Create custom Docker network before deploying container (If the network is already created then ignore it)

*Note : Make sure that the subnet won't conflict with any other subnets*

```bash
docker network create --driver=bridge --subnet=172.31.0.0/16 devops-network
```

### Deploy ffmpeg as Docker container

```bash
docker-compose -f ffmpeg-compose.yml up -d
```

### Working with ffmpeg container

* Login to ffmpeg server

```bash
docker exec -it ffmpeg /bin/bash
```

* Restarting ffmpeg

```bash
docker-compose -f docker-compose.yml restart
```

* stopping/starting ffmpeg

```
docker-compose -f docker-compose.yml stop/start
```

* check the logs of ffmpeg server

```bash
docker logs -f ffmpeg
```

## Docker Swarm Deployment

### Prerequisites

*  The client and daemon API must both be at least 1.24 to use this command. Use the docker version command on the client to check your client and daemon API versions.
* You need at least Docker Engine 19.03.0+ for this to work (Compose specification: 3.8).

```bash
docker version
```

### Run the following command to create a new swarm:

```bash
docker swarm init --default-addr-pool 172.18.0.0/16
```

### Create custom Docker network before deploying container (If the network is already created then ignore it)

*Note : Make sure that the subnet won't conflict with any other subnets*

```bash
docker network create --driver=overlay --subnet=172.30.0.0/16 ffmpeg-swarm-network
```

### Deploy a stack to Swarm

```bash
mkdir -p /usr/share/CceDeploy/MicroModule/FFmpeg/ # The converted audio files will be found under this folder in server
docker stack deploy --compose-file=ffmpeg-swarm.yml ffmpeg-stack
```

### Removing stack

```bash
docker stack rm ffmpeg-stack
```

### Working with ffmpeg container

* List the stack

```bash
docker stack ls
```

* List the tasks in the stack

```bash
docker stack ps ffmpeg-stack
```

* List the services in the stack

```bash
docker stack services ffmpeg-stack
```

* find the docker conatiner ID and Login to ffmpeg server

```bash
docker exec -it $(docker ps -q -f name=ffmpeg-stack) /bin/bash
```

* Restarting ffmpeg

```bash
docker stack deploy --compose-file=docker-swarm.yml ffmpeg-stack
```

* check the logs of ffmpeg server

```bash
docker logs -f $(docker ps -q -f name=ffmpeg-stack)
```

## reference

[install-ffmpeg-ubuntu](https://linuxhint.com/install-ffmpeg-ubuntu/)

[install-ffmpeg-on-ubuntu](https://linuxize.com/post/how-to-install-ffmpeg-on-ubuntu-20-04/)