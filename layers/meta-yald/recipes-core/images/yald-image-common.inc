require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = " kernel-modules"

SECURE_CORE_IMAGE_EXTRA_INSTALL = "\
    ${@bb.utils.contains("DISTRO_FEATURES", "efi-secure-boot", \
                         "packagegroup-efi-secure-boot", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "tpm2", \
                         "packagegroup-tpm2", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "ima", \
                         "packagegroup-ima", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "luks", \
                         "packagegroup-luks", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "ids", \
                         "packagegroup-ids", "", d)} \
"
IMAGE_INSTALL:append = " ${SECURE_CORE_IMAGE_EXTRA_INSTALL}"
