#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CCOPT=gcc -std=c99
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: prelude_basics
prelude_basics: prelude_basics.exe
prelude_basics.exe: prelude_basics_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_basics_dats.c: prelude_basics.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_basics_dats.c --dynamic prelude_basics.dats
clean:: ; $(RMF) prelude_basics_dats.o
clean:: ; $(RMF) prelude_basics_dats.c
cleanall:: ; $(RMF) prelude_basics.exe

all:: prelude_bool
prelude_bool: prelude_bool.exe
prelude_bool.exe: prelude_bool_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_bool_dats.c: prelude_bool.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_bool_dats.c --dynamic prelude_bool.dats
clean:: ; $(RMF) prelude_bool_dats.o
clean:: ; $(RMF) prelude_bool_dats.c
cleanall:: ; $(RMF) prelude_bool.exe

all:: prelude_char
prelude_char: prelude_char.exe
prelude_char.exe: prelude_char_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_char_dats.c: prelude_char.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_char_dats.c --dynamic prelude_char.dats
clean:: ; $(RMF) prelude_char_dats.o
clean:: ; $(RMF) prelude_char_dats.c
cleanall:: ; $(RMF) prelude_char.exe

all:: prelude_integer
prelude_integer: prelude_integer.exe
prelude_integer.exe: prelude_integer_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_integer_dats.c: prelude_integer.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_integer_dats.c --dynamic prelude_integer.dats
clean:: ; $(RMF) prelude_integer_dats.o
clean:: ; $(RMF) prelude_integer_dats.c
cleanall:: ; $(RMF) prelude_integer.exe

all:: prelude_float
prelude_float: prelude_float.exe
prelude_float.exe: prelude_float_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_float_dats.c: prelude_float.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_float_dats.c --dynamic prelude_float.dats
clean:: ; $(RMF) prelude_float_dats.o
clean:: ; $(RMF) prelude_float_dats.c
cleanall:: ; $(RMF) prelude_float.exe

all:: prelude_memory
prelude_memory: prelude_memory.exe
prelude_memory.exe: prelude_memory_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_memory_dats.c: prelude_memory.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_memory_dats.c --dynamic prelude_memory.dats
clean:: ; $(RMF) prelude_memory_dats.o
clean:: ; $(RMF) prelude_memory_dats.c
cleanall:: ; $(RMF) prelude_memory.exe

all:: prelude_pointer
prelude_pointer: prelude_pointer.exe
prelude_pointer.exe: prelude_pointer_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_pointer_dats.c: prelude_pointer.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_pointer_dats.c --dynamic prelude_pointer.dats
clean:: ; $(RMF) prelude_pointer_dats.o
clean:: ; $(RMF) prelude_pointer_dats.c
cleanall:: ; $(RMF) prelude_pointer.exe

all:: prelude_string
prelude_string: prelude_string.exe
prelude_string.exe: prelude_string_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_string_dats.c: prelude_string.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_string_dats.c --dynamic prelude_string.dats
clean:: ; $(RMF) prelude_string_dats.o
clean:: ; $(RMF) prelude_string_dats.c
cleanall:: ; $(RMF) prelude_string.exe

all:: prelude_reference
prelude_reference: prelude_reference.exe
prelude_reference.exe: prelude_reference_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_reference_dats.c: prelude_reference.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_reference_dats.c --dynamic prelude_reference.dats
clean:: ; $(RMF) prelude_reference_dats.o
clean:: ; $(RMF) prelude_reference_dats.c
cleanall:: ; $(RMF) prelude_reference.exe


all:: prelude_filebas
prelude_filebas: prelude_filebas.exe
prelude_filebas.exe: prelude_filebas_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
prelude_filebas_dats.c: prelude_filebas.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_filebas_dats.c --dynamic prelude_filebas.dats
clean:: ; $(RMF) prelude_filebas_dats.o
clean:: ; $(RMF) prelude_filebas_dats.c
cleanall:: ; $(RMF) prelude_filebas.exe


