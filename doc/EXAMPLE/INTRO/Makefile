#
# A simple Makefile
# for testing doc/EXAMPLE/INTRO
#

######

CC=gcc

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

PATSCCOMP=$(CC) -D_XOPEN_SOURCE -I${PATSHOMEQ} -I${PATSHOMEQ}/ccomp/runtime

######

export PATSCCOMP

######

all::

######

all:: acker1
all:: acker2
all:: acker3
all:: areverse
all:: atof
all:: atoi
all:: bintree
all:: f91
all:: fact1
all:: fact2
all:: fact3
all:: fcopy
all:: fcopy2
all:: fib1
all:: fib2
all:: fibmem
all:: gfact
all:: hello
all:: intecho
all:: intrange
all:: linenmbr
all:: listfuns
all:: ordset
all:: staref
all:: strprefix
all:: tally

######

cleanall:: ; $(RMF) acker1
cleanall:: ; $(RMF) acker2
cleanall:: ; $(RMF) acker3
cleanall:: ; $(RMF) areverse
cleanall:: ; $(RMF) atof
cleanall:: ; $(RMF) atoi
cleanall:: ; $(RMF) bintree
cleanall:: ; $(RMF) f91
cleanall:: ; $(RMF) fact1
cleanall:: ; $(RMF) fact2
cleanall:: ; $(RMF) fact3
cleanall:: ; $(RMF) fcopy
cleanall:: ; $(RMF) fcopy2
cleanall:: ; $(RMF) fib1
cleanall:: ; $(RMF) fib2
cleanall:: ; $(RMF) fibmem
cleanall:: ; $(RMF) gfact
cleanall:: ; $(RMF) hello
cleanall:: ; $(RMF) intecho
cleanall:: ; $(RMF) intrange
cleanall:: ; $(RMF) linenmbr
cleanall:: ; $(RMF) listfuns
cleanall:: ; $(RMF) ordset
cleanall:: ; $(RMF) staref
cleanall:: ; $(RMF) strprefix
cleanall:: ; $(RMF) tally

######

acker1: acker1.dats ; $(PATSCC) -o $@ $<
acker2: acker2.dats ; $(PATSCC) -o $@ $<
acker3: acker3.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

areverse: areverse.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

atof: acker1.dats ; $(PATSCC) -o $@ $<
atoi: acker1.dats ; $(PATSCC) -o $@ $<

######

bintree: bintree.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

f91: f91.dats ; $(PATSCC) -o $@ $<

######

fact1: fact1.dats ; $(PATSCC) -o $@ $<
fact2: fact2.dats ; $(PATSCC) -o $@ $<
fact3: fact3.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

fcopy: fcopy.dats ; $(PATSCC) -o $@ $<
fcopy2: fcopy2.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< myatslib.dats 

######

fib1: fib1.dats ; $(PATSCC) -o $@ $<
fib2: fib2.dats ; $(PATSCC) -o $@ $<
fibmem: fibmem.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

gfact: gfact.dats ; $(PATSCC) -o $@ $<

######

hello: hello.dats ; $(PATSCC) -o $@ $<

######

intecho: intecho.dats ; $(PATSCC) -o $@ $<

######

intrange: intrange.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

linenmbr: linenmbr.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< myatslib.dats 

######

listfuns: listfuns.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

ordset: ordset.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

staref: staref.dats ; $(PATSCC) -o $@ $<

######

strprefix: strprefix.dats ; $(PATSCC) -o $@ $<

######

tally: tally.dats ; $(PATSCC) -o $@ $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile] ######
