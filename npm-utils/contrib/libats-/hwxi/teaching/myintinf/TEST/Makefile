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
#
all:: \
test01_dats
test01_dats: \
test01.dats ; \
$(PATSCC) -O2 \
-I$(PATSHOME)/contrib -DATS_MEMALLOC_LIBC -o $@ $<
#
######
#
all:: \
test02_dats
test02_dats: \
test02.dats ; \
$(PATSCC) -O2 \
-I$(PATSHOME)/contrib -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
#
######

regress:: test01_dats; ./$<
regress:: test02_dats; ./$<

######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) test01_dats
cleanall:: ; $(RMF) test02_dats

###### end of [Makefile] ######
