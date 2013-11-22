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

all:: main

######

main: \
  main_dats.o \
  eval_subst_dats.o ; \
  $(CCOPT) \
    -I${PATSHOME} \
    -I${PATSHOME}/ccomp/runtime \
    -L${PATSHOME}/ccomp/atslib/lib \
    -O2 -o $@ $^ $(LGC) -latslib

######

%_dats.c: \
  %.dats eval_subst.sats ; $(PATSCC) -ccats $<
%_dats.o: %_dats.c; $(PATSCC) $(DATSMEMALLOC) -c $<

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
cleanall:: ; $(RMF) main

######

###### end of [Makefile] ######
