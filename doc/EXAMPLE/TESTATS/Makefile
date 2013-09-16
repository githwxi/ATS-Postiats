#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

all:: clofuns
clofuns: clofuns.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) clofuns

######

all:: conjdisj
conjdisj: conjdisj.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) conjdisj

######

all:: dotoverld
dotoverld: dotoverld.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) dotoverld

######

all:: extfcall
extfcall: extfcall.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) extfcall

######

all:: mutailrec
mutailrec: mutailrec.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) mutailrec

######

all:: partmplt
partmplt: partmplt.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) partmplt

######

all:: patlinrec
patlinrec: patlinrec.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) patlinrec

######

all:: patrefas
patrefas: patrefas.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) patrefas

######

all:: sumodd
sumodd: sumodd.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) sumodd

######

all:: stkalloc
stkalloc: stkalloc.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) stkalloc

######

all:: trywith
trywith: trywith.dats ; \
  $(PATSCC) -D_GNU_SOURCE -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) trywith

######

all:: weekday
weekday: weekday.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) weekday

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######