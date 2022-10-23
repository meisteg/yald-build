# Yet Another Linux Distro - Build Repository

## Build

```
$ git clone https://github.com/meisteg/yald-build.git
$ cd yald-build
$ ./repo-mgr.sh init
$ docker run --rm -t -v $(pwd):/workdir -e MACHINE=<machine name> crops/poky:ubuntu-22.04 --workdir=/workdir /workdir/run-build.sh
```

### Supported machines

- raspberrypi3-64
- intel-corei7-64
- qemux86-64

## Run on target

Once the image is built, the bootable image is in the `build/tmp/deploy/images/xxx` directory, where `xxx` refers to the machine name used in the build.

Under Linux, insert a USB flash drive or SD card (depending on what the target machine requires).  Assuming the drive takes device `/dev/sdf`, use dd to copy the image to it.  Before the image can be flashed onto the drive, it should be un-mounted. Some Linux distros may automatically mount a USB drive when it is plugged in. Using device `/dev/sdf` as an example, find all mounted partitions:

```
$ mount | grep sdf
```

and un-mount those that are mounted, for example:

```
$ umount /dev/sdf1
$ umount /dev/sdf2
```

Now burn the `.wic` image for the desired target onto the flash drive, for example:

```
$ sudo dd if=yald-image-dev-intel-corei7-64.wic of=/dev/sdf status=progress
$ sync
```

This should give you a bootable flash device.  Insert the device into a bootable USB socket on the target, and power on.
