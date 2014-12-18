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

all:: integer.dats
integer.dats: integer_atxt.exe ; ./$< > $@
integer_atxt.exe: integer_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ integer_atxt.dats -latsdoc
integer_atxt.dats: integer.atxt
	$(ATSDOC) --outcode $@ -i integer.atxt > integer_atxt.txt
clean:: ; $(RMF) integer_atxt.exe
cleanall:: ; $(RMF) integer.dats

all:: pointer.dats
pointer.dats: pointer_atxt.exe ; ./$< > $@
pointer_atxt.exe: pointer_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ pointer_atxt.dats -latsdoc
pointer_atxt.dats: pointer.atxt
	$(ATSDOC) --outcode $@ -i pointer.atxt > pointer_atxt.txt
clean:: ; $(RMF) pointer_atxt.exe
cleanall:: ; $(RMF) pointer.dats

all:: memory.dats
memory.dats: memory_atxt.exe ; ./$< > $@
memory_atxt.exe: memory_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ memory_atxt.dats -latsdoc
memory_atxt.dats: memory.atxt
	$(ATSDOC) --outcode $@ -i memory.atxt > memory_atxt.txt
clean:: ; $(RMF) memory_atxt.exe
cleanall:: ; $(RMF) memory.dats


all:: bool.dats
bool.dats: bool_atxt.exe ; ./$< > $@
bool_atxt.exe: bool_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ bool_atxt.dats -latsdoc
bool_atxt.dats: bool.atxt
	$(ATSDOC) --outcode $@ -i bool.atxt > bool_atxt.txt
clean:: ; $(RMF) bool_atxt.exe
cleanall:: ; $(RMF) bool.dats

all:: char.dats
char.dats: char_atxt.exe ; ./$< > $@
char_atxt.exe: char_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ char_atxt.dats -latsdoc
char_atxt.dats: char.atxt
	$(ATSDOC) --outcode $@ -i char.atxt > char_atxt.txt
clean:: ; $(RMF) char_atxt.exe
cleanall:: ; $(RMF) char.dats

all:: float.dats
float.dats: float_atxt.exe ; ./$< > $@
float_atxt.exe: float_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ float_atxt.dats -latsdoc
float_atxt.dats: float.atxt
	$(ATSDOC) --outcode $@ -i float.atxt > float_atxt.txt
clean:: ; $(RMF) float_atxt.exe
cleanall:: ; $(RMF) float.dats

all:: string.dats
string.dats: string_atxt.exe ; ./$< > $@
string_atxt.exe: string_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ string_atxt.dats -latsdoc
string_atxt.dats: string.atxt
	$(ATSDOC) --outcode $@ -i string.atxt > string_atxt.txt
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) string.dats

all:: strptr.dats
strptr.dats: strptr_atxt.exe ; ./$< > $@
strptr_atxt.exe: strptr_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ strptr_atxt.dats -latsdoc
strptr_atxt.dats: strptr.atxt
	$(ATSDOC) --outcode $@ -i strptr.atxt > strptr_atxt.txt
clean:: ; $(RMF) strptr_atxt.exe
cleanall:: ; $(RMF) strptr.dats


all:: tuple.dats
tuple.dats: tuple_atxt.exe ; ./$< > $@
tuple_atxt.exe: tuple_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ tuple_atxt.dats -latsdoc
tuple_atxt.dats: tuple.atxt
	$(ATSDOC) --outcode $@ -i tuple.atxt > tuple_atxt.txt
clean:: ; $(RMF) tuple_atxt.exe
cleanall:: ; $(RMF) tuple.dats


all:: reference.dats
reference.dats: reference_atxt.exe ; ./$< > $@
reference_atxt.exe: reference_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ reference_atxt.dats -latsdoc
reference_atxt.dats: reference.atxt
	$(ATSDOC) --outcode $@ -i reference.atxt > reference_atxt.txt
clean:: ; $(RMF) reference_atxt.exe
cleanall:: ; $(RMF) reference.dats


all:: arith_prf.dats
arith_prf.dats: arith_prf_atxt.exe ; ./$< > $@
arith_prf_atxt.exe: arith_prf_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ arith_prf_atxt.dats -latsdoc
arith_prf_atxt.dats: arith_prf.atxt
	$(ATSDOC) --outcode $@ -i arith_prf.atxt > arith_prf_atxt.txt
clean:: ; $(RMF) arith_prf_atxt.exe
cleanall:: ; $(RMF) arith_prf.dats

all:: integer_fixed.dats
integer_fixed.dats: integer_fixed_atxt.exe ; ./$< > $@
integer_fixed_atxt.exe: integer_fixed_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ integer_fixed_atxt.dats -latsdoc
integer_fixed_atxt.dats: integer_fixed.atxt
	$(ATSDOC) --outcode $@ -i integer_fixed.atxt > integer_fixed_atxt.txt
clean:: ; $(RMF) integer_fixed_atxt.exe
cleanall:: ; $(RMF) integer_fixed.dats


