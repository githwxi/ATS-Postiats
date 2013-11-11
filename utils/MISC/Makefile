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

all:: linenumbering
linenumbering: linenumbering.exe
linenumbering.exe: linenumbering_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
linenumbering_dats.c: linenumbering.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output linenumbering_dats.c --dynamic linenumbering.dats
clean:: ; $(RMF) linenumbering_dats.o
clean:: ; $(RMF) linenumbering_dats.c
cleanall:: ; $(RMF) linenumbering.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
