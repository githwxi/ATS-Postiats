#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######
#
# HX:
# this example shows a straightforward way
# one's own malloc/free.
#
######

all:: test
test: \
  program-1-2_dats.c \
  program-1-2-test_dats.c ; \
  $(PATSCC2) -DATS_MEMALLOC_USER -O2 -o $@ myruntime.c $^
cleanall:: ; $(RMF) test

######

%_dats.c: %.dats; $(PATSOPT) --output $@ --dynamic $<

######

cleanats:: ; $(RMF) *_dats.c

###### end of [Makefile] ######
