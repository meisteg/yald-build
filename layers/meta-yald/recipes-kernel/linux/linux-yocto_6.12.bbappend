FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"

# Note: Whinlatter 5.3.1 is currently on Linux 6.12.60
SRCREV_machine = "db1df153bf158b548f3b58c167f91f30e2dd0b5e"
SRCREV_meta = "5b1ff7df002df6e7069a53b361d9e8f5f9df3aac"
LINUX_VERSION = "6.12.69"

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
