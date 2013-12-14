#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all::fcopy1
all::fcopy2
all::fcopy3

######

fcopy1: fcopy1.dats ; $(PATSCC) -o $@ $<
fcopy2: fcopy2.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
fcopy3: fcopy3.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

RMF=rm -f

######

clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) fcopy1
cleanall:: ; $(RMF) fcopy2
cleanall:: ; $(RMF) fcopy3

######

###### end of [Makefile] ######
