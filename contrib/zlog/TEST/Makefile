#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::
all:: test01

######

test01: test01.dats ; \
  $(PATSCC) -cleanaft --gline -IIATS $(PATSHOMEQ)/contrib -o $@ $< -lzlog
cleanall:: ; $(RMF) test01

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
