#
# A simple Makefile for
# testing the ATS API for OpenMP
#

######

ifdef CCFOMP
else
CCFOMP=-fopenmp
endif

######

include $(PATSHOME)/share/atsmake-pre.mk

######

LDFLAGS += 

######

CFLAGS += $(CCFOMP)

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

all:: hello
hello: hello.dats ; $(PATSCC2) $(CFLAGS) -o $@ $< $(LDFLAGS) 
cleanall:: ; $(RMF) hello

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
