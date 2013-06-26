#
# A simple Makefile
#

######

CCOPT=gcc -std=c99
PATSOPT=$(PATSHOME)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2
ATSCCFLAGS=

######

all:: misc
all:: intexp

######

misc: misc_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

intexp: intexp_dats.c ; \
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
cleanall:: ; $(RMF) intexp

######

###### end of [Makefile] ######
