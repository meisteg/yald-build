FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

# Note: Whinlatter 5.3.1 is currently on Linux 6.12.60
SRCREV_machine = "f94ee5cfc0ea1ae849be57614d59ad6d34458266"
SRCREV_meta = "33dbf39fb1e2d30fbc2bc9fcd69133e5bcbff215"
LINUX_VERSION = "6.12.68"

SRC_URI += " \
    file://ath10k.cfg \
    file://firewalld.cfg \
"

# Required for firewalld
KERNEL_FEATURES:append = " features/nf_tables/nf_tables.scc"

# Disable kernel options if not in distro
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "alsa", "", " disable-sound.scc", d)}"
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "", " disable-bluetooth.scc", d)}"

RDEPENDS:${KERNEL_PACKAGE_NAME} += "linux-firmware-ath10k"
