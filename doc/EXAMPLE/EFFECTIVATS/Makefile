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

all:: fcopy-1
fcopy-1: fcopy-1.exe
fcopy-1.exe: fcopy-1_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
fcopy-1_dats.c: fcopy-1.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fcopy-1_dats.c --dynamic fcopy-1.dats
clean:: ; $(RMF) fcopy-1_dats.o
clean:: ; $(RMF) fcopy-1_dats.c
cleanall:: ; $(RMF) fcopy-1.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
