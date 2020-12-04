## Overview 
Yocto build environment

### Build
It is expected that the working/src directory be volume mounted to build-time variable ``work_dir``. This is the target location *inside the container*.

The environment variable ``YOCTO_WORKDIR`` is also set to this directory. The default value is ``/yocto_workspace``.

    export YOCTO_WORKDIR="/yocto_workspace"

    sudo docker build --build-arg "host_uid=$(id -u)"       \
                      --build-arg "host_gid=$(id -g)"       \
                      --build-arg "work_dir=$YOCTO_WORKDIR" \
                      -f Dockerfile                         \
                      -t yocto-builder .

### Run
    export YOCTO_WORKDIR="/yocto_workspace"

    sudo docker run   --rm -it                                 \
                      --privileged                             \
                      --volume /dev:/dev                       \
                      --volume /local/workdir:"$YOCTO_WORKDIR" \
                      yocto-builder
