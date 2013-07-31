#
# A Simple Makefile
#

######

CC=gcc -std=c99
#CC=clang -std=c99

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all:: test

######

test: \
  test_dats.c \
  calculator_dats.o \
  calculator_cstream_dats.o \
  calculator_tstream_dats.o ; \
  $(CC) -D_XOPEN_SOURCE \
    -I${PATSHOME} \
    -I${PATSHOME}/ccomp/runtime \
    -L${PATSHOME}/ccomp/atslib/lib \
    -DATS_MEMALLOC_GCBDW \
    -O2 -o $@ $^ -lgc -latslib

######

test_dats.c: \
  test.dats; $(PATSOPT) --output $@ --dynamic $<

######

calculator_dats.o: \
  calculator.dats; $(PATSCC) -DATS_MEMALLOC_GCBDW -c $<
calculator_cstream_dats.o: \
  calculator_cstream.dats; $(PATSCC) -DATS_MEMALLOC_GCBDW -c $<
calculator_tstream_dats.o: \
  calculator_tstream.dats; $(PATSCC) -DATS_MEMALLOC_GCBDW -c $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) test

######

###### end of [Makefile] ######
