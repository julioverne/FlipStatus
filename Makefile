include theos/makefiles/common.mk

TWEAK_NAME = FlipStatus
FlipStatus_FILES = /mnt/d/codes/flipstatus/Tweak.xm
FlipStatus_FRAMEWORKS = CydiaSubstrate Foundation UIKit
FlipStatus_CFLAGS = -fobjc-arc
FlipStatus_LDFLAGS = -Wl,-segalign,4000

FlipStatus_ARCHS = armv7 arm64
export ARCHS = armv7 arm64

include $(THEOS_MAKE_PATH)/tweak.mk
