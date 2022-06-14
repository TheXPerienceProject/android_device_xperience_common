# Copyright (C) 2021 Paranoid Android
# Copyright (C) 2021 The XPerience Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_SOONG_NAMESPACES += \
    device/xperience/common/vendor/perf

# Configs
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(QCOM_COMMON_PATH)/vendor/perf/configs/common,$(TARGET_COPY_OUT_VENDOR)/etc) \
    $(call find-copy-subdir-files,*,$(QCOM_COMMON_PATH)/vendor/perf/configs/$(TARGET_BOARD_PLATFORM),$(TARGET_COPY_OUT_VENDOR)/etc)

# Disable IOP HAL for select platforms.
ifneq ($(filter msm8937 msm8953 msm8998 qcs605 sdm660 sdm710, $(TARGET_BOARD_PLATFORM)),)
PRODUCT_COPY_FILES += \
    $(QCOM_COMMON_PATH)/vendor/perf/vendor.qti.hardware.iop@2.0-service-disable.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/vendor.qti.hardware.iop@2.0-service-disable.rc
endif

# Disable the poweropt service for non 5.4 platforms.
ifneq ($(TARGET_KERNEL_VERSION),5.4)
PRODUCT_COPY_FILES += \
    $(QCOM_COMMON_PATH)/vendor/perf/poweropt-service-disable.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/poweropt-service-disable.rc
endif

# Packages
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0.vendor \
    libavservices_minijail.vendor \
    libpsi.vendor \
    libtflite \
    vendor.qti.hardware.servicetracker@1.2.vendor

ifeq ($(TARGET_KERNEL_VERSION),5.4)
PRODUCT_PACKAGES += \
    task_profiles-qti
endif

# Properties
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.qti.games.gt.prof=1 \
    ro.vendor.perf-hal.ver=2.2 \
    ro.vendor.extension_library=libqti-perfd-client.so \
    ro.vendor.perf.scroll_opt=true \
    ro.vendor.perf.scroll_opt.heavy_app=true \
    vendor.enable_prefetch=1 \
    vendor.iop.enable_uxe=1 \
    vendor.iop.enable_prefetch_ofr=1 \
    vendor.perf.iop_v3.enable=1 \
    vendor.power.pasr.enabled=true \
    vendor.pasr.activemode.enabled=true \
    ro.vendor.qspm.enable=true

ifeq ($(call is-board-platform-in-list, kona lahaina taro),true)
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.beluga.p=0x3 \
    ro.vendor.beluga.c=0x4800 \
    ro.vendor.beluga.s=0x900 \
    ro.vendor.beluga.t=0x240
endif

# Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/qcom/common/vendor/perf/perf-vendor.mk)
