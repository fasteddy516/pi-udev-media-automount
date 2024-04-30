# pi-usb-automount

###### Auto mount USB flash drives on a headless/console-only Raspberry Pi.

Forked from [Fernando Carmona Varo's](https://github.com/Ferk) [udev-media-automount](https://github.com/Ferk/udev-media-automount) and modified by [Edward Wright](https://github.com/fasteddy516).

Available at https://github.com/fasteddy516/pi-usb-automount


## Description
This is a modified version of [udev-media-automount](https://github.com/Ferk/udev-media-automount) created specifically for use with Raspberry Pis and USB flash drives when a full desktop environment is not installed.  (i.e. Raspberry Pi OS Lite, headless installations, kiosk and other purpose-built applications, etc.)

Once _pi-usb-automount_ is installed, a USB drive will be automatically mounted and accessible in `/media/usb0` when it is connected, and will be automatically unmounted when it is removed.  If multiple USB drives are connected, they will appear as `usb1`, `usb2`, etc.


## Compatibility
_pi-usb-automount_ has been tested exclusively with Raspberry Pi models 4B and 5 running Raspberry Pi OS Lite based on Debian 12 (bookworm) along with a variety of USB flash drives all formatted as a single FAT16 or FAT32 partition.  It may work on other platforms, and certainly *should* work with other device types and filesystems also supported by _udev-media-automount_, but no testing has been done for those use cases.  Also note that running _udev-media-automount_ and _pi-usb-automount_ at the same time is not supported.

If you are successfully using _pi-usb-automount_ under conditions that I haven't mentioned above, please let me know and I can update the information accordingly.


## Installation
Use the following commands to install _pi-usb-automount_ on your Raspberry Pi:
```
wget https://github.com/fasteddy516/pi-usb-automount/releases/download/latest/pi-usb-automount.deb
sudo dpkg -i pi-usb-automount.deb
```
After the installation completes you can safely remove the `.deb` file with the command `rm pi-usb-automount.deb`.

To uninstall _pi-usb-automount_ but leave its configuration files in `/etc/pi-usb-automount.d`, use `sudo dpkg -r pi-usb-automount`. To remove everything including configuration files, use `sudo dpkg --purge pi-usb-automount`.


## Troubleshooting
To check the logs produced by _pi-usb-automount_, run `journalctl -t pi-usb-automount`. Add `-b` to limit the results to the current boot only.


## Configuration
No configuration is required for typical read/write access to USB flash drive contents.  However, the folder `/etc/pi-usb-automount.d` can be used to set custom mount options for specific file system types if desired.

If a file with a name matching a filesystem type (eg. `vfat`, `nfts`, `etc`) is found, it will be loaded when a device using the given filesystem is to be mounted. This can be used to change the parameters provided to `mount`.

An example below for `/etc/media-automount.d/ntfs`:

```
# Mount options to use for auto-mounting NTFS drives
AUTOMOUNT_OPTS='errors=remount-ro,relatime,utf8,user,flush'

# Always use NTFS-3G to automount NTFS filesystems
AUTOMOUNT_TYPE="ntfs-3g"
```

Note that these files are sourced as shell scripts, so it's possible to include logic in them in case you want to conditionally apply some configuration.


## Differences from _udev-media-automount_
_pi-usb-automount_ differs from _udev-media-automount_ in that it:

- Is intended for - and tested on - Raspberry Pis

- Is easily installable (_and removeable!_) in Raspberry Pi OS via a `.deb` package

- Only mounts devices identified as `sd[a-z]` (i.e. `sda`, `sdb`, etc.)  Devices identified as `vd`, `mmcblk` or `nvme` are all ignored.

- Uses a different, more generic naming convention for mount points; `/media/usb0`, `/media/usb1`, etc.


## Contributing
If you have questions, problems, feature requests, etc. please post them to the 
[Issues section on Github](https://github.com/fasteddy516/pi-usb-automount/issues).  If you would like to contribute, please let me know.