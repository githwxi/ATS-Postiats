#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all::tailrec

######

tailrec: tailrec.dats ; $(PATSCC) -tcats $@ $<

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/loop-as-tailrec/

######

RMF=rm -f

######

clean:: ; $(RMF) *~

######

cleanall:: clean

######

###### end of [Makefile] ######
