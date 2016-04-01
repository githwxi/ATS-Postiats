#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

PATSCC2=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2

######

MYATEXTING=./../ATEXT/bin/myatexting

######

all:: main.html
main.html: main.atxt ; $(MYATEXTING) -o $@ -i $<

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/list-folding/

######

list_fold_left: list_fold_left.dats; $(PATSCC2) -o $@ $<
list_fold_right: list_fold_right.dats; $(PATSCC2) -o $@ $<
list_fold_split: list_fold_split.dats; $(PATSCC2) -o $@ $<

######

regress:: list_fold_left; ./$<
regress:: list_fold_right; ./$<
regress:: list_fold_split; ./$<

######

testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) list_fold_left
cleanall:: ; $(RMF) list_fold_right
cleanall:: ; $(RMF) list_fold_split

######

###### end of [Makefile] ######
