#!/bin/bash

# Abort script if any command returns error
set -e

IMAGE="yald-image-dev"
BUILD_DIR="build"

# Source build environment
. ./poky/oe-init-build-env $BUILD_DIR

# Add layers
bitbake-layers add-layer ../poky/meta-raspberrypi
bitbake-layers add-layer ../poky/meta-intel
bitbake-layers add-layer ../poky/meta-openembedded/meta-oe
bitbake-layers add-layer ../poky/meta-openembedded/meta-filesystems
bitbake-layers add-layer ../poky/meta-openembedded/meta-networking
bitbake-layers add-layer ../poky/meta-openembedded/meta-python
bitbake-layers add-layer ../poky/meta-virtualization
bitbake-layers add-layer ../poky/meta-yald

# Build
bitbake $IMAGE
