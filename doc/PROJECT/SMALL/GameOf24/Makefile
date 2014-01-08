#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2

######

LDFLAGS :=
LDFLAGS += -lgc

######

MALLOCFLAG := -DATS_MEMALLOC_GCBDW

######

SOURCES_SATS += \
  GameOf24.sats \

SOURCES_DATS += \
  GameOf24.dats \
  GameOf24_card.dats \
  GameOf24_cardset.dats \
  GameOf24_solve.dats \
  GameOf24_mylib.dats \

######

MYTARGET=GameOf24

######
#
MYPORTDIR=MYPORTDIR
#
#MYPORTCPP=MYPORTCPP
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanall:: ; $(RMF) $(MYPORTDIR)/*
cleanats:: ; $(RMF) $(MYPORTDIR)/*_?ats.o
cleanats:: ; $(RMF) $(MYPORTDIR)/*_?ats.c

######

###### end of [Makefile] ######
