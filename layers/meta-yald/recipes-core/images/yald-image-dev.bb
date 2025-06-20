require yald-image-prod.bb

IMAGE_FEATURES:append = " allow-empty-password"
IMAGE_FEATURES:append = " allow-root-login"
IMAGE_FEATURES:append = " empty-root-password"
IMAGE_FEATURES:append = " ssh-server-dropbear"

IMAGE_FEATURES:remove = " read-only-rootfs"

IMAGE_INSTALL:append = " bash"
IMAGE_INSTALL:append = " coreutils"
IMAGE_INSTALL:append = " dosfstools"
IMAGE_INSTALL:append = " e2fsprogs"
IMAGE_INSTALL:append = " inetutils-ifconfig"
IMAGE_INSTALL:append = " util-linux"
