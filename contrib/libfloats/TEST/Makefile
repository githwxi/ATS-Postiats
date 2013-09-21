#
# A simple Makefile for testing libfloats/blas
#

######

# (* Author: Hongwei Xi *)
# (* Authoremail: hwxi AT cs DOT bu DOT edu *)
# (* Start time: July, 2013 *)

# (* ****** ****** *)

# (* Author: Brandon Barker *)
# (* Authoremail: brandon.barker AT gmail DOT com *)
# (* Start time: July, 2013 *)

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOME)/bin/patscc

######

ATSCCOMP='gcc -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -DATS_MEMALLOC_LIBC'

######

all::
all:: test_gemm
all:: test_LUPdec
all:: test_LUPdec2
all:: test_Strassen
all:: test_LAgvec
all:: test_LAgmat

######

test_gemm: test_gemm.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS $(PATSHOMERELOCQ)/contrib -o $@ $<
cleanall:: ; $(RMF) test_gemm

test_LUPdec: test_LUPdec.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS $(PATSHOMERELOCQ)/contrib -o $@ $<
cleanall:: ; $(RMF) test_LUPdec

test_LUPdec2: test_LUPdec2.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS $(PATSHOMERELOCQ)/contrib -o $@ $<
cleanall:: ; $(RMF) test_LUPdec2

test_Strassen: test_Strassen.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS $(PATSHOMERELOCQ)/contrib -o $@ $<
cleanall:: ; $(RMF) test_Strassen

######

test_LAgvec: test_LAgvec.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS $(PATSHOMERELOCQ)/contrib -o $@ $<
cleanall:: ; $(RMF) test_LAgvec
test_LAgmat: test_LAgmat.dats ; \
  $(PATSCC) -atsccomp $(ATSCCOMP) -IATS $(PATSHOMERELOCQ)/contrib -o $@ $<
cleanall:: ; $(RMF) test_LAgmat

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile] ######
