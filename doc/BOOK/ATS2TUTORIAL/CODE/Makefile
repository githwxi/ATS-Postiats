#
# ATS2TUTORIAL
#

######
#
# Author: Hongwei Xi
# Authoremail: gmhwxiATgmailDOTcom
#
######
#
# Author: Kiawamu Okabe
# Authoremail: kiwamuATgmailDOTcom
# For initiating regression test
#
######

include $(PATSHOME)/share/atsmake-pre.mk

######
#
all:: \
chap_brktoverld
chap_brktoverld: \
  chap_brktoverld.dats ; $(PATSCC2) -tcats $<
#
######
#
all:: \
chap_dotoverld
chap_dotoverld: \
  chap_dotoverld.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
regress:: chap_dotoverld; ./$<
cleanall:: ; $(RMF) chap_dotoverld
#
######
#
all:: \
chap_exception
chap_exception: \
  chap_exception.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
regress:: chap_exception; ./$<
cleanall:: ; $(RMF) chap_exception
#
######
#
all:: \
chap_reference
chap_reference: \
  chap_reference.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: chap_reference; ./$<
cleanall:: ; $(RMF) chap_reference
#
######
#
all:: \
chap_arrayref
chap_arrayref: \
  chap_arrayref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: chap_arrayref; ./$<
cleanall:: ; $(RMF) chap_arrayref
#
######
#
all:: \
chap_arrszref
chap_arrszref: \
  chap_arrszref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: chap_arrszref; ./$<
cleanall:: ; $(RMF) chap_arrszref
#
######
#
all:: \
chap_matrixref
chap_matrixref: \
  chap_matrixref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: chap_matrixref; ./$<
cleanall:: ; $(RMF) chap_matrixref
#
######
#
all:: \
chap_mtrxszref
chap_mtrxszref: \
  chap_mtrxszref.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: chap_mtrxszref; ./$<
cleanall:: ; $(RMF) chap_mtrxszref
#
######
#
all:: \
chap_hordfun
chap_hordfun: \
  chap_hordfun.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
regress:: chap_hordfun; ./$<
cleanall:: ; $(RMF) chap_hordfun
#
######
#
all:: \
chap_cloptr
chap_cloptr: \
  chap_cloptr.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
regress:: chap_cloptr; ./$<
cleanall:: ; $(RMF) chap_cloptr
#
######
#
all:: \
chap_stream
chap_stream: \
  chap_stream.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
regress:: chap_stream; ./$<
cleanall:: ; $(RMF) chap_stream
#
all:: \
chap_stream_vt
chap_stream_vt: \
  chap_stream_vt.dats ; $(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
regress:: chap_stream_vt; ./$<
cleanall:: ; $(RMF) chap_stream_vt
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
