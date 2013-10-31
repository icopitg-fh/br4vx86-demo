# br4vx86-demo
This project is a simple pre-compiled Buildroot example for Vortex86 based embedded devices.

## Usage
To install the demo attach a USB flash storage device to your machine and issue the following commands from a Terminal. SD and CF cards may also be used if attached with a USB card reader.

`cd <path to br4vx86`  
`sudo fdisk -l` confirm your device has been recognized and make a note of its device name eg., /dev/sdb  
`sudo ./install.sh /dev/sdx` replacing x with the letter that corresponds to your device

If your system automounts USB devices, you will first need to unmount them with the `umount` command.

