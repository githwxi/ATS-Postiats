#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CCOPT=emcc -std=c99
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: fact
fact: fact.js
fact.js: fact_dats.c ;   $(CCOPT) --pre-js pre.js --js-library $(PATSHOMEQ)/contrib/HTML/JS/HTMLdocument.js     -D_GNU_SOURCE -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -I $(PATSHOMEQ)/contrib -I ./gmp/include -o $@ $< ./gmp/lib/libgmp.a
fact_dats.c: fact.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fact_dats.c --dynamic fact.dats
clean:: ; $(RMF) fact_dats.o
clean:: ; $(RMF) fact_dats.c
cleanall:: ; $(RMF) fact fact.js


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) *.map
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
