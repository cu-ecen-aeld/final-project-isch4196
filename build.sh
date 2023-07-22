#!/bin/bash
# Script to build image for qemu.
# Author: Siddhant Jajoo.

source build-helper.sh

git submodule init
git submodule sync
git submodule update

# local.conf won't exist until this step on first execution
source poky/oe-init-build-env

# configure for raspberrypi3-64
CONFLINE="MACHINE = \"raspberrypi3-64\""

cat conf/local.conf | grep "${CONFLINE}" > /dev/null
local_conf_info=$?

if [ $local_conf_info -ne 0 ];then
	echo "Append ${CONFLINE} in the local.conf file"
	echo ${CONFLINE} >> conf/local.conf
	
else
	echo "${CONFLINE} already exists in the local.conf file"
fi

# TODO: configure i2c


# layer configuration
config_layer "meta-openembedded/meta-oe"
config_layer "meta-openembedded/meta-python"
config_layer "meta-openembedded/meta-multimedia"
config_layer "meta-openembedded/meta-networking"
config_layer "meta-raspberrypi"

# TODO: add the rest of the layers

set -e
#bitbake core-image-aesd
bitbake core-image-base
