#!/bin/bash

failure () {
    echo "$0 Failed"
    echo "Failed build located in ${BUILD_DIR}"
    exit -1
}

. ./poky/oe-init-build-env rpi-build

#bitbake quilt-native
# did bitbake run happily?
#if [ $? -ne 0 ]; then
#    failure
#fi
