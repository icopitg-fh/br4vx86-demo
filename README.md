# br4vx86-demo
This project is a basic, pre-compiled Buildroot example for headless Vortex86 based embedded devices.

## Requirements
To install and use this demo, you will need a Linux operating system, serial or usb-to-serial cable, and a hyperterminal application such as minicom.

## Installation
Attach a USB flash storage device to your machine and issue the following commands from a command line. SD and CF cards may also be used if attached with a USB card reader.

`cd <path to br4vx86>`  
`sudo fdisk -l` confirm your device has been recognized and make a note of its device name eg., /dev/sdb  
`sudo ./install.sh /dev/sdx` replacing x with the letter that corresponds to your device

If your system automounts USB devices, you will first need to unmount them with the `umount` command. After installation is complete, remove the device from your system and attach/insert it to your Vortex86 device.

## Usage 
Console redirection is required to login to the system. Attach your Vortex86 device to your host system via a serial or usb-to-serial cable and run minicom `sudo minicom -s`.  In this example we'll be using a usb-to-serial cable.

Under "Serial port setup" make the following changes:

1. Serial Device: /dev/ttyUSB0
2. Bps/Par/Bits: 115200 8N1

Exit out of the configuration menu and turn on your device. After several seconds, you should be presented with a login prompt.  Login with the following credentials:

username: root
password: password

## Additional Information
This demo is compiled with Linux Kernel 2.6.34 and Busybox. In addition, USB support, OpenSSH, and SQLite have been included.  After initial setup and login, you may opt to use SSH (recommended) to login instead of Console Redirection.