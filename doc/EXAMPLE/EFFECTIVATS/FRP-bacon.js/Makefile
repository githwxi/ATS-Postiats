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

MYTEXTING=./../MYTEXT/bin/mytexting

######
#
all:: \
main.html
main.html: main.atxt ; $(MYTEXTING) -o $@ -i $<
#
######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/FRP-bacon.js/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) main.html
#
######

###### end of [Makefile] ######
