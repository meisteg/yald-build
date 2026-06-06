FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

SRCREV_machine = "61a746df3dd151cccb3078ee6e1092d227b2514a"
SRCREV_meta = "177495c151446a679945c20611499537d72ebcd9"
LINUX_VERSION = "6.18.25"

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
