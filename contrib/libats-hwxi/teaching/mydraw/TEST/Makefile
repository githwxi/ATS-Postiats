#
# A simple Makefile
#

######

PATSCC=patscc

######

.PHONY: all

######

all:: test01

######

test01: test01.dats ; \
  $(PATSCC) -cleanaft -IATS $(PATSHOME)/contrib -o $@ $<
cleanall:: ; $(RMF) test01

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile]