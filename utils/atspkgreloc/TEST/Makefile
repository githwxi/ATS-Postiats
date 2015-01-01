#
# A simple Makefile
#

######

MAKE=make

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSPKGRELOC=$(PATSHOME)/bin/atspkgreloc_curl
ATSPKGRELOC2=$(PATSHOME)/bin/atspkgreloc_wget

######

test01: test01.dats ; \
$(PATSCC) -DATS ATSPKGRELOCROOT='\".TEST01\"' -o $@ $<

######
#
test02: \
test02.dats ; \
$(PATSCC) -IIATS ./.TEST02 \
-DATS_MEMALLOC_LIBC -DATS ATSPKGRELOCROOT='\".TEST02\"' -o $@ $< -lgmp
#
######
#
test03: \
test03.dats ; \
$(PATSCC) -IIATS ./.TEST03 \
-DATS_MEMALLOC_LIBC -DATS ATSPKGRELOCROOT='\".TEST03\"' -o $@ $< -lpcre
#
######

assignment0: assignment0.dats ; $(PATSCC) -D_GNU_SOURCE -o $@ $<

######
#
test01-pkgreloc: \
test01-pkgreloc.json ; $(ATSPKGRELOC) ./$<
test01-pkgreloc.json: ; \
$(PATSOPT) --pkgreloc \
-DATS ATSPKGRELOCROOT='".TEST01"' --output-w $@ -d test01.dats
#
######
#
test02-pkgreloc: \
test02-pkgreloc.json ; $(ATSPKGRELOC) ./$<
test02-pkgreloc.json: ; \
$(PATSOPT) --pkgreloc \
-DATS ATSPKGRELOCROOT='".TEST02"' --output-w $@ -d test02.dats
#
######
#
test03-pkgreloc: \
test03-pkgreloc.mk ; $(MAKE) -f ./$< wgetall
test03-pkgreloc.mk: ; \
$(PATSOPT) --pkgreloc \
-DATS ATSPKGRELOCROOT='".TEST03"' -d test03.dats | $(ATSPKGRELOC2) --output-w $@
#
######
#
assignment0-pkgreloc:: ; \
  $(PATSOPT) --pkgreloc -d assignment0.dats | $(ATSPKGRELOC)
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
cleanall:: ; $(RMF) assignment0
cleanall:: ; $(RMRF) .CS320WEBROOT
cleanall:: ; $(RMF) test01-pkgreloc.json
cleanall:: ; $(RMF) test02-pkgreloc.json
cleanall:: ; $(RMF) test03-pkgreloc.mk
cleanall:: ; $(RMF) test03-pkgreloc.json

###### end of [Makefile] ######
