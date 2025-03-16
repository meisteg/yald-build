# Yet Another Linux Distro

## Build

### Dependencies

[kas](https://kas.readthedocs.io) is used to build yald. To install `kas`:

```bash
$ sudo pip install kas
```

If an externally managed environment error is seen, Ubuntu-based systems have the option to run:

```bash
$ sudo apt install kas
```

### Start the Build

```bash
$ git clone https://github.com/meisteg/yald-build.git
$ cd yald-build
$ kas build kas/<machine>.yaml
```

Replace `<machine>` with `qemux86-64` or `intel-corei7-64`.

### Build the Software Development Kit (SDK)

```bash
$ kas build kas/<machine>.yaml:kas/sdk.yaml
```

## Run on QEMU

Development image:

```bash
$ kas shell kas/<machine>.yaml -c "runqemu tmp/deploy/images/<machine>/yald-image-dev-<machine>.rootfs.qemuboot.conf nographic slirp"
```

Production image:

```bash
$ kas shell kas/<machine>.yaml -c "runqemu tmp/deploy/images/<machine>/yald-image-prod-<machine>.rootfs.qemuboot.conf nographic slirp"
```

To quit QEMU, enter `Ctrl-A x`.

## Run on target

Once the image is built, the bootable image is in the `build/tmp/deploy/images/<machine>` directory.

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
$ sudo dd if=yald-image-dev-intel-corei7-64.rootfs.wic of=/dev/sdf status=progress
$ sync
```

This should give you a bootable flash device.  Insert the device into a bootable USB socket on the target, and power on.
