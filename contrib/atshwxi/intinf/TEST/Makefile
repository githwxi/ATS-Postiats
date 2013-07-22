#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE

######

PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: test01
test01: test01.exe
test01.exe: test01_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOME)/contrib   -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
test01_dats.c: test01.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output test01_dats.c --dynamic test01.dats
clean:: ; $(RMF) test01_dats.o
clean:: ; $(RMF) test01_dats.c
cleanall:: ; $(RMF) test01.exe

all:: test02
test02: test02.exe
test02.exe: test02_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOME)/contrib   -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
test02_dats.c: test02.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output test02_dats.c --dynamic test02.dats
clean:: ; $(RMF) test02_dats.o
clean:: ; $(RMF) test02_dats.c
cleanall:: ; $(RMF) test02.exe

all:: test03
test03: test03.exe
test03.exe: test03_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOME)/contrib   -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
test03_dats.c: test03.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output test03_dats.c --dynamic test03.dats
clean:: ; $(RMF) test03_dats.o
clean:: ; $(RMF) test03_dats.c
cleanall:: ; $(RMF) test03.exe

all:: test04
test04: test04.exe
test04.exe: test04_dats.c ;   $(CCOPT)   -I$(PATSHOMEQ)   -I$(PATSHOMEQ)/ccomp/runtime   -I$(PATSHOME)/contrib   -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
test04_dats.c: test04.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output test04_dats.c --dynamic test04.dats
clean:: ; $(RMF) test04_dats.o
clean:: ; $(RMF) test04_dats.c
cleanall:: ; $(RMF) test04.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
