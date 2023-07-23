#!/bin/bash
# Script to provide holder functions for building images for qemu.
# Author: isch

#config_localconf: check if a configuration exists or not, if not then add it to local.conf
config_localconf () {
    confline=$1
    addconf=$2 #grep doesn't play nicely with backslashes, so add manually if this exists
    
    cat conf/local.conf | grep "${confline}" > /dev/null
    local_conf_info=$?

    if [ $local_conf_info -ne 0 ];then
	if [[ -n $addconf ]];then
	    confline=$addconf
	fi
	echo "Append ${confline} in the local.conf file"
	echo ${confline} >> conf/local.conf
	
    else
	echo "${confline} already exists in the local.conf file"
    fi
}

#config_layer: check if a layer exists or not, if not then adds it to bitbake-layers
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
