#!/bin/sh

INSTALL_ROOT=/mnt
DEV_NODE=0

if [ "$1" = "/dev/hda" ] || [ "$1" = "/dev/hdb" ] || [ "$1" = "/dev/hdc" ] || [ "$1" = "/dev/hdd" ] || [ "$1" = "/dev/sda" ] || [ "$1" = "/dev/sdb" ] || [ "$1" = "/dev/sdc" ] || [ "$1" = "/dev/sdd" ]; then
  DEV_NODE=1
fi

# Display usage information if parameter is empty

if [ "$DEV_NODE" = "0" ]; then
  echo
  echo "Usage: $0 DEVICE"
  echo
  echo "       DEVICE=/dev/hd[a-d] -> install Buildroot to hard disk."
  echo "       DEVICE=/dev/sd[a-d] -> install Buildroot to USB mass storage."
  echo
  echo "  Ex: $0 /dev/hdc"
  echo "      $0 /dev/sda"
  echo
  exit 0
fi

echo

if [ "$DEV_NODE" = "1" ]; then

  echo Install Production Environment onto $1
  echo
 
  # Delete all partitions on target
  # Create a FAT  partition for SYSLINUX
  # Create a LINUX parition for the root filesystem 
  echo Create Paritions
  fdisk $1 < ./fdisk.in > /dev/null
  
  # Format the first partition
  # Install syslinux
  echo Format "$1"1
  mkdosfs "$1"1 > /dev/null 2>&1
  syslinux -i "$1"1

  # Add the syslinux configuation file
  echo Install Bootloader on "$1"1
  mount "$1"1 $INSTALL_ROOT
  echo "DEFAULT linux" > $INSTALL_ROOT/syslinux.cfg
  echo "LABEL linux" >> $INSTALL_ROOT/syslinux.cfg
  echo "KERNEL bzimage" >> $INSTALL_ROOT/syslinux.cfg
  echo "APPEND root=/dev/sda2 console=tty1 console=ttyS0,115200n8" >> $INSTALL_ROOT/syslinux.cfg

  # Copy the file system image
  echo Install Kernel Image on "$1"1
  cp images/bzImage $INSTALL_ROOT/bzImage
  umount $INSTALL_ROOT

  echo Format "$1"2
  mke2fs "$1"2 > /dev/null 2>&1

  echo Install Root Filesystem on "$1"2
  mount "$1"2 $INSTALL_ROOT
  tar xf images/rootfs.tar -C $INSTALL_ROOT
  umount $INSTALL_ROOT

  echo Installation finished!
fi
