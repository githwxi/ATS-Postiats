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

all:: irrationality-of-sqrt2
irrationality-of-sqrt2: irrationality-of-sqrt2.dats ; $(PATSCC) -tcats $<

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

RMF=rm -f

######

clean:: ; $(RMF) *~

######

cleanall:: clean

###### end of [Makefile] ######
