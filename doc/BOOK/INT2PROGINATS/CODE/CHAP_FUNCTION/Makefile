#
# A simple Makefile
#

######

CC=gcc -std=c99
PATSOPT=$(PATSHOME)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2
ATSCCFLAGS=

######

all:: misc
all:: bsearch
all:: coinchange
all:: queens

######

misc: misc_dats.c ; \
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

bsearch: bsearch_dats.c ; \
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

coinchange: coinchange_dats.c ; \
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

queens: queens_dats.c ; \
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

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
cleanall:: ; $(RMF) bsearch
cleanall:: ; $(RMF) coinchange
cleanall:: ; $(RMF) queens

######

###### end of [Makefile] ######
