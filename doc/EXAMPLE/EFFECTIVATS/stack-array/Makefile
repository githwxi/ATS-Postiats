#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all:: postfix_eval

######

postfix_eval: postfix_eval.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/stack-array/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) postfix_eval

######

###### end of [Makefile] ######