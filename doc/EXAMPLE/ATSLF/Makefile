#
# A simple Makefile
#

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::

######

all:: Ackermann
Ackermann: Ackermann.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: Ackermann

######

all:: BinaryTreeLemmas
BinaryTreeLemmas: BinaryTreeLemmas.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: BinaryTreeLemmas

######

all:: CPS
CPS: CPS.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: CPS

######

all:: CutElimIL
CutElimIL: CutElimIL.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: CutElimIL

######

all:: CutElimILL
CutElimILL: CutElimILL.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: CutElimILL

######

all:: HilbertCalc
HilbertCalc: HilbertCalc.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: HilbertCalc

######

all:: infprime
infprime: infprime.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: infprime

######

all:: sqrt2_irrat
sqrt2_irrat: sqrt2_irrat.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: sqrt2_irrat

######

all:: KolmogorovTrans
KolmogorovTrans: KolmogorovTrans.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: KolmogorovTrans

######

all:: naive-set
naive-set: naive-set.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: naive-set

######

all:: PHP
PHP: PHP.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: PHP

######

all:: SMI
SMI: SMI.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: SMI

######

all:: \
STLC-SN-foas
STLC-SN-foas: STLC-SN-foas.dats ; $(PATSCC) -tcats $< || (echo "$< failed" && exit 1)
regress:: STLC-SN-foas

######

all:: \
IsoscelesAngleq
IsoscelesAngleq: \
IsoscelesAngleq.dats; $(PATSCC) -verbose -tcats $< || (echo "$< failed" && exit 1)

######

all:: \
F-algebra
F-algebra: \
F-algebra.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: F-algebra F-algebra.test-cmp
	./$< 2>&1 | diff -q F-algebra.test-cmp - >/dev/null || \
	(echo "$< failed" && exit 1)
cleanall:: ; $(RMF) F-algebra

######

all:: \
YonedaLemma
YonedaLemma: \
YonedaLemma.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: YonedaLemma YonedaLemma.test-cmp
	./$< 2>&1 | diff -q YonedaLemma.test-cmp - >/dev/null || \
	(echo "$< failed" && exit 1)
cleanall:: ; $(RMF) YonedaLemma

######

all:: \
CoYonedaLemma
CoYonedaLemma: \
CoYonedaLemma.dats ; \
$(PATSCC) --constraint-ignore -DATS_MEMALLOC_LIBC -o $@ $<
regress:: CoYonedaLemma CoYonedaLemma.test-cmp
	./$< 2>&1 | diff -q CoYonedaLemma.test-cmp - >/dev/null || \
	(echo "$< failed" && exit 1)
cleanall:: ; $(RMF) CoYonedaLemma

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
