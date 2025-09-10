# Linux Tips and Tricks
## NetHack compilation
1. Change `PREFIX` in `linux.370` or equivalent hints file to match the installation dir of choice (e.g. `PREFIX=$(wildcard ~)/.local`)
2. Run `sh sys/unix/setup.sh sys/unix/hints/linux.370`
3. In config.h file uncomment `define CURSES_GRAPHICS`
### For NetHack
4. In Makefile file uncomment `WANT_WIN_TTY`, `WANT_WIN_CURSES=1` and `WANT_DEFAULT=curses` lines
5. Compile with `make WANT_WIN_TTY=1 WANT_WIN_CURSES=1 all`
6. Install with `make install`
### For GnollHack
4. In files.c file remove the unnecessary WARNING line for LIVELOG
5. Compile with `make all`
6. Install with `make install`

# Lofree keyboard fixes
# Solution for Arch Linux
## Method 1: Using udev rules (no reboot required)
### Create udev rule
sudo nano /etc/udev/rules.d/99-lofree-keyboard.rules
### Add this line
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="024f", RUN+="/bin/sh -c 'echo 2 > /sys/module/hid_apple/parameters/fnmode'"
### Apply rules
sudo udevadm control --reload
sudo udevadm trigger

## Method 2: Using kernel module parameters
### Create config file
sudo nano /etc/modprobe.d/hid_apple.conf
### Add this line
options hid_apple fnmode=2
### Regenerate initramfs
sudo mkinitcpio -P
### Reboot
sudo reboot

# Solution for Ubuntu/Debian
## Method 1: Using udev rules
### Create udev rule
sudo nano /etc/udev/rules.d/99-lofree-keyboard.rules
### Add this line
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="024f", RUN+="/bin/sh -c 'echo 2 > /sys/module/hid_apple/parameters/fnmode'"
### Apply rules
sudo udevadm control --reload-rules
sudo udevadm trigger

## Method 2: Using kernel module parameters
### Create config file
sudo nano /etc/modprobe.d/hid_apple.conf
### Add this line
options hid_apple fnmode=2
### Update initramfs
sudo update-initramfs -u
### Reboot
sudo reboot

# Solution for Fedora/RHEL
## Method 1: Using udev rules
### Create udev rule
sudo nano /etc/udev/rules.d/99-lofree-keyboard.rules
### Add this line
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="024f", RUN+="/bin/sh -c 'echo 2 > /sys/module/hid_apple/parameters/fnmode'"
### Apply rules
sudo udevadm control --reload
sudo udevadm trigger

## Method 2: Using kernel module parameters
### Create config file
sudo nano /etc/modprobe.d/hid_apple.conf
### Add this line
options hid_apple fnmode=2
### Regenerate initramfs
sudo dracut --force
### Reboot
sudo reboot