all:: prelude_intrange
prelude_intrange: prelude_intrange.exe
prelude_intrange.exe: prelude_intrange_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_intrange_dats.c: prelude_intrange.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_intrange_dats.c --dynamic prelude_intrange.dats
clean:: ; $(RMF) prelude_intrange_dats.o
clean:: ; $(RMF) prelude_intrange_dats.c
cleanall:: ; $(RMF) prelude_intrange.exe


all:: prelude_list
prelude_list: prelude_list.exe
prelude_list.exe: prelude_list_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_list_dats.c: prelude_list.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_list_dats.c --dynamic prelude_list.dats
clean:: ; $(RMF) prelude_list_dats.o
clean:: ; $(RMF) prelude_list_dats.c
cleanall:: ; $(RMF) prelude_list.exe

all:: prelude_list_vt
prelude_list_vt: prelude_list_vt.exe
prelude_list_vt.exe: prelude_list_vt_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_list_vt_dats.c: prelude_list_vt.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_list_vt_dats.c --dynamic prelude_list_vt.dats
clean:: ; $(RMF) prelude_list_vt_dats.o
clean:: ; $(RMF) prelude_list_vt_dats.c
cleanall:: ; $(RMF) prelude_list_vt.exe


all:: prelude_option
prelude_option: prelude_option.exe
prelude_option.exe: prelude_option_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_option_dats.c: prelude_option.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_option_dats.c --dynamic prelude_option.dats
clean:: ; $(RMF) prelude_option_dats.o
clean:: ; $(RMF) prelude_option_dats.c
cleanall:: ; $(RMF) prelude_option.exe

all:: prelude_option_vt
prelude_option_vt: prelude_option_vt.exe
prelude_option_vt.exe: prelude_option_vt_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_option_vt_dats.c: prelude_option_vt.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_option_vt_dats.c --dynamic prelude_option_vt.dats
clean:: ; $(RMF) prelude_option_vt_dats.o
clean:: ; $(RMF) prelude_option_vt_dats.c
cleanall:: ; $(RMF) prelude_option_vt.exe


all:: prelude_array
prelude_array: prelude_array.exe
prelude_array.exe: prelude_array_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_array_dats.c: prelude_array.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_array_dats.c --dynamic prelude_array.dats
clean:: ; $(RMF) prelude_array_dats.o
clean:: ; $(RMF) prelude_array_dats.c
cleanall:: ; $(RMF) prelude_array.exe

all:: prelude_arrayptr
prelude_arrayptr: prelude_arrayptr.exe
prelude_arrayptr.exe: prelude_arrayptr_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_arrayptr_dats.c: prelude_arrayptr.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_arrayptr_dats.c --dynamic prelude_arrayptr.dats
clean:: ; $(RMF) prelude_arrayptr_dats.o
clean:: ; $(RMF) prelude_arrayptr_dats.c
cleanall:: ; $(RMF) prelude_arrayptr.exe

all:: prelude_arrayref
prelude_arrayref: prelude_arrayref.exe
prelude_arrayref.exe: prelude_arrayref_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_arrayref_dats.c: prelude_arrayref.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_arrayref_dats.c --dynamic prelude_arrayref.dats
clean:: ; $(RMF) prelude_arrayref_dats.o
clean:: ; $(RMF) prelude_arrayref_dats.c
cleanall:: ; $(RMF) prelude_arrayref.exe


all:: prelude_matrix
prelude_matrix: prelude_matrix.exe
prelude_matrix.exe: prelude_matrix_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_matrix_dats.c: prelude_matrix.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_matrix_dats.c --dynamic prelude_matrix.dats
clean:: ; $(RMF) prelude_matrix_dats.o
clean:: ; $(RMF) prelude_matrix_dats.c
cleanall:: ; $(RMF) prelude_matrix.exe

all:: prelude_matrixptr
prelude_matrixptr: prelude_matrixptr.exe
prelude_matrixptr.exe: prelude_matrixptr_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_matrixptr_dats.c: prelude_matrixptr.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_matrixptr_dats.c --dynamic prelude_matrixptr.dats
clean:: ; $(RMF) prelude_matrixptr_dats.o
clean:: ; $(RMF) prelude_matrixptr_dats.c
cleanall:: ; $(RMF) prelude_matrixptr.exe

