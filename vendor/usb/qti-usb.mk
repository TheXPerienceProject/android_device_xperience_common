#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_SOONG_NAMESPACES += \
    device/xperience/common/vendor/usb

ifneq (,$(filter 5.4 5.10 5.15, $(TARGET_KERNEL_VERSION)))
TARGET_HAS_DIAG_ROUTER := true
endif

ifneq ($(TARGET_KERNEL_VERSION), 4.19)
PRODUCT_PACKAGES += android.hardware.usb@1.0-service
endif

ifeq (,$(filter 5.4 5.10 5.15, $(TARGET_KERNEL_VERSION)))
PRODUCT_PACKAGES += android.hardware.usb-service.qti
endif

ifeq (,$(filter 4.4 4.9 4.14 4.19 5.4, $(TARGET_KERNEL_VERSION)))
PRODUCT_HAS_GADGET_HAL := true
endif

ifeq ($(PRODUCT_HAS_GADGET_HAL),true)
PRODUCT_PACKAGES += \
    NcmTetheringOverlay \
    NcmTetheringOverlayMainline
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

PRODUCT_PACKAGES += \
    init.xperience.usb.rc
