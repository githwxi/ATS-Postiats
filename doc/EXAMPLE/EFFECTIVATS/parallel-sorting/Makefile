#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

PATSCC2=$(PATSCC) -DATS_MEMALLOC_LIBC -O2

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######
#
PATS2XHTML=$(PATSHOMEQ)/bin/pats2xhtml
%_sats.html: %.sats ; $(PATS2XHTML) -o $@ -s $<
%_dats.html: %.dats ; $(PATS2XHTML) -o $@ -d $<
#
######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

INPATH :=
INPATH += -I$(PATSHOME)/src
INPATH += -IATS $(PATSHOME) -IATS $(ATSHOME)

LDPATH :=
LDPATH += -L$(PATSHOME)/ccomp/atslib/lib
#LDPATH += -L$(PATSHOME)/utils/libatsopt
#LDPATH += -L$(PATSHOME)/utils/libatsynmark

LIBRARY :=
LIBRARY := -latsynmark -latsdoc -latsopt -lats -lgmp

######
#
main.exe: \
main_atxt.dats ; \
$(ATSCC) \
  -D_ATS_GCATS \
  $(INPATH) -o $@ $< $(LDPATH) $(LIBRARY)
#
main_atxt.dats: main.atxt; \
$(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
#
######

all:: \
main.html
main.html: main.exe ; ./main.exe > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/parallel-sorting/

######

typecheck:: mergesort.dats; $(PATSCC) -tcats $<
typecheck:: mergesort_cps.dats; $(PATSCC) -tcats $<
typecheck:: mergesort_par_cps.dats; $(PATSCC) -tcats $<

######

cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) main_atxt.txt
cleanats:: ; $(RMF) main_atxt.dats

######

cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) *_?ats.html

######

###### end of [Makefile] ######
