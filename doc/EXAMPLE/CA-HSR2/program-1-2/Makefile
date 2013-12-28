#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CCOMP=gcc -std=c99 -D_XOPEN_SOURCE
CCOMP=clang -std=c99 -D_XOPEN_SOURCE

######

CFLAGS=-I${PATSHOME} -I${PATSHOME}/ccomp/runtime 

######
#
# HX: this example shows a straightforward way of using one's own malloc/free.
#
######

all:: test
test: \
  program-1-2_dats.c \
  program-1-2-test_dats.c ; \
  $(CCOMP) -DATS_MEMALLOC_USER $(CFLAGS) -O2 -o $@ myruntime.c $^
cleanall:: ; $(RMF) test

######

%_dats.c: %.dats; \
  $(PATSOPT) -IATS${PATSHOME}/contrib --output $@ --dynamic $<

######

include $(PATSHOME)/share/atsmake-post.mk

######

clean:: cleanats

######

###### end of [Makefile] ######