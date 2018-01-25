#
# A simple Makefile
#

######

PATSCC=${PATSHOME}/bin/patscc

######
#
INCLATS += -I./../..
#
#INCLATS += -I${PATSHOME}/contrib
#
######

all::

######
#
all:: \
test01
test01: \
test01.dats; \
$(PATSCC) $(INCLATS) -o $@ $<
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: \
test02.dats; \
$(PATSCC) $(INCLATS) -o $@ $<
#
regress:: test02; ./$<
cleanall:: ; $(RMF) test02
#
######
#
all:: \
test03
test03: \
test03.dats; \
$(PATSCC) $(INCLATS) -o $@ $<
#
regress:: test03; ./$<
cleanall:: ; $(RMF) test03
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
