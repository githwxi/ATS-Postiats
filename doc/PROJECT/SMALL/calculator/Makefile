#
# A Simple Makefile
#

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=\
$(PATSHOMEQ)/bin/patscc \
  -atsccomp "$(CCOPT)" \
  -IIATS $(PATSHOME) -IIATS $(PATSHOME)/ccomp/runtime
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all:: calc

######

calc: \
  calculator_dats.o \
  calculator_print_dats.o \
  calculator_token_dats.o \
  calculator_cstream_dats.o \
  calculator_tstream_dats.o \
  calculator_parsing_dats.o ; \
  $(CCOPT) \
    -I${PATSHOME} \
    -I${PATSHOME}/ccomp/runtime \
    -L${PATSHOME}/ccomp/atslib/lib \
    -O2 -o $@ $^ $(LGC) -latslib

######

calculator_dats.o: \
  calculator.dats; $(PATSCC) $(DATSMEMALLOC) -c $<
calculator_print_dats.o: \
  calculator_print.dats; $(PATSCC) $(DATSMEMALLOC) -c $<
calculator_token_dats.o: \
  calculator_token.dats; $(PATSCC) $(DATSMEMALLOC) -c $<
calculator_cstream_dats.o: \
  calculator_cstream.dats; $(PATSCC) $(DATSMEMALLOC) -c $<
calculator_tstream_dats.o: \
  calculator_tstream.dats; $(PATSCC) $(DATSMEMALLOC) -c $<
calculator_parsing_dats.o: \
  calculator_parsing.dats; $(PATSCC) $(DATSMEMALLOC) -c $<

######
#
#LGC=
#DATSMEMALLOC=-DATS_MEMALLOC_LIBC
#
LGC=-lgc
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) calc

######

###### end of [Makefile] ######
