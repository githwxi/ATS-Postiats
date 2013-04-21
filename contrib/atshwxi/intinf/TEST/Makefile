#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CCOPT=gcc -std=c99
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: test1
test1: test1.exe
test1.exe: test1_dats.c ; $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOME)/contrib   -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
test1_dats.c: test1.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output test1_dats.c --dynamic test1.dats
clean:: ; $(RMF) test1_dats.o
clean:: ; $(RMF) test1_dats.c
cleanall:: ; $(RMF) test1.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
