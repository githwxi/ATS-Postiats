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

all:: qa-list-32
qa-list-32: qa-list-32.exe
qa-list-32.exe: qa-list-32_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
qa-list-32_dats.c: qa-list-32.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output qa-list-32_dats.c --dynamic qa-list-32.dats
clean:: ; $(RMF) qa-list-32_dats.o
clean:: ; $(RMF) qa-list-32_dats.c
cleanall:: ; $(RMF) qa-list-32.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
