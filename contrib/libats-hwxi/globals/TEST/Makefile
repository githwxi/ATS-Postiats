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

all:: test01
test01: test01.exe
test01.exe: test01_dats.c intvar_dats.c floatvar_dats.c ; \
  $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -I$(PATSHOME)/contrib -DATS_MEMALLOC_LIBC -o $@ $^ -lgmp
clean:: ; $(RMF) test01_dats.o intvar_dats.o floatvar_dats.o
clean:: ; $(RMF) test01_dats.c intvar_dats.c floatvar_dats.c
cleanall:: ; $(RMF) test01.exe

######

all:: test02
test02: test02.exe
test02.exe: test02_dats.c count1_dats.c count2_dats.c ; \
  $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -I$(PATSHOME)/contrib -DATS_MEMALLOC_LIBC -o $@ $^ -lgmp
clean:: ; $(RMF) test02_dats.o count1_dats.o count2_dats.o
clean:: ; $(RMF) test02_dats.c count1_dats.c count2_dats.c
cleanall:: ; $(RMF) test02.exe

######

%_dats.c: %.dats ; $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output $@ --dynamic $<

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
