#
# A simple Makefile
#

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

ifeq ("$(PATSHOMERELOC)","")
  PATSHOMERELOCQ="$(ATSHOMERELOC)"
else
  PATSHOMERELOCQ="$(PATSHOMERELOC)"
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

PATSCC2=\
  $(PATSCC) \
  -atsccomp "$(CCOPT)" \
  -IIATS $(PATSHOME) -IIATS $(PATSHOME)/ccomp/runtime

######

all:: constraint.o

######

constraint.o: \
  constraint_sats.o \
  constraint_stamp_dats.o \
  constraint_symbol_dats.o \
  constraint_location_dats.o \
  constraint_s2rt_dats.o \
  constraint_s2cst_dats.o \
  constraint_s2var_dats.o \
  constraint_s2Var_dats.o \
  constraint_s2exp_dats.o \
  constraint_s3itm_dats.o \
  constraint_h3ypo_dats.o \
  constraint_c3nstr_dats.o \
  dynloadall_dats.o ; ld -r -o $@ $^

######

%_sats.o: %.sats ; $(PATSCC) -c $<

%_dats.o: %_dats.c ; $(PATSCC2) $(DATSMEMALLOC) -c $<
%_dats.c: %.dats constraint.sats ; $(PATSCC2) -ccats $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) constraint.o

###### end of [Makefile] ######
