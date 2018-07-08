#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=${PATSHOMEQ}/bin/patscc

######

all::

######
#
all:: \
test00
test00: \
test00.dats ; \
$(PATSCC) -cleanaft -I./../.. -o $@ $< -lhiredis
#
cleanall:: ; $(RMF) test00
#
######
#
all:: \
test01
test01: \
test01.dats ; \
$(PATSCC) -cleanaft -I./../.. -DATS_MEMALLOC_LIBC -o $@ $< -lhiredis
#
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: \
test02.dats ; \
$(PATSCC) -cleanaft -I./../.. -DATS_MEMALLOC_LIBC -o $@ $< -lhiredis
#
cleanall:: ; $(RMF) test02
#
######
#
all:: \
test03
test03:: \
test03_1
test03_1: \
test03_1.dats ; \
$(PATSCC) -cleanaft -I./../.. -DATS_MEMALLOC_LIBC -o $@ $< -lhiredis
#
cleanall:: ; $(RMF) test03_1
#
test03:: \
test03_2
test03_2: \
test03_2.dats ; \
$(PATSCC) -cleanaft -I./../.. -DATS_MEMALLOC_LIBC -o $@ $< -lhiredis
#
cleanall:: ; $(RMF) test03_2
#
######
#
all:: fact
fact: fact.dats ; \
$(PATSCC) -cleanaft -I./../.. -DATS_MEMALLOC_GCBDW -o $@ $< -lhiredis -lgc
#
cleanall:: ; $(RMF) fact
#
######

RMF=rm -f

######

testall:: all
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
