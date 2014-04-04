#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2
CFLAGS += $(shell pkg-config sdl2 --cflags)

######

LDFLAGS :=
LDFLAGS += $(shell pkg-config sdl2 --libs)

######

MALLOCFLAG := -DATS_MEMALLOC_LIBC

######

SOURCES_DATS += Hello.dats

######

MYTARGET=Hello

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