all:: prelude_matrixref
prelude_matrixref: prelude_matrixref.exe
prelude_matrixref.exe: prelude_matrixref_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
prelude_matrixref_dats.c: prelude_matrixref.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_matrixref_dats.c --dynamic prelude_matrixref.dats
clean:: ; $(RMF) prelude_matrixref_dats.o
clean:: ; $(RMF) prelude_matrixref_dats.c
cleanall:: ; $(RMF) prelude_matrixref.exe


all:: prelude_gprint
prelude_gprint: prelude_gprint.exe
prelude_gprint.exe: prelude_gprint_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_gprint_dats.c: prelude_gprint.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_gprint_dats.c --dynamic prelude_gprint.dats
clean:: ; $(RMF) prelude_gprint_dats.o
clean:: ; $(RMF) prelude_gprint_dats.c
cleanall:: ; $(RMF) prelude_gprint.exe


######

all:: libc_dirent
libc_dirent: libc_dirent.exe
libc_dirent.exe: libc_dirent_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libc_dirent_dats.c: libc_dirent.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_dirent_dats.c --dynamic libc_dirent.dats
clean:: ; $(RMF) libc_dirent_dats.o
clean:: ; $(RMF) libc_dirent_dats.c
cleanall:: ; $(RMF) libc_dirent.exe

all:: libc_fcntl
libc_fcntl: libc_fcntl.exe
libc_fcntl.exe: libc_fcntl_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
libc_fcntl_dats.c: libc_fcntl.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_fcntl_dats.c --dynamic libc_fcntl.dats
clean:: ; $(RMF) libc_fcntl_dats.o
clean:: ; $(RMF) libc_fcntl_dats.c
cleanall:: ; $(RMF) libc_fcntl.exe

all:: libc_fnmatch
libc_fnmatch: libc_fnmatch.exe
libc_fnmatch.exe: libc_fnmatch_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
libc_fnmatch_dats.c: libc_fnmatch.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_fnmatch_dats.c --dynamic libc_fnmatch.dats
clean:: ; $(RMF) libc_fnmatch_dats.o
clean:: ; $(RMF) libc_fnmatch_dats.c
cleanall:: ; $(RMF) libc_fnmatch.exe

all:: libc_malloc
libc_malloc: libc_malloc.exe
libc_malloc.exe: libc_malloc_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libc_malloc_dats.c: libc_malloc.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_malloc_dats.c --dynamic libc_malloc.dats
clean:: ; $(RMF) libc_malloc_dats.o
clean:: ; $(RMF) libc_malloc_dats.c
cleanall:: ; $(RMF) libc_malloc.exe

all:: libc_math
libc_math: libc_math.exe
libc_math.exe: libc_math_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime  -o $@ $< -lm
libc_math_dats.c: libc_math.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_math_dats.c --dynamic libc_math.dats
clean:: ; $(RMF) libc_math_dats.o
clean:: ; $(RMF) libc_math_dats.c
cleanall:: ; $(RMF) libc_math.exe

all:: libc_stdio
libc_stdio: libc_stdio.exe
libc_stdio.exe: libc_stdio_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libc_stdio_dats.c: libc_stdio.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_stdio_dats.c --dynamic libc_stdio.dats
clean:: ; $(RMF) libc_stdio_dats.o
clean:: ; $(RMF) libc_stdio_dats.c
cleanall:: ; $(RMF) libc_stdio.exe

all:: libc_stdlib
libc_stdlib: libc_stdlib.exe
libc_stdlib.exe: libc_stdlib_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libc_stdlib_dats.c: libc_stdlib.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_stdlib_dats.c --dynamic libc_stdlib.dats
clean:: ; $(RMF) libc_stdlib_dats.o
clean:: ; $(RMF) libc_stdlib_dats.c
cleanall:: ; $(RMF) libc_stdlib.exe

all:: libc_string
libc_string: libc_string.exe
libc_string.exe: libc_string_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libc_string_dats.c: libc_string.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_string_dats.c --dynamic libc_string.dats
clean:: ; $(RMF) libc_string_dats.o
clean:: ; $(RMF) libc_string_dats.c
cleanall:: ; $(RMF) libc_string.exe

