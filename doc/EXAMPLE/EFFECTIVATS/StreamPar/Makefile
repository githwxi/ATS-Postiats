######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

PATSCC2=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2
PATSCC3=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_GCBDW -O2

######

MYTEXTING=./../MYTEXT/bin/mytexting

######

all::
regress::
cleanall::

######
#
all:: \
main.html
main.html: \
main.atxt ; $(MYTEXTING) -o $@ -i $<
#
######
#
QueenPuzzle: \
QueenPuzzle.dats; $(PATSCC2) -o $@ $< -latslib
#
regress:: QueenPuzzle; ./$<
cleanall:: ; $(RMF) QueenPuzzle
#
######
#
StreamPar_misc: \
StreamPar_misc.dats; $(PATSCC2) -o $@ $< -latslib
#
regress:: StreamPar_misc; ./$<
cleanall:: ; $(RMF) StreamPar_misc
#
######
#
StreamPar_binge: \
StreamPar_binge.dats; \
$(PATSCC3) \
-I $(PATSHOME)/contrib -o $@ $< -latslib -lpcre -lpthread -lgc
#
regress:: StreamPar_binge; ./$<
cleanall:: ; $(RMF) StreamPar_binge
#
######
#
NPM=npm
#
npm-update:: ; (NPM) update
npm-install:: ; $(NPM) install
#
######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/StreamPar/

######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f
RMRF=rm -rf

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMRF) node_modules
#
######

###### end of [Makefile] ######
