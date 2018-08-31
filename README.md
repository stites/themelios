# Themelios
Bootstrap a zfs-on-root NixOS configuration in one command

![Themelios NixOS Screenshot](https://github.com/a-schaefers/themelios/raw/master/themelios_usage.png)

## What Themelios does
From any NixOS live disk, Themelios will do the following in approximate order:
- Automatically installs zfs and git to the livedisk if needed.
- Clones your git repo, optionally using a non-master branch.
- Finds your configuration.sh file automatically.
- Configures a zfs-on-root system to your configuration.sh file specification including the following options:
  * Uses sgdisk and/or wipefs, or dd to clear your disks.
  * Creates a single/mirror/raidz1/raidz2/raidz3 zpool
  * Configures a zfs-on-root dataset scheme by default
  * Bootstraps your top level .nix configuration and install the rest of your operating system
- Aims to fail gracefully with continue and retry options.
- A simple script, easy to hack on.

## What Themelios does not do (yet)
- Currently uefi is unsupported. (imho legacy bios with zfs BE's is more robust.)
- Configure more than one pool.
- Write zeros to more than one disk concurrently.
- Full Disk encryption (kinda just waiting for zfsonlinux to hit maturity in this area...)

## What Themelios will never do
- Mess with any of your .nix files in your repo. This means you still need to turn on some basic ZFS settings in you nix files. I recommend something like the following:
https://github.com/a-schaefers/nix-config/blob/master/modules/nixos/nixos-zfs.nix

## Configuration.sh Variables:
```bash
# Themelios configuration.sh example
POOL_NAME="zroot"
POOL_TYPE="raidz1"    # May also be set to "mirror". Leave empty "" for single.

# use one disk per line here!
POOL_DISKS="/dev/sda
/dev/sdb
/dev/sdc"

SGDISK_CLEAR="true"   # Use sgdisk --clear
WIPEFS_ALL="true"     # wipefs --all
ZERO_DISKS="false"    # uses dd if=/dev/zero ...
ATIME="off"           # recommended "off" for SSD disks.
SNAPSHOT_ROOT="true"  # Sets the value of com.sun:auto-snapshot
SNAPSHOT_HOME="true"
USE_ZSWAP="false"     # Creates a swap zvol
ZSWAP_SIZE="4G"

# Your top-level configuration.nix file relative path from the project_root.
# e.g. for the file project_root/hosts/hpZ620/default.nix use the following:
TOP_LEVEL_NIXFILE="hosts/hpZ620/default.nix"

# Directory name of <git-remote> in "/" (root). Do not use slashes.
NIXCFG_DIR="nix-config"

# Setting this to true would trade-off the ability to use zfs boot environments for extra disk space.
# OTOH, if you garbage collect often, this should not be much of an issue. (Recommended false.)
NIXDIR_NOROOT="false" # mount /nix outside of the / (root) dataset.
```

## Debug options:
See the end of the script for details.
