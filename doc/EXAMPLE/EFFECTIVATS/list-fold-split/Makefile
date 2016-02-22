#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

PATSCC2=$(PATSCC) -DATS_MEMALLOC_LIBC -O2

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

RMF=rm -f

######

clean:: ; $(RMF) *~

######

cleanall:: clean
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) *_?ats.html

######

###### end of [Makefile] ######
