#!/bin/bash

DOCKER_IMAGE_TAG="ubuntu-22.04-onekiwi"
DOCKER_USER="onekiwi"
DOCKER_WORKDIR="/home/${DOCKER_USER}/yocto"
YOCTO_NAME=""

usage() {
  cat <<EOF
Example :
  $ $0 stm32mp13-6.1
  $ $0 rzv2l-3.0.6-update4
  $ $0 rzv2l-3.0.7-update3
  $ $0 rzv2h-v5.20
  $ $0 luckfox-pico
EOF
}

./setup-docker.sh

case "$1" in
    rzv2l-3.0.6-update4|rzv2l-3.0.7-update3)
        YOCTO_NAME="yocto-$1"
        ;;
    stm32mp13-6.1)
        YOCTO_NAME="yocto-$1"
        ;;
    rzv2h-v5.20)
        YOCTO_NAME="yocto-$1"
        ;;
    luckfox-pico)
        YOCTO_NAME=$1
        ;;
    *)
        usage
        exit 0
        ;;
esac

docker run -it --rm \
    --name=onekiwi-yocto \
    --volume $(pwd)/${YOCTO_NAME}:${DOCKER_WORKDIR} \
    "${DOCKER_IMAGE_TAG}"
