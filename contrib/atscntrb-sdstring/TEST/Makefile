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
test1
test1: \
test1.dats; \
$(PATSCC) $(INCLATS) -o $@ ./../DATS/sdstring.dats $<
regress:: test1; ./$<
cleanall:: ; $(RMF) test1
#
######
#
all:: \
test2
test2: \
test2.dats; \
$(PATSCC) $(INCLATS) -o $@ ./../DATS/sdstring.dats $<
regress:: test2; ./$<
cleanall:: ; $(RMF) test2
#
######
#
all:: \
test3
test3: \
test3.dats; \
$(PATSCC) $(INCLATS) -o $@ ./../DATS/sdstring.dats $<
regress:: test3; ./$<
cleanall:: ; $(RMF) test3
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
