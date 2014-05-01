#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

test01: test01.dats ; $(PATSCC) -o $@ $^

######

assignment1: assignment1.dats ; $(PATSCC) -D_GNU_SOURCE -o $@ $^

######
#
pkgreloc:: ; \
$(PATSOPT) --pkgreloc \
  -DATS ATSPKGRELOCROOT=\".TEST01\" --output-a .pkgreloc -d test01.dats
#
pkgreloc:: ; \
$(PATSOPT) --pkgreloc --output-a .pkgreloc -d assignment1.dats
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) test01
cleanall:: ; $(RMF) assignment1
cleanall:: ; $(RMF) .pkgreloc

###### end of [Makefile] ######