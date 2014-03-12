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

######

all:: BinaryTreeLemmas
BinaryTreeLemmas: BinaryTreeLemmas.dats ; $(PATSCC) -tcats $<

######

all:: CPS
CPS: CPS.dats ; $(PATSCC) -tcats $<

######

all:: CutElimIL
CutElimIL: CutElimIL.dats ; $(PATSCC) -tcats $<

######

all:: CutElimILL
CutElimILL: CutElimILL.dats ; $(PATSCC) -tcats $<

######

all:: HilbertCalc
HilbertCalc: HilbertCalc.dats ; $(PATSCC) -tcats $<

######

all:: infprime
infprime: infprime.dats ; $(PATSCC) -tcats $<

######

all:: sqrt2_irrat
sqrt2_irrat: sqrt2_irrat.dats ; $(PATSCC) -tcats $<

######

all:: KolmogorovTrans
KolmogorovTrans: KolmogorovTrans.dats ; $(PATSCC) -tcats $<

######

all:: naive-set
naive-set: naive-set.dats ; $(PATSCC) -tcats $<

######

all:: PHP
PHP: PHP.dats ; $(PATSCC) -tcats $<

######

all:: SMI
SMI: SMI.dats ; $(PATSCC) -tcats $<

######

all:: STLC-SN-foas
STLC-SN-foas: STLC-SN-foas.dats ; $(PATSCC) -tcats $<

######

all:: YonedaLemma
YonedaLemma: \
  YonedaLemma.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) YonedaLemma

######

all:: CoYonedaLemma
CoYonedaLemma: \
  CoYonedaLemma.dats ; $(PATSCC) -CSignore -DATS_MEMALLOC_LIBC -o $@ $<
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
