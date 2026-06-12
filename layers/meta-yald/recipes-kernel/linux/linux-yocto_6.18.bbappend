FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

SRCREV_machine = "efc05d9af9f5b5a647e229c92542e413c3a9915d"
SRCREV_meta = "4dafe0e420087b6381728e68eeeff6d9af0a32e7"
LINUX_VERSION = "6.18.35"

LINUX_VERSION_EXTENSION ?= "-${DISTRO}-${LINUX_KERNEL_TYPE}"

SRC_URI += " \
    file://firewalld.cfg \
    file://vfio.cfg \
    file://watchdog.cfg \
"

# Required for firewalld
KERNEL_FEATURES:append = " features/nf_tables/nf_tables.scc"

# Set KERNEL_FEATURES based on DISTRO_FEATURES
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "alsa", "", "disable-sound.scc", d)}"
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "bluetooth", "", "disable-bluetooth.scc", d)}"
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "wifi", "", "disable-wifi.scc", d)}"
