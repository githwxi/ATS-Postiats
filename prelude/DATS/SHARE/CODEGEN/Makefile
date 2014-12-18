#
#
# A simple Makefile
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######
#
GCFLAG=
#
# GCFLAG=-D_ATS_GCATS
#
######

all::

######

all:: gorder_int.dats
gorder_int.dats: gorder_int_atxt.exe ; ./$< > $@
gorder_int_atxt.exe: gorder_int_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gorder_int_atxt.dats -latsdoc
gorder_int_atxt.dats: gorder_int.atxt
	$(ATSDOC) --outcode $@ -i gorder_int.atxt > gorder_int_atxt.txt
clean:: ; $(RMF) gorder_int_atxt.exe
cleanall:: ; $(RMF) gorder_int.dats

all:: gorder_uint.dats
gorder_uint.dats: gorder_uint_atxt.exe ; ./$< > $@
gorder_uint_atxt.exe: gorder_uint_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gorder_uint_atxt.dats -latsdoc
gorder_uint_atxt.dats: gorder_uint.atxt
	$(ATSDOC) --outcode $@ -i gorder_uint.atxt > gorder_uint_atxt.txt
clean:: ; $(RMF) gorder_uint_atxt.exe
cleanall:: ; $(RMF) gorder_uint.dats

all:: gorder_bool.dats
gorder_bool.dats: gorder_bool_atxt.exe ; ./$< > $@
gorder_bool_atxt.exe: gorder_bool_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gorder_bool_atxt.dats -latsdoc
gorder_bool_atxt.dats: gorder_bool.atxt
	$(ATSDOC) --outcode $@ -i gorder_bool.atxt > gorder_bool_atxt.txt
clean:: ; $(RMF) gorder_bool_atxt.exe
cleanall:: ; $(RMF) gorder_bool.dats

all:: gorder_char.dats
gorder_char.dats: gorder_char_atxt.exe ; ./$< > $@
gorder_char_atxt.exe: gorder_char_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gorder_char_atxt.dats -latsdoc
gorder_char_atxt.dats: gorder_char.atxt
	$(ATSDOC) --outcode $@ -i gorder_char.atxt > gorder_char_atxt.txt
clean:: ; $(RMF) gorder_char_atxt.exe
cleanall:: ; $(RMF) gorder_char.dats

all:: gorder_float.dats
gorder_float.dats: gorder_float_atxt.exe ; ./$< > $@
gorder_float_atxt.exe: gorder_float_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gorder_float_atxt.dats -latsdoc
gorder_float_atxt.dats: gorder_float.atxt
	$(ATSDOC) --outcode $@ -i gorder_float.atxt > gorder_float_atxt.txt
clean:: ; $(RMF) gorder_float_atxt.exe
cleanall:: ; $(RMF) gorder_float.dats

all:: gorder_string.dats
gorder_string.dats: gorder_string_atxt.exe ; ./$< > $@
gorder_string_atxt.exe: gorder_string_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gorder_string_atxt.dats -latsdoc
gorder_string_atxt.dats: gorder_string.atxt
	$(ATSDOC) --outcode $@ -i gorder_string.atxt > gorder_string_atxt.txt
clean:: ; $(RMF) gorder_string_atxt.exe
cleanall:: ; $(RMF) gorder_string.dats


######

all:: gnumber_int.dats
gnumber_int.dats: gnumber_int_atxt.exe ; ./$< > $@
gnumber_int_atxt.exe: gnumber_int_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gnumber_int_atxt.dats -latsdoc
gnumber_int_atxt.dats: gnumber_int.atxt
	$(ATSDOC) --outcode $@ -i gnumber_int.atxt > gnumber_int_atxt.txt
clean:: ; $(RMF) gnumber_int_atxt.exe
cleanall:: ; $(RMF) gnumber_int.dats

all:: gnumber_uint.dats
gnumber_uint.dats: gnumber_uint_atxt.exe ; ./$< > $@
gnumber_uint_atxt.exe: gnumber_uint_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gnumber_uint_atxt.dats -latsdoc
gnumber_uint_atxt.dats: gnumber_uint.atxt
	$(ATSDOC) --outcode $@ -i gnumber_uint.atxt > gnumber_uint_atxt.txt
clean:: ; $(RMF) gnumber_uint_atxt.exe
cleanall:: ; $(RMF) gnumber_uint.dats

all:: gnumber_float.dats
gnumber_float.dats: gnumber_float_atxt.exe ; ./$< > $@
gnumber_float_atxt.exe: gnumber_float_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gnumber_float_atxt.dats -latsdoc
gnumber_float_atxt.dats: gnumber_float.atxt
	$(ATSDOC) --outcode $@ -i gnumber_float.atxt > gnumber_float_atxt.txt
clean:: ; $(RMF) gnumber_float_atxt.exe
cleanall:: ; $(RMF) gnumber_float.dats


######

all:: list_vt_mergesort.dats
list_vt_mergesort.dats: list_vt_mergesort_atxt.exe ; ./$< > $@
list_vt_mergesort_atxt.exe: list_vt_mergesort_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ list_vt_mergesort_atxt.dats -latsdoc
list_vt_mergesort_atxt.dats: list_vt_mergesort.atxt
	$(ATSDOC) --outcode $@ -i list_vt_mergesort.atxt > list_vt_mergesort_atxt.txt
clean:: ; $(RMF) list_vt_mergesort_atxt.exe
cleanall:: ; $(RMF) list_vt_mergesort.dats

all:: list_vt_quicksort.dats
list_vt_quicksort.dats: list_vt_quicksort_atxt.exe ; ./$< > $@
list_vt_quicksort_atxt.exe: list_vt_quicksort_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ list_vt_quicksort_atxt.dats -latsdoc
list_vt_quicksort_atxt.dats: list_vt_quicksort.atxt
	$(ATSDOC) --outcode $@ -i list_vt_quicksort.atxt > list_vt_quicksort_atxt.txt
clean:: ; $(RMF) list_vt_quicksort_atxt.exe
cleanall:: ; $(RMF) list_vt_quicksort.dats


######

all:: array_bsearch.dats
array_bsearch.dats: array_bsearch_atxt.exe ; ./$< > $@
array_bsearch_atxt.exe: array_bsearch_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ array_bsearch_atxt.dats -latsdoc
array_bsearch_atxt.dats: array_bsearch.atxt
	$(ATSDOC) --outcode $@ -i array_bsearch.atxt > array_bsearch_atxt.txt
clean:: ; $(RMF) array_bsearch_atxt.exe
cleanall:: ; $(RMF) array_bsearch.dats

all:: array_quicksort.dats
array_quicksort.dats: array_quicksort_atxt.exe ; ./$< > $@
array_quicksort_atxt.exe: array_quicksort_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ array_quicksort_atxt.dats -latsdoc
array_quicksort_atxt.dats: array_quicksort.atxt
	$(ATSDOC) --outcode $@ -i array_quicksort.atxt > array_quicksort_atxt.txt
clean:: ; $(RMF) array_quicksort_atxt.exe
cleanall:: ; $(RMF) array_quicksort.dats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
