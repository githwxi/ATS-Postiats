#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2
ATSCCFLAGS=-D_GNU_SOURCE -DATS_MEMALLOC_LIBC

######

all:: misc
all:: listfuns
all:: mergesort

######

misc: misc_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: misc; ./misc
cleanall:: ; $(RMF) misc

######

listfuns: listfuns_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: listfuns; ./listfuns
cleanall:: ; $(RMF) listfuns

######

mergesort: mergesort_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: mergesort; ./mergesort
cleanall:: ; $(RMF) mergesort

######

%_dats.c: %.dats ; $(PATSOPT) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f
RMRF=rm -rf

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
