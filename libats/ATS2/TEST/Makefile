######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
MYATSCC=$(PATSHOME)/bin/myatscc

######

all:: \
test01
test01: \
test01.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: test01; ./$<
cleanall:: ; rm -f test01

######

all:: \
test02
test02: \
test02.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: test02; ./$<
cleanall:: ; rm -f test02

######

all:: \
test03
test03: \
test03.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: test03; ./$<
cleanall:: ; rm -f test03

######

all:: \
isPrime
isPrime: \
isPrime.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -lm
regress:: isPrime; ./$<
cleanall:: ; rm -f isPrime

######

all:: \
QueenPuzzle
QueenPuzzle: \
QueenPuzzle.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -lm
regress:: QueenPuzzle; ./$<
cleanall:: ; rm -f QueenPuzzle

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
