#
# A Simple Makefile
#

######

GCC=gcc
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

all:: test

######

test: \
  program-1-2_dats.c \
  program-1-2-test_dats.c ; \
  $(GCC) -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -O2 -o $@ $^

######

program-1-2_dats.c: \
  program-1-2.dats; \
  $(PATSOPT) -IATS${PATSHOME}/contrib --output $@ --dynamic $<
program-1-2-test_dats.c: \
  program-1-2-test.dats; \
  $(PATSOPT) -IATS${PATSHOME}/contrib --output $@ --dynamic $<

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