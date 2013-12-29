##
##
## A simple Makefile
##
##

######

include \
$(PATSHOME)/share/atsmake2-pre.mk

######

CFLAGS += -O2

######

LDFLAGS += -lpthread

######

SOURCES_SATS += \
  DiningPhil2.sats \

SOURCES_DATS += \
  DiningPhil2.dats \
  DiningPhil2_fork.dats \
  DiningPhil2_thread.dats \

######

MYTARGET=test

######

include $(PATSHOME)/share/atsmake2-post.mk

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil2/

######

###### end of [Makefile] ######
