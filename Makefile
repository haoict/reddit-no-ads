ARCHS = arm64 arm64e
TARGET = iphone::13.2:13.2
DEBUG = 0
THEOS_DEVICE_IP = 192.168.1.21

INSTALL_TARGET_PROCESSES = Reddit

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = redditnoads

redditnoads_FILES = Tweak.xm
redditnoads_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

