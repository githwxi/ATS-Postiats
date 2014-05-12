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
Ackermann: Ackermann.dats ; $(PATSCC) -tcats $<
regress:: Ackermann

######

all:: BinaryTreeLemmas
BinaryTreeLemmas: BinaryTreeLemmas.dats ; $(PATSCC) -tcats $<
regress:: BinaryTreeLemmas

######

all:: CPS
CPS: CPS.dats ; $(PATSCC) -tcats $<
regress:: CPS

######

all:: CutElimIL
CutElimIL: CutElimIL.dats ; $(PATSCC) -tcats $<
regress:: CutElimIL

######

all:: CutElimILL
CutElimILL: CutElimILL.dats ; $(PATSCC) -tcats $<
regress:: CutElimILL

######

all:: HilbertCalc
HilbertCalc: HilbertCalc.dats ; $(PATSCC) -tcats $<
regress:: HilbertCalc

######

all:: infprime
infprime: infprime.dats ; $(PATSCC) -tcats $<
regress:: infprime

######

all:: sqrt2_irrat
sqrt2_irrat: sqrt2_irrat.dats ; $(PATSCC) -tcats $<
regress:: sqrt2_irrat

######

all:: KolmogorovTrans
KolmogorovTrans: KolmogorovTrans.dats ; $(PATSCC) -tcats $<
regress:: KolmogorovTrans

######

all:: naive-set
naive-set: naive-set.dats ; $(PATSCC) -tcats $<
regress:: naive-set

######

all:: PHP
PHP: PHP.dats ; $(PATSCC) -tcats $<
regress:: PHP

######

all:: SMI
SMI: SMI.dats ; $(PATSCC) -tcats $<
regress:: SMI

######

all:: STLC-SN-foas
STLC-SN-foas: STLC-SN-foas.dats ; $(PATSCC) -tcats $<
regress:: STLC-SN-foas

######

all:: YonedaLemma
YonedaLemma: \
  YonedaLemma.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: YonedaLemma ; ./$<
cleanall:: ; $(RMF) YonedaLemma

######

all:: CoYonedaLemma
CoYonedaLemma: \
  CoYonedaLemma.dats ; $(PATSCC) -CSignore -DATS_MEMALLOC_LIBC -o $@ $<
regress:: CoYonedaLemma ; ./$<
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
