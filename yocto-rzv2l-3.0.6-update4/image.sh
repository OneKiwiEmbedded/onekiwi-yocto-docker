#!/bin/bash

BASEDIR=$(pwd)
IMAGE_TARGET=""
IMAGE_OUTPUT=""
PATH_TARGET=""

UBOOT_BL2=""
UBOOT_FIP=""
UBOOT_FW=""

LINUX_IMAGE=""
LINUX_DEVICE=""
LINUX_ROOTFS=""
LINUX_WIC=""

usage() {
  cat <<EOF
Example:
  $0 onekiwi-rzv2l
  $0 smarc-rzv2l
EOF
}

main() {
    if [[ $1 == "onekiwi-rzv2l" ]] || [[ $1 == "smarc-rzv2l" ]]; then

        if [ ! -d "build/tmp/deploy/images/"$1 ]; then
            echo "Directory build/tmp/deploy/images/$1 does not exist."
            exit 0
        fi

        if [ $1 == "onekiwi-rzv2l" ]; then
            IMAGE_TARGET="onekiwi-rzv2l"
            IMAGE_OUTPUT=image-${IMAGE_TARGET}
            PATH_TARGET="build/tmp/deploy/images/"${IMAGE_TARGET}

            UBOOT_BL2="bl2_bp-onekiwi-rzv2l_pmic.srec"
            UBOOT_FIP="fip-onekiwi-rzv2l_pmic.srec"
            UBOOT_FW="Flash_Writer_SCIF_RZV2L_SMARC_PMIC_DDR4_2GB_1PCS.mot"

            LINUX_IMAGE="Image-onekiwi-rzv2l.bin"
            LINUX_DEVICE="Image-onekiwi-rzv2l.dtb"
            LINUX_ROOTFS="core-image-weston-onekiwi-rzv2l.tar.bz2"
            #LINUX_WIC="core-image-weston-onekiwi-rzv2l.wic"
        fi

        if [ $1 == "smarc-rzv2l" ]; then
            IMAGE_TARGET="smarc-rzv2l"
            IMAGE_OUTPUT=image-${IMAGE_TARGET}
            PATH_TARGET="build/tmp/deploy/images/"${IMAGE_TARGET}

            UBOOT_BL2="bl2_bp-smarc-rzv2l_pmic.srec"
            UBOOT_FIP="fip-smarc-rzv2l_pmic.srec"
            UBOOT_FW="Flash_Writer_SCIF_RZV2L_SMARC_PMIC_DDR4_2GB_1PCS.mot"

            LINUX_IMAGE="Image-smarc-rzv2l.bin"
            LINUX_DEVICE="Image-r9a07g054l2-smarc.dtb"
            LINUX_ROOTFS="core-image-weston-smarc-rzv2l.tar.bz2"
            #LINUX_WIC="core-image-weston-smarc-rzv2l.wic"
        fi

        if [ -d ${IMAGE_OUTPUT} ]; then
            echo "Directory exists."
            rm -rf ${IMAGE_OUTPUT}
        fi

        mkdir ${IMAGE_OUTPUT}

        cp -v ${PATH_TARGET}/${UBOOT_BL2} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${UBOOT_FIP} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${UBOOT_FW} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${LINUX_IMAGE} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${LINUX_DEVICE} ${IMAGE_OUTPUT}
        cp -v ${PATH_TARGET}/${LINUX_ROOTFS} ${IMAGE_OUTPUT}
        #cp -v ${PATH_TARGET}/${LINUX_WIC} ${IMAGE_OUTPUT}
        sync

        zip ${IMAGE_OUTPUT}.zip ${IMAGE_OUTPUT}/*
        
    else
        usage
        exit 0
    fi
}

main "$@"
