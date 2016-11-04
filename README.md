## Summary

This box is based on Debian Jessie 8.6.0 (http://cdimage.debian.org/cdimage/release/8.6.0/amd64/iso-cd/debian-8.6.0-amd64-netinst.iso). Currently, it only supports building for Virtualbox.

## Packages

The box has the following packages installed:

- `git`
- `go` 1.7.3
- `godep` (https://github.com/tools/godep)
- `vim`

## Build

You will need the following to build this box:

- Virtualbox (https://www.virtualbox.org/wiki/Downloads)
- Packer (https://www.packer.io/)

To build the box, simply run the following command:

```sh
$ packer build jessie-golang
```

> The build process will take some time (more than 5 minutes), so go make yourself a coffee.

Once finished, the box can be found at `bin/jessie-golang_virtualbox.box`.
