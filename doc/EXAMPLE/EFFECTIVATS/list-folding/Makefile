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

main.html: main.atxt ; $(MYATEXTING) -o $@ -i $<

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/sorting-linear-lists/

######

list-fold-left: list-fold-left.dats; $(PATSCC2) -o $@ $<
list-fold-right: list-fold-right.dats; $(PATSCC2) -o $@ $<
list-fold-split: list-fold-split.dats; $(PATSCC2) -o $@ $<

######

regress:: list-fold-left; ./$<
regress:: list-fold-right; ./$<
regress:: list-fold-split; ./$<

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
cleanall:: ; $(RMF) list-fold-left
cleanall:: ; $(RMF) list-fold-right
cleanall:: ; $(RMF) list-fold-split

######

###### end of [Makefile] ######
