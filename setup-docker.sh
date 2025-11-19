#!/usr/bin/env bash

DOCKER_FILE="Dockerfile.ubuntu-22.04-onekiwi"
DOCKER_IMAGE_TAG="ubuntu-22.04-onekiwi"
DOCKER_USER="onekiwi"
DOCKER_GIT_USER="OneKiwi"
DOCKER_GIT_EMAIL="productdev@ontech.com.vn"
DOCKER_WORKDIR="/home/${DOCKER_USER}/yocto"

if [ -n "$(docker images -q ${DOCKER_IMAGE_TAG})" ]; then
    echo "docker images already exists"
fi

if [ -z "$(docker images -q ${DOCKER_IMAGE_TAG})" ]; then
    echo "docker images does not exist"

    docker build --no-cache \
        --build-arg "host_uid=$(id -u)" \
        --build-arg "host_gid=$(id -g)" \
        --build-arg "USERNAME=$DOCKER_USER" \
        --build-arg "DOCKER_WORKDIR=${DOCKER_WORKDIR}" \
        --build-arg "TZ_VALUE=$(cat /etc/timezone)" \
        --tag ${DOCKER_IMAGE_TAG} \
        --file ${DOCKER_FILE} .
fi