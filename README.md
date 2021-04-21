## Overview
Yocto build environment

### Setup
It is expected that ``YOCTO_WORKDIR`` be set to your YOCTO src/working directory.
This directoy will be volume mounted to the docker container, and act as a 'share' between the two.

This should probably be a separate, large, storage device.

I recommend setting this permanently via ``~/.bashrc``:

    export YOCTO_WORKDIR="/your/yocto/working/dir"

### Build
    sudo docker build --build-arg "host_uid=$(id -u)" \
                      --build-arg "host_gid=$(id -g)" \
                      -f Dockerfile                   \
                      -t yocto-builder .

### Run
    export YOCTO_WORKDIR="/your/yocto/working/dir"

    sudo docker run   --rm -it                                 \
                      --privileged                             \
                      --volume /dev:/dev                       \
                      --volume /run:/run                       \
                      --volume $YOCTO_WORKDIR:"$YOCTO_WORKDIR" \
                      --env     YOCTO_WORKDIR="$YOCTO_WORKDIR" \
                      yocto-builder
