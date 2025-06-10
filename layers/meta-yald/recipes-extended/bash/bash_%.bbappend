# mkbuiltins.c is built with native toolchain and needs gnu17 as well:
# http://errors.yoctoproject.org/Errors/Details/853016/
BUILD_CFLAGS += "-std=gnu17"
