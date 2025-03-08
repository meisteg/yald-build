require yald-image-prod.bb

IMAGE_FEATURES:append = " allow-empty-password"
IMAGE_FEATURES:append = " allow-root-login"
IMAGE_FEATURES:append = " empty-root-password"

IMAGE_FEATURES:remove = " read-only-rootfs"
