#
# A simple Makefile
#

######

CC=gcc
CCOPT=$(CC) -std=c99 -D_GNU_SOURCE

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2
ATSCCFLAGS=

######

all:: misc

######

misc: misc_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: misc; ./misc
cleanall:: ; $(RMF) misc

######

%_dats.c: %.dats ; $(PATSOPT) $(ATSCCFLAGS) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

######

###### end of [Makefile] ######
