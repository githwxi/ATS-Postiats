#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

all:: \
fibonacci
fibonacci:: ; $(PATSCC) -tcats fibonacci.dats || (echo "$< failed" && exit 1)
regress:: fibonacci

######

all:: \
tally
tally:: ; $(PATSCC) -tcats tally-of-powers.dats || (echo "$< failed" && exit 1)
regress:: tally

######

all:: \
Bezout_identity
Bezout_identity:: ; $(PATSCC) -tcats Bezout_identity.dats || (echo "$< failed" && exit 1)
regress:: Bezout_identity

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