all:: unsafe.dats
unsafe.dats: unsafe_atxt.exe ; ./$< > $@
unsafe_atxt.exe: unsafe_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ unsafe_atxt.dats -latsdoc
unsafe_atxt.dats: unsafe.atxt
	$(ATSDOC) --outcode $@ -i unsafe.atxt > unsafe_atxt.txt
clean:: ; $(RMF) unsafe_atxt.exe
cleanall:: ; $(RMF) unsafe.dats

all:: checkast.dats
checkast.dats: checkast_atxt.exe ; ./$< > $@
checkast_atxt.exe: checkast_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ checkast_atxt.dats -latsdoc
checkast_atxt.dats: checkast.atxt
	$(ATSDOC) --outcode $@ -i checkast.atxt > checkast_atxt.txt
clean:: ; $(RMF) checkast_atxt.exe
cleanall:: ; $(RMF) checkast.dats


all:: filebas.dats
filebas.dats: filebas_atxt.exe ; ./$< > $@
filebas_atxt.exe: filebas_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ filebas_atxt.dats -latsdoc
filebas_atxt.dats: filebas.atxt
	$(ATSDOC) --outcode $@ -i filebas.atxt > filebas_atxt.txt
clean:: ; $(RMF) filebas_atxt.exe
cleanall:: ; $(RMF) filebas.dats

all:: filebas_prf.dats
filebas_prf.dats: filebas_prf_atxt.exe ; ./$< > $@
filebas_prf_atxt.exe: filebas_prf_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ filebas_prf_atxt.dats -latsdoc
filebas_prf_atxt.dats: filebas_prf.atxt
	$(ATSDOC) --outcode $@ -i filebas_prf.atxt > filebas_prf_atxt.txt
clean:: ; $(RMF) filebas_prf_atxt.exe
cleanall:: ; $(RMF) filebas_prf.dats

all:: intrange.dats
intrange.dats: intrange_atxt.exe ; ./$< > $@
intrange_atxt.exe: intrange_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ intrange_atxt.dats -latsdoc
intrange_atxt.dats: intrange.atxt
	$(ATSDOC) --outcode $@ -i intrange.atxt > intrange_atxt.txt
clean:: ; $(RMF) intrange_atxt.exe
cleanall:: ; $(RMF) intrange.dats


all:: basics.dats
basics.dats: basics_atxt.exe ; ./$< > $@
basics_atxt.exe: basics_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ basics_atxt.dats -latsdoc
basics_atxt.dats: basics.atxt
	$(ATSDOC) --outcode $@ -i basics.atxt > basics_atxt.txt
clean:: ; $(RMF) basics_atxt.exe
cleanall:: ; $(RMF) basics.dats


all:: gorder.dats
gorder.dats: gorder_atxt.exe ; ./$< > $@
gorder_atxt.exe: gorder_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gorder_atxt.dats -latsdoc
gorder_atxt.dats: gorder.atxt
	$(ATSDOC) --outcode $@ -i gorder.atxt > gorder_atxt.txt
clean:: ; $(RMF) gorder_atxt.exe
cleanall:: ; $(RMF) gorder.dats

all:: gnumber.dats
gnumber.dats: gnumber_atxt.exe ; ./$< > $@
gnumber_atxt.exe: gnumber_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gnumber_atxt.dats -latsdoc
gnumber_atxt.dats: gnumber.atxt
	$(ATSDOC) --outcode $@ -i gnumber.atxt > gnumber_atxt.txt
clean:: ; $(RMF) gnumber_atxt.exe
cleanall:: ; $(RMF) gnumber.dats


all:: list.dats
list.dats: list_atxt.exe ; ./$< > $@
list_atxt.exe: list_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ list_atxt.dats -latsdoc
list_atxt.dats: list.atxt
	$(ATSDOC) --outcode $@ -i list.atxt > list_atxt.txt
clean:: ; $(RMF) list_atxt.exe
cleanall:: ; $(RMF) list.dats

all:: list_vt.dats
list_vt.dats: list_vt_atxt.exe ; ./$< > $@
list_vt_atxt.exe: list_vt_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ list_vt_atxt.dats -latsdoc
list_vt_atxt.dats: list_vt.atxt
	$(ATSDOC) --outcode $@ -i list_vt.atxt > list_vt_atxt.txt
clean:: ; $(RMF) list_vt_atxt.exe
cleanall:: ; $(RMF) list_vt.dats


all:: option.dats
option.dats: option_atxt.exe ; ./$< > $@
option_atxt.exe: option_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ option_atxt.dats -latsdoc
option_atxt.dats: option.atxt
	$(ATSDOC) --outcode $@ -i option.atxt > option_atxt.txt
clean:: ; $(RMF) option_atxt.exe
cleanall:: ; $(RMF) option.dats

all:: option_vt.dats
option_vt.dats: option_vt_atxt.exe ; ./$< > $@
option_vt_atxt.exe: option_vt_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ option_vt_atxt.dats -latsdoc
option_vt_atxt.dats: option_vt.atxt
	$(ATSDOC) --outcode $@ -i option_vt.atxt > option_vt_atxt.txt
