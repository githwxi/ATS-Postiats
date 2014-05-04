#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSPKGRELOC=$(PATSHOME)/bin/atspkgreloc_curl

######

test01: test01.dats ; \
$(PATSCC) -DATS ATSPKGRELOCROOT=\\\".TEST01\\\" -o $@ $<

######
#
test02: test02.dats ; \
$(PATSCC) -I./.TEST02/contrib \
  -DATS_MEMALLOC_LIBC -DATS ATSPKGRELOCROOT=\\\".TEST02\\\" -o $@ $< -lgmp
#
######
#
test03: test03.dats ; \
$(PATSCC) -I./.TEST03/contrib \
  -DATS_MEMALLOC_LIBC -DATS ATSPKGRELOCROOT=\\\".TEST03\\\" -o $@ $< -lpcre
#
######

assignment1: assignment1.dats ; $(PATSCC) -D_GNU_SOURCE -o $@ $<

######
#
pkgreloc-test01:: ; \
$(PATSOPT) --pkgreloc \
  -DATS ATSPKGRELOCROOT=\".TEST01\" --output-a .$@ -d test01.dats
pkgreloc-test01:: ; $(ATSPKGRELOC) ./.$@
#
pkgreloc-test02:: ; \
$(PATSOPT) --pkgreloc \
  -DATS ATSPKGRELOCROOT=\".TEST02\" --output-a .$@ -d test02.dats
pkgreloc-test02:: ; $(ATSPKGRELOC) ./.$@
#
pkgreloc-test03:: ; \
$(PATSOPT) --pkgreloc \
  -DATS ATSPKGRELOCROOT=\".TEST03\" --output-a .$@ -d test03.dats
pkgreloc-test03:: ; $(ATSPKGRELOC) ./.$@
#
pkgreloc-assignment1:: ; \
  $(PATSOPT) --pkgreloc -d assignment1.dats | $(ATSPKGRELOC)
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
cleanall:: ; $(RMF) test02
cleanall:: ; $(RMRF) .TEST02
cleanall:: ; $(RMF) test03
cleanall:: ; $(RMRF) .TEST03
cleanall:: ; $(RMF) assignment1
cleanall:: ; $(RMRF) .CS320WEBROOT
cleanall:: ; $(RMF) .pkgreloc-test01
cleanall:: ; $(RMF) .pkgreloc-test02
cleanall:: ; $(RMF) .pkgreloc-test03
cleanall:: ; $(RMF) .pkgreloc-assignment1

###### end of [Makefile] ######
