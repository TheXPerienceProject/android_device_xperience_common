
# Soong Namespace
SOONG_CONFIG_NAMESPACES += qtidisplay

# Soong Keys
SOONG_CONFIG_qtidisplay := gralloc_handle_has_no_reserved_size

# Soong Values
SOONG_CONFIG_qtidisplay_gralloc_handle_has_no_reserved_size := false

ifeq ($(TARGET_GRALLOC_HANDLE_HAS_NO_RESERVED_SIZE),true)
    SOONG_CONFIG_qtidisplay_gralloc_handle_has_no_reserved_size := true
endif
