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
all:: chap_cloptr
chap_cloptr: \
  chap_cloptr.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
cleanall:: ; $(RMF) chap_cloptr
#
######
#
all:: chap_stream
chap_stream: \
  chap_stream.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
cleanall:: ; $(RMF) chap_stream
#
all:: chap_stream_vt
chap_stream_vt: \
  chap_stream_vt.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
cleanall:: ; $(RMF) chap_stream_vt
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
