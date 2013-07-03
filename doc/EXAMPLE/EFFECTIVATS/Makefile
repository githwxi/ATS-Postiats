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

all:: fcopy3
fcopy3: fcopy3.exe
fcopy3.exe: fcopy3_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
fcopy3_dats.c: fcopy3.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fcopy3_dats.c --dynamic fcopy3.dats
clean:: ; $(RMF) fcopy3_dats.o
clean:: ; $(RMF) fcopy3_dats.c
cleanall:: ; $(RMF) fcopy3.exe


######

all:: queue-sllist2
queue-sllist2: queue-sllist2.exe
queue-sllist2.exe: queue-sllist2_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
queue-sllist2_dats.c: queue-sllist2.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output queue-sllist2_dats.c --dynamic queue-sllist2.dats
clean:: ; $(RMF) queue-sllist2_dats.o
clean:: ; $(RMF) queue-sllist2_dats.c
cleanall:: ; $(RMF) queue-sllist2.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
