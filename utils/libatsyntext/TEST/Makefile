#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

ATSLIB=$(ATSHOME)/ccomp/lib
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

all::
all:: test01
all:: test02

######
#
test01: \
test01.dats ; \
$(ATSCC) -I$(PATSHOME)/src \
  -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ $< \
  -L./../BUILD -L$(ATSLIB) -latsyntext -latsopt -lgmp
#
regress:: test01; ./$<
#
cleanall:: ; $(RMF) test01
#
######
#
test02: \
test02.dats ; \
$(ATSCC) -I$(PATSHOME)/src \
  -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ $< \
  -L./../BUILD -L$(ATSLIB) -latsyntext -latsopt -lgmp
#
regress:: test02 ; $(CAT) DATA/fact.dats | ./$<
#
cleanall:: ; $(RMF) test02
#
######

testall:: all
testall:: regress
testall:: cleanall

######

CAT=cat
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######

