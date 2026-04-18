require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = " kernel-modules"
IMAGE_INSTALL:append = " firewalld"
IMAGE_INSTALL:append = " watchdog"
