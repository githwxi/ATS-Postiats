#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

ATSGCFLAG=-D_ATS_GCATS

######

all::

######

all:: arith_prf.sats
arith_prf.sats: arith_prf_atxt.exe ; ./$< > $@
arith_prf_atxt.exe: arith_prf_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ arith_prf_atxt.dats -latsdoc
arith_prf_atxt.dats: arith_prf.atxt
	$(ATSDOC) --outcode $@ -i arith_prf.atxt > arith_prf_atxt.txt
clean:: ; $(RMF) arith_prf_atxt.exe
cleanall:: ; $(RMF) arith_prf.sats


all:: bool.sats
bool.sats: bool_atxt.exe ; ./$< > $@
bool_atxt.exe: bool_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ bool_atxt.dats -latsdoc
bool_atxt.dats: bool.atxt
	$(ATSDOC) --outcode $@ -i bool.atxt > bool_atxt.txt
clean:: ; $(RMF) bool_atxt.exe
cleanall:: ; $(RMF) bool.sats

all:: char.sats
char.sats: char_atxt.exe ; ./$< > $@
char_atxt.exe: char_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ char_atxt.dats -latsdoc
char_atxt.dats: char.atxt
	$(ATSDOC) --outcode $@ -i char.atxt > char_atxt.txt
clean:: ; $(RMF) char_atxt.exe
cleanall:: ; $(RMF) char.sats

all:: integer.sats
integer.sats: integer_atxt.exe ; ./$< > $@
integer_atxt.exe: integer_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ integer_atxt.dats -latsdoc
integer_atxt.dats: integer.atxt
	$(ATSDOC) --outcode $@ -i integer.atxt > integer_atxt.txt
clean:: ; $(RMF) integer_atxt.exe
cleanall:: ; $(RMF) integer.sats

all:: integer_ptr.sats
integer_ptr.sats: integer_ptr_atxt.exe ; ./$< > $@
integer_ptr_atxt.exe: integer_ptr_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ integer_ptr_atxt.dats -latsdoc
integer_ptr_atxt.dats: integer_ptr.atxt
	$(ATSDOC) --outcode $@ -i integer_ptr.atxt > integer_ptr_atxt.txt
clean:: ; $(RMF) integer_ptr_atxt.exe
cleanall:: ; $(RMF) integer_ptr.sats

all:: integer_fixed.sats
integer_fixed.sats: integer_fixed_atxt.exe ; ./$< > $@
integer_fixed_atxt.exe: integer_fixed_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ integer_fixed_atxt.dats -latsdoc
integer_fixed_atxt.dats: integer_fixed.atxt
	$(ATSDOC) --outcode $@ -i integer_fixed.atxt > integer_fixed_atxt.txt
clean:: ; $(RMF) integer_fixed_atxt.exe
cleanall:: ; $(RMF) integer_fixed.sats

all:: float.sats
float.sats: float_atxt.exe ; ./$< > $@
float_atxt.exe: float_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ float_atxt.dats -latsdoc
float_atxt.dats: float.atxt
	$(ATSDOC) --outcode $@ -i float.atxt > float_atxt.txt
clean:: ; $(RMF) float_atxt.exe
cleanall:: ; $(RMF) float.sats

all:: tuple.sats
tuple.sats: tuple_atxt.exe ; ./$< > $@
tuple_atxt.exe: tuple_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ tuple_atxt.dats -latsdoc
tuple_atxt.dats: tuple.atxt
	$(ATSDOC) --outcode $@ -i tuple.atxt > tuple_atxt.txt
clean:: ; $(RMF) tuple_atxt.exe
cleanall:: ; $(RMF) tuple.sats


all:: memory.sats
memory.sats: memory_atxt.exe ; ./$< > $@
memory_atxt.exe: memory_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ memory_atxt.dats -latsdoc
memory_atxt.dats: memory.atxt
	$(ATSDOC) --outcode $@ -i memory.atxt > memory_atxt.txt
clean:: ; $(RMF) memory_atxt.exe
cleanall:: ; $(RMF) memory.sats


