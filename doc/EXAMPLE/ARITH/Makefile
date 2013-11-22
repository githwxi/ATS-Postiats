#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

all:: gcd
gcd:: ; $(PATSCC) -tcats gcd.dats

######

all:: tally
tally:: ; $(PATSCC) -tcats tally.dats

######

all:: fibonacci
fibonacci:: ; $(PATSCC) -tcats fibonacci.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
