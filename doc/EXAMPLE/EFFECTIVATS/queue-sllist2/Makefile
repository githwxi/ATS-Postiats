#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all:: queue-sllist2

######

queue-sllist2: queue-sllist2.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/queue-sllist2/

######

RMF=rm -f

######

clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) queue-sllist2

######

###### end of [Makefile] ######