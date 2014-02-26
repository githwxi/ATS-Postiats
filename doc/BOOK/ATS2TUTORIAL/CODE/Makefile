#
# ATS2TUTORIAL
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######
#
all:: chap_reference
chap_reference: \
  chap_reference.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) chap_reference
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
