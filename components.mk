# Copyright 2022 Paranoid Android
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
  ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/adreno/qti-adreno.mk
  else ifeq ($(call is-board-platform-in-list,$(3_18_FAMILY) $(4_4_FAMILY) msm8953 sdm660),true)
    include $(QCOM_COMMON_PATH)/vendor/adreno-5xx/qti-adreno-5xx.mk
  else
    include $(QCOM_COMMON_PATH)/vendor/adreno-6xx-legacy/qti-adreno-6xx-legacy.mk
  endif
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

ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY)),true)
  include $(QCOM_COMMON_PATH)/dlkm/qti-dlkm.mk
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

ifneq (,$(filter media, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY) $(5_15_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/media/qti-media.mk
  else ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/media-5.4/qti-media-5.4.mk
  else
    include $(QCOM_COMMON_PATH)/vendor/media-legacy/qti-media-legacy.mk
  endif
endif

ifneq (,$(filter nfc, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/vendor/nfc/qti-nfc.mk
endif

ifneq (,$(filter overlay, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/overlay/qti-overlay.mk
endif

ifneq (,$(filter perf, $(TARGET_COMMON_QTI_COMPONENTS)))
  include $(QCOM_COMMON_PATH)/system/perf/qti-perf.mk
  ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY) $(5_15_FAMILY)),true)
    include $(QCOM_COMMON_PATH)/vendor/perf/qti-perf.mk
  else
    include $(QCOM_COMMON_PATH)/vendor/perf-legacy/qti-perf-legacy.mk
  endif
endif

ifneq (,$(filter qseecomd, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY) $(5_10_FAMILY)),true)
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