all:: pointer.sats
pointer.sats: pointer_atxt.exe ; ./$< > $@
pointer_atxt.exe: pointer_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ pointer_atxt.dats -latsdoc
pointer_atxt.dats: pointer.atxt
	$(ATSDOC) --outcode $@ -i pointer.atxt > pointer_atxt.txt
clean:: ; $(RMF) pointer_atxt.exe
cleanall:: ; $(RMF) pointer.sats

all:: reference.sats
reference.sats: reference_atxt.exe ; ./$< > $@
reference_atxt.exe: reference_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ reference_atxt.dats -latsdoc
reference_atxt.dats: reference.atxt
	$(ATSDOC) --outcode $@ -i reference.atxt > reference_atxt.txt
clean:: ; $(RMF) reference_atxt.exe
cleanall:: ; $(RMF) reference.sats


all:: string.sats
string.sats: string_atxt.exe ; ./$< > $@
string_atxt.exe: string_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ string_atxt.dats -latsdoc
string_atxt.dats: string.atxt
	$(ATSDOC) --outcode $@ -i string.atxt > string_atxt.txt
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) string.sats

all:: strptr.sats
strptr.sats: strptr_atxt.exe ; ./$< > $@
strptr_atxt.exe: strptr_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ strptr_atxt.dats -latsdoc
strptr_atxt.dats: strptr.atxt
	$(ATSDOC) --outcode $@ -i strptr.atxt > strptr_atxt.txt
clean:: ; $(RMF) strptr_atxt.exe
cleanall:: ; $(RMF) strptr.sats


all:: filebas.sats
filebas.sats: filebas_atxt.exe ; ./$< > $@
filebas_atxt.exe: filebas_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ filebas_atxt.dats -latsdoc
filebas_atxt.dats: filebas.atxt
	$(ATSDOC) --outcode $@ -i filebas.atxt > filebas_atxt.txt
clean:: ; $(RMF) filebas_atxt.exe
cleanall:: ; $(RMF) filebas.sats

all:: intrange.sats
intrange.sats: intrange_atxt.exe ; ./$< > $@
intrange_atxt.exe: intrange_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ intrange_atxt.dats -latsdoc
intrange_atxt.dats: intrange.atxt
	$(ATSDOC) --outcode $@ -i intrange.atxt > intrange_atxt.txt
clean:: ; $(RMF) intrange_atxt.exe
cleanall:: ; $(RMF) intrange.sats


all:: gorder.sats
gorder.sats: gorder_atxt.exe ; ./$< > $@
gorder_atxt.exe: gorder_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ gorder_atxt.dats -latsdoc
gorder_atxt.dats: gorder.atxt
	$(ATSDOC) --outcode $@ -i gorder.atxt > gorder_atxt.txt
clean:: ; $(RMF) gorder_atxt.exe
cleanall:: ; $(RMF) gorder.sats

all:: gnumber.sats
gnumber.sats: gnumber_atxt.exe ; ./$< > $@
gnumber_atxt.exe: gnumber_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ gnumber_atxt.dats -latsdoc
gnumber_atxt.dats: gnumber.atxt
	$(ATSDOC) --outcode $@ -i gnumber.atxt > gnumber_atxt.txt
clean:: ; $(RMF) gnumber_atxt.exe
cleanall:: ; $(RMF) gnumber.sats


all:: unsafe.sats
unsafe.sats: unsafe_atxt.exe ; ./$< > $@
unsafe_atxt.exe: unsafe_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ unsafe_atxt.dats -latsdoc
unsafe_atxt.dats: unsafe.atxt
	$(ATSDOC) --outcode $@ -i unsafe.atxt > unsafe_atxt.txt
clean:: ; $(RMF) unsafe_atxt.exe
cleanall:: ; $(RMF) unsafe.sats

all:: checkast.sats
checkast.sats: checkast_atxt.exe ; ./$< > $@
checkast_atxt.exe: checkast_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ checkast_atxt.dats -latsdoc
checkast_atxt.dats: checkast.atxt
	$(ATSDOC) --outcode $@ -i checkast.atxt > checkast_atxt.txt