all:: libc_strings
libc_strings: libc_strings.exe
libc_strings.exe: libc_strings_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libc_strings_dats.c: libc_strings.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_strings_dats.c --dynamic libc_strings.dats
clean:: ; $(RMF) libc_strings_dats.o
clean:: ; $(RMF) libc_strings_dats.c
cleanall:: ; $(RMF) libc_strings.exe

all:: libc_time
libc_time: libc_time.exe
libc_time.exe: libc_time_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libc_time_dats.c: libc_time.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_time_dats.c --dynamic libc_time.dats
clean:: ; $(RMF) libc_time_dats.o
clean:: ; $(RMF) libc_time_dats.c
cleanall:: ; $(RMF) libc_time.exe

all:: libc_unistd
libc_unistd: libc_unistd.exe
libc_unistd.exe: libc_unistd_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libc_unistd_dats.c: libc_unistd.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_unistd_dats.c --dynamic libc_unistd.dats
clean:: ; $(RMF) libc_unistd_dats.o
clean:: ; $(RMF) libc_unistd_dats.c
cleanall:: ; $(RMF) libc_unistd.exe


######

all:: libc_gdbm_gdbm
libc_gdbm_gdbm: libc_gdbm_gdbm.exe
libc_gdbm_gdbm.exe: libc_gdbm_gdbm_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -lgdbm
libc_gdbm_gdbm_dats.c: libc_gdbm_gdbm.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_gdbm_gdbm_dats.c --dynamic libc_gdbm_gdbm.dats
clean:: ; $(RMF) libc_gdbm_gdbm_dats.o
clean:: ; $(RMF) libc_gdbm_gdbm_dats.c
cleanall:: ; $(RMF) libc_gdbm_gdbm.exe


######

all:: libats_qlist
libats_qlist: libats_qlist.exe
libats_qlist.exe: libats_qlist_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_qlist_dats.c: libats_qlist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_qlist_dats.c --dynamic libats_qlist.dats
clean:: ; $(RMF) libats_qlist_dats.o
clean:: ; $(RMF) libats_qlist_dats.c
cleanall:: ; $(RMF) libats_qlist.exe

all:: libats_sllist
libats_sllist: libats_sllist.exe
libats_sllist.exe: libats_sllist_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_sllist_dats.c: libats_sllist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_sllist_dats.c --dynamic libats_sllist.dats
clean:: ; $(RMF) libats_sllist_dats.o
clean:: ; $(RMF) libats_sllist_dats.c
cleanall:: ; $(RMF) libats_sllist.exe

all:: libats_dllist
libats_dllist: libats_dllist.exe
libats_dllist.exe: libats_dllist_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_dllist_dats.c: libats_dllist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_dllist_dats.c --dynamic libats_dllist.dats
clean:: ; $(RMF) libats_dllist_dats.o
clean:: ; $(RMF) libats_dllist_dats.c
cleanall:: ; $(RMF) libats_dllist.exe

all:: libats_stkarray
libats_stkarray: libats_stkarray.exe
libats_stkarray.exe: libats_stkarray_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_stkarray_dats.c: libats_stkarray.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_stkarray_dats.c --dynamic libats_stkarray.dats
clean:: ; $(RMF) libats_stkarray_dats.o
clean:: ; $(RMF) libats_stkarray_dats.c
cleanall:: ; $(RMF) libats_stkarray.exe

all:: libats_dynarray
libats_dynarray: libats_dynarray.exe
libats_dynarray.exe: libats_dynarray_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_dynarray_dats.c: libats_dynarray.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_dynarray_dats.c --dynamic libats_dynarray.dats
clean:: ; $(RMF) libats_dynarray_dats.o
clean:: ; $(RMF) libats_dynarray_dats.c
cleanall:: ; $(RMF) libats_dynarray.exe


######

all:: libats_refcount
libats_refcount: libats_refcount.exe
libats_refcount.exe: libats_refcount_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_refcount_dats.c: libats_refcount.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_refcount_dats.c --dynamic libats_refcount.dats
clean:: ; $(RMF) libats_refcount_dats.o
clean:: ; $(RMF) libats_refcount_dats.c
cleanall:: ; $(RMF) libats_refcount.exe


