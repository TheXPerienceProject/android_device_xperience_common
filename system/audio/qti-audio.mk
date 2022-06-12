# Copyright (C) 2021 Paranoid Android
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

# Inherit from QSSI audio makefile.
include $(TOPDIR)vendor/qcom/opensource/commonsys/audio/configs/qssi/qssi.mk

5_4_FM := lahaina holi
4_19_FM := bengal kona lito
4_14_FM := trinket atoll msmnile msmnile_au

ifneq ($(filter $(5_4_FM),$(TARGET_BOARD_PLATFORM)),)
VARIANT := sm8350
else ifneq ($(filter $(4_19_FM),$(TARGET_BOARD_PLATFORM)),)
VARIANT := sm8250
else ifneq ($(filter $(4_14_FM),$(TARGET_BOARD_PLATFORM)),)
VARIANT := sm8150
else ifneq ($(filter sdm710 sdm845 qcs605,$(TARGET_BOARD_PLATFORM)),)
VARIANT := sdm845
endif

ifneq ($(filter sm6150,$(TARGET_BOARD_PLATFORM)),)
-include $(TOPDIR)hardware/qcom-caf/sm8150/audio/configs/msmsteppe/msmsteppe.mk
else
-include $(TOPDIR)hardware/qcom-caf/$(VARIANT)/audio/configs/$(TARGET_BOARD_PLATFORM)/$(TARGET_BOARD_PLATFORM).mk
endif
#$(warning "$(TOPDIR)hardware/qcom-caf/$(VARIANT)/audio/configs/$(TARGET_BOARD_PLATFORM)/$(TARGET_BOARD_PLATFORM).mk")

# Override proprietary definitions from SoC audio makefile.
AUDIO_FEATURE_ENABLED_AHAL_EXT := false

# Override proprietary definitions from SoC audio HAL Makefiles.
AUDIO_FEATURE_ENABLED_DYNAMIC_LOG := false
BOARD_SUPPORTS_OPENSOURCE_STHAL := false

# OMX Packages
PRODUCT_PACKAGES += \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxEvrcEnc \
    libOmxG711Enc \
    libOmxQcelp13Enc

# Audio Packages
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.primary.$(TARGET_BOARD_PLATFORM) \
    audio.r_submix.default \
    audio.usb.default \
    liba2dpoffload \
    libaudiohal \
    libaudio-resampler \
    libaudioroute \
    libbatterylistener \
    libcirrusspkrprot \
    libcomprcapture \
    libexthwplugin \
    libhdmiedid \
    libhfp \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libsndmonitor \
    libspkrprot \
    libssrec \
    libtinycompress \
    libvolumelistener \
    sound_trigger.primary.$(TARGET_BOARD_PLATFORM)

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Get non-open-source specific aspects.
$(call inherit-product-if-exists, vendor/qcom/common/system/audio/audio-vendor.mk)
