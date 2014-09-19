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
#
all:: \
theHome_layout
theHome_layout: \
theHome_layout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_LIBC -o $@ $< myweboxy.dats
#
regress:: \
theHome_layout.html
theHome_layout.html: theHome_layout; ./$< > $@
#
cleanall:: ; $(RMF) theHome_layout
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

cleanall:: cleanats
cleanall:: ; $(RMF) theHome_layout.html

######

###### end of [Makefile] ######
