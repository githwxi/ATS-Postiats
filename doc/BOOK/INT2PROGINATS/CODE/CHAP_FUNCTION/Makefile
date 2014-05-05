#
# A simple Makefile
#

######

CC=gcc
CCOPT=$(CC) -std=c99 -D_XOPEN_SOURCE

######

PATSCCT=$(PATSHOME)/bin/patscc
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
regress:: misc; ./misc
cleanall:: ; $(RMF) misc

acker: acker_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: acker; ./acker
cleanall:: ; $(RMF) acker

bsearch: bsearch_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: bsearch; ./bsearch
cleanall:: ; $(RMF) bsearch

coinchange: coinchange_dats.c ; \
  $(CCOPT) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: coinchange; ./coinchange
cleanall:: ; $(RMF) coinchange

queens: queens_dats.c ; \
  $(CCOPT) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: queens; ./queens
cleanall:: ; $(RMF) queens

twice: twice_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: twice; ./twice
cleanall:: ; $(RMF) twice

######

%_dats.c: %.dats ; \
  $(PATSOPT) $(ATSCCFLAGS) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
