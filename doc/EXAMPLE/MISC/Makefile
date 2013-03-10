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

all:: ferryman
ferryman: ferryman.exe
ferryman.exe: ferryman_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
ferryman_dats.c: ferryman.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output ferryman_dats.c --dynamic ferryman.dats
clean:: ; $(RMF) ferryman_dats.o
clean:: ; $(RMF) ferryman_dats.c
cleanall:: ; $(RMF) ferryman ferryman.exe

all:: fibver_trec
fibver_trec: fibver_trec.exe
fibver_trec.exe: fibver_trec_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fibver_trec_dats.c: fibver_trec.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fibver_trec_dats.c --dynamic fibver_trec.dats
clean:: ; $(RMF) fibver_trec_dats.o
clean:: ; $(RMF) fibver_trec_dats.c
cleanall:: ; $(RMF) fibver_trec fibver_trec.exe

all:: hanoi
hanoi: hanoi.exe
hanoi.exe: hanoi_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
hanoi_dats.c: hanoi.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output hanoi_dats.c --dynamic hanoi.dats
clean:: ; $(RMF) hanoi_dats.o
clean:: ; $(RMF) hanoi_dats.c
cleanall:: ; $(RMF) hanoi hanoi.exe

all:: isqrt
isqrt: isqrt.exe
isqrt.exe: isqrt_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
isqrt_dats.c: isqrt.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output isqrt_dats.c --dynamic isqrt.dats
clean:: ; $(RMF) isqrt_dats.o
clean:: ; $(RMF) isqrt_dats.c
cleanall:: ; $(RMF) isqrt isqrt.exe

all:: passwdgen
passwdgen: passwdgen.exe
passwdgen.exe: passwdgen_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
passwdgen_dats.c: passwdgen.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output passwdgen_dats.c --dynamic passwdgen.dats
clean:: ; $(RMF) passwdgen_dats.o
clean:: ; $(RMF) passwdgen_dats.c
cleanall:: ; $(RMF) passwdgen passwdgen.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
