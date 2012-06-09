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

all::

######

all:: arith_prf.sats
arith_prf.sats: arith_prf_atxt.exe ; ./$< > $@
arith_prf_atxt.exe: arith_prf_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ arith_prf_atxt.dats -latsdoc
arith_prf_atxt.dats: arith_prf.atxt
	$(ATSDOC) -do $@ -i arith_prf.atxt > arith_prf_atxt.txt
clean:: ; $(RMF) arith_prf_atxt.exe
cleanall:: ; $(RMF) arith_prf.sats


all:: bool.sats
bool.sats: bool_atxt.exe ; ./$< > $@
bool_atxt.exe: bool_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ bool_atxt.dats -latsdoc
bool_atxt.dats: bool.atxt
	$(ATSDOC) -do $@ -i bool.atxt > bool_atxt.txt
clean:: ; $(RMF) bool_atxt.exe
cleanall:: ; $(RMF) bool.sats

all:: char.sats
char.sats: char_atxt.exe ; ./$< > $@
char_atxt.exe: char_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ char_atxt.dats -latsdoc
char_atxt.dats: char.atxt
	$(ATSDOC) -do $@ -i char.atxt > char_atxt.txt
clean:: ; $(RMF) char_atxt.exe
cleanall:: ; $(RMF) char.sats

all:: float.sats
float.sats: float_atxt.exe ; ./$< > $@
float_atxt.exe: float_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ float_atxt.dats -latsdoc
float_atxt.dats: float.atxt
	$(ATSDOC) -do $@ -i float.atxt > float_atxt.txt
clean:: ; $(RMF) float_atxt.exe
cleanall:: ; $(RMF) float.sats

all:: integer.sats
integer.sats: integer_atxt.exe ; ./$< > $@
integer_atxt.exe: integer_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ integer_atxt.dats -latsdoc
integer_atxt.dats: integer.atxt
	$(ATSDOC) -do $@ -i integer.atxt > integer_atxt.txt
clean:: ; $(RMF) integer_atxt.exe
cleanall:: ; $(RMF) integer.sats

all:: pointer.sats
pointer.sats: pointer_atxt.exe ; ./$< > $@
pointer_atxt.exe: pointer_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ pointer_atxt.dats -latsdoc
pointer_atxt.dats: pointer.atxt
	$(ATSDOC) -do $@ -i pointer.atxt > pointer_atxt.txt
clean:: ; $(RMF) pointer_atxt.exe
cleanall:: ; $(RMF) pointer.sats

all:: memory.sats
memory.sats: memory_atxt.exe ; ./$< > $@
memory_atxt.exe: memory_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ memory_atxt.dats -latsdoc
memory_atxt.dats: memory.atxt
	$(ATSDOC) -do $@ -i memory.atxt > memory_atxt.txt
clean:: ; $(RMF) memory_atxt.exe
cleanall:: ; $(RMF) memory.sats

all:: string.sats
string.sats: string_atxt.exe ; ./$< > $@
string_atxt.exe: string_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ string_atxt.dats -latsdoc
string_atxt.dats: string.atxt
	$(ATSDOC) -do $@ -i string.atxt > string_atxt.txt
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) string.sats

all:: strptr.sats
strptr.sats: strptr_atxt.exe ; ./$< > $@
strptr_atxt.exe: strptr_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ strptr_atxt.dats -latsdoc
strptr_atxt.dats: strptr.atxt
	$(ATSDOC) -do $@ -i strptr.atxt > strptr_atxt.txt
clean:: ; $(RMF) strptr_atxt.exe
cleanall:: ; $(RMF) strptr.sats


all:: lazy.sats
lazy.sats: lazy_atxt.exe ; ./$< > $@
lazy_atxt.exe: lazy_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ lazy_atxt.dats -latsdoc
lazy_atxt.dats: lazy.atxt
	$(ATSDOC) -do $@ -i lazy.atxt > lazy_atxt.txt
