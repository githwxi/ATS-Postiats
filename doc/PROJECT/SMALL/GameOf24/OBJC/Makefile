#
# A simple Makefile
#

######

CCOPT=gcc

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

CFLAGS += -DATS_MEMALLOC_LIBC
CFLAGS += -I${PATSHOME}
CFLAGS += -I${PATSHOME}/ccomp/runtime

######

GameOf24: \
  GameOf24.o GameOf24_dats.c ; $(CCOPT) $(CFLAGS) -o $@ $^

######

GameOf24.o: GameOf24.m ; $(CCOPT) -x objective-c -c -o $@ $<

######

%_dats.c: %.dats ; $(PATSCC) -ccats -o $@ $<

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
