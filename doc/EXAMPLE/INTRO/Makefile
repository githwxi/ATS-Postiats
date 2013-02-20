#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

GCC=gcc
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

ATSGCFLAG=-D_ATS_GCATS

######

all::

######

all:: fact1
fact1: fact1.exe
fact1.exe: fact1_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fact1_dats.c: fact1.dats ;   $(PATSOPT) --output fact1_dats.c --dynamic fact1.dats
clean:: ; $(RMF) fact1_dats.o
clean:: ; $(RMF) fact1_dats.c
cleanall:: ; $(RMF) fact1.exe

all:: fact2
fact2: fact2.exe
fact2.exe: fact2_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fact2_dats.c: fact2.dats ;   $(PATSOPT) --output fact2_dats.c --dynamic fact2.dats
clean:: ; $(RMF) fact2_dats.o
clean:: ; $(RMF) fact2_dats.c
cleanall:: ; $(RMF) fact2.exe

all:: fact3
fact3: fact3.exe
fact3.exe: fact3_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fact3_dats.c: fact3.dats ;   $(PATSOPT) --output fact3_dats.c --dynamic fact3.dats
clean:: ; $(RMF) fact3_dats.o
clean:: ; $(RMF) fact3_dats.c
cleanall:: ; $(RMF) fact3.exe

all:: mutailrec
mutailrec: mutailrec.exe
mutailrec.exe: mutailrec_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
mutailrec_dats.c: mutailrec.dats ;   $(PATSOPT) --output mutailrec_dats.c --dynamic mutailrec.dats
clean:: ; $(RMF) mutailrec_dats.o
clean:: ; $(RMF) mutailrec_dats.c
cleanall:: ; $(RMF) mutailrec.exe


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
