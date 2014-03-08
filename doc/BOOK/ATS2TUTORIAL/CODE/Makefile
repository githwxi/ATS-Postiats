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
#
all:: chap_stream
chap_stream: \
  chap_stream.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
cleanall:: ; $(RMF) chap_stream
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
