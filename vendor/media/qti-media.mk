#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_SOONG_NAMESPACES += \
    device/xperience/common/vendor/media

TARGET_MEDIA_COMPONENT_VARIANT := media

# Inherit configuration from the HAL.
$(call inherit-product-if-exists, hardware/qcom-caf/$(VARIANT)/media/product.mk)
$(warning "Media variant is $(VARIANT)")

# Enable 64-bit mediaserver
PRODUCT_VENDOR_PROPERTIES += \
    ro.mediaserver.64b.enable=true

PRODUCT_COPY_FILES += \
    device/xperience/common/vendor/media/media_codecs_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2_audio.xml

# Packages
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.2.vendor \
    libavservices_minijail.vendor

# Properties
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    media.stagefright.thumbnail.prefer_hw_codecs=true \
    ro.media.recorder-max-base-layer-fps=60

#---------------------------------------------------------------------------------------------------
# Runtime Codec2.0 enablement
#---------------------------------------------------------------------------------------------------
ifeq ($(TARGET_BOARD_PLATFORM), lahaina)
#enable c2 based encoders/decoders as default NT decoders/encoders
PRODUCT_VENDOR_PROPERTIES += \
    vendor.audio.c2.preferred=true
endif

# Media Init
PRODUCT_COPY_FILES += \
    device/xperience/common/vendor/media/init.qti.media.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.media.sh

# Get non-open-source specific aspects.
$(call inherit-product-if-exists, vendor/qcom/common/vendor/media/media-vendor.mk)
