#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

MYLIBIES :=
MYLIBIES += ./../mylibies.sats
MYLIBIES += ./../mylibies.dats

######
#
all:: \
test00
regress:: \
test00; $(CAT) test00.dats | ./$< 
test00: \
test00.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -lm
#
######
#
all:: \
test01
regress:: \
test01; $(CAT) test01.dats | ./$< 
test01: \
test01.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -lm
#
######
#
all:: \
test02
regress:: \
test02; $(CAT) test02.dats | ./$< 
test02: \
test02.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -L$(PATSLIB) -latslib -lm
#
######
#
all:: \
test03
regress:: \
test03; $(CAT) test03.dats | ./$< 
test03: \
test03.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -L$(PATSLIB) -latslib -lm
#
######
#
all:: \
test04
regress:: \
test04; $(CAT) test04.dats | ./$< 
test04: \
test04.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -L$(PATSLIB) -latslib -lm
#
######
#
all:: \
test05
regress:: \
test05; $(CAT) test05.dats | ./$< 
test05: \
test05.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -L$(PATSLIB) -latslib -lm
#
######
#
all:: \
test06
regress:: \
test06; $(CAT) test06.dats | ./$< 
test06: \
test06.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -L$(PATSLIB) -latslib -lm
#
######

CAT=cat
RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) test00
cleanall:: ; $(RMF) test01
cleanall:: ; $(RMF) test02
cleanall:: ; $(RMF) test03
cleanall:: ; $(RMF) test04
cleanall:: ; $(RMF) test05
cleanall:: ; $(RMF) test06

###### end of [Makefile] ######
