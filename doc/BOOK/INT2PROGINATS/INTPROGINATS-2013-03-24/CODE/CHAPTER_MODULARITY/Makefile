##
##
## A simple Makefile for compiling ATS programs
##
##

######

ATSUSRQ="$(ATSHOME)"
ifeq ($(ATSUSRQ),"")
ATSUSRQ="/usr"
endif # end of [ifeq]

######

ATSCC=$(ATSUSRQ)/bin/atscc
ATSOPT=$(ATSUSRQ)/bin/atsopt

######

ATSCCFLAGS=-O2
ATSGCFLAG=-D_ATS_GCATS

######

all: checkall cleanall

######

checkall:: misc ; ./misc
checkall:: listeq ; ./listeq
checkall:: test_acker ; ./test_acker
checkall:: test_acker2 ; ./test_acker2
checkall:: test_intset ; ./test_intset
checkall:: test_ratmod ; ./test_ratmod
checkall:: test_ratfun_rec ; ./test_ratfun_rec
checkall:: test_ratfun_tmp ; ./test_ratfun_tmp

######

distclean:: cleanall

######

misc: misc.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< -lm || touch $@
cleanall:: ; $(RMF) misc

######

listeq: listeq.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) listeq

######

ACKER_SRC=acker.sats acker.dats test_acker.dats
ACKER_OBJ := $(ACKER_SRC)
ACKER_OBJ := $(patsubst %.sats, %_sats.o, $(ACKER_OBJ))
ACKER_OBJ := $(patsubst %.dats, %_dats.o, $(ACKER_OBJ))

test_acker: $(ACKER_OBJ)
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ || touch $@
cleanall:: ; $(RMF) test_acker

######

ACKER2_SRC=acker.sats acker2.dats test_acker2.dats
ACKER2_OBJ := $(ACKER2_SRC)
ACKER2_OBJ := $(patsubst %.sats, %_sats.o, $(ACKER2_OBJ))
ACKER2_OBJ := $(patsubst %.dats, %_dats.o, $(ACKER2_OBJ))

test_acker2: $(ACKER2_OBJ)
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ || touch $@
cleanall:: ; $(RMF) test_acker2

######

INTSET_SRC=intset.sats intset.dats test_intset.dats
INTSET_OBJ := $(INTSET_SRC)
INTSET_OBJ := $(patsubst %.sats, %_sats.o, $(INTSET_OBJ))
INTSET_OBJ := $(patsubst %.dats, %_dats.o, $(INTSET_OBJ))

test_intset: $(INTSET_OBJ)
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ || touch $@
cleanall:: ; $(RMF) test_intset

######

RATMOD_SRC=\
  ratmod.sats ratmod.dats test_ratmod.dats
RATMOD_OBJ := $(RATMOD_SRC)
RATMOD_OBJ := $(patsubst %.sats, %_sats.o, $(RATMOD_OBJ))
RATMOD_OBJ := $(patsubst %.dats, %_dats.o, $(RATMOD_OBJ))

test_ratmod: $(RATMOD_OBJ)
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ || touch $@
cleanall:: ; $(RMF) test_ratmod

######

RATFUN_REC_SRC=\
  ratfun_rec.sats ratfun_rec.dats test_ratfun_rec.dats
RATFUN_REC_OBJ := $(RATFUN_REC_SRC)
RATFUN_REC_OBJ := $(patsubst %.sats, %_sats.o, $(RATFUN_REC_OBJ))
RATFUN_REC_OBJ := $(patsubst %.dats, %_dats.o, $(RATFUN_REC_OBJ))

test_ratfun_rec: $(RATFUN_REC_OBJ)
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ -lm || touch $@
cleanall:: ; $(RMF) test_ratfun_rec

######

RATFUN_TMP_SRC=\
  ratfun_tmp.sats ratfun_tmp.dats test_ratfun_tmp.dats
RATFUN_TMP_OBJ := $(RATFUN_TMP_SRC)
RATFUN_TMP_OBJ := $(patsubst %.sats, %_sats.o, $(RATFUN_TMP_OBJ))
RATFUN_TMP_OBJ := $(patsubst %.dats, %_dats.o, $(RATFUN_TMP_OBJ))

test_ratfun_tmp: $(RATFUN_TMP_OBJ)
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ -lm || touch $@
cleanall:: ; $(RMF) test_ratfun_tmp

######

%_sats.o: %.sats
	$(ATSCC) $(ATSCCFLAGS) -c $< || touch $@

%_dats.o: %.dats
	$(ATSCC) $(ATSCCFLAGS) -c $< || touch $@

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
