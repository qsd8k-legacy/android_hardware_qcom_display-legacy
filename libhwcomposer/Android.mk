LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/../common.mk
include $(CLEAR_VARS)
LOCAL_MODULE                  := hwcomposer.qsd8k
LOCAL_MODULE_PATH             := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_SHARED_LIBRARIES        := $(common_libs) libEGL liboverlay libgenlock \
                                 libhwcexternal libqdutils libhardware_legacy \
                                 libdl libmemalloc libhwcservice libsync \
                                 libGLESv1_CM

LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"hwcomposer\"
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := hwc.cpp          \
                                 hwc_video.cpp    \
                                 hwc_pip.cpp    \
                                 hwc_utils.cpp    \
                                 hwc_uimirror.cpp \
                                 hwc_uevents.cpp  \
                                 hwc_vsync.cpp    \
                                 hwc_copybit.cpp  \
                                 hwc_mdpcomp.cpp  \
                                 hwc_extonly.cpp

include $(BUILD_SHARED_LIBRARY)

#libhwcexternal library
include $(CLEAR_VARS)
LOCAL_MODULE                  := libhwcexternal
LOCAL_MODULE_PATH             := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_SHARED_LIBRARIES        := $(common_libs) liboverlay

LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"hwcexternal\"
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := hwc_external.cpp

ifeq ($(TARGET_QCOM_HDMI_RESOLUTION_AUTO),true)
    LOCAL_CFLAGS += -DFORCE_AUTO_RESOLUTION
endif

include $(BUILD_SHARED_LIBRARY)

#libhwcservice library
include $(CLEAR_VARS)
LOCAL_MODULE                  := libhwcservice
LOCAL_MODULE_PATH             := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_SHARED_LIBRARIES        := $(common_libs) libhwcexternal libbinder \

LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"hwcservice\"
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := hwc_service.cpp \
                                 ihwc.cpp

include $(BUILD_SHARED_LIBRARY)
