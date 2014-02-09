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

intexp: intexp_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

bstree: bstree_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC $(INCLUDES) $(CFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

######

%_dats.c: %.dats ; \
  $(PATSOPT) $(ATSCFLAGS) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) misc
cleanall:: ; $(RMF) intexp
cleanall:: ; $(RMF) bstree

######

###### end of [Makefile] ######
