#
# A Simple Makefile
#

######

CC=gcc -std=c99
#CC=clang -std=c99
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

all:: test

######

test: \
  test_dats.c \
  calculator_dats.c ; \
  $(CC) -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -D_XOPEN_SOURCE -DATS_MEMALLOC_GCBDW -O2 -o $@ $^ -lgc

######

test_dats.c: \
  test.dats; $(PATSOPT) --output $@ --dynamic $<

######

calculator_dats.c: \
  calculator.dats; $(PATSOPT) --output $@ --dynamic $<

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
