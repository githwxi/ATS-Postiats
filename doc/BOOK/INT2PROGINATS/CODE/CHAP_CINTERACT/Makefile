##
##
## A simple Makefile for compiling ATS programs
##
##

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

ATSCCFLAGS=-O2

######

all:: misc
all:: fact
all:: factext
all:: extfcall
all:: strcmp
all:: ArrayCopyFromList
all:: StaticAllocList

######

distclean:: cleanall

######

misc: misc_dats.c; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(ATSCCFAGS) -o $@ $<
cleanall:: ; $(RMF) misc

######

fact: fact_dats.c fact2.c ; $(PATSCC) $(ATSCCFAGS) -o $@ $^
cleanall:: ; $(RMF) fact

######

factext: factext_dats.c ; $(PATSCC) $(ATSCCFAGS) -o $@ $^
cleanall:: ; $(RMF) factext

######

extfcall: extfcall_dats.c ; $(PATSCC) $(ATSCCFAGS) -o $@ $^
cleanall:: ; $(RMF) extfcall

######

strcmp: strcmp_dats.c ; $(PATSCC) $(ATSCCFAGS) -o $@ $^
cleanall:: ; $(RMF) strcmp

######

ArrayCopyFromList: ArrayCopyFromList_dats.c ; $(PATSCC) $(ATSCCFAGS) -o $@ $^
cleanall:: ; $(RMF) ArrayCopyFromList

######

StaticAllocList: StaticAllocList_dats.c ; $(PATSCC) $(ATSCCFAGS) -o $@ $^
cleanall:: ; $(RMF) StaticAllocList

######

%_dats.c: %.dats
	$(PATSCC) -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -ccats $< || touch $@

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
