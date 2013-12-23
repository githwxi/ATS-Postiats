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

LDFLAGS :=
LDFLAGS += -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS +=  $(shell pkg-config --libs json-c)

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOPT)" $(DATSMEMALLOC) $(CFLAGS)

######

UTFPLsrc_sta := \
  utfpl.sats \

UTFPLsrc_dyn := \
  utfpl_stamp.dats \
  utfpl_symbol.dats \
  utfpl_location.dats \
  utfpl_label.dats \
  utfpl_d2cst.dats \
  utfpl_d2var.dats \
  utfpl_d2sym.dats \
  utfpl_p2at.dats \
  utfpl_d2exp.dats \
  utfpl_d2ecl.dats \

UTFPLsrc := \
  $(UTFPLsrc_sta) \
  $(UTFPLsrc_dyn) \

######

UTFPLobj := $(UTFPLsrc)
UTFPLobj := $(patsubst %.sats, %_sats.o, $(UTFPLobj))
UTFPLobj := $(patsubst %.dats, %_dats.o, $(UTFPLobj))

######

all:: UTFPLeval

######
#
utfpl.o: $(UTFPLobj) ; ld -r -o $@ $^
#
parsing/parsing.o: ; make -C parsing parsing.o
#
evaluating/evaluating.o: ; make -C evaluating evaluating.o
#
######

UTFPLeval: \
  utfpl.o \
  parsing/parsing.o \
  evaluating/evaluating.o \
  utfpl_mylib_dats.o \
  utfpl_dynloadall_dats.o \
  utfpl_eval_dats.o ; $(PATSCC2) -o $@ $^ $(LDFLAGS)

######

%_sats.o: %.sats ; $(PATSCC) -c $<
%_dats.o: %.dats ; $(PATSCC2) -c $<

######
#
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

-include .depend

######

depend:: ; $(RMF) .depend
depend:: ; $(PATSOPT) --output-a .depend --depgen -
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(UTFPLsrc_sta)
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(UTFPLsrc_dyn)
depend:: ; $(PATSOPT) --output-a .depend --depgen -s utfpl_eval.sats
depend:: ; $(PATSOPT) --output-a .depend --depgen -d utfpl_eval.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) utfpl.o
cleanall:: ; $(RMF) UTFPLeval
cleanall:: ; make -C parsing cleanall
cleanall:: ; make -C evaluating cleanall
cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######
