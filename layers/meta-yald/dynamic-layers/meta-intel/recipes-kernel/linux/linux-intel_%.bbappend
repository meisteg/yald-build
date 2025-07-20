FILESEXTRAPATHS:prepend := "${THISDIR}/linux-intel:"

SRC_URI += "file://ath10k.cfg"

RDEPENDS:${KERNEL_PACKAGE_NAME} += "linux-firmware-ath10k"
