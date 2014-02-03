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

include $(PATSHOME)/share/atsmake-post.mk

######

all:: hello
hello: \
  hello.dats \
  hello_Window.dats \
  hello_Renderer.dats ; \
  $(PATSCC2) $(CFLAGS) -o $@ $^ $(LDFLAGS)
cleanall:: ; $(RMF) hello

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
