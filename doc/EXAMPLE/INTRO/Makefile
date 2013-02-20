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


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
