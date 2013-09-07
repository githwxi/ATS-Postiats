#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

all:: test01
test01: test01.dats ; \
$(PATSCC) -cleanaft \
  -IIATS $(PATSHOMEQ)/contrib -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; \
$(PATSCC) -cleanaft \
  -IIATS $(PATSHOMEQ)/contrib -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
cleanall:: ; $(RMF) test02

######

all:: test03
test03: test03.dats ; \
$(PATSCC) -cleanaft \
  -IIATS $(PATSHOMEQ)/contrib -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
cleanall:: ; $(RMF) test03

######

all:: test04
test04: test04.dats ; \
$(PATSCC) -cleanaft \
  -IIATS $(PATSHOMEQ)/contrib -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
cleanall:: ; $(RMF) test04

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
