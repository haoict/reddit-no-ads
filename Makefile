ARCHS = armv7 arm64 arm64e
TARGET = iphone:clang:12.2:10.0
INSTALL_TARGET_PROCESSES = Reddit Preferences

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = redditnoads

redditnoads_FILES = $(wildcard *.xm *.m)
redditnoads_EXTRA_FRAMEWORKS = libhdev
redditnoads_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += pref

include $(THEOS_MAKE_PATH)/aggregate.mk
