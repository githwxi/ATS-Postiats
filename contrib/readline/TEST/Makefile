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

all:: test01
test01: test01.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test01

######

include \
$(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######