#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS :=
LDFLAGS :=

######

GTKCFLAGS=`pkg-config gtk+-3.0 --cflags`
GTKLDFLAGS=`pkg-config gtk+-3.0 --libs`

######

include $(PATSHOME)/share/atsmake-post.mk

######
#
all:: \
chap_start
chap_start: \
chap_start.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ $(GTKCFLAGS) $< $(GTKLDFLAGS)
cleanall:: ; $(RMF) chap_start
#
######
#
all:: \
chap_hello
chap_hello: \
chap_hello.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ $(GTKCFLAGS) $< $(GTKLDFLAGS)
cleanall:: ; $(RMF) chap_hello
#
######
#
all:: \
chap_boxpack
chap_boxpack: \
chap_boxpack.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ $(GTKCFLAGS) $< $(GTKLDFLAGS)
cleanall:: ; $(RMF) chap_boxpack
#
######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
