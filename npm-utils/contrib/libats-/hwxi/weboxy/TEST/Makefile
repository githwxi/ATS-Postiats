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

all::
regress::
cleanall::

######
#
all:: \
BUCS320_layout
BUCS320_layout: \
BUCS320_layout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
BUCS320_layout.html
BUCS320_layout.html: BUCS320_layout; ./$< > $@
#
######
#
all:: \
ATS2LANG_layout
ATS2LANG_layout: \
ATS2LANG_layout.dats; \
$(PATSCC2) \
  -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
ATS2LANG_layout.html
ATS2LANG_layout.html: ATS2LANG_layout; ./$< > $@
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

testall:: all
testall:: regress
testall:: cleanall

######
#
cleanats:: ; $(RMF) *_?ats.c
#
cleanats:: ; $(RMF) BUCS320_layout
cleanats:: ; $(RMF) ATS2LANG_layout
#
######
#
cleanall:: cleanats
#
cleanall:: ; $(RMF) BUCS320_layout.html
cleanall:: ; $(RMF) ATS2LANG_layout.html
#
######

###### end of [Makefile] ######