######



######

all:: libats_funset_listord
libats_funset_listord: libats_funset_listord.exe
libats_funset_listord.exe: libats_funset_listord_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_funset_listord_dats.c: libats_funset_listord.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_funset_listord_dats.c --dynamic libats_funset_listord.dats
clean:: ; $(RMF) libats_funset_listord_dats.o
clean:: ; $(RMF) libats_funset_listord_dats.c
cleanall:: ; $(RMF) libats_funset_listord.exe

all:: libats_funset_avltree
libats_funset_avltree: libats_funset_avltree.exe
libats_funset_avltree.exe: libats_funset_avltree_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_funset_avltree_dats.c: libats_funset_avltree.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_funset_avltree_dats.c --dynamic libats_funset_avltree.dats
clean:: ; $(RMF) libats_funset_avltree_dats.o
clean:: ; $(RMF) libats_funset_avltree_dats.c
cleanall:: ; $(RMF) libats_funset_avltree.exe

all:: libats_funmap_list
libats_funmap_list: libats_funmap_list.exe
libats_funmap_list.exe: libats_funmap_list_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_funmap_list_dats.c: libats_funmap_list.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_funmap_list_dats.c --dynamic libats_funmap_list.dats
clean:: ; $(RMF) libats_funmap_list_dats.o
clean:: ; $(RMF) libats_funmap_list_dats.c
cleanall:: ; $(RMF) libats_funmap_list.exe

all:: libats_funmap_avltree
libats_funmap_avltree: libats_funmap_avltree.exe
libats_funmap_avltree.exe: libats_funmap_avltree_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_funmap_avltree_dats.c: libats_funmap_avltree.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_funmap_avltree_dats.c --dynamic libats_funmap_avltree.dats
clean:: ; $(RMF) libats_funmap_avltree_dats.o
clean:: ; $(RMF) libats_funmap_avltree_dats.c
cleanall:: ; $(RMF) libats_funmap_avltree.exe


######

all:: libats_fundeque_fngtree
libats_fundeque_fngtree: libats_fundeque_fngtree.exe
libats_fundeque_fngtree.exe: libats_fundeque_fngtree_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_fundeque_fngtree_dats.c: libats_fundeque_fngtree.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_fundeque_fngtree_dats.c --dynamic libats_fundeque_fngtree.dats
clean:: ; $(RMF) libats_fundeque_fngtree_dats.o
clean:: ; $(RMF) libats_fundeque_fngtree_dats.c
cleanall:: ; $(RMF) libats_fundeque_fngtree.exe

all:: libats_funralist_nested
libats_funralist_nested: libats_funralist_nested.exe
libats_funralist_nested.exe: libats_funralist_nested_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_funralist_nested_dats.c: libats_funralist_nested.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_funralist_nested_dats.c --dynamic libats_funralist_nested.dats
clean:: ; $(RMF) libats_funralist_nested_dats.o
clean:: ; $(RMF) libats_funralist_nested_dats.c
cleanall:: ; $(RMF) libats_funralist_nested.exe


######

all:: libats_linhashtbl_chain
libats_linhashtbl_chain: libats_linhashtbl_chain.exe
libats_linhashtbl_chain.exe: libats_linhashtbl_chain_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linhashtbl_chain_dats.c: libats_linhashtbl_chain.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linhashtbl_chain_dats.c --dynamic libats_linhashtbl_chain.dats
clean:: ; $(RMF) libats_linhashtbl_chain_dats.o
clean:: ; $(RMF) libats_linhashtbl_chain_dats.c
cleanall:: ; $(RMF) libats_linhashtbl_chain.exe


######

all:: libats_linset_listord
libats_linset_listord: libats_linset_listord.exe
libats_linset_listord.exe: libats_linset_listord_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linset_listord_dats.c: libats_linset_listord.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linset_listord_dats.c --dynamic libats_linset_listord.dats
clean:: ; $(RMF) libats_linset_listord_dats.o
clean:: ; $(RMF) libats_linset_listord_dats.c
cleanall:: ; $(RMF) libats_linset_listord.exe

