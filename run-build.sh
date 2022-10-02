#!/bin/bash

# Abort script if any command returns error
set -e

IMAGE="core-image-base"
TMP_FILE=".env_check"

# Source build environment
. ./poky/oe-init-build-env build

# Add BSP layer
bitbake-layers add-layer ../poky/meta-raspberrypi
bitbake-layers add-layer ../poky/meta-intel

# Parse environment
bitbake -e $IMAGE > $TMP_FILE
TARGET=`grep ^MACHINE= $TMP_FILE | cut -d\" -f2`
rm $TMP_FILE

# Machine-specific variables
if [ "$TARGET" == "raspberrypi3-64" ]; then
  export ENABLE_UART=1
fi

# Build
bitbake $IMAGE
