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
ferryman: ferryman.exe ; $(LNS) ferryman.exe ferryman
ferryman.exe: ferryman_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
ferryman_dats.c: ferryman.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output ferryman_dats.c --dynamic ferryman.dats
clean:: ; $(RMF) ferryman_dats.o
clean:: ; $(RMF) ferryman_dats.c
cleanall:: ; $(RMF) ferryman ferryman.exe

all:: fibver_rec
fibver_rec: fibver_rec.exe ; $(LNS) fibver_rec.exe fibver_rec
fibver_rec.exe: fibver_rec_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fibver_rec_dats.c: fibver_rec.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fibver_rec_dats.c --dynamic fibver_rec.dats
clean:: ; $(RMF) fibver_rec_dats.o
clean:: ; $(RMF) fibver_rec_dats.c
cleanall:: ; $(RMF) fibver_rec fibver_rec.exe

all:: hanoi
hanoi: hanoi.exe ; $(LNS) hanoi.exe hanoi
hanoi.exe: hanoi_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
hanoi_dats.c: hanoi.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output hanoi_dats.c --dynamic hanoi.dats
clean:: ; $(RMF) hanoi_dats.o
clean:: ; $(RMF) hanoi_dats.c
cleanall:: ; $(RMF) hanoi hanoi.exe

all:: isqrt
isqrt: isqrt.exe ; $(LNS) isqrt.exe isqrt
isqrt.exe: isqrt_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
isqrt_dats.c: isqrt.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output isqrt_dats.c --dynamic isqrt.dats
clean:: ; $(RMF) isqrt_dats.o
clean:: ; $(RMF) isqrt_dats.c
cleanall:: ; $(RMF) isqrt isqrt.exe

all:: passwdgen
passwdgen: passwdgen.exe ; $(LNS) passwdgen.exe passwdgen
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
