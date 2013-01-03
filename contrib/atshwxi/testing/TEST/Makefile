#
# A simple Makefile
#

######

PATSOPT=patsopt

######

all::
all:: test1
all:: test2

######

test1: test1.dats ; \
  $(PATSOPT) -IATS$(PATSHOME)/contrib -tc -d test1.dats

test2: test2.dats ; \
  $(PATSOPT) -IATS$(PATSHOME)/contrib -tc -d test2.dats

######

###### end of [Makefile]