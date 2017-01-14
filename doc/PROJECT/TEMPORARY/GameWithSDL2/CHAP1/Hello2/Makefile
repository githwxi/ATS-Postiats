#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######
#
CFLAGS += -O2
CFLAGS += -I$(PATSCONTRIB)/contrib
#
CFLAGS += $(shell pkg-config sdl2 --cflags)
#
MALLOCFLAG := -DATS_MEMALLOC_LIBC
#
######

LDFLAGS :=
LDFLAGS += $(shell pkg-config sdl2 --libs)

######

MYTARGET=Hello

######

SOURCES_DATS += Hello.dats

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
