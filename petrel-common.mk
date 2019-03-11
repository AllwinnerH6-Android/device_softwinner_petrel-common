# inherit common.mk
$(call inherit-product-if-exists, device/softwinner/common/common.mk)
$(call inherit-product, vendor/aw/homlet/homlet.mk)

DEVICE_PACKAGE_OVERLAYS := \
    device/softwinner/petrel-common/overlay \
    $(DEVICE_PACKAGE_OVERLAYS)

PRODUCT_COPY_FILES += \
    device/softwinner/petrel-common/init.sun50iw6p1.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.sun50iw6p1.rc \
    device/softwinner/petrel-common/init.sun50iw6p1.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.sun50iw6p1.usb.rc \
    device/softwinner/petrel-common/ueventd.sun50iw6p1.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

# video
PRODUCT_COPY_FILES += \
    device/softwinner/petrel-common/configs/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    device/softwinner/petrel-common/configs/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    device/softwinner/petrel-common/configs/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    device/softwinner/petrel-common/configs/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    device/softwinner/petrel-common/configs/mediacodec-arm.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy

USE_XML_AUDIO_POLICY_CONF := 0
PRODUCT_COPY_FILES += \
    device/softwinner/petrel-common/configs/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    device/softwinner/petrel-common/configs/audio_policy_volumes_drc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes_drc.xml \
    device/softwinner/petrel-common/configs/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    hardware/aw/audio/homlet/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf \
    hardware/aw/audio/homlet/ac100_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/ac100_paths.xml \
    device/softwinner/petrel-common/configs/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    device/softwinner/petrel-common/configs/cfg-videoplayer.xml:system/etc/cfg-videoplayer.xml 

# PPPoE
PRODUCT_COPY_FILES += \
    vendor/aw/homlet/external/pppoe/pppd/script/ip-up-pppoe:system/etc/ppp/ip-up-pppoe \
    vendor/aw/homlet/external/pppoe/pppd/script/ip-down-pppoe:system/etc/ppp/ip-down-pppoe \
    vendor/aw/homlet/external/pppoe/pppd/script/pppoe-options:system/etc/ppp/peers/pppoe-options \
    vendor/aw/homlet/external/pppoe/pppd/script/pppoe-connect:system/bin/pppoe-connect \
    vendor/aw/homlet/external/pppoe/pppd/script/pppoe-disconnect:system/bin/pppoe-disconnect

# setting default audio output/input
# "AUDIO_CODEC","AUDIO_HDMI","AUDIO_SPDIF","AUDIO_I2S", etc.
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.audio.output.active=AUDIO_CODEC,AUDIO_HDMI \
    vendor.audio.input.active=AUDIO_CODEC

#libGLES_mali.so
PRODUCT_COPY_FILES += \
    hardware/aw/gpu/mali-midgard/mali-t720/arm/lib/libGLES_mali.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLES_mali.so
#privapp-permissions
PRODUCT_COPY_FILES += \
   device/softwinner/petrel-common/etc/privapp-permissions-petrel_p1.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-petrel_p1.xml
#usb and backup permissions file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.backup.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.backup.xml

# 131072=opengles 2.0
# 196608=opengles 3.0
# 196609=opengles 3.1
# 196610=opengles 3.2
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.kernel.android.checkjni=0

#IOMMU:0xaf10
#CMA:0xfa01
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.iomem.type=0xaf10

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.cputype=QuadCore-H6

# Enabling type-precise GC results in larger optimized DEX files.  The
# additional storage requirements for ".odex" files can cause /system
# to overflow on some devices, so this is configured separately for
# each product.
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.firmware=H6-p-mr1-v1.0

# if DISPLAY_BUILD_NUMBER := true then
# BUILD_DISPLAY_ID := $(BUILD_ID).$(BUILD_NUMBER)
# required by gms.
DISPLAY_BUILD_NUMBER := true
HAS_BUILD_NUMBER := true
BUILD_NUMBER := $(shell date +%Y%m%d-%H%M%S)

PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

PRODUCT_PACKAGES += \
    libwvhidl \
    libwvdrmengine \
    libvtswidevine

