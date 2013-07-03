#
# A simple Makefile
#

######

CCOPT=\
gcc -std=c99 -D_XOPEN_SOURCE
PATSOPT=$(PATSHOME)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2

######

ATSCCFLAGS=

######

all:: misc
all:: acker
all:: bsearch
all:: coinchange
all:: queens
all:: twice

######

misc: misc_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

acker: acker_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

bsearch: bsearch_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

coinchange: coinchange_dats.c ; \
  $(CCOPT) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

queens: queens_dats.c ; \
  $(CCOPT) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

twice: twice_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

######

%_dats.c: %.dats ; \
  $(PATSOPT) $(ATSCCFLAGS) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) misc
cleanall:: ; $(RMF) acker
cleanall:: ; $(RMF) bsearch
cleanall:: ; $(RMF) coinchange
cleanall:: ; $(RMF) queens
cleanall:: ; $(RMF) twice

######

###### end of [Makefile] ######
