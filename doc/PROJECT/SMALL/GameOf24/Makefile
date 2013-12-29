#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake2-pre.mk

######

CFLAGS += -O2
LDFLAGS += -lgc

######

MEMALLOC_ATS := -DATS_MEMALLOC_GCBDW

######

SOURCES_SATS += \
  GameOf24.sats \

SOURCES_DATS += \
  GameOf24.dats \
  GameOf24_card.dats \
  GameOf24_cardset.dats \
  GameOf24_solve.dats \

######

MYTARGET=GameOf24

######

include $(PATSHOME)/share/atsmake2-post.mk

######

###### end of [Makefile] ######
