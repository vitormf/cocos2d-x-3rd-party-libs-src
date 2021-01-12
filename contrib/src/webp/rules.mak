# webp

WEBP_VERSION := 0.2.0
WEBP_GIT := https://chromium.googlesource.com/webm/libwebp

$(TARBALLS)/libwebp-$(WEBP_VERSION).tar.gz:
	git clone $(WEBP_GIT) -b $(WEBP_VERSION) libwebp-$(WEBP_VERSION) 

ifdef HAVE_ANDROID
ifeq ($(MY_TARGET_ARCH),armeabi-v7a)
	mkdir -p $(PREFIX)/lib
	cp $(PREFIX)/../../src/webp/libcpufeatures.a $(PREFIX)/lib/
endif
endif

webp: libwebp-$(WEBP_VERSION).tar.gz
	$(UPDATE_AUTOCONFIG)
	pwd
	$(MOVE)
	cp $(SRC)/webp/cpu-features.h webp/src/dsp/cpu-features.h

.webp: webp
	cd $< && ./autogen.sh
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE)
	cd $< && $(MAKE) install
	touch $@
