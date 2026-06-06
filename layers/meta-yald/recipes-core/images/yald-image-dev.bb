require recipes-core/images/yald-image-common.inc

IMAGE_FEATURES:append = " allow-empty-password"
IMAGE_FEATURES:append = " allow-root-login"
IMAGE_FEATURES:append = " empty-root-password"
IMAGE_FEATURES:append = " ssh-server-dropbear"

# Common tools

IMAGE_INSTALL:append = " bash"
IMAGE_INSTALL:append = " bmaptool"
IMAGE_INSTALL:append = " coreutils"
IMAGE_INSTALL:append = " dosfstools"
IMAGE_INSTALL:append = " e2fsprogs"
IMAGE_INSTALL:append = " htop"
IMAGE_INSTALL:append = " inetutils-ifconfig"
IMAGE_INSTALL:append = " omping"
IMAGE_INSTALL:append = " tree"
IMAGE_INSTALL:append = " util-linux"

# Machine specific tools

IMAGE_INSTALL:append:yald-x86-64 = " pcimem"
IMAGE_INSTALL:append:yald-x86-64 = " pciutils"
