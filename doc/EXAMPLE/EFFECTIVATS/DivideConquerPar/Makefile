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
ParFibo: \
ParFibo.dats; \
$(PATSCC2) -o $@ $< -latslib -lgc -lpthread
#
regress:: ParFibo; ./$<
cleanall:: ; $(RMF) ParFibo
#
######
#
DirWalk: \
DirWalk.dats; \
$(PATSCC2) -o $@ $< -latslib -lgc -lpthread
#
regress:: DirWalk; ./$<
cleanall:: ; $(RMF) DirWalk
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
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DivideConquerPar/

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
cleanall:: ; $(RMF) ParFibo
cleanall:: ; $(RMF) DirWalk
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMRF) node_modules
cleanall:: ; $(RMRF) package-lock.json
#
######

###### end of [Makefile] ######
