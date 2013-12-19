#
# A Simple Makefile
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

PATSCC2=\
  $(PATSCC) \
  -atsccomp "$(CCOPT)" \
  -IIATS $(PATSHOME) \
  -IIATS $(PATSHOME)/ccomp/runtime \
  -IIATS $(PATSHOMERELOCQ)/contrib \

######

CFLAGS :=
CFLAGS += -I$(PATSHOMEQ)
CFLAGS += -I$(PATSHOMEQ)/ccomp/runtime
CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS += $(shell pkg-config --libs json-c)

######

all:: UTFPL main

######

main: \
  main_dats.o \
  parsing_sats.o \
  parsing_dats.o \
  parsing_s2cst_dats.o \
  parsing_s2var_dats.o \
  parsing_mylib_dats.o ; \
  $(CCOPT) $(CFLAGS) -O2 -o $@ $^ ../constraint.o $(LDFLAGS)

######

UTFPL: ; make -C .. constraint.o

######

%_sats.o: %.sats ; $(PATSCC2) $(CFLAGS) -c $<

%_dats.c: %.dats parsing.sats ; $(PATSCC2) -ccats $<
%_dats.o: %_dats.c ; $(PATSCC2) $(DATSMEMALLOC) $(CFLAGS) -c $<

######
#
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

testdata: \
TEST/test01_dats.cnstr
TEST/test01_dats.cnstr: \
  TEST/test01.dats ; $(PATSOPT) --constraint-export --typecheck -o $@ -d $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) main
cleanall:: ; $(RMF) TEST/test??_dats.cnstr

######

###### end of [Makefile] ######
