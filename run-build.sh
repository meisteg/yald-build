#!/bin/bash

# Abort script if any command returns error
set -e

# Source build environment
. ./poky/oe-init-build-env rpi-build

# Add BSP layer
bitbake-layers add-layer ../poky/meta-raspberrypi

# Build
bitbake core-image-minimal
