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
all:: chap_arrayref
chap_arrayref: \
  chap_arrayref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) chap_arrayref
#
######
#
all:: chap_arrszref
chap_arrszref: \
  chap_arrszref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) chap_arrszref
#
######
#
all:: chap_matrixref
chap_matrixref: \
  chap_matrixref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) chap_matrixref
#
######
#
all:: chap_mtrxszref
chap_mtrxszref: \
  chap_mtrxszref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) chap_mtrxszref
#
######
#
all:: chap_hordfun
chap_hordfun: \
  chap_hordfun.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
cleanall:: ; $(RMF) chap_hordfun
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
