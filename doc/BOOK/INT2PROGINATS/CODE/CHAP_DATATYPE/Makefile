#
# A simple Makefile
#

######

CCOPT=gcc -std=c99 -D_GNU_SOURCE
PATSOPT=$(PATSHOME)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CFLAGS=-O2
ATSCFLAGS=

######

all:: misc
all:: intexp
all:: bstree

######

misc: misc_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: misc; ./misc
cleanall:: ; $(RMF) misc

######

intexp: intexp_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: intexp; ./intexp
cleanall:: ; $(RMF) intexp

######

bstree: bstree_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: bstree; ./bstree
cleanall:: ; $(RMF) bstree

######

%_dats.c: %.dats ; \
  $(PATSOPT) $(ATSCFLAGS) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
