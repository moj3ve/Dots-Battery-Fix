FINALPACKAGE = 1

ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DotsBatteryFix

DotsBatteryFix_FILES = Tweak.x
DotsBatteryFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
