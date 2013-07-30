# script expect linphone-root-dir variable to be set by parent !

#default values
ifeq ($(BUILD_AMRNB),)
BUILD_AMRNB=light
endif
ifeq ($(BUILD_AMRWB),)
BUILD_AMRWB=0
endif
ifeq ($(BUILD_G729),)
BUILD_G729=0
endif
BUILD_SRTP=1

BUILD_X264=0
LINPHONE_VIDEO=0
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
BUILD_X264=1
LINPHONE_VIDEO=1
endif

include $(linphone-root-dir)/submodules/linphone/mediastreamer2/src/android/libneon/Android.mk

#Xsocket
include $(linphone-root-dir)/submodules/externals/Xsocket/Android.mk

##ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
ifeq ($(BUILD_GPLV3_ZRTP), 1)
	BUILD_SRTP=1
ZRTP_C_INCLUDE= \
	$(linphone-root-dir)/submodules/externals/libzrtpcpp/src
endif

ifeq ($(BUILD_SRTP), 1)
SRTP_C_INCLUDE= \
	$(linphone-root-dir)/submodules/externals/srtp \
	$(linphone-root-dir)/submodules/externals/srtp/include \
	$(linphone-root-dir)/submodules/externals/srtp/crypto/include
endif
#endif

#libupnp
ifeq ($(BUILD_UPNP),1)
include $(linphone-root-dir)/submodules/externals/build/libupnp/Android.mk
endif

#libxml2 + xml2lpc + lpc2xml
ifeq ($(BUILD_REMOTE_PROVISIONING),1)
include $(linphone-root-dir)/submodules/externals/build/libxml2/Android.mk
include $(linphone-root-dir)/submodules/linphone/build/android/xml2lpc.mk
include $(linphone-root-dir)/submodules/linphone/build/android/lpc2xml.mk
endif

# Speex
include $(linphone-root-dir)/submodules/externals/build/speex/Android.mk

# Gsm
include $(linphone-root-dir)/submodules/externals/build/gsm/Android.mk

include $(linphone-root-dir)/submodules/externals/build/exosip/Android.mk

include $(linphone-root-dir)/submodules/externals/build/osip/Android.mk

# Openssl
include $(linphone-root-dir)/submodules/externals/openssl/Android.mk

include $(linphone-root-dir)/submodules/linphone/oRTP/build/android/Android.mk

include $(linphone-root-dir)/submodules/linphone/mediastreamer2/build/android/Android.mk
include $(linphone-root-dir)/submodules/linphone/mediastreamer2/tools/Android.mk


ifeq ($(BUILD_TUNNEL), 1)
include $(linphone-root-dir)/submodules/tunnel/Android.mk
endif

ifeq ($(BUILD_SILK), 1)
ifeq (,$(DUMP_VAR))
$(info Build proprietary SILK plugin for mediastreamer2)
endif
include $(linphone-root-dir)/submodules/mssilk/Android.mk
endif


ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
include $(linphone-root-dir)/submodules/msilbc/Android.mk

ifeq ($(BUILD_X264), 1)
ifeq (,$(DUMP_VAR))
$(info Build X264 plugin for mediastreamer2)
endif
include $(linphone-root-dir)/submodules/msx264/Android.mk
include $(linphone-root-dir)/submodules/externals/build/x264/Android.mk
endif

include $(linphone-root-dir)/submodules/externals/build/ffmpeg/Android.mk
include $(linphone-root-dir)/submodules/externals/build/ffmpeg-no-neon/Android.mk

include $(linphone-root-dir)/submodules/externals/build/libvpx/Android.mk
endif #armeabi-v7a


ifeq ($(BUILD_GPLV3_ZRTP), 1)
ifeq (,$(DUMP_VAR))
$(info Build ZRTP support - makes application GPLv3)
endif
include $(linphone-root-dir)/submodules/externals/build/libzrtpcpp/Android.mk
endif

ifeq ($(BUILD_SRTP), 1)
include $(linphone-root-dir)/submodules/externals/build/srtp/Android.mk
endif

ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
include $(linphone-root-dir)/submodules/linphone/build/android/Android.mk
endif
include $(linphone-root-dir)/submodules/linphone/build/android/Android-no-neon.mk

_BUILD_AMR=0
ifneq ($(BUILD_AMRNB), 0)
_BUILD_AMR=1
endif

ifneq ($(BUILD_AMRWB), 0)
_BUILD_AMR=1
endif

ifneq ($(_BUILD_AMR), 0)
include $(linphone-root-dir)/submodules/externals/build/opencore-amr/Android.mk
include $(linphone-root-dir)/submodules/msamr/Android.mk
endif

ifneq ($(BUILD_AMRWB), 0)
include $(linphone-root-dir)/submodules/externals/build/vo-amrwbenc/Android.mk
endif

ifneq ($(BUILD_G729), 0)
include $(linphone-root-dir)/submodules/bcg729/Android.mk
include $(linphone-root-dir)/submodules/bcg729/msbcg729/Android.mk
endif

ifneq ($(BUILD_WEBRTC_AECM), 0)
ifneq ($(TARGET_ARCH), x86)
ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
WEBRTC_BUILD_NEON_LIBS=true
endif
include $(linphone-root-dir)/submodules/externals/build/webrtc/system_wrappers/Android.mk
include $(linphone-root-dir)/submodules/externals/build/webrtc/common_audio/signal_processing/Android.mk
include $(linphone-root-dir)/submodules/externals/build/webrtc/modules/audio_processing/utility/Android.mk
include $(linphone-root-dir)/submodules/externals/build/webrtc/modules/audio_processing/aecm/Android.mk
endif
endif
