######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
MYATSCC=$(PATSHOME)/bin/myatscc
ATSCC2JS=$(PATSHOME)/bin/atscc2js

######

all::

######
#
all:: \
DigitClock_dats.js
#
DigitClock_dats.c: DigitClock.dats; $(PATSCC) -ccats $<
DigitClock_dats.js: DigitClock_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
all:: \
Sierpinski_dats.js
#
Sierpinski_dats.c: Sierpinski.dats; $(PATSCC) -ccats $<
Sierpinski_dats.js: Sierpinski_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.c

######

cleanall:: clean
cleanall:: ; rm -f *_dats.js

######

testall:: all
testall:: regress
testall:: cleanall

###### end of [Makefile] ######
