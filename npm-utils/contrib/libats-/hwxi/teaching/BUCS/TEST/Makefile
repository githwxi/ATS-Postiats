######
#
# A simple Makefile
#
######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::

######

all:: \
test_find
test_find: \
test_find.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

all:: \
test_which
test_which: \
test_which.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

all:: \
test_download
test_download: \
test_download.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

all:: \
test_lineto
test_lineto: \
test_lineto.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -latslib

######
#
all:: \
test_intinf
test_intinf: \
test_intinf.dats ; \
$(PATSCC) -O2 \
-I$(PATSHOME)/contrib -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
#
######

testall:: all
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) test_find
cleanall:: ; $(RMF) test_which
cleanall:: ; $(RMF) test_download
cleanall:: ; $(RMF) test_lineto
cleanall:: ; $(RMF) test_intinf

###### end of [Makefile] ######
