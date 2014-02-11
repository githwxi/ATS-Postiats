#
# A simple Makefile for
# testing the ATS API for SDL2
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS0 = $(CFLAGS)
CFLAGS_image = $(CFLAGS)

######

CFLAGS0 += $(shell pkg-config sdl2 --cflags)
CFLAGS_image += $(shell pkg-config SDL2_image --cflags)

######

LDFLAGS0 = $(LDFLAGS)
LDFLAGS_image = $(LDFLAGS)

######

LDFLAGS0 += $(shell pkg-config sdl2 --libs)
LDFLAGS_image := $(shell pkg-config SDL2_image --libs)

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

all:: test00
test00: test00.dats ; $(PATSCC2) $(CFLAGS0) -o $@ $< $(LDFLAGS0)
cleanall:: ; $(RMF) test00

######

all:: test01
test01: test01.dats ; $(PATSCC2) $(CFLAGS0) -o $@ $< $(LDFLAGS0)
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; $(PATSCC2) $(CFLAGS_image) -o $@ $< $(LDFLAGS_image)
cleanall:: ; $(RMF) test02

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
