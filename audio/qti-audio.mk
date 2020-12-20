# Copyright (C) 2020 Paranoid Android
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

# Audio Configuration File
include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/qssi/qssi.mk

ifneq ($(TARGET_BOARD_PLATFORM),)
include $(TOPDIR)vendor/qcom/opensource/audio-hal/primary-hal/configs/$(TARGET_BOARD_PLATFORM)/$(TARGET_BOARD_PLATFORM).mk
else
$(error "TARGET_BOARD_PLATFORM is not defined yet. Please define in your device Makefile if you wish to use this component")
endif

# Override proprietary definitions from SoC audio makefile.
AUDIO_FEATURE_ENABLED_AHAL_EXT := false

# Override proprietary definitions from SoC audio HAL Makefiles.
AUDIO_FEATURE_ENABLED_DYNAMIC_LOG := false
AUDIO_FEATURE_ENABLED_SSR := false
BOARD_SUPPORTS_OPENSOURCE_STHAL := false

PRODUCT_PACKAGES += \
    libaudiohal

# Get non-open-source specific aspects.
$(call inherit-product-if-exists, vendor/qcom/common/audio/audio-vendor.mk)
