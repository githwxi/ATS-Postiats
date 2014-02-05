#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS=$(shell pkg-config gtk+-3.0 --cflags)

######

LDFLAGS += -lgc
LDFLAGS += $(shell pkg-config gtk+-3.0 --libs)

######

all:: quicksort_anim
quicksort_anim: quicksort_anim.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_GCBDW -O2 -o $@ $(CFLAGS) $< $(LDFLAGS)
cleanall:: ; $(RMF) quicksort_anim

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
