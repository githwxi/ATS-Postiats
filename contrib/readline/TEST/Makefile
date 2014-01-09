#
# A simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

LDFLAGS += -lreadline

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

all:: test00
test00: test00.dats ; $(PATSCC2) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test00

######

all:: test01
test01: test01.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test02

######

include \
$(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######