FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

SRCREV_machine = "82a182f895e9b2a4021cd580e8f3fd18ac82420a"
SRCREV_meta = "8af6e86ecd97388ecbae830d484445146a2a2159"
LINUX_VERSION = "6.18.21"

# Since we backported the 6.18 recipe, meta-yocto-bsp does not set these for this version.
COMPATIBLE_MACHINE:genericx86-64 = "genericx86-64"
KMACHINE:genericx86-64 ?= "common-pc-64"

SRC_URI += " \
    file://firewalld.cfg \
"

# Required for firewalld
KERNEL_FEATURES:append = " features/nf_tables/nf_tables.scc"

# Set KERNEL_FEATURES based on DISTRO_FEATURES 
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "alsa", "", "disable-sound.scc", d)}"
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "", "disable-bluetooth.scc", d)}"
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "wifi", "enable-wifi.scc", "disable-wifi.scc", d)}"

RDEPENDS:${KERNEL_PACKAGE_NAME} += "${@bb.utils.contains("DISTRO_FEATURES", "wifi", "linux-firmware-ath10k", "", d)}"
