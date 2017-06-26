#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::
regress::
cleanall::

######
#
all:: \
test00
test00: \
test00.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: test00; ./$<
cleanall:: ; $(RMF) test00
#
######
#
all:: \
test01
test01: \
test01.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: \
test02.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: test02; ./$<
cleanall:: ; $(RMF) test02
#
######
#
all:: \
test03
test03: \
test03.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: test03; ./$<
cleanall:: ; $(RMF) test03
#
######
#
all:: \
test04
test04: \
test04.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $< -latslib -lm
#
regress:: test04; ./$<
cleanall:: ; $(RMF) test04
#
######
#
all:: \
test05
test05: \
test05.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $< -latslib -lm
#
regress:: test05; ./$<
cleanall:: ; $(RMF) test05
#
######

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
cleanall:: ; $(RMF) test01_dats.scad
cleanall:: ; $(RMF) test02_dats.scad
cleanall:: ; $(RMF) test03_dats.scad
cleanall:: ; $(RMF) test04_dats.scad
cleanall:: ; $(RMF) test05_dats.scad

###### end of [Makefile] ######
