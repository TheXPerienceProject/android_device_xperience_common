# Copyright (C) 2025 The XPerience Project
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

# call lhdc per kernel variant
TARGET_LHDC_COMPONENT_VARIANT ?= 6.1

ifneq (,$(filter lhdc, $(TARGET_COMMON_QTI_COMPONENTS)))
  ifeq ($(call is-board-platform-in-list,$(6_1_FAMILY)),true)
    TARGET_LHDC_COMPONENT_VARIANT ?= 6.1
  else ifeq ($(call is-board-platform-in-list,$(5_15_FAMILY)),true)
    TARGET_LHDC_COMPONENT_VARIANT ?= 5.15
  else ifeq ($(call is-board-platform-in-list,$(5_10_FAMILY)),true)
    TARGET_LHDC_COMPONENT_VARIANT ?= 5.10
  else ifeq ($(call is-board-platform-in-list,$(5_4_FAMILY)),true)
    TARGET_LHDC_COMPONENT_VARIANT ?= 5.4
  else ifeq ($(call is-board-platform-in-list,$(3_18_FAMILY) $(4_4_FAMILY) msm8953),true)
    $(warning this device is not supported)
  else
    $(error "lhdc component is enabled, but there is not a variant available for your platform.")
  endif
endif


PRODUCT_SOONG_NAMESPACES += \
    vendor/savitech/lhdc/$(TARGET_LHDC_COMPONENT_VARIANT)
