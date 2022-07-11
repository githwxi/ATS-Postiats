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

testall:: all
testall:: regress
testall:: cleanall

######

regress:: test01; $(TIME) ./test01

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) test01

######

###### end of [Makefile] ######
