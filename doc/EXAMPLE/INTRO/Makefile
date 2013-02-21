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
fact1_dats.c: fact1.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fact1_dats.c --dynamic fact1.dats
clean:: ; $(RMF) fact1_dats.o
clean:: ; $(RMF) fact1_dats.c
cleanall:: ; $(RMF) fact1.exe

all:: fact2
fact2: fact2.exe
fact2.exe: fact2_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fact2_dats.c: fact2.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fact2_dats.c --dynamic fact2.dats
clean:: ; $(RMF) fact2_dats.o
clean:: ; $(RMF) fact2_dats.c
cleanall:: ; $(RMF) fact2.exe

all:: fact3
fact3: fact3.exe
fact3.exe: fact3_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fact3_dats.c: fact3.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fact3_dats.c --dynamic fact3.dats
clean:: ; $(RMF) fact3_dats.o
clean:: ; $(RMF) fact3_dats.c
cleanall:: ; $(RMF) fact3.exe

all:: fibmem
fibmem: fibmem.exe
fibmem.exe: fibmem_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fibmem_dats.c: fibmem.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fibmem_dats.c --dynamic fibmem.dats
clean:: ; $(RMF) fibmem_dats.o
clean:: ; $(RMF) fibmem_dats.c
cleanall:: ; $(RMF) fibmem.exe

all:: fcopy
fcopy: fcopy.exe
fcopy.exe: fcopy_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fcopy_dats.c: fcopy.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fcopy_dats.c --dynamic fcopy.dats
clean:: ; $(RMF) fcopy_dats.o
clean:: ; $(RMF) fcopy_dats.c
cleanall:: ; $(RMF) fcopy.exe

all:: mutailrec
mutailrec: mutailrec.exe
mutailrec.exe: mutailrec_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
mutailrec_dats.c: mutailrec.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output mutailrec_dats.c --dynamic mutailrec.dats
clean:: ; $(RMF) mutailrec_dats.o
clean:: ; $(RMF) mutailrec_dats.c
cleanall:: ; $(RMF) mutailrec.exe

all:: revarr
revarr: revarr.exe
revarr.exe: revarr_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
revarr_dats.c: revarr.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output revarr_dats.c --dynamic revarr.dats
clean:: ; $(RMF) revarr_dats.o
clean:: ; $(RMF) revarr_dats.c
cleanall:: ; $(RMF) revarr.exe


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
