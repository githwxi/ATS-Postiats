######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib
#
######
#
CXXFLAGS = $(MYCFLAGS)
#
######
#
MYCFLAGS := -fpermissive -w
#
MYCFLAGS += -DATS_MEMALLOC_GCBDW
#
MYCFLAGS += -D_ATS_CCOMP_PRELUDE_NONE_
#
MYCFLAGS += -D_ATS_CCOMP_EXCEPTION_NONE_
MYCFLAGS += -D_ATS_CCOMP_RUNTIME_TRYWITH_NONE_
#
MYCFLAGS += -D_ATS_CCOMP_PRELUDE_USER_='"pats_ats2cpp_prelude.h"'
#
# MYCFLAGS += -D_ATSTYPE_VAR_SIZE_=1024
#
MYCFLAGS += -I${PATSHOME}/contrib/ats2cpp
MYCFLAGS += -I${PATSHOME}/contrib/ats2cpp/H
MYCFLAGS += -I${PATSHOME}/contrib/ats2cpp/ccomp
#
######

CC=gcc
CPP=g++

######

all::

######
#
all:: \
QueenPuzzle
QueenPuzzle: \
QueenPuzzle_dats.c; $(CPP) $(CXXFLAGS) -o $@ $< -lgccpp -lgc
QueenPuzzle_dats.c: QueenPuzzle.dats; $(PATSOPT) -o $@ -d $<
#
regress:: \
QueenPuzzle; ./$<
cleanall:: ; rm -f QueenPuzzle
#
######
#
all:: \
GameOf24Play
GameOf24Play: \
GameOf24Play_dats.c; $(CPP) $(CXXFLAGS) -o $@ $< -lgccpp -lgc
GameOf24Play_dats.c: GameOf24Play.dats; $(PATSOPT) -o $@ -d $<
#
regress:: \
GameOf24Play; ./$< 3 3 8 8
cleanall:: ; rm -f GameOf24Play
#
######
#
all:: \
DoubletsPlay
DoubletsPlay: \
DoubletsPlay_dats.c; \
$(CPP) $(CXXFLAGS) -o $@ $< -L$(PATSLIB) -latslib -lgccpp -lgc
DoubletsPlay_dats.c: DoubletsPlay.dats; $(PATSOPT) -o $@ -d $<
#
regress:: \
DoubletsPlay; ./$< clean dirty
cleanall:: ; rm -f DoubletsPlay
#
######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.c
clean:: ; rm -f *_?ats.o

######

cleanall:: clean

###### end of [Makefile] ######
