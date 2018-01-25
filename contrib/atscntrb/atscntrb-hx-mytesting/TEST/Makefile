#
# A simple Makefile
#

######

PATSCC=patscc

######

all::
regress::
cleanall::

######
#
all:: \
test01
test01: test01.dats ; \
$(PATSCC) -cleanaft -IATS $(PATSHOME)/contrib -o $@ $<
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: test02.dats ; \
$(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -IATS $(PATSHOME)/contrib -o $@ $<
#
regress:: test02; ./$<
cleanall:: ; $(RMF) test02
#
######
#
all:: \
test03
test03: test03.dats ; \
$(PATSCC) -cleanaft -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -IATS $(PATSHOME)/contrib -o $@ $<
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

###### end of [Makefile]
