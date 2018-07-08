#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CCOPT=gcc -std=c99

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

######

PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::

######

LNS=ln -s
RMF=rm -f

######
#
all:: arith_overflow
arith_overflow: arith_overflow.exe
arith_overflow.exe: arith_overflow_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
arith_overflow_dats.c: arith_overflow.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output arith_overflow_dats.c --dynamic arith_overflow.dats
clean:: ; $(RMF) arith_overflow_dats.o
clean:: ; $(RMF) arith_overflow_dats.c
cleanall:: ; $(RMF) arith_overflow arith_overflow.exe

all:: coinflip
coinflip: coinflip.exe
coinflip.exe: coinflip_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
coinflip_dats.c: coinflip.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output coinflip_dats.c --dynamic coinflip.dats
clean:: ; $(RMF) coinflip_dats.o
clean:: ; $(RMF) coinflip_dats.c
cleanall:: ; $(RMF) coinflip coinflip.exe

all:: ferryman
ferryman: ferryman.exe
ferryman.exe: ferryman_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
ferryman_dats.c: ferryman.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output ferryman_dats.c --dynamic ferryman.dats
clean:: ; $(RMF) ferryman_dats.o
clean:: ; $(RMF) ferryman_dats.c
cleanall:: ; $(RMF) ferryman ferryman.exe

all:: fibver_loop
fibver_loop: fibver_loop.exe
fibver_loop.exe: fibver_loop_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fibver_loop_dats.c: fibver_loop.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fibver_loop_dats.c --dynamic fibver_loop.dats
clean:: ; $(RMF) fibver_loop_dats.o
clean:: ; $(RMF) fibver_loop_dats.c
cleanall:: ; $(RMF) fibver_loop fibver_loop.exe

all:: fibver_trec
fibver_trec: fibver_trec.exe
fibver_trec.exe: fibver_trec_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
fibver_trec_dats.c: fibver_trec.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fibver_trec_dats.c --dynamic fibver_trec.dats
clean:: ; $(RMF) fibver_trec_dats.o
clean:: ; $(RMF) fibver_trec_dats.c
cleanall:: ; $(RMF) fibver_trec fibver_trec.exe

all:: matrixops
matrixops: matrixops.exe
matrixops.exe: matrixops_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
matrixops_dats.c: matrixops.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output matrixops_dats.c --dynamic matrixops.dats
clean:: ; $(RMF) matrixops_dats.o
clean:: ; $(RMF) matrixops_dats.c
cleanall:: ; $(RMF) matrixops matrixops.exe

#
all:: autodiff
autodiff: autodiff.exe
autodiff.exe: autodiff_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_GCBDW -O2 -o $@ $< -lm -lgc
autodiff_dats.c: autodiff.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output autodiff_dats.c --dynamic autodiff.dats
clean:: ; $(RMF) autodiff_dats.o
clean:: ; $(RMF) autodiff_dats.c
cleanall:: ; $(RMF) autodiff autodiff.exe

all:: fib_memo
fib_memo: fib_memo.exe
fib_memo.exe: fib_memo_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
fib_memo_dats.c: fib_memo.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fib_memo_dats.c --dynamic fib_memo.dats
clean:: ; $(RMF) fib_memo_dats.o
clean:: ; $(RMF) fib_memo_dats.c
cleanall:: ; $(RMF) fib_memo fib_memo.exe

all:: fourslot
fourslot: fourslot.exe
fourslot.exe: fourslot_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
fourslot_dats.c: fourslot.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output fourslot_dats.c --dynamic fourslot.dats
clean:: ; $(RMF) fourslot_dats.o
clean:: ; $(RMF) fourslot_dats.c
cleanall:: ; $(RMF) fourslot fourslot.exe

all:: hanoi
hanoi: hanoi.exe
hanoi.exe: hanoi_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
hanoi_dats.c: hanoi.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output hanoi_dats.c --dynamic hanoi.dats
clean:: ; $(RMF) hanoi_dats.o
clean:: ; $(RMF) hanoi_dats.c
cleanall:: ; $(RMF) hanoi hanoi.exe

all:: intsqrt_cps
intsqrt_cps: intsqrt_cps.exe
intsqrt_cps.exe: intsqrt_cps_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
intsqrt_cps_dats.c: intsqrt_cps.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output intsqrt_cps_dats.c --dynamic intsqrt_cps.dats
clean:: ; $(RMF) intsqrt_cps_dats.o
clean:: ; $(RMF) intsqrt_cps_dats.c
cleanall:: ; $(RMF) intsqrt_cps intsqrt_cps.exe

