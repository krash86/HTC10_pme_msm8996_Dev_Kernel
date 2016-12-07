#!/bin/bash

DEFCONFIG_FILE=$1

if [ -z "$DEFCONFIG_FILE" ]; then
    echo "Need defconfig file(xxx_defconfig)!"
    exit -1
fi

if [ ! -e arch/arm64/configs/$DEFCONFIG_FILE ]; then
    echo "No such file : arch/arm64/configs/$DEFCONFIG_FILE"
    exit -1
fi

# make .config
env KCONFIG_NOTIMESTAMP=true \
make ARCH=arm64 CROSS_COMPILE=/home/eliminater74/Builds/kernel/toolchains/LinaroTC/aarch64-linux-android-5.x-kernel/bin/aarch64-linux-android- ${DEFCONFIG_FILE}

# run menuconfig
env KCONFIG_NOTIMESTAMP=true \
make menuconfig ARCH=arm64

make savedefconfig ARCH=arm64
# copy .config to defconfig
mv defconfig arch/arm64/configs/${DEFCONFIG_FILE}
# clean kernel object
make mrproper