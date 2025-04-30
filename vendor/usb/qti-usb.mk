#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_SOONG_NAMESPACES += \
    device/xperience/common/vendor/usb

# Inherit from the USB product definition.
$(call inherit-product, hardware/xperience/interfaces/usb/1.3/vendor_product.mk)

ifneq (,$(filter 5.4 5.10 5.15, $(TARGET_KERNEL_VERSION)))
TARGET_HAS_DIAG_ROUTER := true
endif

ifeq (,$(filter 4.19 5.4 5.10 5.15, $(TARGET_KERNEL_VERSION)))
PRODUCT_PACKAGES += android.hardware.usb@1.3-service-qti
endif

ifeq (,$(filter 4.4 4.9 4.14 4.19 5.4, $(TARGET_KERNEL_VERSION)))
PRODUCT_HAS_GADGET_HAL := true
endif

ifeq ($(PRODUCT_HAS_GADGET_HAL),true)
PRODUCT_PACKAGES += \
    NcmTetheringOverlay
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

PRODUCT_PACKAGES += \
    init.xperience.usb.rc
