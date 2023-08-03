#!/bin/bash
# Script to build image for qemu.
# Author: isch

source build-helper.sh

git submodule init
git submodule sync
git submodule update

# local.conf won't exist until this step on first execution
source poky/oe-init-build-env

### configurations ###
echo -e "\nlocal.conf configurations"
config_localconf "MACHINE = \"raspberrypi3-64\""

# mpu-6050 configuration
config_localconf "ENABLE_I2C = \"1\""

# sysfs trigger didn't work... else I would be using mpu6050 through iio
# config_localconf "KERNEL_DEVICETREE:append = \" overlays/mpu6050.dtbo\""

# # RPI_EXTRA_CONFIG used to add additional lines to config.txt.
# # For the rpi, it uses this config file instead of the BIOS you would expect to
# # find a conventional PC. System config parameters, which would be in BIOS, are
# # stored in this optional text file named config.txt.
# # Note that it is not obvious to me that this line actually does much. The
# # above line "KERNEL_DEVICETREE:append..." seems to actually allow the expected
# # device to show up under "/sys/bus/iio/devices/", but no harm in including.
# # I surmise it is because the device tree was never included in this base image,
# # so you need to include it in the device tree first, else overlay doesn't work.
# config_localconf "RPI_EXTRA_CONFIG = '\\\ndtoverlay=mpu6050\\\n'"\
# 		 "RPI_EXTRA_CONFIG = ' \ndtoverlay=mpu6050\n'"


### layer configuration ###
echo -e "\nlayer configuration"
config_layer "meta-openembedded/meta-oe"
config_layer "meta-openembedded/meta-python"
config_layer "meta-openembedded/meta-multimedia"
config_layer "meta-openembedded/meta-networking"
config_layer "meta-raspberrypi"
config_layer "meta-bot"


set -e
#bitbake core-image-aesd
bitbake core-image-bot
