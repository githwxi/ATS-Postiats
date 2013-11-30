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

all:: utfpl.o

######

utfpl.o: \
  utfpl_sats.o \
  utfpl_stamp_dats.o \
  utfpl_symbol_dats.o \
  utfpl_location_dats.o \
  utfpl_d2cst_dats.o \
  utfpl_d2var_dats.o \
  utfpl_d2sym_dats.o \
  utfpl_p2at_dats.o \
  utfpl_d2exp_dats.o \
  utfpl_d2ecl_dats.o \
  dynloadall_dats.o ; \
  ld -r -o $@ $^

######

%_sats.o: %.sats ; $(PATSCC) -c $<

%_dats.c: \
  %.dats utfpl.sats ; $(PATSCC) -ccats $<
%_dats.o: %_dats.c; $(PATSCC) $(DATSMEMALLOC) -c $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) utfpl.o

######

###### end of [Makefile] ######
