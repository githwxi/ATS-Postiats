#
# A simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake2-pre.mk

######

CFLAGS += -O2

######

LDFLAGS += -lrt

######

SOURCES_SATS += \
  DiningPhil.sats \

SOURCES_DATS += \
  DiningPhil.dats \
  DiningPhil_fork.dats \
  DiningPhil_dine.dats \
  DiningPhil_think.dats \

######

MYTARGET=test

######

include $(PATSHOME)/share/atsmake2-post.mk

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil/

######

###### end of [Makefile] ######
