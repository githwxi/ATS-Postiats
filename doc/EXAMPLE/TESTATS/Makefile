#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

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

all:: fieldarr
fieldarr: fieldarr.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
cleanall:: ; $(RMF) fieldarr

######

all:: findexn
findexn: findexn_dats.c ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
findexn_dats.c: findexn.dats ; $(PATSCC) -ccats $<
cleanall:: ; $(RMF) findexn

######

all:: fixedpoint
fixedpoint: fixedpoint.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
cleanall:: ; $(RMF) fixedpoint

######

all:: lazytest
lazytest: lazytest_dats.c ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
lazytest_dats.c: lazytest.dats ; $(PATSCC) -ccats $<
cleanall:: ; $(RMF) lazytest
all:: llazytest
llazytest: llazytest_dats.c ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
llazytest_dats.c: llazytest.dats ; $(PATSCC) -ccats $<
cleanall:: ; $(RMF) llazytest

######

all:: mutailrec
mutailrec: mutailrec.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) mutailrec

######

all:: partmplt
partmplt: partmplt.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) partmplt

######

all:: patguard
patguard: patguard.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) patguard

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

all:: stkalloc
stkalloc: stkalloc.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) stkalloc

######

all:: sumodd
sumodd: sumodd.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) sumodd

######

all:: trywith
trywith: trywith.dats ; \
  $(PATSCC) -D_GNU_SOURCE -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) trywith

######

all:: union
union: union.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) union

######

all:: weekday
weekday: weekday.dats ; $(PATSCC) -cleanaft -o $@ $<
cleanall:: ; $(RMF) weekday

######

include $(PATSHOME)/share/atsmake-post.mk

######

clean:: cleanats

###### end of [Makefile] ######