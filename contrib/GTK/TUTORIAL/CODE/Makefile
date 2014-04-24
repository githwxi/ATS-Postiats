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

GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`

######

include $(PATSHOME)/share/atsmake-post.mk

######
#
all:: \
chap_hello
chap_hello: \
chap_hello.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) chap_hello
#
######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
