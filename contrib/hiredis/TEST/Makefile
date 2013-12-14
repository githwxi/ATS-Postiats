#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=${PATSHOMEQ}/bin/patscc

######

all::

######

all:: test00
test00: test00.dats ; \
  $(PATSCC) -cleanaft \
    -IIATS $(PATSHOMERELOCQ)/contrib -o $@ $< -lhiredis
cleanall:: ; $(RMF) test00

######

all:: test01
test01: test01.dats ; \
  $(PATSCC) -cleanaft \
    -IIATS $(PATSHOMERELOCQ)/contrib -o $@ $< -lhiredis
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; \
  $(PATSCC) -cleanaft \
    -IIATS $(PATSHOMERELOCQ)/contrib \
    -DATS_MEMALLOC_GCBDW -o $@ $< testlib.dats -lhiredis -lgc
cleanall:: ; $(RMF) test02

######

all:: test03
test03:: test03_1
test03_1: test03_1.dats ; \
  $(PATSCC) -cleanaft \
    -IIATS $(PATSHOMERELOCQ)/contrib \
    -DATS_MEMALLOC_GCBDW -o $@ $< testlib.dats -lhiredis -lgc
cleanall:: ; $(RMF) test03_1
test03:: test03_2
test03_2: test03_2.dats ; \
  $(PATSCC) -cleanaft \
    -IIATS $(PATSHOMERELOCQ)/contrib \
    -DATS_MEMALLOC_GCBDW -o $@ $< testlib.dats -lhiredis -lgc
cleanall:: ; $(RMF) test03_2

######

all:: fact
fact: fact.dats ; \
  $(PATSCC) -cleanaft \
    -IIATS $(PATSHOMERELOCQ)/contrib \
    -DATS_MEMALLOC_GCBDW -o $@ $< testlib.dats -lhiredis -lgc
cleanall:: ; $(RMF) fact

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
