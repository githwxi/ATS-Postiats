#
# A simple Makefile
#

######

CCOPT=gcc

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

GameOf24: \
  GameOf24.o GameOf24_dats.o mylib_dats.o ; $(CCOPT) -o $@ $^

######

GameOf24.o: GameOf24.m ; $(PATSCC) -x objective-c -c -o $@ $<
GameOf24_dats.o: GameOf24.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -c $<

######

mylib_dats.o: mylib.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -c $<

######

RMF=rm -f

######

clean::; $(RMF) *~
clean::; $(RMF) GameOf24.o
clean::; $(RMF) GameOf24_dats.o
clean::; $(RMF) GameOf24_dats.c
clean::; $(RMF) mylib_dats.o
clean::; $(RMF) mylib_dats.c

cleanall:: clean
cleanall::; $(RMF) GameOf24

######

###### end of [Makefile] ######
