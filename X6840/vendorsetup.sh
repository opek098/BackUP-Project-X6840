#!/bin/bash
device_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
workspace_root="$(cd "${device_dir}/../../.." && pwd)"
vibration_patch_file="${device_dir}/patches/01-patch-vibration.patch"
health_patch_file="${device_dir}/patches/02-patch-health-hal.patch"

if [[ ! -f "${health_patch_file}" ]]; then
    echo "[X6840] Missing patch: ${health_patch_file}"
elif [[ ! -f "${vibration_patch_file}" ]]; then
    echo "[X6840] Missing patch: ${vibration_patch_file}"
elif ! command -v patch >/dev/null 2>&1; then
    echo "[X6840] Missing required command: patch"
elif (
    cd "${workspace_root}" &&
	patch -p1 -N --dry-run --silent < "${vibration_patch_file}" >/dev/null 2>&1
    patch -p1 -N --dry-run --silent < "${health_patch_file}" >/dev/null 2>&1
); then
    if (
        cd "${workspace_root}" &&
		patch -p1 -N --silent < "${vibration_patch_file}" >/dev/null 2>&1
        patch -p1 -N --silent < "${health_patch_file}" >/dev/null 2>&1
    ); then
        echo "[X6840] Applied patches."
    else
        echo "[X6840] Failed to apply patches."
    fi
else
    echo "[X6840] Patches already applied or not applicable"
fi

unset device_dir workspace_root patch_file

# additional properties
	export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v28.1.zip
	export FOX_VIRTUAL_AB_DEVICE=1
	export FOX_VANILLA_BUILD=1
	export FOX_ENABLE_APP_MANAGER=1
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_LZ4_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_USE_ZSTD_BINARY=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_DELETE_AROMAFM=1
	export OF_DEFAULT_KEYMASTER_VERSION=4.1

	# screen settings
	export OF_SCREEN_H=2400
	export OF_STATUS_H=95
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
	export OF_ALLOW_DISABLE_NAVBAR=0
	export OF_CLOCK_POS=1

	# other stuff
	export OF_QUICK_BACKUP_LIST="/boot:/data"
	export OF_ENABLE_LPTOOLS=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export FOX_USE_BASH_SHELL=1
	export FOX_USE_NANO_EDITOR=1

	# number of list options before scrollbar creation
	export OF_OPTIONS_LIST_NUM=9

	# ----- data format stuff -----
	# ensure that /sdcard is bind-unmounted before f2fs data repair or format
	export OF_UNBIND_SDCARD_F2FS=1

	# automatically wipe /metadata after data format
	export OF_WIPE_METADATA_AFTER_DATAFORMAT=1

	# avoid MTP issues after data format
	export OF_BIND_MOUNT_SDCARD_ON_FORMAT=1

	# don't spam the console with loop errors
	export OF_LOOP_DEVICE_ERRORS_TO_LOG=1

	# lz4 compression
	export OF_USE_LZ4_COMPRESSION=1

	# build all the partition tools
	export OF_ENABLE_ALL_PARTITION_TOOLS=1

	# variant
	export OF_MAINTAINER="Opek_Furina"

	# no flashlight
	export OF_FLASHLIGHT_ENABLE=0

  # common lunch
add_lunch_combo twrp_X6840-eng
