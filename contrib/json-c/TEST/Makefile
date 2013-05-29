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

CCOPT=gcc
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

ATSGCFLAG=-D_ATS_GCATS

######

JSON=/usr/include/json

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: test01
test01: test01.exe
test01.exe: test01_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOMEQ)/contrib   -I$(JSON)   -DATS_MEMALLOC_LIBC -DATS_MEMALLOC_LIBC -o $@ $< -ljson
test01_dats.c: test01.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output test01_dats.c --dynamic test01.dats
clean:: ; $(RMF) test01_dats.o
clean:: ; $(RMF) test01_dats.c
cleanall:: ; $(RMF) test01.exe

all:: test02
test02: test02.exe
test02.exe: test02_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOMEQ)/contrib   -I$(JSON)   -DATS_MEMALLOC_LIBC -DATS_MEMALLOC_LIBC -o $@ $< -ljson
test02_dats.c: test02.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output test02_dats.c --dynamic test02.dats
clean:: ; $(RMF) test02_dats.o
clean:: ; $(RMF) test02_dats.c
cleanall:: ; $(RMF) test02.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean
cleanall:: ; $(RMF) *.png

###### end of [Makefile] ######
