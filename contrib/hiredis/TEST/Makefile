#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

test01: test01.dats ; $(PATSCC) -cleanaft -IIATS $(PATSHOMEQ)/contrib -o $@ $< -lhiredis

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) test01

###### end of [Makefile] ######
