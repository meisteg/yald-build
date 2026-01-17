require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = " kernel-module-ath10k-pci"
IMAGE_INSTALL:append = " firewalld"