ifeq ($(BOARD_HAS_SECURE_OS), true)
SECURE_OS_OPTEE := yes
PRODUCT_PACKAGES += \
    libteec \
    tee_supplicant

# keymaster version (0 or 2)
BOARD_KEYMASTER_VERSION := 2

# hardware keymaster hal
PRODUCT_PACKAGES += \
    keystore.petrel

# keymaster ta
ifeq ($(BOARD_KEYMASTER_VERSION), 0)
PRODUCT_COPY_FILES += \
    device/softwinner/common/optee_ta/d6bebe60-be3e-4046-b239891e0a594860.ta:$(TARGET_COPY_OUT_VENDOR)/lib/optee_armtz/d6bebe60-be3e-4046-b239891e0a594860.ta
else
PRODUCT_COPY_FILES += \
    device/softwinner/common/optee_ta/f5f7b549-ba64-44fe-9b74f3fc357c7c61.ta:$(TARGET_COPY_OUT_VENDOR)/lib/optee_armtz/f5f7b549-ba64-44fe-9b74f3fc357c7c61.ta
endif

# gatekeeper ta
PRODUCT_COPY_FILES += \
    device/softwinner/common/optee_ta/2233b43b-cec6-449a-9509469f5023e425.ta:$(TARGET_COPY_OUT_VENDOR)/lib/optee_armtz/2233b43b-cec6-449a-9509469f5023e425.ta

ifeq ($(BOARD_WIDEVINE_OEMCRYPTO_LEVEL), 1)
PRODUCT_PACKAGES += \
    liboemcrypto
PRODUCT_COPY_FILES += \
    device/softwinner/common/optee_ta/a98befed-d679-ce4a-a3c827dcd51d21ed.ta:$(TARGET_COPY_OUT_VENDOR)/lib/optee_armtz/a98befed-d679-ce4a-a3c827dcd51d21ed.ta \
    device/softwinner/common/optee_ta/4d78d2ea-a631-70fb-aaa787c2b5773052.ta:$(TARGET_COPY_OUT_VENDOR)/lib/optee_armtz/4d78d2ea-a631-70fb-aaa787c2b5773052.ta \
    device/softwinner/common/optee_ta/e41f7029-c73c-344a-8c5bae90c7439a47.ta:$(TARGET_COPY_OUT_VENDOR)/lib/optee_armtz/e41f7029-c73c-344a-8c5bae90c7439a47.ta
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.widevine_oemcrypto_level=1
else # ifeq ($(BOARD_WIDEVINE_OEMCRYPTO_LEVEL), 1)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.widevine_oemcrypto_level=3
endif # ifeq ($(BOARD_WIDEVINE_OEMCRYPTO_LEVEL), 1)

else # ifeq ($(BOARD_HAS_SECURE_OS), true)
SECURE_OS_OPTEE := no
# if has no secure os, widevine level must set to 3
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.widevine_oemcrypto_level=3
endif # ifeq ($(BOARD_HAS_SECURE_OS), true)

#playready
BOARD_USE_PLAYREADY := 1
BOARD_PLAYREADY_USE_SECUREOS := 0
PLAYREADY_DEBUG := 1
BOARD_USE_PLAYREADY_LICENSE := 0

ifeq ($(BOARD_USE_PLAYREADY), 1)
PRODUCT_PACKAGES += \
    libplayreadypk \
    playreadydemo

PRODUCT_COPY_FILES += \
    hardware/aw/playready/keys/bgroupcert.dat:system/etc/playready/bgroupcert.dat \
    hardware/aw/playready/keys/zgpriv_protected.dat:system/etc/playready/zgpriv_protected.dat
endif

ifeq ($(BOARD_PLAYREADY_USE_SECUREOS), 1)
PRODUCT_COPY_FILES += \
    device/softwinner/common/optee_ta/b713fbe8-bf5e-2442-83b8c78b53bed4c8.ta:$(TARGET_COPY_OUT_VENDOR)/lib/optee_armtz/b713fbe8-bf5e-2442-83b8c78b53bed4c8.ta
endif
