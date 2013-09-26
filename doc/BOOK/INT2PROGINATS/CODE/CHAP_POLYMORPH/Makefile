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

######

misc: misc_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

######

listfuns: listfuns_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

######

mergesort: mergesort_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

######

%_dats.c: %.dats ; $(PATSOPT) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) misc
cleanall:: ; $(RMF) listfuns
cleanall:: ; $(RMF) mergesort

######

###### end of [Makefile] ######
