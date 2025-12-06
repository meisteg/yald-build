FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

SRC_URI += "file://ath10k.cfg"

RDEPENDS:${KERNEL_PACKAGE_NAME} += "linux-firmware-ath10k"
