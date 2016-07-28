#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

PATSCC2=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2
PATSCC3=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_USER -O2

######

MYTEXTING=./../MYTEXT/bin/mytexting

######

all:: main.html
main.html: main.atxt ; $(MYTEXTING) -o $@ -i $<

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/linear-streams/

######

Fibonacci: Fibonacci.dats; $(PATSCC2) -o $@ $<
Fibonacci_vt: Fibonacci_vt.dats; $(PATSCC3) -o $@ $<

######

QueensPuzzle: QueensPuzzle.dats; $(PATSCC2) -o $@ $<
QueensPuzzle_vt: QueensPuzzle_vt.dats; $(PATSCC3) -o $@ $<

######

regress:: Fibonacci; ./$<
regress:: Fibonacci_vt; ./$<

######

regress:: QueensPuzzle; ./$<
regress:: QueensPuzzle_vt; valgrind ./$<

######

testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) Fibonacci
cleanall:: ; $(RMF) Fibonacci_vt
cleanall:: ; $(RMF) QueensPuzzle
cleanall:: ; $(RMF) QueensPuzzle_vt

######

###### end of [Makefile] ######
