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
  GameOf24.o GameOf24_dats.o ; $(CCOPT) -o $@ $^ -lgnustep-base

######

GameOf24.o: GameOf24.m ; \
  $(PATSCC) -x objective-c \
    -I/usr/include/GNUstep \
    -D_NATIVE_OBJC_EXCEPTIONS \
    -c -o $@ $< -fconstant-string-class=NSConstantString

GameOf24_dats.o: GameOf24.dats; \
  $(PATSCC) -D_GNU_SOURCE -IIATS $(PATSHOME)/contrib -I$(JNIincl) -fPIC -DATS_MEMALLOC_LIBC -c GameOf24.dats

######

RMF=rm -f

######

clean::; $(RMF) *~
clean::; $(RMF) GameOf24.o
clean::; $(RMF) GameOf24_dats.o
clean::; $(RMF) GameOf24_dats.c

cleanall:: clean
cleanall::; $(RMF) GameOf24

######

###### end of [Makefile] ######