all:: libats_linset_avltree
libats_linset_avltree: libats_linset_avltree.exe
libats_linset_avltree.exe: libats_linset_avltree_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linset_avltree_dats.c: libats_linset_avltree.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linset_avltree_dats.c --dynamic libats_linset_avltree.dats
clean:: ; $(RMF) libats_linset_avltree_dats.o
clean:: ; $(RMF) libats_linset_avltree_dats.c
cleanall:: ; $(RMF) libats_linset_avltree.exe


######

all:: libats_linmap_list
libats_linmap_list: libats_linmap_list.exe
libats_linmap_list.exe: libats_linmap_list_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linmap_list_dats.c: libats_linmap_list.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linmap_list_dats.c --dynamic libats_linmap_list.dats
clean:: ; $(RMF) libats_linmap_list_dats.o
clean:: ; $(RMF) libats_linmap_list_dats.c
cleanall:: ; $(RMF) libats_linmap_list.exe

all:: libats_linmap_avltree
libats_linmap_avltree: libats_linmap_avltree.exe
libats_linmap_avltree.exe: libats_linmap_avltree_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linmap_avltree_dats.c: libats_linmap_avltree.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linmap_avltree_dats.c --dynamic libats_linmap_avltree.dats
clean:: ; $(RMF) libats_linmap_avltree_dats.o
clean:: ; $(RMF) libats_linmap_avltree_dats.c
cleanall:: ; $(RMF) libats_linmap_avltree.exe

all:: libats_linmap_randbst
libats_linmap_randbst: libats_linmap_randbst.exe
libats_linmap_randbst.exe: libats_linmap_randbst_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linmap_randbst_dats.c: libats_linmap_randbst.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linmap_randbst_dats.c --dynamic libats_linmap_randbst.dats
clean:: ; $(RMF) libats_linmap_randbst_dats.o
clean:: ; $(RMF) libats_linmap_randbst_dats.c
cleanall:: ; $(RMF) libats_linmap_randbst.exe

all:: libats_linmap_skiplist
libats_linmap_skiplist: libats_linmap_skiplist.exe
libats_linmap_skiplist.exe: libats_linmap_skiplist_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_linmap_skiplist_dats.c: libats_linmap_skiplist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linmap_skiplist_dats.c --dynamic libats_linmap_skiplist.dats
clean:: ; $(RMF) libats_linmap_skiplist_dats.o
clean:: ; $(RMF) libats_linmap_skiplist_dats.c
cleanall:: ; $(RMF) libats_linmap_skiplist.exe


######

all:: libats_linheap_binomial
libats_linheap_binomial: libats_linheap_binomial.exe
libats_linheap_binomial.exe: libats_linheap_binomial_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linheap_binomial_dats.c: libats_linheap_binomial.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linheap_binomial_dats.c --dynamic libats_linheap_binomial.dats
clean:: ; $(RMF) libats_linheap_binomial_dats.o
clean:: ; $(RMF) libats_linheap_binomial_dats.c
cleanall:: ; $(RMF) libats_linheap_binomial.exe

all:: libats_linheap_binomial2
libats_linheap_binomial2: libats_linheap_binomial2.exe
libats_linheap_binomial2.exe: libats_linheap_binomial2_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_linheap_binomial2_dats.c: libats_linheap_binomial2.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_linheap_binomial2_dats.c --dynamic libats_linheap_binomial2.dats
clean:: ; $(RMF) libats_linheap_binomial2_dats.o
clean:: ; $(RMF) libats_linheap_binomial2_dats.c
cleanall:: ; $(RMF) libats_linheap_binomial2.exe


######

all:: libats_lindeque_dllist
libats_lindeque_dllist: libats_lindeque_dllist.exe
libats_lindeque_dllist.exe: libats_lindeque_dllist_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< 
libats_lindeque_dllist_dats.c: libats_lindeque_dllist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_lindeque_dllist_dats.c --dynamic libats_lindeque_dllist.dats
clean:: ; $(RMF) libats_lindeque_dllist_dats.o
clean:: ; $(RMF) libats_lindeque_dllist_dats.c
cleanall:: ; $(RMF) libats_lindeque_dllist.exe


