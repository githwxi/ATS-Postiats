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

GCC=gcc
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

ATSGCFLAG=-D_ATS_GCATS

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: prelude_bool
prelude_bool: prelude_bool.exe
prelude_bool.exe: prelude_bool_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
prelude_bool_dats.c: prelude_bool.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_bool_dats.c --dynamic prelude_bool.dats
clean:: ; $(RMF) prelude_bool_dats.o
clean:: ; $(RMF) prelude_bool_dats.c
cleanall:: ; $(RMF) prelude_bool.exe

all:: prelude_char
prelude_char: prelude_char.exe
prelude_char.exe: prelude_char_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
prelude_char_dats.c: prelude_char.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_char_dats.c --dynamic prelude_char.dats
clean:: ; $(RMF) prelude_char_dats.o
clean:: ; $(RMF) prelude_char_dats.c
cleanall:: ; $(RMF) prelude_char.exe

all:: prelude_integer
prelude_integer: prelude_integer.exe
prelude_integer.exe: prelude_integer_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
prelude_integer_dats.c: prelude_integer.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_integer_dats.c --dynamic prelude_integer.dats
clean:: ; $(RMF) prelude_integer_dats.o
clean:: ; $(RMF) prelude_integer_dats.c
cleanall:: ; $(RMF) prelude_integer.exe

all:: prelude_float
prelude_float: prelude_float.exe
prelude_float.exe: prelude_float_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
prelude_float_dats.c: prelude_float.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_float_dats.c --dynamic prelude_float.dats
clean:: ; $(RMF) prelude_float_dats.o
clean:: ; $(RMF) prelude_float_dats.c
cleanall:: ; $(RMF) prelude_float.exe

all:: prelude_string
prelude_string: prelude_string.exe
prelude_string.exe: prelude_string_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
prelude_string_dats.c: prelude_string.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_string_dats.c --dynamic prelude_string.dats
clean:: ; $(RMF) prelude_string_dats.o
clean:: ; $(RMF) prelude_string_dats.c
cleanall:: ; $(RMF) prelude_string.exe

all:: prelude_reference
prelude_reference: prelude_reference.exe
prelude_reference.exe: prelude_reference_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
prelude_reference_dats.c: prelude_reference.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_reference_dats.c --dynamic prelude_reference.dats
clean:: ; $(RMF) prelude_reference_dats.o
clean:: ; $(RMF) prelude_reference_dats.c
cleanall:: ; $(RMF) prelude_reference.exe


######

all:: libc_stdio
libc_stdio: libc_stdio.exe
libc_stdio.exe: libc_stdio_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libc_stdio_dats.c: libc_stdio.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_stdio_dats.c --dynamic libc_stdio.dats
clean:: ; $(RMF) libc_stdio_dats.o
clean:: ; $(RMF) libc_stdio_dats.c
cleanall:: ; $(RMF) libc_stdio.exe

all:: libc_stdlib
libc_stdlib: libc_stdlib.exe
libc_stdlib.exe: libc_stdlib_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libc_stdlib_dats.c: libc_stdlib.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_stdlib_dats.c --dynamic libc_stdlib.dats
clean:: ; $(RMF) libc_stdlib_dats.o
clean:: ; $(RMF) libc_stdlib_dats.c
cleanall:: ; $(RMF) libc_stdlib.exe

all:: libc_string
libc_string: libc_string.exe
libc_string.exe: libc_string_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libc_string_dats.c: libc_string.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_string_dats.c --dynamic libc_string.dats
clean:: ; $(RMF) libc_string_dats.o
clean:: ; $(RMF) libc_string_dats.c
cleanall:: ; $(RMF) libc_string.exe

all:: libc_strings
libc_strings: libc_strings.exe
libc_strings.exe: libc_strings_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libc_strings_dats.c: libc_strings.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_strings_dats.c --dynamic libc_strings.dats
clean:: ; $(RMF) libc_strings_dats.o
clean:: ; $(RMF) libc_strings_dats.c
cleanall:: ; $(RMF) libc_strings.exe

all:: libc_unistd
libc_unistd: libc_unistd.exe
libc_unistd.exe: libc_unistd_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libc_unistd_dats.c: libc_unistd.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libc_unistd_dats.c --dynamic libc_unistd.dats
clean:: ; $(RMF) libc_unistd_dats.o
clean:: ; $(RMF) libc_unistd_dats.c
cleanall:: ; $(RMF) libc_unistd.exe


######

all:: libats_qlist
libats_qlist: libats_qlist.exe
libats_qlist.exe: libats_qlist_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libats_qlist_dats.c: libats_qlist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_qlist_dats.c --dynamic libats_qlist.dats
clean:: ; $(RMF) libats_qlist_dats.o
clean:: ; $(RMF) libats_qlist_dats.c
cleanall:: ; $(RMF) libats_qlist.exe

all:: libats_sllist
libats_sllist: libats_sllist.exe
libats_sllist.exe: libats_sllist_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libats_sllist_dats.c: libats_sllist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_sllist_dats.c --dynamic libats_sllist.dats
clean:: ; $(RMF) libats_sllist_dats.o
clean:: ; $(RMF) libats_sllist_dats.c
cleanall:: ; $(RMF) libats_sllist.exe

all:: libats_dllist
libats_dllist: libats_dllist.exe
libats_dllist.exe: libats_dllist_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libats_dllist_dats.c: libats_dllist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_dllist_dats.c --dynamic libats_dllist.dats
clean:: ; $(RMF) libats_dllist_dats.o
clean:: ; $(RMF) libats_dllist_dats.c
cleanall:: ; $(RMF) libats_dllist.exe


######

all:: libats_ML_string0
libats_ML_string0: libats_ML_string0.exe
libats_ML_string0.exe: libats_ML_string0_dats.c ;   $(GCC) -D_GNU_SOURCE -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -DATS_MEMALLOC_LIBC -o $@ $<
libats_ML_string0_dats.c: libats_ML_string0.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_string0_dats.c --dynamic libats_ML_string0.dats
clean:: ; $(RMF) libats_ML_string0_dats.o
clean:: ; $(RMF) libats_ML_string0_dats.c
cleanall:: ; $(RMF) libats_ML_string0.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
