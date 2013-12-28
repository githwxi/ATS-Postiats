#
# A Simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CCOMP=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOMP)"

######

CFLAGS= -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime

######

SOURCES_SATS += \
  GameOf24.sats \

SOURCES_DATS += \
  GameOf24.dats \
  GameOf24_card.dats \
  GameOf24_cardset.dats \
  GameOf24_solve.dats \

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: GameOf24

######

OBJECTS= $(TARGETS_DATS_O)

######

GameOf24: $(OBJECTS) ; \
  $(CCOMP) $(CFLAGS) -O2 -o $@ $^ -lgc -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) GameOf24

######

%_dats.c: %.dats ; $(PATSCC) -ccats $<
%_dats.o: %_dats.c; $(PATSCC2) -DATS_MEMALLOC_GCBDW $(CFLAGS) -c $<

######

clean:: cleanats

######

###### end of [Makefile] ######
