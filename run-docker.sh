#!/bin/bash

DOCKER_IMAGE_TAG="ubuntu-22.04-onekiwi"
DOCKER_USER="onekiwi"
DOCKER_WORKDIR="/home/${DOCKER_USER}/yocto"
YOCTO_NAME=""

usage() {
    echo "
Example build:
    $ ./build.sh stm32mp13-6.1"
    exit 0
}

./setup-docker.sh

case "$1" in
    stm32mp13-6.1)
        YOCTO_NAME="yocto-$1"
    ;;
    rzv2h-v5.20)
        YOCTO_NAME="yocto-$1"
    ;;
    *)
        usage
    ;;
esac

docker run -it --rm \
    --name=onekiwi-yocto \
    --volume $(pwd)/${yocto_name}:${DOCKER_WORKDIR} \
    "${DOCKER_IMAGE_TAG}"