#
# A Simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

CFLAGS :=
CFLAGS += -IIATS $(PATSHOMEQ)
CFLAGS += -IIATS $(PATSHOMEQ)/ccomp/runtime
CFLAGS += -IIATS $(PATSHOMERELOCQ)/contrib
CFLAGS +=  $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lm
LDFLAGS += -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS +=  $(shell pkg-config --libs json-c)

######

MALLOCFLAG=-DATS_MEMALLOC_GCBDW

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOPT)" $(MALLOCFLAG) $(CFLAGS)

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

all:: UTFPLEVAL

######
#
utfpl.o: $(UTFPLobj) ; ld -r -o $@ $^
#
parsing/parsing.o: ; make -C parsing parsing.o
#
evaluating/evaluating.o: ; make -C evaluating evaluating.o
#
######

UTFPLEVAL:: ; make -C parsing
UTFPLEVAL:: ; make -C evaluating
UTFPLEVAL:: \
  utfpl.o \
  parsing/parsing.o \
  evaluating/evaluating.o \
  utfpl_dynloadall_dats.o \
  utfpleval_dats.o \
  utfpleval_symenv_dats.o \
  utfpleval_mylib_dats.o ; \
  $(PATSCC2) -o utfpleval $^ $(LDFLAGS)

######

%_sats.o: %.sats ; $(PATSCC) -c $<
%_dats.o: %.dats ; $(PATSCC2) -c $<

######

-include .depend

######

depend:: ; $(RMF) .depend
depend:: ; $(PATSOPT) --output-a .depend --depgen -
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(UTFPLsrc_sta)
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(UTFPLsrc_dyn)
depend:: ; $(PATSOPT) --output-a .depend --depgen -s utfpleval.sats
depend:: ; $(PATSOPT) --output-a .depend --depgen -d utfpleval_symenv.dats
depend:: ; $(PATSOPT) --output-a .depend --depgen -d utfpleval.dats

######

cleanall:: ; $(RMF) utfpl.o
cleanall:: ; $(RMF) utfpleval
cleanall:: ; make -C parsing cleanall
cleanall:: ; make -C evaluating cleanall
cleanall:: ; make -C TEST cleanall

######

###### end of [Makefile] ######
