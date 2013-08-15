#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

all:: clofun
clofun: clofun.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) clofun

######

all:: extfcall
extfcall: extfcall.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) extfcall

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