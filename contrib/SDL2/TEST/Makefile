#
# A simple Makefile for
# testing the ATS API for SDL2
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

LDFLAGS += -lSDL2

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

all:: test00
test00: test00.dats ; $(PATSCC2) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test00

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
