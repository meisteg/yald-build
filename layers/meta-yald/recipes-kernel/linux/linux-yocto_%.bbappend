FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

SRC_URI += " \
    file://ath10k.cfg \
    file://firewalld.cfg \
"

# Required for firewalld
KERNEL_FEATURES:append = " features/nf_tables/nf_tables.scc"

RDEPENDS:${KERNEL_PACKAGE_NAME} += "linux-firmware-ath10k"
