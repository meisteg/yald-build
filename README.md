# Yet Another Linux Distro

## Build

### Dependencies

[kas](https://kas.readthedocs.io) is used to build yald. To install `kas`:

```bash
$ sudo pip install kas
```

### Start the Build

```bash
$ git clone https://github.com/meisteg/yald-build.git
$ cd yald-build
$ kas build qemux86-64.yaml
```

## Run on QEMU

```bash
$ kas shell qemux86-64.yaml -c "runqemu nographic slirp"
```

To quit QEMU, enter `Ctrl-A x`.

## Run on target

Once the image is built, the bootable image is in the `build/tmp/deploy/images/xxx` directory, where `xxx` refers to the machine name used in the build.

Under Linux, insert a USB flash drive or SD card (depending on what the target machine requires).  Assuming the drive takes device `/dev/sdf`, use `dd` to copy the image to it.  Before the image can be flashed onto the drive, it should be un-mounted. Some Linux distros may automatically mount a USB drive when it is plugged in. Using device `/dev/sdf` as an example, find all mounted partitions:

```bash
$ mount | grep sdf
```

and un-mount those that are mounted, for example:

```bash
$ umount /dev/sdf1
$ umount /dev/sdf2
```

Now burn the `.wic` image for the desired target onto the flash drive, for example:

```bash
$ sudo dd if=yald-image-dev-intel-corei7-64.wic of=/dev/sdf status=progress
$ sync
```

This should give you a bootable flash device.  Insert the device into a bootable USB socket on the target, and power on.
