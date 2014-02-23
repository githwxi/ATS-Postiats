#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE

######

all::

######

LNS=ln -s
RMF=rm -f

######
#
all:: ; make -C program-1-2
#
all:: program-1-3
program-1-3: program-1-3.exe
program-1-3.exe: program-1-3_dats.c ;   $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
program-1-3_dats.c: program-1-3.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-3_dats.c --dynamic program-1-3.dats
clean:: ; $(RMF) program-1-3_dats.o
clean:: ; $(RMF) program-1-3_dats.c
cleanall:: ; $(RMF) program-1-3.exe

all:: program-1-4
program-1-4: program-1-4.exe
program-1-4.exe: program-1-4_dats.c ;   $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
program-1-4_dats.c: program-1-4.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-4_dats.c --dynamic program-1-4.dats
clean:: ; $(RMF) program-1-4_dats.o
clean:: ; $(RMF) program-1-4_dats.c
cleanall:: ; $(RMF) program-1-4.exe

all:: program-1-5
program-1-5: program-1-5.exe
program-1-5.exe: program-1-5_dats.c ;   $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
program-1-5_dats.c: program-1-5.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-5_dats.c --dynamic program-1-5.dats
clean:: ; $(RMF) program-1-5_dats.o
clean:: ; $(RMF) program-1-5_dats.c
cleanall:: ; $(RMF) program-1-5.exe

all:: program-1-6
program-1-6: program-1-6.exe
program-1-6.exe: program-1-6_dats.c ;   $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
program-1-6_dats.c: program-1-6.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-6_dats.c --dynamic program-1-6.dats
clean:: ; $(RMF) program-1-6_dats.o
clean:: ; $(RMF) program-1-6_dats.c
cleanall:: ; $(RMF) program-1-6.exe

all:: program-1-7
program-1-7: program-1-7.exe
program-1-7.exe: program-1-7_dats.c ;   $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
program-1-7_dats.c: program-1-7.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-7_dats.c --dynamic program-1-7.dats
clean:: ; $(RMF) program-1-7_dats.o
clean:: ; $(RMF) program-1-7_dats.c
cleanall:: ; $(RMF) program-1-7.exe

all:: program-1-14
program-1-14: program-1-14.exe
program-1-14.exe: program-1-14_dats.c ;   $(CCOPT) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
program-1-14_dats.c: program-1-14.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output program-1-14_dats.c --dynamic program-1-14.dats
clean:: ; $(RMF) program-1-14_dats.o
clean:: ; $(RMF) program-1-14_dats.c
cleanall:: ; $(RMF) program-1-14.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

######

cleanall:: clean
cleanall:: ; make -C program-1-2 cleanall

###### end of [Makefile] ######
