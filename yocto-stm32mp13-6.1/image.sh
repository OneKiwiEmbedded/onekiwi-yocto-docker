#!/bin/bash

BASEDIR=$(pwd)
IMAGE_TARGET="stm32mp131dae-som"
FLASH_TYPE="optee"
MACHINE="onekiwi"
PATH_TARGET="build/tmp-glibc/deploy/images/${MACHINE}"
FLASH_LAYOUT="flashlayout_st-image-weston/${FLASH_TYPE}/FlashLayout"
ATF_USB="arm-trusted-firmware/tf-a-${IMAGE_TARGET}-usb.stm32"
ATF_EMMC="arm-trusted-firmware/tf-a-${IMAGE_TARGET}-emmc.stm32"
ATF_SDCARD="arm-trusted-firmware/tf-a-${IMAGE_TARGET}-sdcard.stm32"
ATF_META="arm-trusted-firmware/metadata.bin"
FIP_EMMC="fip/fip-${IMAGE_TARGET}-${FLASH_TYPE}.bin"
#FIP_SDCARD="fip/fip-${IMAGE_TARGET}-${FLASH_TYPE}-sdcard.bin"
ST_BOOTFS="st-image-bootfs-openstlinux-weston-${MACHINE}.ext4"
ST_VENDORFS="st-image-vendorfs-openstlinux-weston-${MACHINE}.ext4"
ST_USERFS="st-image-userfs-openstlinux-weston-${MACHINE}.ext4"
ST_WESTON="st-image-weston-openstlinux-weston-${MACHINE}.ext4"
IMAGE="image-"${IMAGE_TARGET}

if [ -f "${IMAGE}.zip" ]; then
    echo "remove ${IMAGE}"
    rm -rf ${IMAGE}*
fi

mkdir -p ${IMAGE}/arm-trusted-firmware
mkdir -p ${IMAGE}/fip
cp ${PATH_TARGET}/${FLASH_LAYOUT}_sdcard_${IMAGE_TARGET}-${FLASH_TYPE}.tsv ${IMAGE}
cp ${PATH_TARGET}/${FLASH_LAYOUT}_emmc_${IMAGE_TARGET}-${FLASH_TYPE}.tsv ${IMAGE}
cp ${PATH_TARGET}/${ATF_USB} ${IMAGE}/arm-trusted-firmware
cp ${PATH_TARGET}/${ATF_EMMC} ${IMAGE}/arm-trusted-firmware
cp ${PATH_TARGET}/${ATF_SDCARD} ${IMAGE}/arm-trusted-firmware
cp ${PATH_TARGET}/${ATF_META} ${IMAGE}/arm-trusted-firmware
cp ${PATH_TARGET}/${FIP_EMMC} ${IMAGE}/fip
#cp ${PATH_TARGET}/${FIP_SDCARD} ${IMAGE}/fip
cp ${PATH_TARGET}/${ST_BOOTFS} ${IMAGE}
cp ${PATH_TARGET}/${ST_VENDORFS} ${IMAGE}
cp ${PATH_TARGET}/${ST_USERFS} ${IMAGE}
cp ${PATH_TARGET}/${ST_WESTON} ${IMAGE}

zip ${IMAGE}.zip ${IMAGE}/* ${IMAGE}/fip/* ${IMAGE}/arm-trusted-firmware/*
#unzip ${IMAGE}.zip -d ${IMAGE}
#scp -P 31152 onekiwi@proxy65.rt3.io:/home/onekiwi/thanhduong/yocto-stm32mp/image-stm32mp151aaa-thatico-r2x512v12.zip .
#STM32_Programmer_CLI -c port=usb1 -w FlashLayout_emmc_stm32mp13xxae-som-optee.tsv
