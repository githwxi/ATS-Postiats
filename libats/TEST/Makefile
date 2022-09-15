######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
MYATSCC=$(PATSHOME)/bin/myatscc

######

RMF=rm -f
TIME=time

######

######
TEST01=\
test01-2022-07-11
######
all:: \
test01
test01: $(TEST01).dats; \
$(PATSCC) -O2 -DATS_MEMALLOC_LIBC -o $@ $<
######

######
TEST02=\
test02-2022-07-11
######
all:: \
test02
test02: $(TEST02).dats; \
$(PATSCC) -O2 -DATS_MEMALLOC_LIBC -o $@ $<
######

######
TEST03=\
test03-2022-07-12
######
all:: \
test03
test03: $(TEST03).dats; \
$(PATSCC) -O2 -DATS_MEMALLOC_LIBC -o $@ $<
######

testall:: all
testall:: regress
testall:: cleanall

######
#
regress:: \
regress01
regress01: test01; $(TIME) ./test01
regress:: \
regress02
regress02: test02; $(TIME) ./test02
regress:: \
regress03
regress03: test03; $(TIME) ./test03
#
######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) test01
cleanall:: ; $(RMF) test02
cleanall:: ; $(RMF) test03

######

###### end of [Makefile] ######