clean:: ; $(RMF) checkast_atxt.exe
cleanall:: ; $(RMF) checkast.sats


all:: list.sats
list.sats: list_atxt.exe ; ./$< > $@
list_atxt.exe: list_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ list_atxt.dats -latsdoc
list_atxt.dats: list.atxt
	$(ATSDOC) --outcode $@ -i list.atxt > list_atxt.txt
clean:: ; $(RMF) list_atxt.exe
cleanall:: ; $(RMF) list.sats

all:: list_vt.sats
list_vt.sats: list_vt_atxt.exe ; ./$< > $@
list_vt_atxt.exe: list_vt_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ list_vt_atxt.dats -latsdoc
list_vt_atxt.dats: list_vt.atxt
	$(ATSDOC) --outcode $@ -i list_vt.atxt > list_vt_atxt.txt
clean:: ; $(RMF) list_vt_atxt.exe
cleanall:: ; $(RMF) list_vt.sats


all:: option.sats
option.sats: option_atxt.exe ; ./$< > $@
option_atxt.exe: option_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ option_atxt.dats -latsdoc
option_atxt.dats: option.atxt
	$(ATSDOC) --outcode $@ -i option.atxt > option_atxt.txt
clean:: ; $(RMF) option_atxt.exe
cleanall:: ; $(RMF) option.sats

all:: option_vt.sats
option_vt.sats: option_vt_atxt.exe ; ./$< > $@
option_vt_atxt.exe: option_vt_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ option_vt_atxt.dats -latsdoc
option_vt_atxt.dats: option_vt.atxt
	$(ATSDOC) --outcode $@ -i option_vt.atxt > option_vt_atxt.txt
clean:: ; $(RMF) option_vt_atxt.exe
cleanall:: ; $(RMF) option_vt.sats


all:: array.sats
array.sats: array_atxt.exe ; ./$< > $@
array_atxt.exe: array_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ array_atxt.dats -latsdoc
array_atxt.dats: array.atxt
	$(ATSDOC) --outcode $@ -i array.atxt > array_atxt.txt
clean:: ; $(RMF) array_atxt.exe
cleanall:: ; $(RMF) array.sats

all:: array_prf.sats
array_prf.sats: array_prf_atxt.exe ; ./$< > $@
array_prf_atxt.exe: array_prf_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ array_prf_atxt.dats -latsdoc
array_prf_atxt.dats: array_prf.atxt
	$(ATSDOC) --outcode $@ -i array_prf.atxt > array_prf_atxt.txt
clean:: ; $(RMF) array_prf_atxt.exe
cleanall:: ; $(RMF) array_prf.sats

all:: arrayptr.sats
arrayptr.sats: arrayptr_atxt.exe ; ./$< > $@
arrayptr_atxt.exe: arrayptr_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ arrayptr_atxt.dats -latsdoc
arrayptr_atxt.dats: arrayptr.atxt
	$(ATSDOC) --outcode $@ -i arrayptr.atxt > arrayptr_atxt.txt
clean:: ; $(RMF) arrayptr_atxt.exe
cleanall:: ; $(RMF) arrayptr.sats

all:: arrayref.sats
arrayref.sats: arrayref_atxt.exe ; ./$< > $@
arrayref_atxt.exe: arrayref_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ arrayref_atxt.dats -latsdoc
arrayref_atxt.dats: arrayref.atxt
	$(ATSDOC) --outcode $@ -i arrayref.atxt > arrayref_atxt.txt
clean:: ; $(RMF) arrayref_atxt.exe
cleanall:: ; $(RMF) arrayref.sats


all:: matrix.sats
matrix.sats: matrix_atxt.exe ; ./$< > $@
matrix_atxt.exe: matrix_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ matrix_atxt.dats -latsdoc
matrix_atxt.dats: matrix.atxt
	$(ATSDOC) --outcode $@ -i matrix.atxt > matrix_atxt.txt
clean:: ; $(RMF) matrix_atxt.exe
cleanall:: ; $(RMF) matrix.sats

