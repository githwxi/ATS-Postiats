#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

PATSCC2=$(PATSCC) -O2 -DATS_MEMALLOC_LIBC

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: mergesort
mergesort: ; $(PATSCC) -tcats mergesort.dats

all:: mergesort_list
mergesort_list: ; $(PATSCC2) -o $@ mergesort_list.dats
cleanall:: ; $(RMF) mergesort_list

all:: mergesort_array
mergesort_array: ; $(PATSCC2) -o $@ mergesort_array.dats
cleanall:: ; $(RMF) mergesort_array

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

main.exe: \
  main_atxt.dats ; \
  $(ATSCC) \
  -IATS $(PATSHOME) -IATS $(ATSHOME) \
  -I$(PATSHOME)/src -D_ATS_GCATS -o $@ $< \
  -L$(PATSHOME)/libatsynmark -latsynmark -latsdoc

main_atxt.dats: \
  main.atxt; $(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
main.html: main.exe ; ./main.exe > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/mergesort/

######

clean:: cleanats
clean:: ; $(RMF) main_atxt.txt
clean:: ; $(RMF) main_atxt.dats

######

cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html

######

###### end of [Makefile] ######