clean:: ; $(RMF) lazy_atxt.exe
cleanall:: ; $(RMF) lazy.sats

all:: lazy_vt.sats
lazy_vt.sats: lazy_vt_atxt.exe ; ./$< > $@
lazy_vt_atxt.exe: lazy_vt_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ lazy_vt_atxt.dats -latsdoc
lazy_vt_atxt.dats: lazy_vt.atxt
	$(ATSDOC) -do $@ -i lazy_vt.atxt > lazy_vt_atxt.txt
clean:: ; $(RMF) lazy_vt_atxt.exe
cleanall:: ; $(RMF) lazy_vt.sats


all:: array.sats
array.sats: array_atxt.exe ; ./$< > $@
array_atxt.exe: array_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ array_atxt.dats -latsdoc
array_atxt.dats: array.atxt
	$(ATSDOC) -do $@ -i array.atxt > array_atxt.txt
clean:: ; $(RMF) array_atxt.exe
cleanall:: ; $(RMF) array.sats

all:: array_prf.sats
array_prf.sats: array_prf_atxt.exe ; ./$< > $@
array_prf_atxt.exe: array_prf_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ array_prf_atxt.dats -latsdoc
array_prf_atxt.dats: array_prf.atxt
	$(ATSDOC) -do $@ -i array_prf.atxt > array_prf_atxt.txt
clean:: ; $(RMF) array_prf_atxt.exe
cleanall:: ; $(RMF) array_prf.sats

all:: arrayptr.sats
arrayptr.sats: arrayptr_atxt.exe ; ./$< > $@
arrayptr_atxt.exe: arrayptr_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ arrayptr_atxt.dats -latsdoc
arrayptr_atxt.dats: arrayptr.atxt
	$(ATSDOC) -do $@ -i arrayptr.atxt > arrayptr_atxt.txt
clean:: ; $(RMF) arrayptr_atxt.exe
cleanall:: ; $(RMF) arrayptr.sats

all:: arrayref.sats
arrayref.sats: arrayref_atxt.exe ; ./$< > $@
arrayref_atxt.exe: arrayref_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ arrayref_atxt.dats -latsdoc
arrayref_atxt.dats: arrayref.atxt
	$(ATSDOC) -do $@ -i arrayref.atxt > arrayref_atxt.txt
clean:: ; $(RMF) arrayref_atxt.exe
cleanall:: ; $(RMF) arrayref.sats



all:: parrnull.sats
parrnull.sats: parrnull_atxt.exe ; ./$< > $@
parrnull_atxt.exe: parrnull_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ parrnull_atxt.dats -latsdoc
parrnull_atxt.dats: parrnull.atxt
	$(ATSDOC) -do $@ -i parrnull.atxt > parrnull_atxt.txt
clean:: ; $(RMF) parrnull_atxt.exe
cleanall:: ; $(RMF) parrnull.sats


all:: filebas.sats
filebas.sats: filebas_atxt.exe ; ./$< > $@
filebas_atxt.exe: filebas_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ filebas_atxt.dats -latsdoc
filebas_atxt.dats: filebas.atxt
	$(ATSDOC) -do $@ -i filebas.atxt > filebas_atxt.txt
clean:: ; $(RMF) filebas_atxt.exe
cleanall:: ; $(RMF) filebas.sats


all:: list.sats
list.sats: list_atxt.exe ; ./$< > $@
list_atxt.exe: list_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ list_atxt.dats -latsdoc
list_atxt.dats: list.atxt
	$(ATSDOC) -do $@ -i list.atxt > list_atxt.txt
clean:: ; $(RMF) list_atxt.exe
cleanall:: ; $(RMF) list.sats

all:: list0.sats
list0.sats: list0_atxt.exe ; ./$< > $@
list0_atxt.exe: list0_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ list0_atxt.dats -latsdoc
list0_atxt.dats: list0.atxt
	$(ATSDOC) -do $@ -i list0.atxt > list0_atxt.txt
