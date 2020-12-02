#
# Copyright 2020 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/xperience/common

# Kernel Families
5_4_FAMILY := \
    holi

4_19_FAMILY := \
    bengal \
    kona \
    lito

4_14_FAMILY := \
    $(MSMSTEPPE) \
    $(TRINKET) \
    atoll \
    msmnile \
    msmnile_au

4_9_FAMILY := \
    msm8953 \
    qcs605 \
    sdm710 \
    sdm845

4_4_FAMILY := \
    msm8998 \
    sdm660

3_18_FAMILY := \
    msm8937 \
    msm8996

ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY)),true)
TARGET_KERNEL_VERSION ?= 5.4
else ifeq ($(call is-board-platform-in-list,$(4_19_FAMILY)),true)
TARGET_KERNEL_VERSION ?= 4.19
else ifeq ($(call is-board-platform-in-list,$(4_14_FAMILY)),true)
TARGET_KERNEL_VERSION ?= 4.14
else ifeq ($(call is-board-platform-in-list,$(4_9_FAMILY)),true)
TARGET_KERNEL_VERSION ?= 4.9
else ifeq ($(call is-board-platform-in-list,$(4_4_FAMILY)),true)
TARGET_KERNEL_VERSION ?= 4.4
else ifeq ($(call is-board-platform-in-list,$(3_18_FAMILY)),true)
TARGET_KERNEL_VERSION ?= 3.18
endif

ifeq ($(TARGET_COMMON_QTI_COMPONENTS), all)
TARGET_COMMON_QTI_COMPONENTS := \
    audio \
    av \
    bt \
    display \
    gps \
    overlay \
    perf \
    telephony \
    wfd
endif

# SECCOMP Extensions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/seccomp/codec2.software.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.software.ext.policy \
    $(DEVICE_PATH)/seccomp/codec2.vendor.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.vendor.ext.policy \
    $(DEVICE_PATH)/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(DEVICE_PATH)/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

ifeq ($(TARGET_COMMON_QTI_COMPONENTS), all)
TARGET_COMMON_QTI_COMPONENTS := \
    audio \
    av \
    bt \
    display \
    gps \
    init \
    media \
    nq-nfc \
    overlay \
    perf \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan
endif

# QTI common components
ifneq (,$(filter av, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/av/qti-av.mk
endif

ifneq (,$(filter bt, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/bt/qti-bt.mk
endif

ifneq (,$(filter gps, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/gps/qti-gps.mk
endif

ifneq (,$(filter overlay, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/overlay/qti-overlay.mk
endif

ifneq (,$(filter perf, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/perf/qti-perf.mk
endif

ifneq (,$(filter telephony, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/telephony/qti-telephony.mk
endif

ifneq (,$(filter usb, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/usb/qti-usb.mk
endif

ifneq (,$(filter vibrator, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/vibrator/qti-vibrator.mk
endif

# 845 series and newer
ifneq (,$(filter audio, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/audio/qti-audio.mk
endif

ifneq (,$(filter display, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/display/qti-display.mk
endif

ifneq (,$(filter media, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/media/qti-media.mk
endif

ifneq (,$(filter nq-nfc, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/nq-nfc/qti-nq-nfc.mk
endif

ifneq (,$(filter wfd, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/wfd/qti-wfd.mk
endif

ifneq (,$(filter wlan, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/wlan/qti-wlan.mk
endif

# 8998 series and older
ifneq (,$(filter wfd-legacy, $(TARGET_COMMON_QTI_COMPONENTS)))
include $(DEVICE_PATH)/wfd-legacy/qti-wfd-legacy.mk
endif
