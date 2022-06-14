FROM ubuntu:20.04
ARG FF_VERSION=7:4.2.7-0ubuntu0.1

RUN apt-get update && apt-get install ffmpeg=${FF_VERSION} -y
WORKDIR /usr/share/microservices/FFmpeg
# ENTRYPOINT ["sleep", "infinity"]
ENTRYPOINT ["tail", "-f", "/dev/null"]