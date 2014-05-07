#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
ATSPKGRELOC=$(PATSHOMEQ)/bin/atspkgreloc_curl

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2
ATSCCFLAGS=-D_GNU_SOURCE -DATS_MEMALLOC_LIBC

######

all:: pkgreloc
regress:: pkgreloc

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

pkgreloc:: ; $(PATSOPT) --pkgreloc -d listfuns.dats | $(ATSPKGRELOC)
pkgreloc:: ; $(PATSOPT) --pkgreloc -d mergesort.dats | $(ATSPKGRELOC)

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
cleanall:: ; $(RMRF) .ATSPKGRELOCROOT

######

###### end of [Makefile] ######
