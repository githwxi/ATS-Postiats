#
# A simple Makefile
#

######

MAKE=make

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSRELOC1=$(PATSHOME)/bin/atsreloc_curl
ATSRELOC2=$(PATSHOME)/bin/atsreloc_wget

######

test01: \
test01.dats ; \
$(PATSCC) \
-DATS PATSRELOCROOT='\".TEST01\"' -o $@ $<

######
#
test02: \
test02.dats ; \
$(PATSCC) \
-IIATS ./.TEST02 \
-I$(PATSHOME)/contrib/atscntrb \
-DATS_MEMALLOC_LIBC -o $@ $< -lgmp
#
######
#
test03: \
test03.dats ; \
$(PATSCC) \
-IIATS ./.TEST03 \
-I$(PATSHOME)/contrib/atscntrb \
-DATS_MEMALLOC_LIBC \
-DATS PATSRELOCROOT='\".TEST03\"' -o $@ $< -lpcre
#
######
#
assignment0: \
assignment0.dats ; $(PATSCC) -D_GNU_SOURCE -o $@ $<
#
######
#
test01-atsreloc: \
test01-atsreloc.json ; $(ATSRELOC1) ./$<
test01-atsreloc.json: ; $(PATSOPT) --atsreloc \
-DATS PATSRELOCROOT='".TEST01"' --output-w $@ -d test01.dats
#
######
#
test02-atsreloc: \
test02-atsreloc.json ; $(ATSRELOC1) ./$<
test02-atsreloc.json: ; \
$(PATSOPT) --atsreloc --output-w $@ -d test02.dats
#
######
#
test03-atsreloc: \
test03-atsreloc.make ; $(MAKE) -f ./$< wgetall
test03-atsreloc.make: ; $(PATSOPT) --atsreloc \
-DATS PATSRELOCROOT='".TEST03"' -d test03.dats | $(ATSRELOC2) --output-w $@
#
######
#
assignment0-atsreloc:: ; \
$(PATSOPT) --atsreloc -d assignment0.dats | $(ATSRELOC1)
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
cleanall:: ; $(RMF) test01-atsreloc.json
cleanall:: ; $(RMF) test02-atsreloc.json
cleanall:: ; $(RMF) test03-atsreloc.make

###### end of [Makefile] ######
