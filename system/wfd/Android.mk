#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq (,$(filter wfd, $(TARGET_COMMON_QTI_COMPONENTS)))

include $(CLEAR_VARS)

WFDSERVICE_LIBRARIES := libwfdnative.so

WFDSERVICE_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS_PRIVILEGED)/WfdService/lib/arm64/,$(notdir $(WFDSERVICE_LIBRARIES)))
$(WFDSERVICE_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system/system_ext/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WFDSERVICE_SYMLINKS)

endif
