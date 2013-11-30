#
# A Simple Makefile
#

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=\
$(PATSHOMEQ)/bin/patscc \
  -atsccomp "$(CCOPT)" \
  -IIATS $(PATSHOME) \
  -IIATS $(PATSHOME)/ccomp/runtime \
  -IIATS $(PATSHOMERELOCQ)/contrib \

PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all:: main

######

main: \
  main_dats.o \
  parsing_sats.o \
  parsing_dats.o \
  parsing_d2cst_dats.o \
  parsing_d2var_dats.o \
  parsing_d2sym_dats.o \
  parsing_p2at_dats.o \
  parsing_d2exp_dats.o \
  parsing_d2ecl_dats.o \
  parsing_mylib_dats.o ; \
  $(CCOPT) \
    -I${PATSHOME} \
    -I${PATSHOME}/ccomp/runtime \
    -L${PATSHOME}/ccomp/atslib/lib \
    -O2 -o $@ ../utfpl.o $^ -latslib $(LGC) $(LJSONC)

######

%_sats.o: %.sats ; $(PATSCC) -c $<

%_dats.c: \
  %.dats parsing.sats ; $(PATSCC) -ccats $<
%_dats.o: %_dats.c; $(PATSCC) $(DATSMEMALLOC) -c $<

######
#
#LGC=
#DATSMEMALLOC=-DATS_MEMALLOC_LIBC
#
LGC=-lgc
LJSONC=-ljson-c
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) main

######

###### end of [Makefile] ######
