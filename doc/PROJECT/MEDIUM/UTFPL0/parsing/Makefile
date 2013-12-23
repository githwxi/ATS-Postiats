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

######

CFLAGS :=
CFLAGS += -IIATS $(PATSHOMEQ)
CFLAGS += -IIATS $(PATSHOMEQ)/ccomp/runtime
CFLAGS += -IIATS $(PATSHOMERELOCQ)/contrib
CFLAGS +=  $(shell pkg-config --cflags json-c)

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOPT)" $(DATSMEMALLOC) $(CFLAGS)

######

all:: parsing.o

######

parsing.o: \
  parsing_sats.o \
  parsing_dats.o \
  parsing_d2cst_dats.o \
  parsing_d2var_dats.o \
  parsing_d2sym_dats.o \
  parsing_p2at_dats.o \
  parsing_d2exp_dats.o \
  parsing_d2ecl_dats.o \
  dynloadall_dats.o ; ld -r -o $@ $^

######

%_sats.o: %.sats ; $(PATSCC) $(CFLAGS) -c $<
%_dats.o: %.dats ; $(PATSCC2) $(CFLAGS) -c $<

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

######

cleanall:: clean
cleanall:: ; $(RMF) parsing.o

######

###### end of [Makefile] ######
