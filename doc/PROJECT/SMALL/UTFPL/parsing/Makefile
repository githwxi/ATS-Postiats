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

CFLAGS :=
CFLAGS += -I${PATSHOME}
CFLAGS += -I${PATSHOME}/ccomp/runtime
CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lgc
LDFLAGS += -L${PATSHOME}/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS += $(shell pkg-config --libs json-c)

######

all:: UTFPL main

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
  $(CCOPT) $(CFLAGS) -O2 -o $@ $^ ../utfpl.o $(LDFLAGS)

######

UTFPL: ; make -C .. utfpl.o

######

%_sats.o: %.sats ; $(PATSCC) $(CFLAGS) -c $<

%_dats.c: \
  %.dats parsing.sats ; $(PATSCC) -ccats $<
%_dats.o: %_dats.c; $(PATSCC) $(DATSMEMALLOC) $(CFLAGS) -c $<

######
#
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

testdata: \
TEST/test01_dats.json
TEST/test01_dats.json: \
  TEST/test01.dats ; ${PATSOPT} --jsonize-2 -o $@ -d $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) main
cleanall:: ; $(RMF) TEST/test??_dats.json

######

###### end of [Makefile] ######
