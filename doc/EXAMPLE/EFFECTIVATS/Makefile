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

all:: fcopy1
fcopy1: fcopy1.exe
fcopy1.exe: fcopy1_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime  -o $@ $< 
fcopy1_dats.c: fcopy1.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fcopy1_dats.c --dynamic fcopy1.dats
clean:: ; $(RMF) fcopy1_dats.o
clean:: ; $(RMF) fcopy1_dats.c
cleanall:: ; $(RMF) fcopy1.exe

all:: fcopy2
fcopy2: fcopy2.exe
fcopy2.exe: fcopy2_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
fcopy2_dats.c: fcopy2.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fcopy2_dats.c --dynamic fcopy2.dats
clean:: ; $(RMF) fcopy2_dats.o
clean:: ; $(RMF) fcopy2_dats.c
cleanall:: ; $(RMF) fcopy2.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