all:: matrixptr.sats
matrixptr.sats: matrixptr_atxt.exe ; ./$< > $@
matrixptr_atxt.exe: matrixptr_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ matrixptr_atxt.dats -latsdoc
matrixptr_atxt.dats: matrixptr.atxt
	$(ATSDOC) --outcode $@ -i matrixptr.atxt > matrixptr_atxt.txt
clean:: ; $(RMF) matrixptr_atxt.exe
cleanall:: ; $(RMF) matrixptr.sats

all:: matrixref.sats
matrixref.sats: matrixref_atxt.exe ; ./$< > $@
matrixref_atxt.exe: matrixref_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ matrixref_atxt.dats -latsdoc
matrixref_atxt.dats: matrixref.atxt
	$(ATSDOC) --outcode $@ -i matrixref.atxt > matrixref_atxt.txt
clean:: ; $(RMF) matrixref_atxt.exe
cleanall:: ; $(RMF) matrixref.sats


all:: stream.sats
stream.sats: stream_atxt.exe ; ./$< > $@
stream_atxt.exe: stream_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ stream_atxt.dats -latsdoc
stream_atxt.dats: stream.atxt
	$(ATSDOC) --outcode $@ -i stream.atxt > stream_atxt.txt
clean:: ; $(RMF) stream_atxt.exe
cleanall:: ; $(RMF) stream.sats

all:: stream_vt.sats
stream_vt.sats: stream_vt_atxt.exe ; ./$< > $@
stream_vt_atxt.exe: stream_vt_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ stream_vt_atxt.dats -latsdoc
stream_vt_atxt.dats: stream_vt.atxt
	$(ATSDOC) --outcode $@ -i stream_vt.atxt > stream_vt_atxt.txt
clean:: ; $(RMF) stream_vt_atxt.exe
cleanall:: ; $(RMF) stream_vt.sats


all:: gprint.sats
gprint.sats: gprint_atxt.exe ; ./$< > $@
gprint_atxt.exe: gprint_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ gprint_atxt.dats -latsdoc
gprint_atxt.dats: gprint.atxt
	$(ATSDOC) --outcode $@ -i gprint.atxt > gprint_atxt.txt
clean:: ; $(RMF) gprint_atxt.exe
cleanall:: ; $(RMF) gprint.sats

all:: giterator.sats
giterator.sats: giterator_atxt.exe ; ./$< > $@
giterator_atxt.exe: giterator_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ giterator_atxt.dats -latsdoc
giterator_atxt.dats: giterator.atxt
	$(ATSDOC) --outcode $@ -i giterator.atxt > giterator_atxt.txt
clean:: ; $(RMF) giterator_atxt.exe
cleanall:: ; $(RMF) giterator.sats


all:: fcontainer.sats
fcontainer.sats: fcontainer_atxt.exe ; ./$< > $@
fcontainer_atxt.exe: fcontainer_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ fcontainer_atxt.dats -latsdoc
fcontainer_atxt.dats: fcontainer.atxt
	$(ATSDOC) --outcode $@ -i fcontainer.atxt > fcontainer_atxt.txt
clean:: ; $(RMF) fcontainer_atxt.exe
cleanall:: ; $(RMF) fcontainer.sats



all:: parray.sats
parray.sats: parray_atxt.exe ; ./$< > $@
parray_atxt.exe: parray_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ parray_atxt.dats -latsdoc
parray_atxt.dats: parray.atxt
	$(ATSDOC) --outcode $@ -i parray.atxt > parray_atxt.txt
clean:: ; $(RMF) parray_atxt.exe
cleanall:: ; $(RMF) parray.sats


all:: extern.sats
extern.sats: extern_atxt.exe ; ./$< > $@
extern_atxt.exe: extern_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ extern_atxt.dats -latsdoc
extern_atxt.dats: extern.atxt
	$(ATSDOC) --outcode $@ -i extern.atxt > extern_atxt.txt
clean:: ; $(RMF) extern_atxt.exe
cleanall:: ; $(RMF) extern.sats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
