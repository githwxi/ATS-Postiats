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

LNS=ln -s
RMF=rm -f

######

all:: program-1-3
program-1-3: program-1-3.exe
program-1-3.exe: program-1-3_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
program-1-3_dats.c: program-1-3.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-3_dats.c --dynamic program-1-3.dats
clean:: ; $(RMF) program-1-3_dats.o
clean:: ; $(RMF) program-1-3_dats.c
cleanall:: ; $(RMF) program-1-3.exe

all:: program-1-5
program-1-5: program-1-5.exe
program-1-5.exe: program-1-5_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
program-1-5_dats.c: program-1-5.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-5_dats.c --dynamic program-1-5.dats
clean:: ; $(RMF) program-1-5_dats.o
clean:: ; $(RMF) program-1-5_dats.c
cleanall:: ; $(RMF) program-1-5.exe

all:: program-1-6
program-1-6: program-1-6.exe
program-1-6.exe: program-1-6_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
program-1-6_dats.c: program-1-6.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-6_dats.c --dynamic program-1-6.dats
clean:: ; $(RMF) program-1-6_dats.o
clean:: ; $(RMF) program-1-6_dats.c
cleanall:: ; $(RMF) program-1-6.exe

all:: program-1-14
program-1-14: program-1-14.exe
program-1-14.exe: program-1-14_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
program-1-14_dats.c: program-1-14.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-14_dats.c --dynamic program-1-14.dats
clean:: ; $(RMF) program-1-14_dats.o
clean:: ; $(RMF) program-1-14_dats.c
cleanall:: ; $(RMF) program-1-14.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
