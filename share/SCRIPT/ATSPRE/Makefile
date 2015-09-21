#
# A simple Makefile
#

## ****** ****** ##

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

## ****** ****** ##

prelude_cats: \
prelude_cats.dats \
CATS/integer_gen.dats \
; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

## ****** ****** ##

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.c
clean:: ; rm -f *_?ats.o

cleanall:: clean
cleanall:: ; rm -f prelude_cats

###### end of [Makefile] ######
