#!/bin/bash
# Script to provide holder functions for building images for qemu.

config_layer () {
    layer=$1

    bitbake-layers show-layers | grep $layer > /dev/null
    layer_info=$?

    if [ $layer_info -ne 0 ];then
	echo "Adding $layer layer"
	bitbake-layers add-layer ../$layer
    else
	echo "$layer layer already exists"
    fi    
}
