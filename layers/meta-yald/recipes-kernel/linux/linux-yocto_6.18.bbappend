FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

SRCREV_machine = "057e0bf6446ead5535717da84b234c64615458db"
SRCREV_meta = "8e6a09c7a858e7dd1c1120b3838fe463a273a1b5"
LINUX_VERSION = "6.18.11"

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