clean:: ; $(RMF) option_vt_atxt.exe
cleanall:: ; $(RMF) option_vt.dats


all:: stream.dats
stream.dats: stream_atxt.exe ; ./$< > $@
stream_atxt.exe: stream_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ stream_atxt.dats -latsdoc
stream_atxt.dats: stream.atxt
	$(ATSDOC) --outcode $@ -i stream.atxt > stream_atxt.txt
clean:: ; $(RMF) stream_atxt.exe
cleanall:: ; $(RMF) stream.dats

all:: stream_vt.dats
stream_vt.dats: stream_vt_atxt.exe ; ./$< > $@
stream_vt_atxt.exe: stream_vt_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ stream_vt_atxt.dats -latsdoc
stream_vt_atxt.dats: stream_vt.atxt
	$(ATSDOC) --outcode $@ -i stream_vt.atxt > stream_vt_atxt.txt
clean:: ; $(RMF) stream_vt_atxt.exe
cleanall:: ; $(RMF) stream_vt.dats


all:: array.dats
array.dats: array_atxt.exe ; ./$< > $@
array_atxt.exe: array_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ array_atxt.dats -latsdoc
array_atxt.dats: array.atxt
	$(ATSDOC) --outcode $@ -i array.atxt > array_atxt.txt
clean:: ; $(RMF) array_atxt.exe
cleanall:: ; $(RMF) array.dats

all:: array_prf.dats
array_prf.dats: array_prf_atxt.exe ; ./$< > $@
array_prf_atxt.exe: array_prf_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ array_prf_atxt.dats -latsdoc
array_prf_atxt.dats: array_prf.atxt
	$(ATSDOC) --outcode $@ -i array_prf.atxt > array_prf_atxt.txt
clean:: ; $(RMF) array_prf_atxt.exe
cleanall:: ; $(RMF) array_prf.dats

all:: arrayptr.dats
arrayptr.dats: arrayptr_atxt.exe ; ./$< > $@
arrayptr_atxt.exe: arrayptr_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ arrayptr_atxt.dats -latsdoc
arrayptr_atxt.dats: arrayptr.atxt
	$(ATSDOC) --outcode $@ -i arrayptr.atxt > arrayptr_atxt.txt
clean:: ; $(RMF) arrayptr_atxt.exe
cleanall:: ; $(RMF) arrayptr.dats

all:: arrayref.dats
arrayref.dats: arrayref_atxt.exe ; ./$< > $@
arrayref_atxt.exe: arrayref_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ arrayref_atxt.dats -latsdoc
arrayref_atxt.dats: arrayref.atxt
	$(ATSDOC) --outcode $@ -i arrayref.atxt > arrayref_atxt.txt
clean:: ; $(RMF) arrayref_atxt.exe
cleanall:: ; $(RMF) arrayref.dats



all:: parray.dats
parray.dats: parray_atxt.exe ; ./$< > $@
parray_atxt.exe: parray_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ parray_atxt.dats -latsdoc
parray_atxt.dats: parray.atxt
	$(ATSDOC) --outcode $@ -i parray.atxt > parray_atxt.txt
clean:: ; $(RMF) parray_atxt.exe
cleanall:: ; $(RMF) parray.dats


all:: matrix.dats
matrix.dats: matrix_atxt.exe ; ./$< > $@
matrix_atxt.exe: matrix_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ matrix_atxt.dats -latsdoc
matrix_atxt.dats: matrix.atxt
	$(ATSDOC) --outcode $@ -i matrix.atxt > matrix_atxt.txt
clean:: ; $(RMF) matrix_atxt.exe
cleanall:: ; $(RMF) matrix.dats

all:: matrixptr.dats
matrixptr.dats: matrixptr_atxt.exe ; ./$< > $@
matrixptr_atxt.exe: matrixptr_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ matrixptr_atxt.dats -latsdoc
matrixptr_atxt.dats: matrixptr.atxt
	$(ATSDOC) --outcode $@ -i matrixptr.atxt > matrixptr_atxt.txt
clean:: ; $(RMF) matrixptr_atxt.exe
cleanall:: ; $(RMF) matrixptr.dats

all:: matrixref.dats
matrixref.dats: matrixref_atxt.exe ; ./$< > $@
matrixref_atxt.exe: matrixref_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ matrixref_atxt.dats -latsdoc
matrixref_atxt.dats: matrixref.atxt
	$(ATSDOC) --outcode $@ -i matrixref.atxt > matrixref_atxt.txt
clean:: ; $(RMF) matrixref_atxt.exe
cleanall:: ; $(RMF) matrixref.dats


all:: gprint.dats
gprint.dats: gprint_atxt.exe ; ./$< > $@
gprint_atxt.exe: gprint_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ gprint_atxt.dats -latsdoc
gprint_atxt.dats: gprint.atxt
	$(ATSDOC) --outcode $@ -i gprint.atxt > gprint_atxt.txt
clean:: ; $(RMF) gprint_atxt.exe
cleanall:: ; $(RMF) gprint.dats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
