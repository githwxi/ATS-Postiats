#
# A Simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

CC=gcc -std=c99 -D_XOPEN_SOURCE
CC=clang -std=c99 -D_XOPEN_SOURCE

######

all:: test

######
#
# HX: this example shows a straightforward way of using one's own malloc/free.
#
######

test: \
  program-1-2_dats.c \
  program-1-2-test_dats.c ; \
  $(CC) -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -DATS_MEMALLOC_USER -O2 -o $@ myruntime.c $^

######

%_dats.c: %.dats; $(PATSOPT) -IATS${PATSHOME}/contrib --output $@ --dynamic $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) test

######

###### end of [Makefile] ######