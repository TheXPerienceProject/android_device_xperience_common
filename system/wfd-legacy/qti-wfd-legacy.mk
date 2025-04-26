#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_FRAMEWORK_MANIFEST_FILE += device/xperience/common/system/wfd-legacy/configs/vintf/framework_manifest.xml

PRODUCT_SOONG_NAMESPACES += \
    device/xperience/common/vendor/gps-legacy

# Flags
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
LOC_HIDL_VERSION := 4.3

# Manifest
DEVICE_MANIFEST_FILE += \
    $(QCOM_COMMON_PATH)/vendor/gps-legacy/qcc-manifest.xml

# Overlays
PRODUCT_PACKAGES += \
    libnl

PRODUCT_BOOT_JARS += \
    WfdCommon

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0

# Display
PRODUCT_PACKAGES += \
    libdisplayconfig \
    libqdMetaData \
    libqdMetaData.system

# Media
PRODUCT_PACKAGES += \
    libaacwrapper

# Get non-open-source specific aspects.
$(call inherit-product-if-exists, vendor/qcom/common/system/wfd-legacy/wfd-legacy-vendor.mk)
