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
    -IIATS $(PATSHOMEQ)/contrib -o $@ $< -lhiredis
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; \
  $(PATSCC) -cleanaft -IIATS $(PATSHOMEQ)/contrib \
    -DATS_MEMALLOC_GCBDW -o $@ $< testlib.dats -lhiredis -lgc
cleanall:: ; $(RMF) test02

######

all:: fact
fact: fact.dats ; \
  $(PATSCC) -cleanaft -IIATS $(PATSHOMEQ)/contrib \
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
