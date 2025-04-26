#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

MSMSTEPPE := sm6150
5_4_FM := lahaina holi
4_19_FM := bengal kona lito
4_14_FM := trinket atoll msmnile msmnile_au $(MSMSTEPPE)

ifneq ($(filter $(5_4_FM),$(TARGET_BOARD_PLATFORM)),)
VARIANT := sm8350
else ifneq ($(filter $(4_19_FM),$(TARGET_BOARD_PLATFORM)),)
VARIANT := sm8250
else ifneq ($(filter $(4_14_FM),$(TARGET_BOARD_PLATFORM)),)
VARIANT := sm8150
else ifneq ($(filter sdm710 sdm845 qcs605,$(TARGET_BOARD_PLATFORM)),)
VARIANT := sdm845
endif

#ifeq ($(TARGET_COMMON_QTI_COMPONENTS), all)

ifneq (,$(filter all, $(TARGET_COMMON_QTI_COMPONENTS)))
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    audio \
    av \
    bt \
    display \
    gps \
    init \
    lhdc \
    media \
    nfc \
    overlay \
    perf \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan \
    $(filter-out all,$(TARGET_COMMON_QTI_COMPONENTS))
endif

# QTI Common Components

ifneq (,$(filter adreno, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(6_1_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-u
  else ifeq ($(call is-board-platform-in-list,$(5_15_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-t
  else ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-s
  else ifeq ($(call is-board-platform-in-list,$(4_14_FAMILY) $(4_19_FAMILY) $(5_4_FAMILY)),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-r
  else ifeq ($(call is-board-platform-in-list,$(3_18_FAMILY) $(4_4_FAMILY) msm8953),true)
    TARGET_ADRENO_COMPONENT_VARIANT ?= adreno-5xx
  else
    $(error "Adreno component is enabled, but there is not a variant available for your platform.")
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_ADRENO_COMPONENT_VARIANT)/qti-$(TARGET_ADRENO_COMPONENT_VARIANT).mk
endif

ifneq (,$(filter alarm, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/alarm/qti-alarm.mk
  include $(QCOM_COMMON_PATH)/vendor/alarm/qti-alarm.mk
endif

ifneq (,$(filter audio, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/audio/qti-audio.mk
  include $(QCOM_COMMON_PATH)/vendor/audio/qti-audio.mk
endif

ifneq (,$(filter av, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/av/qti-av.mk
endif

ifneq (,$(filter bt, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/bt/qti-bt.mk
  include $(QCOM_COMMON_PATH)/vendor/bt/qti-bt.mk
endif

ifneq (,$(filter charging, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/charging/qti-charging.mk
endif

ifneq (,$(filter display, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/display/qti-display.mk
  include $(QCOM_COMMON_PATH)/vendor/display/qti-display.mk
endif

# Some devices not opt for use display makefiles so
# Help them with this
ifneq (,$(filter gralloc_not_reserved, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/display/gralloc_reserved_soong.mk
endif

ifneq (,$(filter dsprpcd, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/dsprpcd/qti-dsprpcd.mk
endif

ifneq (,$(filter gps, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/gps/qti-gps.mk
  include $(QCOM_COMMON_PATH)/vendor/gps/qti-gps.mk
endif

ifneq (,$(filter init, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/init/qti-init.mk
endif

ifneq (,$(filter keymaster, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/keymaster/qti-keymaster.mk
endif

ifneq (,$(filter lhdc, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/lhdc/lhdc.mk
endif

ifneq (,$(filter media, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY) $(5_15_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/media/qti-media.mk
  else ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/media-5.4/qti-media-5.4.mk
  else
    include $(QCOM_COMMON_PATH)/vendor/media-legacy/qti-media-legacy.mk
  endif
  include $(QCOM_COMMON_PATH)/vendor/$(TARGET_MEDIA_COMPONENT_VARIANT)/qti-$(TARGET_MEDIA_COMPONENT_VARIANT).mk

  PRODUCT_COPY_FILES += \
    $(QCOM_COMMON_PATH)/vendor/seccomp/codec2.software.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.software.ext.policy \
    $(QCOM_COMMON_PATH)/vendor/seccomp/codec2.vendor.ext.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/codec2.vendor.ext.policy \
    $(QCOM_COMMON_PATH)/vendor/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(QCOM_COMMON_PATH)/vendor/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy
endif

ifneq (,$(filter nfc, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/nfc/qti-nfc.mk
endif

ifneq (,$(filter overlay, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/overlay/qti-overlay.mk
  include $(QCOM_COMMON_PATH)/vendor/overlay/qti-overlay.mk
endif

ifneq (,$(filter perf, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/perf/qti-perf.mk
  include $(QCOM_COMMON_PATH)/vendor/perf/qti-perf.mk
endif

ifneq (,$(filter perf-legacy, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/perf/qti-perf.mk
  include $(QCOM_COMMON_PATH)/vendor/perf-legacy/qti-perf-legacy.mk
endif

ifneq (,$(filter qseecomd, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY) $(5_10_FAMILY) $(5_15_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/qseecomd/qti-qseecomd.mk
  else
    include $(QCOM_COMMON_PATH)/vendor/qseecomd-legacy/qti-qseecomd-legacy.mk
  endif
endif

ifneq (,$(filter telephony, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/telephony/qti-telephony.mk
  include $(QCOM_COMMON_PATH)/vendor/telephony/qti-telephony.mk
endif

ifneq (,$(filter usb, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/usb/qti-usb.mk
endif

ifneq (,$(filter vibrator, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/vibrator/qti-vibrator.mk
endif

ifneq (,$(filter wfd, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/wfd/qti-wfd.mk
endif

ifneq (,$(filter wlan, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY) $(5_15_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/wlan/qti-wlan.mk
  else
    include $(QCOM_COMMON_PATH)/vendor/wlan-legacy/qti-wlan-legacy.mk
  endif
endif
