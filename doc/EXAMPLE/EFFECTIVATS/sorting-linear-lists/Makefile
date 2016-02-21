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

all:: \
mergesort_sllist
mergesort_sllist: \
  mergesort_sllist.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $^
regress:: mergesort_sllist ; ./$<
cleanall:: ; $(RMF) mergesort_sllist

######

all:: \
mergesort_list_vt
mergesort_list_vt: \
  mergesort_list_vt.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $^
regress:: mergesort_list_vt ; ./$<
cleanall:: ; $(RMF) mergesort_list_vt

######

all:: \
quicksort_sllist
quicksort_sllist: \
  quicksort_sllist.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $^
regress:: quicksort_sllist ; ./$<
cleanall:: ; $(RMF) quicksort_sllist

######

all:: \
quicksort_list_vt
quicksort_list_vt: \
  quicksort_list_vt.dats ; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $^
regress:: quicksort_list_vt ; ./$<
cleanall:: ; $(RMF) quicksort_list_vt

######
#
PATS2XHTML=\
$(PATSHOMEQ)/bin/pats2xhtml
#
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
LDPATH += -L$(PATSHOME)/utils/libatsopt
LDPATH += -L$(PATSHOME)/utils/libatsynmark

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

main.html: main.exe ; ./main.exe > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/sorting-linear-lists/

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