clean:: ; $(RMF) list0_atxt.exe
cleanall:: ; $(RMF) list0.sats

all:: list_vt.sats
list_vt.sats: list_vt_atxt.exe ; ./$< > $@
list_vt_atxt.exe: list_vt_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ list_vt_atxt.dats -latsdoc
list_vt_atxt.dats: list_vt.atxt
	$(ATSDOC) -do $@ -i list_vt.atxt > list_vt_atxt.txt
clean:: ; $(RMF) list_vt_atxt.exe
cleanall:: ; $(RMF) list_vt.sats


all:: option.sats
option.sats: option_atxt.exe ; ./$< > $@
option_atxt.exe: option_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ option_atxt.dats -latsdoc
option_atxt.dats: option.atxt
	$(ATSDOC) -do $@ -i option.atxt > option_atxt.txt
clean:: ; $(RMF) option_atxt.exe
cleanall:: ; $(RMF) option.sats

all:: option0.sats
option0.sats: option0_atxt.exe ; ./$< > $@
option0_atxt.exe: option0_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ option0_atxt.dats -latsdoc
option0_atxt.dats: option0.atxt
	$(ATSDOC) -do $@ -i option0.atxt > option0_atxt.txt
clean:: ; $(RMF) option0_atxt.exe
cleanall:: ; $(RMF) option0.sats

all:: option_vt.sats
option_vt.sats: option_vt_atxt.exe ; ./$< > $@
option_vt_atxt.exe: option_vt_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ option_vt_atxt.dats -latsdoc
option_vt_atxt.dats: option_vt.atxt
	$(ATSDOC) -do $@ -i option_vt.atxt > option_vt_atxt.txt
clean:: ; $(RMF) option_vt_atxt.exe
cleanall:: ; $(RMF) option_vt.sats


all:: reference.sats
reference.sats: reference_atxt.exe ; ./$< > $@
reference_atxt.exe: reference_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ reference_atxt.dats -latsdoc
reference_atxt.dats: reference.atxt
	$(ATSDOC) -do $@ -i reference.atxt > reference_atxt.txt
clean:: ; $(RMF) reference_atxt.exe
cleanall:: ; $(RMF) reference.sats


all:: iterator.sats
iterator.sats: iterator_atxt.exe ; ./$< > $@
iterator_atxt.exe: iterator_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ iterator_atxt.dats -latsdoc
iterator_atxt.dats: iterator.atxt
	$(ATSDOC) -do $@ -i iterator.atxt > iterator_atxt.txt
clean:: ; $(RMF) iterator_atxt.exe
cleanall:: ; $(RMF) iterator.sats


all:: fcontainer.sats
fcontainer.sats: fcontainer_atxt.exe ; ./$< > $@
fcontainer_atxt.exe: fcontainer_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ fcontainer_atxt.dats -latsdoc
fcontainer_atxt.dats: fcontainer.atxt
	$(ATSDOC) -do $@ -i fcontainer.atxt > fcontainer_atxt.txt
clean:: ; $(RMF) fcontainer_atxt.exe
cleanall:: ; $(RMF) fcontainer.sats


all:: extern.sats
extern.sats: extern_atxt.exe ; ./$< > $@
extern_atxt.exe: extern_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ extern_atxt.dats -latsdoc
extern_atxt.dats: extern.atxt
	$(ATSDOC) -do $@ -i extern.atxt > extern_atxt.txt
clean:: ; $(RMF) extern_atxt.exe
cleanall:: ; $(RMF) extern.sats


all:: unsafe.sats
unsafe.sats: unsafe_atxt.exe ; ./$< > $@
unsafe_atxt.exe: unsafe_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ unsafe_atxt.dats -latsdoc
unsafe_atxt.dats: unsafe.atxt
	$(ATSDOC) -do $@ -i unsafe.atxt > unsafe_atxt.txt
clean:: ; $(RMF) unsafe_atxt.exe
cleanall:: ; $(RMF) unsafe.sats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
