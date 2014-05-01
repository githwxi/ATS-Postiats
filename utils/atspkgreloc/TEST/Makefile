#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSPKGRELOC=$(PATSHOME)/bin/atspkgreloc

######

test01: test01.dats ; \
$(PATSCC) -DATS ATSPKGRELOCROOT=\\\".TEST01\\\" -o $@ $^

######

assignment1: assignment1.dats ; $(PATSCC) -D_GNU_SOURCE -o $@ $^

######
#
pkgreloc:: ; \
$(PATSOPT) --pkgreloc \
  -DATS ATSPKGRELOCROOT=\".TEST01\" --output-a .pkgreloc -d test01.dats
pkgreloc:: ; \
$(PATSOPT) --pkgreloc --output-a .pkgreloc -d assignment1.dats
#
pkgreloc:: ; cat .pkgreloc | $(ATSPKGRELOC)
#
######

RMF=rm -f
RMRF=rm -rf

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) test01
cleanall:: ; $(RMRF) .TEST01
cleanall:: ; $(RMF) assignment1
cleanall:: ; $(RMRF) .CS320WEBROOT
cleanall:: ; $(RMF) .pkgreloc

###### end of [Makefile] ######