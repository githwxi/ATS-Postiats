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

distclean:: cleanall

######

all:: misc
misc: misc_dats.c; \
$(PATSCC) -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -o $@ $<
regress:: misc; ./misc
cleanall:: ; $(RMF) misc

######

all:: fact
fact: fact_dats.c fact2.c ; $(PATSCC) $(ATSCCFLAGS) -o $@ $^
regress:: fact; ./fact
cleanall:: ; $(RMF) fact

######

all:: factext
factext: factext_dats.c ; $(PATSCC) $(ATSCCFLAGS) -o $@ $^
regress:: factext; ./factext
cleanall:: ; $(RMF) factext

######

all:: extfcall
extfcall: extfcall_dats.c ; $(PATSCC) $(ATSCCFLAGS) -o $@ $^
regress:: extfcall; ./extfcall
cleanall:: ; $(RMF) extfcall

######

all:: strcmp
strcmp: strcmp_dats.c ; $(PATSCC) $(ATSCCFLAGS) -o $@ $^
regress:: strcmp; ./strcmp
cleanall:: ; $(RMF) strcmp

######

all:: ArrayCopyFromList
ArrayCopyFromList: ArrayCopyFromList_dats.c ; $(PATSCC) $(ATSCCFLAGS) -o $@ $^
regress:: ArrayCopyFromList; ./ArrayCopyFromList
cleanall:: ; $(RMF) ArrayCopyFromList

######

all:: StaticAllocList
StaticAllocList: StaticAllocList_dats.c ; $(PATSCC) $(ATSCCFLAGS) -o $@ $^
regress:: StaticAllocList; ./StaticAllocList
cleanall:: ; $(RMF) StaticAllocList

######

%_dats.c: %.dats; $(PATSCC) -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -ccats $< || touch $@

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
