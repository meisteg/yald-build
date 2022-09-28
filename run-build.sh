#!/bin/bash

# Abort script if any command returns error
set -e

# Source build environment
. ./poky/oe-init-build-env build

# Add BSP layer
bitbake-layers add-layer ../poky/meta-raspberrypi
bitbake-layers add-layer ../poky/meta-intel

# Build
bitbake core-image-minimal
