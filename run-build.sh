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
bitbake-layers add-layer ../poky/meta-yald

# Build
bitbake $IMAGE
