#
# A simple Makefile
#

######

PATSCC=patscc

######

all::
all:: test01
all:: test02

######

test01: test01.dats ; \
  $(PATSCC) -cleanaft -IATS $(PATSHOME)/contrib -o $@ $<
cleanall:: ; $(RMF) test01

test02: test02.dats ; \
  $(PATSCC) -cleanaft -DATS_MEMALLOC_LIBC -IATS $(PATSHOME)/contrib -o $@ $<
cleanall:: ; $(RMF) test02

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile]