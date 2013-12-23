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

all:: evaluating.o

######

evaluating.o: \
  eval_sats.o \
  print_dats.o \
  cloenv_dats.o \
  eval_d2cst_dats.o \
  eval_d2var_dats.o \
  eval_d2sym_dats.o \
  eval_d2exp_dats.o \
  eval_d2ecl_dats.o \
  dynloadall_dats.o ; ld -r -o $@ $^

######

%_sats.o: %.sats ; $(PATSCC) -c $<
%_dats.o: %.dats ; $(PATSCC) -c $<

######
#
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) evaluating.o

######

###### end of [Makefile] ######
