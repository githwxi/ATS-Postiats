#
# A simple Makefile
#

######

PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######

all:: isqrt
all:: hanoi
all:: ferryman
all:: morse_enum
all:: strmat

######

isqrt: ; \
  $(PATSOPT) -d $(PATSHOME)/doc/EXAMPLE/MISC/isqrt.dats
hanoi: ; \
  $(PATSOPT) -d $(PATSHOME)/doc/EXAMPLE/MISC/hanoi.dats
ferryman: ; \
  $(PATSOPT) -d $(PATSHOME)/doc/EXAMPLE/MISC/ferryman.dats
morse_enum: ; \
  $(PATSOPT) -d $(PATSHOME)/doc/EXAMPLE/MISC/morse_enum.dats
strmat: ; \
  $(PATSOPT) -d $(PATSHOME)/doc/EXAMPLE/MISC/strmat.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~

cleanall:: clean

###### end of [Makefile] ######