######

all:: libats_ML_list0
libats_ML_list0: libats_ML_list0.exe
libats_ML_list0.exe: libats_ML_list0_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_list0_dats.c: libats_ML_list0.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_list0_dats.c --dynamic libats_ML_list0.dats
clean:: ; $(RMF) libats_ML_list0_dats.o
clean:: ; $(RMF) libats_ML_list0_dats.c
cleanall:: ; $(RMF) libats_ML_list0.exe

all:: libats_ML_array0
libats_ML_array0: libats_ML_array0.exe
libats_ML_array0.exe: libats_ML_array0_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_array0_dats.c: libats_ML_array0.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_array0_dats.c --dynamic libats_ML_array0.dats
clean:: ; $(RMF) libats_ML_array0_dats.o
clean:: ; $(RMF) libats_ML_array0_dats.c
cleanall:: ; $(RMF) libats_ML_array0.exe

all:: libats_ML_string
libats_ML_string: libats_ML_string.exe
libats_ML_string.exe: libats_ML_string_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_string_dats.c: libats_ML_string.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_string_dats.c --dynamic libats_ML_string.dats
clean:: ; $(RMF) libats_ML_string_dats.o
clean:: ; $(RMF) libats_ML_string_dats.c
cleanall:: ; $(RMF) libats_ML_string.exe

all:: libats_ML_strarr
libats_ML_strarr: libats_ML_strarr.exe
libats_ML_strarr.exe: libats_ML_strarr_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_strarr_dats.c: libats_ML_strarr.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_strarr_dats.c --dynamic libats_ML_strarr.dats
clean:: ; $(RMF) libats_ML_strarr_dats.o
clean:: ; $(RMF) libats_ML_strarr_dats.c
cleanall:: ; $(RMF) libats_ML_strarr.exe


######

all:: libats_ML_filebas
libats_ML_filebas: libats_ML_filebas.exe
libats_ML_filebas.exe: libats_ML_filebas_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_filebas_dats.c: libats_ML_filebas.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_filebas_dats.c --dynamic libats_ML_filebas.dats
clean:: ; $(RMF) libats_ML_filebas_dats.o
clean:: ; $(RMF) libats_ML_filebas_dats.c
cleanall:: ; $(RMF) libats_ML_filebas.exe


######

all:: libats_ML_funset
libats_ML_funset: libats_ML_funset.exe
libats_ML_funset.exe: libats_ML_funset_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_funset_dats.c: libats_ML_funset.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_funset_dats.c --dynamic libats_ML_funset.dats
clean:: ; $(RMF) libats_ML_funset_dats.o
clean:: ; $(RMF) libats_ML_funset_dats.c
cleanall:: ; $(RMF) libats_ML_funset.exe


######

all:: libats_ML_monad_list
libats_ML_monad_list: libats_ML_monad_list.exe
libats_ML_monad_list.exe: libats_ML_monad_list_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_monad_list_dats.c: libats_ML_monad_list.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_monad_list_dats.c --dynamic libats_ML_monad_list.dats
clean:: ; $(RMF) libats_ML_monad_list_dats.o
clean:: ; $(RMF) libats_ML_monad_list_dats.c
cleanall:: ; $(RMF) libats_ML_monad_list.exe

all:: libats_ML_monad_maybe
libats_ML_monad_maybe: libats_ML_monad_maybe.exe
libats_ML_monad_maybe.exe: libats_ML_monad_maybe_dats.c ;   $(CCOPT) -D_GNU_SOURCE -O2     -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
libats_ML_monad_maybe_dats.c: libats_ML_monad_maybe.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_monad_maybe_dats.c --dynamic libats_ML_monad_maybe.dats
clean:: ; $(RMF) libats_ML_monad_maybe_dats.o
clean:: ; $(RMF) libats_ML_monad_maybe_dats.c
cleanall:: ; $(RMF) libats_ML_monad_maybe.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) gdbmtest.gdbm
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
