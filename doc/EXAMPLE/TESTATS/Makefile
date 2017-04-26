#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: \
arrinit
arrinit: \
arrinit.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: arrinit ; ./$<
cleanall:: ; $(RMF) arrinit

######

all:: \
catamorph
catamorph: \
catamorph.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: catamorph ; ./$<
cleanall:: ; $(RMF) catamorph

######

all:: \
clofuns
clofuns: clofuns.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: clofuns ; ./$<
cleanall:: ; $(RMF) clofuns

######

all:: \
conjdisj
conjdisj: conjdisj.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: conjdisj ; ./$<
cleanall:: ; $(RMF) conjdisj

######

all:: \
dotoverld
dotoverld: dotoverld.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: dotoverld ; ./$<
cleanall:: ; $(RMF) dotoverld

######

all:: \
extvar
extvar: extvar.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: extvar ; ./$<
cleanall:: ; $(RMF) extvar

######

all:: \
extfcall
extfcall: extfcall.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: extfcall ; ./$<
cleanall:: ; $(RMF) extfcall

######
#
all:: \
fieldarr
fieldarr: fieldarr.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
regress:: fieldarr ; ./$<
cleanall:: ; $(RMF) fieldarr
#
######

all:: \
findexn
findexn: findexn_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
findexn_dats.c: findexn.dats ; $(PATSCC2) -ccats $<
regress:: findexn ; ./$<
cleanall:: ; $(RMF) findexn
cleanall:: ; $(RMF) findexn_dats.c

######

all:: \
fixedpoint
fixedpoint: fixedpoint.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
regress:: fixedpoint ; ./$<
cleanall:: ; $(RMF) fixedpoint

######

all:: \
funargpat
funargpat: funargpat.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
regress:: funargpat ; ./$<
cleanall:: ; $(RMF) funargpat

######

all:: \
ifcase
ifcase: \
ifcase.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: ifcase ; ./$<
cleanall:: ; $(RMF) ifcase

######

all:: \
ifhead
ifhead: \
ifhead.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: ifhead ; ./$<
cleanall:: ; $(RMF) ifhead
all:: \
casehead
casehead: \
casehead.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: casehead ; ./$<
cleanall:: ; $(RMF) casehead

######

all:: \
intbase
intbase: \
intbase.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: intbase ; ./$<
cleanall:: ; $(RMF) intbase

######

all:: \
kacker
kacker: kacker.dats ; \
$(PATSCC2) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
regress:: kacker ; ./$<
cleanall:: ; $(RMF) kacker

######

all:: \
lazytest
lazytest: lazytest_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
lazytest_dats.c: lazytest.dats ; $(PATSCC2) -ccats $<
regress:: lazytest ; ./$<
cleanall:: ; $(RMF) lazytest
cleanall:: ; $(RMF) lazytest_dats.c

all:: \
llazytest
llazytest: llazytest_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
llazytest_dats.c: llazytest.dats ; $(PATSCC2) -ccats $<
regress:: llazytest ; ./$<
cleanall:: ; $(RMF) llazytest
cleanall:: ; $(RMF) llazytest_dats.c

######

all:: \
listpat
listpat: listpat.dats ; \
   $(PATSCC2) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
regress:: listpat ; ./$<
cleanall:: ; $(RMF) listpat

######

all:: \
loctmplt
loctmplt: \
loctmplt.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: loctmplt ; ./$<
cleanall:: ; $(RMF) loctmplt

######

all:: \
loctmplt2
loctmplt2: \
loctmplt2.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: loctmplt2 ; ./$<
cleanall:: ; $(RMF) loctmplt2

######

all:: \
locimplmnt
locimplmnt: \
locimplmnt.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: locimplmnt ; ./$<
cleanall:: ; $(RMF) locimplmnt

######

all:: \
mutailrec
mutailrec: \
mutailrec.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: mutailrec ; ./$<
cleanall:: ; $(RMF) mutailrec

######

all:: \
partmplt
partmplt: \
partmplt.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: partmplt ; ./$<
cleanall:: ; $(RMF) partmplt

######

all:: \
patguard
patguard: patguard.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: patguard ; ./$<
cleanall:: ; $(RMF) patguard

######

all:: \
patlinrec
patlinrec: patlinrec.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: patlinrec ; ./$<
cleanall:: ; $(RMF) patlinrec

######

all:: \
patrefas
patrefas: patrefas.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: patrefas ; ./$<
cleanall:: ; $(RMF) patrefas

######

all:: \
pfsearch
pfsearch: pfsearch.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: pfsearch ; ./$<
cleanall:: ; $(RMF) pfsearch

######

all:: \
reassume
reassume: reassume.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: reassume ; ./$<
cleanall:: ; $(RMF) reassume

######

all:: \
stkalloc
stkalloc: stkalloc.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: stkalloc ; ./$<
cleanall:: ; $(RMF) stkalloc

######

all:: \
sumodd
sumodd: sumodd.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: sumodd ; ./$<
cleanall:: ; $(RMF) sumodd

######
#
all:: \
tempenver
tempenver: tempenver.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: tempenver ; ./$<
cleanall:: ; $(RMF) tempenver
#
# cleanall:: ; $(RMF) tempenver_dats.c
#
######

all:: \
trywith
trywith: trywith.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
#
#HX: run-time exception
#regress:: trywith ; ./$<
#
cleanall:: ; $(RMF) trywith

######

all:: \
union
union: union.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: union ; ./$<
cleanall:: ; $(RMF) union

######

all:: \
weekday
weekday: weekday.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: weekday ; ./$<
cleanall:: ; $(RMF) weekday

######

all:: \
withtype
withtype: withtype.dats ; $(PATSCC2) -cleanaft -o $@ $<
regress:: withtype ; ./$<
cleanall:: ; $(RMF) withtype

######

CPF=cp -f

######
#
all:: \
d2ctype
d2ctype: \
d2ctype.dats ; \
$(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
regress:: d2ctype ; ./$<
cleanall:: ; $(RMF) d2ctype
#
######
#
all:: \
codegen2
codegen2: \
codegen2.dats \
codegen2_out.dats ; \
$(PATSCC2) -cleanaft -o $@ codegen2_test.dats -DATS_MEMALLOC_LIBC
regress:: codegen2 ; ./$<
cleanall:: ; $(RMF) codegen2
#
codegen2_out.dats: \
codegen2.dats; $(PATSOPT) --output-a $@ --codegen-2 -d codegen2.dats
#
cleanall:: ; $(RMF) codegen2_out.dats
#
######
#
all:: \
s2rt_float
s2rt_float: s2rt_float.dats; $(PATSOPT) --typecheck -d $<
#
######

all:: \
wherecls
wherecls: wherecls_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
wherecls_dats.c: wherecls.dats ; $(PATSCC2) -ccats $<
#
# regress:: wherecls ; ./$<
#
cleanall:: ; $(RMF) wherecls
cleanall:: ; $(RMF) wherecls_dats.c

######

all:: \
undefined
undefined: undefined_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
undefined_dats.c: undefined.dats ; $(PATSCC2) -ccats $<
#
# regress:: undefined ; ./$<
#
cleanall:: ; $(RMF) undefined
cleanall:: ; $(RMF) undefined_dats.c

######

testall:: all
testall:: regress
testall:: cleanall

######

cleanall:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
