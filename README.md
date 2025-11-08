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
$ kas-container build kas/<machine>.yaml
```

Replace `<machine>` with `qemux86-64`, `intel-corei7-64` or `raspberrypi3-64`.

### Build the Software Development Kit (SDK)

```bash
$ kas-container build kas/<machine>.yaml:kas/sdk.yaml
```

## Run on QEMU

Development image:

```bash
$ kas-container --runtime-args --device=/dev/kvm shell kas/<machine>.yaml -c "runqemu <machine> tmp/deploy/images/<machine>/yald-image-dev-<machine>.rootfs.qemuboot.conf nographic slirp kvm"
```

Production image:

```bash
$ kas-container --runtime-args --device=/dev/kvm shell kas/<machine>.yaml -c "runqemu <machine> tmp/deploy/images/<machine>/yald-image-prod-<machine>.rootfs.qemuboot.conf nographic slirp kvm"
```

To quit QEMU, enter `Ctrl-A x`.

## Run on target

Once the image is built, the bootable image is in the `build/tmp/deploy/images/<machine>` directory.

Under Linux, insert a USB flash drive or SD card (depending on what the target machine requires).  Use `bmaptool` or `dd` to copy the image to it.  Before the image can be flashed onto the drive, it should be un-mounted. Some Linux distros may automatically mount a USB drive when it is plugged in. Using device `/dev/sdX` as an example, find all mounted partitions:

```bash
$ mount | grep sdX
```

and un-mount those that are mounted, for example:

```bash
$ umount /dev/sdX1
$ umount /dev/sdX2
```

Now copy the wic image for the desired target onto the flash drive. Using `bmaptool` is recommended as it is much faster than `dd`:

```bash
$ sudo bmaptool copy build/tmp/deploy/images/<machine>/yald-image-dev-<machine>.rootfs.wic.xz /dev/sdX
```

or

```bash
$ sudo dd if=build/tmp/deploy/images/<machine>/yald-image-dev-<machine>.rootfs.wic of=/dev/sdX status=progress
```

This should give you a bootable device.  Insert the device into the target and power on.
