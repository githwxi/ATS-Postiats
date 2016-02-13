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

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSOLVE=$(PATSHOME)/bin/patsolve_z3

######

all::

######

all:: \
bsearch_arr
bsearch_arr: \
bsearch_arr.dats ; \
$(PATSOPT) --typecheck --dynamic bsearch_arr.dats

######

all:: \
quicksort_lst
quicksort_lst: \
quicksort_lst.dats ; \
$(PATSOPT) --typecheck --dynamic quicksort_lst.dats

######

insort_lst:: \
insort_lst.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i

######

mergesort_lst:: \
mergesort_lst.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i

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
