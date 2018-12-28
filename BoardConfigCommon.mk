include device/softwinner/common/BoardConfigCommon.mk
include vendor/aw/homlet/HomletBoardConfig.mk

TARGET_PLATFORM := homlet
SW_CHIP_PLATFORM := H6
TARGET_BOARD_PLATFORM := petrel
TARGET_USE_NEON_OPTIMIZATION := true

TARGET_CPU_SMP := true

TARGET_BOARD_CHIP := sun50iw6p1
TARGET_BOOTLOADER_BOARD_NAME := exdroid
TARGET_BOOTLOADER_NAME := exdroid
TARGET_OTA_RESTORE_BOOT_STORAGE_DATA := true

BOARD_KERNEL_BASE := 0x40000000
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x80000 --ramdisk_offset 0x02000000 --header_version 0x1
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_INCLUDE_RECOVERY_DTBO := true

USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_USES_HWC2 := true
TARGET_GPU_TYPE := mali-t720
USE_IOMMU := true

# Primary Arch
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi

TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_USES_G2D := true
TARGET_USES_DE30 := true

include hardware/aw/gpu/product_config.mk
