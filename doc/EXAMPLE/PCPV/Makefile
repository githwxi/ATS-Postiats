#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::

######

all:: bsearch_arr
bsearch_arr: bsearch_arr.dats ; $(PATSOPT) --typecheck --dynamic bsearch_arr.dats

######

all:: quicksort_lst
quicksort_lst: quicksort_lst.dats ; $(PATSOPT) --typecheck --dynamic quicksort_lst.dats

######

LNS=ln -s
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
