#
# A simple Makefile
# for testing doc/EXAMPLE/INTRO
#

######

CCOMP=gcc

######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

PATSCCOMP=\
$(CCOMP) -D_XOPEN_SOURCE -I${PATSHOMEQ} -I${PATSHOMEQ}/ccomp/runtime

######

export PATSCCOMP

######

all:: acker1
all:: acker2
all:: acker3
all:: acker4
all:: areverse
all:: atof
all:: atoi
all:: bintree
all:: f91
all:: fact1
all:: fact2
all:: fact3
all:: fact_uninterp
all:: fcopy
all:: fcopy2
all:: fib1
all:: fib2
all:: fibmem
all:: fib_lazy
all:: fib_llazy
all:: fprintlst2
all:: fprtuple
all:: gfact
all:: hello
all:: intecho
all:: intrange
all:: linenmbr
all:: listfuns
all:: listpermute
all:: ordset
all:: sieve_lazy
all:: sieve_llazy
all:: staref
all:: strprefix
all:: tally

######

regress:: acker1 ; ./acker1
regress:: acker2 ; ./acker2
regress:: acker3 ; ./acker3
regress:: acker4 ; ./acker4
regress:: areverse ; ./areverse
regress:: atof ; ./atof
regress:: atoi ; ./atoi
regress:: bintree ; ./bintree
regress:: f91 ; ./f91
regress:: fact1 ; ./fact1 10
regress:: fact2 ; ./fact2
regress:: fact3 ; ./fact3
regress:: fact_uninterp ; ./fact_uninterp
#regress:: fcopy ; ./fcopy
#regress:: fcopy2 ; ./fcopy2
regress:: fib1 ; ./fib1
regress:: fib2 ; ./fib2
regress:: fibmem ; ./fibmem
regress:: fib_lazy ; ./fib_lazy
regress:: fib_llazy ; ./fib_llazy
regress:: fprintlst2 ; ./fprintlst2
regress:: fprtuple ; ./fprtuple
regress:: gfact ; ./gfact
regress:: hello ; ./hello
#regress:: intecho ; ./intecho
regress:: intrange ; ./intrange
#regress:: linenmbr ; ./linenmbr
regress:: listfuns ; ./listfuns
regress:: listpermute ; ./listpermute
regress:: ordset ; ./ordset
regress:: sieve_lazy ; ./sieve_lazy
regress:: sieve_llazy ; ./sieve_llazy
regress:: staref ; ./staref
regress:: strprefix ; ./strprefix
regress:: tally ; ./tally

######

cleanall:: ; $(RMF) acker1
cleanall:: ; $(RMF) acker2
cleanall:: ; $(RMF) acker3
cleanall:: ; $(RMF) acker4
cleanall:: ; $(RMF) areverse
cleanall:: ; $(RMF) atof
cleanall:: ; $(RMF) atoi
cleanall:: ; $(RMF) bintree
cleanall:: ; $(RMF) f91
cleanall:: ; $(RMF) fact1
cleanall:: ; $(RMF) fact2
cleanall:: ; $(RMF) fact3
cleanall:: ; $(RMF) fact_uninterp
cleanall:: ; $(RMF) fcopy
cleanall:: ; $(RMF) fcopy2
cleanall:: ; $(RMF) fib1
cleanall:: ; $(RMF) fib2
cleanall:: ; $(RMF) fibmem
cleanall:: ; $(RMF) fib_lazy
cleanall:: ; $(RMF) fib_llazy
cleanall:: ; $(RMF) fprintlst2
cleanall:: ; $(RMF) fprtuple
cleanall:: ; $(RMF) gfact
cleanall:: ; $(RMF) hello
cleanall:: ; $(RMF) intecho
cleanall:: ; $(RMF) intrange
cleanall:: ; $(RMF) linenmbr
cleanall:: ; $(RMF) listfuns
cleanall:: ; $(RMF) listpermute
cleanall:: ; $(RMF) ordset
cleanall:: ; $(RMF) sieve_lazy
cleanall:: ; $(RMF) sieve_llazy
cleanall:: ; $(RMF) staref
cleanall:: ; $(RMF) strprefix
cleanall:: ; $(RMF) tally

######

testall:: all
testall:: regress
testall:: cleanall

######

acker1: acker1.dats ; $(PATSCC) -o $@ $<
acker2: acker2.dats ; $(PATSCC) -o $@ $<
acker3: acker3.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
acker4: acker4.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

areverse: areverse.dats ; \
  $(PATSCC) -D_ATS_EXCEPTION_NONE -DATS_MEMALLOC_LIBC -o $@ $<

######

atof: acker1.dats ; $(PATSCC) -o $@ $<
atoi: acker1.dats ; $(PATSCC) -o $@ $<

######

bintree: bintree.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

f91: f91.dats ; $(PATSCC) -o $@ $<

######
#
fact1: fact1.dats ; $(PATSCC) -o $@ $<
fact2: fact2.dats ; $(PATSCC) -o $@ $<
fact3: fact3.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
fact_uninterp: fact_uninterp.dats ; $(PATSCC) -o $@ $<
#
######

fcopy: fcopy.dats ; $(PATSCC) -o $@ $<
fcopy2: fcopy2.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< myatslib.dats 

######

fib1: fib1.dats ; $(PATSCC) -o $@ $<
fib2: fib2.dats ; $(PATSCC) -o $@ $<
fibmem: fibmem.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

fib_lazy: fib_lazy.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
fib_llazy: fib_llazy.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

fprintlst2: fprintlst2.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

fprtuple: fprtuple.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

gfact: gfact.dats ; $(PATSCC) -o $@ $<

######

hello: hello.dats ; $(PATSCC) -o $@ $<

######

intecho: intecho.dats ; $(PATSCC) -o $@ $<

######

intrange: intrange.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

linenmbr: linenmbr.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< myatslib.dats 

######

listfuns: listfuns.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

listpermute: listpermute.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

ordset: ordset.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

sieve_lazy: sieve_lazy.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_GCBDW -O2 -o $@ $< -lgc

sieve_llazy: sieve_llazy_dats.c ; \
  $(PATSCC) -cleanaft -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2 -o $@ $<
sieve_llazy_dats.c: sieve_llazy.dats ; $(PATSCC) -ccats $<

######

staref: staref.dats ; $(PATSCC) -o $@ $<

######

strprefix: strprefix.dats ; $(PATSCC) -o $@ $<

######

tally: tally.dats ; $(PATSCC) -D_ATS_EXCEPTION_NONE -o $@ $<

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
