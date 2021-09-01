ARCHS = arm64 arm64e
TARGET = iphone:clang:13.6:12.0
INSTALL_TARGET_PROCESSES = Reddit Preferences

PREFIX = "$(THEOS)/toolchain/XcodeDefault-11.5.xctoolchain/usr/bin/"

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = redditnoads

redditnoads_FILES = $(wildcard *.xm *.m)
redditnoads_EXTRA_FRAMEWORKS = libhdev
redditnoads_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += pref

include $(THEOS_MAKE_PATH)/aggregate.mk

clean::
	rm -rf .theos packages