all:: intsqrt_prf
intsqrt_prf: intsqrt_prf.exe
intsqrt_prf.exe: intsqrt_prf_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
intsqrt_prf_dats.c: intsqrt_prf.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output intsqrt_prf_dats.c --dynamic intsqrt_prf.dats
clean:: ; $(RMF) intsqrt_prf_dats.o
clean:: ; $(RMF) intsqrt_prf_dats.c
cleanall:: ; $(RMF) intsqrt_prf intsqrt_prf.exe

all:: monad_list
monad_list: monad_list.exe
monad_list.exe: monad_list_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
monad_list_dats.c: monad_list.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output monad_list_dats.c --dynamic monad_list.dats
clean:: ; $(RMF) monad_list_dats.o
clean:: ; $(RMF) monad_list_dats.c
cleanall:: ; $(RMF) monad_list monad_list.exe

all:: monad_maybe
monad_maybe: monad_maybe.exe
monad_maybe.exe: monad_maybe_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
monad_maybe_dats.c: monad_maybe.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output monad_maybe_dats.c --dynamic monad_maybe.dats
clean:: ; $(RMF) monad_maybe_dats.o
clean:: ; $(RMF) monad_maybe_dats.c
cleanall:: ; $(RMF) monad_maybe monad_maybe.exe

all:: monad_state
monad_state: monad_state.exe
monad_state.exe: monad_state_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
monad_state_dats.c: monad_state.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output monad_state_dats.c --dynamic monad_state.dats
clean:: ; $(RMF) monad_state_dats.o
clean:: ; $(RMF) monad_state_dats.c
cleanall:: ; $(RMF) monad_state monad_state.exe

all:: morse_enum
morse_enum: morse_enum.exe
morse_enum.exe: morse_enum_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
morse_enum_dats.c: morse_enum.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output morse_enum_dats.c --dynamic morse_enum.dats
clean:: ; $(RMF) morse_enum_dats.o
clean:: ; $(RMF) morse_enum_dats.c
cleanall:: ; $(RMF) morse_enum morse_enum.exe

all:: memoization
memoization: memoization.exe
memoization.exe: memoization_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
memoization_dats.c: memoization.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output memoization_dats.c --dynamic memoization.dats
clean:: ; $(RMF) memoization_dats.o
clean:: ; $(RMF) memoization_dats.c
cleanall:: ; $(RMF) memoization memoization.exe

all:: myfixptcomb
myfixptcomb: myfixptcomb.exe
myfixptcomb.exe: myfixptcomb_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
myfixptcomb_dats.c: myfixptcomb.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output myfixptcomb_dats.c --dynamic myfixptcomb.dats
clean:: ; $(RMF) myfixptcomb_dats.o
clean:: ; $(RMF) myfixptcomb_dats.c
cleanall:: ; $(RMF) myfixptcomb myfixptcomb.exe

all:: mysendmailist
mysendmailist: mysendmailist.exe
mysendmailist.exe: mysendmailist_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
mysendmailist_dats.c: mysendmailist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output mysendmailist_dats.c --dynamic mysendmailist.dats
clean:: ; $(RMF) mysendmailist_dats.o
clean:: ; $(RMF) mysendmailist_dats.c
cleanall:: ; $(RMF) mysendmailist mysendmailist.exe

all:: passwdgen
passwdgen: passwdgen.exe
passwdgen.exe: passwdgen_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
passwdgen_dats.c: passwdgen.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output passwdgen_dats.c --dynamic passwdgen.dats
clean:: ; $(RMF) passwdgen_dats.o
clean:: ; $(RMF) passwdgen_dats.c
cleanall:: ; $(RMF) passwdgen passwdgen.exe

all:: queens_lazy
queens_lazy: queens_lazy.exe
queens_lazy.exe: queens_lazy_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
queens_lazy_dats.c: queens_lazy.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output queens_lazy_dats.c --dynamic queens_lazy.dats
clean:: ; $(RMF) queens_lazy_dats.o
clean:: ; $(RMF) queens_lazy_dats.c
cleanall:: ; $(RMF) queens_lazy queens_lazy.exe

all:: queens_loop
queens_loop: queens_loop.exe
queens_loop.exe: queens_loop_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
queens_loop_dats.c: queens_loop.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output queens_loop_dats.c --dynamic queens_loop.dats
clean:: ; $(RMF) queens_loop_dats.o
clean:: ; $(RMF) queens_loop_dats.c
cleanall:: ; $(RMF) queens_loop queens_loop.exe

