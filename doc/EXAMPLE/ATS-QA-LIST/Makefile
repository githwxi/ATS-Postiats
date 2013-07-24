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
PATSOPT=$(PATSHOMEQ)/bin/patsopt
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

all:: qa-list-35
qa-list-35: qa-list-35.exe
qa-list-35.exe: qa-list-35_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
qa-list-35_dats.c: qa-list-35.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output qa-list-35_dats.c --dynamic qa-list-35.dats
clean:: ; $(RMF) qa-list-35_dats.o
clean:: ; $(RMF) qa-list-35_dats.c
cleanall:: ; $(RMF) qa-list-35.exe

all:: for-0install
for-0install: for-0install.exe
for-0install.exe: for-0install_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -I$(PATSHOME)/contrib -o $@ $< -ljson-c
for-0install_dats.c: for-0install.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output for-0install_dats.c --dynamic for-0install.dats
clean:: ; $(RMF) for-0install_dats.o
clean:: ; $(RMF) for-0install_dats.c
cleanall:: ; $(RMF) for-0install.exe

all:: qa-list-43
qa-list-43: qa-list-43.exe
qa-list-43.exe: qa-list-43_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
qa-list-43_dats.c: qa-list-43.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output qa-list-43_dats.c --dynamic qa-list-43.dats
clean:: ; $(RMF) qa-list-43_dats.o
clean:: ; $(RMF) qa-list-43_dats.c
cleanall:: ; $(RMF) qa-list-43.exe

all:: qa-list-45
qa-list-45: qa-list-45.exe
qa-list-45.exe: qa-list-45_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
qa-list-45_dats.c: qa-list-45.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output qa-list-45_dats.c --dynamic qa-list-45.dats
clean:: ; $(RMF) qa-list-45_dats.o
clean:: ; $(RMF) qa-list-45_dats.c
cleanall:: ; $(RMF) qa-list-45.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
