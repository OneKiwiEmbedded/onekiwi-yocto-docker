#!/bin/bash

BASEDIR=$(pwd)
IMAGE_TARGET=""
IMAGE_OUTPUT=""
PATH_TARGET=""

UBOOT_BL2_SPI=""
UBOOT_BL2_MMC=""
UBOOT_FIP=""
UBOOT_FW=""

LINUX_IMAGE=""
LINUX_DEVICE=""
LINUX_ROOTFS=""
LINUX_WIC=""

usage() {
  cat <<EOF
Example:
  $0 onekiwi-rzv2h-8gb
  $0 onekiwi-rzv2h-16gb
EOF
}

main() {
    if [[ $1 == "onekiwi-rzv2h-8gb" ]] || [[ $1 == "onekiwi-rzv2h-16gb" ]]; then

        if [ ! -d "build/tmp/deploy/images/"$1 ]; then
            echo "Directory build/tmp/deploy/images/$1 does not exist."
            exit 0
        fi

        IMAGE_TARGET=$1
        IMAGE_OUTPUT=image-${IMAGE_TARGET}
        PATH_TARGET="build/tmp/deploy/images/"${IMAGE_TARGET}

        UBOOT_BL2_SPI="bl2_bp_spi-$1.srec"
        UBOOT_BL2_MMC="bl2_bp_emmc-$1.srec"
        UBOOT_FIP="fip-$1.srec"
        UBOOT_FW="Flash_Writer_SCIF_RZV2H_DEV_INTERNAL_MEMORY.mot"

        LINUX_WIC_BMAP="core-image-weston-$1.wic.bmap"
        LINUX_WIC_GZ="core-image-weston-$1.wic.gz"
        LINUX_TAR_BZ2="core-image-weston-$1.tar.bz2"
        #LINUX_WIC="core-image-weston-onekiwi-rzv2l.wic"

        if [ -d ${IMAGE_OUTPUT} ]; then
            echo "Directory exists."
            rm -rf ${IMAGE_OUTPUT}
        fi

        mkdir ${IMAGE_OUTPUT}

        cp -v ${PATH_TARGET}/${UBOOT_BL2_SPI} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${UBOOT_BL2_MMC} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${UBOOT_FIP} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${UBOOT_FW} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${LINUX_WIC_BMAP} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${LINUX_WIC_GZ} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${LINUX_TAR_BZ2} ${IMAGE_OUTPUT}
        #cp -v ${PATH_TARGET}/${LINUX_WIC} ${IMAGE_OUTPUT}
        sync

        zip ${IMAGE_OUTPUT}.zip ${IMAGE_OUTPUT}/*
        
    else
        usage
        exit 0
    fi
}

main "$@"