all:: queens_comb
queens_comb: queens_comb.exe
queens_comb.exe: queens_comb_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
queens_comb_dats.c: queens_comb.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output queens_comb_dats.c --dynamic queens_comb.dats
clean:: ; $(RMF) queens_comb_dats.o
clean:: ; $(RMF) queens_comb_dats.c
cleanall:: ; $(RMF) queens_comb queens_comb.exe

all:: queens_lincomb
queens_lincomb: queens_lincomb.exe
queens_lincomb.exe: queens_lincomb_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
queens_lincomb_dats.c: queens_lincomb.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output queens_lincomb_dats.c --dynamic queens_lincomb.dats
clean:: ; $(RMF) queens_lincomb_dats.o
clean:: ; $(RMF) queens_lincomb_dats.c
cleanall:: ; $(RMF) queens_lincomb queens_lincomb.exe

all:: randerlin
randerlin: randerlin.exe
randerlin.exe: randerlin_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
randerlin_dats.c: randerlin.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output randerlin_dats.c --dynamic randerlin.dats
clean:: ; $(RMF) randerlin_dats.o
clean:: ; $(RMF) randerlin_dats.c
cleanall:: ; $(RMF) randerlin randerlin.exe

all:: readdirall
readdirall: readdirall.exe
readdirall.exe: readdirall_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
readdirall_dats.c: readdirall.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output readdirall_dats.c --dynamic readdirall.dats
clean:: ; $(RMF) readdirall_dats.o
clean:: ; $(RMF) readdirall_dats.c
cleanall:: ; $(RMF) readdirall readdirall.exe

all:: sieve
sieve: sieve.exe
sieve.exe: sieve_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
sieve_dats.c: sieve.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output sieve_dats.c --dynamic sieve.dats
clean:: ; $(RMF) sieve_dats.o
clean:: ; $(RMF) sieve_dats.c
cleanall:: ; $(RMF) sieve sieve.exe

all:: sllist_mapfree
sllist_mapfree: sllist_mapfree.exe
sllist_mapfree.exe: sllist_mapfree_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
sllist_mapfree_dats.c: sllist_mapfree.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output sllist_mapfree_dats.c --dynamic sllist_mapfree.dats
clean:: ; $(RMF) sllist_mapfree_dats.o
clean:: ; $(RMF) sllist_mapfree_dats.c
cleanall:: ; $(RMF) sllist_mapfree sllist_mapfree.exe

all:: stdlib_bsearch
stdlib_bsearch: stdlib_bsearch.exe
stdlib_bsearch.exe: stdlib_bsearch_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
stdlib_bsearch_dats.c: stdlib_bsearch.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output stdlib_bsearch_dats.c --dynamic stdlib_bsearch.dats
clean:: ; $(RMF) stdlib_bsearch_dats.o
clean:: ; $(RMF) stdlib_bsearch_dats.c
cleanall:: ; $(RMF) stdlib_bsearch stdlib_bsearch.exe

all:: strmat
strmat: strmat.exe
strmat.exe: strmat_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
strmat_dats.c: strmat.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output strmat_dats.c --dynamic strmat.dats
clean:: ; $(RMF) strmat_dats.o
clean:: ; $(RMF) strmat_dats.c
cleanall:: ; $(RMF) strmat strmat.exe

all:: tempfunctor
tempfunctor: tempfunctor.exe
tempfunctor.exe: tempfunctor_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
tempfunctor_dats.c: tempfunctor.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output tempfunctor_dats.c --dynamic tempfunctor.dats
clean:: ; $(RMF) tempfunctor_dats.o
clean:: ; $(RMF) tempfunctor_dats.c
cleanall:: ; $(RMF) tempfunctor tempfunctor.exe

all:: totient
totient: totient.exe
totient.exe: totient_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -lm
totient_dats.c: totient.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output totient_dats.c --dynamic totient.dats
clean:: ; $(RMF) totient_dats.o
clean:: ; $(RMF) totient_dats.c
cleanall:: ; $(RMF) totient totient.exe

all:: wclines
wclines: wclines.exe
wclines.exe: wclines_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
wclines_dats.c: wclines.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output wclines_dats.c --dynamic wclines.dats
clean:: ; $(RMF) wclines_dats.o
clean:: ; $(RMF) wclines_dats.c
cleanall:: ; $(RMF) wclines wclines.exe

all:: word-chain
word-chain: word-chain.exe
word-chain.exe: word-chain_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
word-chain_dats.c: word-chain.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output word-chain_dats.c --dynamic word-chain.dats
clean:: ; $(RMF) word-chain_dats.o
clean:: ; $(RMF) word-chain_dats.c
cleanall:: ; $(RMF) word-chain word-chain.exe

#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
