#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

PATSHOMEQ="$(PATSHOME)"
PATSRUNTIME=$(PATSHOMEQ)/ccomp/runtime

######

PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

CCOMP=gcc
CCFLAGS=-fPIC -O2

######
#
DATSMEMALLOC=
#
# DATSMEMALLOC=-DATS_MEMALLOC_LIBC
# DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

all:: atslib

######

atslib:: atslib_prelude
atslib_prelude:: atslib_prelude_bool_dats
atslib_prelude_bool_dats: output/atslib_prelude_bool_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_bool_dats.c: ../../prelude/DATS/bool.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_bool_dats.o: output/atslib_prelude_bool_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_bool_dats.c
clean:: ; $(RMF) output/atslib_prelude_bool_dats.o

atslib_prelude:: atslib_prelude_char_dats
atslib_prelude_char_dats: output/atslib_prelude_char_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_char_dats.c: ../../prelude/DATS/char.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_char_dats.o: output/atslib_prelude_char_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_char_dats.c
clean:: ; $(RMF) output/atslib_prelude_char_dats.o

atslib_prelude:: atslib_prelude_integer_dats
atslib_prelude_integer_dats: output/atslib_prelude_integer_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_integer_dats.c: ../../prelude/DATS/integer.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_integer_dats.o: output/atslib_prelude_integer_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_integer_dats.c
clean:: ; $(RMF) output/atslib_prelude_integer_dats.o

atslib_prelude:: atslib_prelude_float_dats
atslib_prelude_float_dats: output/atslib_prelude_float_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_float_dats.c: ../../prelude/DATS/float.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_float_dats.o: output/atslib_prelude_float_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_float_dats.c
clean:: ; $(RMF) output/atslib_prelude_float_dats.o

atslib_prelude:: atslib_prelude_string_dats
atslib_prelude_string_dats: output/atslib_prelude_string_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_string_dats.c: ../../prelude/DATS/string.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_string_dats.o: output/atslib_prelude_string_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_string_dats.c
clean:: ; $(RMF) output/atslib_prelude_string_dats.o

atslib_prelude:: atslib_prelude_strptr_dats
atslib_prelude_strptr_dats: output/atslib_prelude_strptr_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_strptr_dats.c: ../../prelude/DATS/strptr.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_strptr_dats.o: output/atslib_prelude_strptr_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_strptr_dats.c
clean:: ; $(RMF) output/atslib_prelude_strptr_dats.o


######

atslib_prelude:: atslib_prelude_filebas_dats
atslib_prelude_filebas_dats: output/atslib_prelude_filebas_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_filebas_dats.c: ../../prelude/DATS/filebas.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_filebas_dats.o: output/atslib_prelude_filebas_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_filebas_dats.c
clean:: ; $(RMF) output/atslib_prelude_filebas_dats.o


######

atslib:: atslib_libc
atslib_libc:: atslib_libc_dirent_dats
atslib_libc_dirent_dats: output/atslib_libc_dirent_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_dirent_dats.c: ../../libc/DATS/dirent.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_dirent_dats.o: output/atslib_libc_dirent_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_dirent_dats.c
clean:: ; $(RMF) output/atslib_libc_dirent_dats.o

atslib_libc:: atslib_libc_fcntl_dats
atslib_libc_fcntl_dats: output/atslib_libc_fcntl_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_fcntl_dats.c: ../../libc/DATS/fcntl.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_fcntl_dats.o: output/atslib_libc_fcntl_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_fcntl_dats.c
clean:: ; $(RMF) output/atslib_libc_fcntl_dats.o

atslib_libc:: atslib_libc_stdio_dats
atslib_libc_stdio_dats: output/atslib_libc_stdio_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_stdio_dats.c: ../../libc/DATS/stdio.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_stdio_dats.o: output/atslib_libc_stdio_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_stdio_dats.c
clean:: ; $(RMF) output/atslib_libc_stdio_dats.o

atslib_libc:: atslib_libc_stdlib_dats
atslib_libc_stdlib_dats: output/atslib_libc_stdlib_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_stdlib_dats.c: ../../libc/DATS/stdlib.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_stdlib_dats.o: output/atslib_libc_stdlib_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_stdlib_dats.c
clean:: ; $(RMF) output/atslib_libc_stdlib_dats.o

atslib_libc:: atslib_libc_string_dats
atslib_libc_string_dats: output/atslib_libc_string_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_string_dats.c: ../../libc/DATS/string.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_string_dats.o: output/atslib_libc_string_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_string_dats.c
clean:: ; $(RMF) output/atslib_libc_string_dats.o

atslib_libc:: atslib_libc_strings_dats
atslib_libc_strings_dats: output/atslib_libc_strings_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_strings_dats.c: ../../libc/DATS/strings.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_strings_dats.o: output/atslib_libc_strings_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_strings_dats.c
clean:: ; $(RMF) output/atslib_libc_strings_dats.o

atslib_libc:: atslib_libc_time_dats
atslib_libc_time_dats: output/atslib_libc_time_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_time_dats.c: ../../libc/DATS/time.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_time_dats.o: output/atslib_libc_time_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_time_dats.c
clean:: ; $(RMF) output/atslib_libc_time_dats.o

atslib_libc:: atslib_libc_unistd_dats
atslib_libc_unistd_dats: output/atslib_libc_unistd_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libc_unistd_dats.c: ../../libc/DATS/unistd.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libc_unistd_dats.o: output/atslib_libc_unistd_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libc_unistd_dats.c
clean:: ; $(RMF) output/atslib_libc_unistd_dats.o


######

atslib:: atslib_libats
atslib_libats:: atslib_libats_funset_avltree_dats
atslib_libats_funset_avltree_dats: output/atslib_libats_funset_avltree_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_funset_avltree_dats.c: ../../libats/DATS/funset_avltree.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_funset_avltree_dats.o: output/atslib_libats_funset_avltree_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_funset_avltree_dats.c
clean:: ; $(RMF) output/atslib_libats_funset_avltree_dats.o

atslib_libats:: atslib_libats_funset_listord_dats
atslib_libats_funset_listord_dats: output/atslib_libats_funset_listord_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_funset_listord_dats.c: ../../libats/DATS/funset_listord.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_funset_listord_dats.o: output/atslib_libats_funset_listord_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_funset_listord_dats.c
clean:: ; $(RMF) output/atslib_libats_funset_listord_dats.o

atslib_libats:: atslib_libats_funmap_list_dats
atslib_libats_funmap_list_dats: output/atslib_libats_funmap_list_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_funmap_list_dats.c: ../../libats/DATS/funmap_list.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_funmap_list_dats.o: output/atslib_libats_funmap_list_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_funmap_list_dats.c
clean:: ; $(RMF) output/atslib_libats_funmap_list_dats.o

atslib_libats:: atslib_libats_funmap_avltree_dats
atslib_libats_funmap_avltree_dats: output/atslib_libats_funmap_avltree_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_funmap_avltree_dats.c: ../../libats/DATS/funmap_avltree.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_funmap_avltree_dats.o: output/atslib_libats_funmap_avltree_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_funmap_avltree_dats.c
clean:: ; $(RMF) output/atslib_libats_funmap_avltree_dats.o

atslib_libats:: atslib_libats_fundeque_fngtree_dats
atslib_libats_fundeque_fngtree_dats: output/atslib_libats_fundeque_fngtree_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_fundeque_fngtree_dats.c: ../../libats/DATS/fundeque_fngtree.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_fundeque_fngtree_dats.o: output/atslib_libats_fundeque_fngtree_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_fundeque_fngtree_dats.c
clean:: ; $(RMF) output/atslib_libats_fundeque_fngtree_dats.o

atslib_libats:: atslib_libats_funralist_nested_dats
atslib_libats_funralist_nested_dats: output/atslib_libats_funralist_nested_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_funralist_nested_dats.c: ../../libats/DATS/funralist_nested.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_funralist_nested_dats.o: output/atslib_libats_funralist_nested_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_funralist_nested_dats.c
clean:: ; $(RMF) output/atslib_libats_funralist_nested_dats.o


######

atslib_libats:: atslib_libats_linmap_list_dats
atslib_libats_linmap_list_dats: output/atslib_libats_linmap_list_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linmap_list_dats.c: ../../libats/DATS/linmap_list.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linmap_list_dats.o: output/atslib_libats_linmap_list_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linmap_list_dats.c
clean:: ; $(RMF) output/atslib_libats_linmap_list_dats.o

atslib_libats:: atslib_libats_linmap_randbst_dats
atslib_libats_linmap_randbst_dats: output/atslib_libats_linmap_randbst_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linmap_randbst_dats.c: ../../libats/DATS/linmap_randbst.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linmap_randbst_dats.o: output/atslib_libats_linmap_randbst_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linmap_randbst_dats.c
clean:: ; $(RMF) output/atslib_libats_linmap_randbst_dats.o

atslib_libats:: atslib_libats_linmap_skiplist_dats
atslib_libats_linmap_skiplist_dats: output/atslib_libats_linmap_skiplist_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linmap_skiplist_dats.c: ../../libats/DATS/linmap_skiplist.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linmap_skiplist_dats.o: output/atslib_libats_linmap_skiplist_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linmap_skiplist_dats.c
clean:: ; $(RMF) output/atslib_libats_linmap_skiplist_dats.o

atslib_libats:: atslib_libats_linset_listord_dats
atslib_libats_linset_listord_dats: output/atslib_libats_linset_listord_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linset_listord_dats.c: ../../libats/DATS/linset_listord.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linset_listord_dats.o: output/atslib_libats_linset_listord_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linset_listord_dats.c
clean:: ; $(RMF) output/atslib_libats_linset_listord_dats.o

atslib_libats:: atslib_libats_linset_avltree_dats
atslib_libats_linset_avltree_dats: output/atslib_libats_linset_avltree_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linset_avltree_dats.c: ../../libats/DATS/linset_avltree.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linset_avltree_dats.o: output/atslib_libats_linset_avltree_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linset_avltree_dats.c
clean:: ; $(RMF) output/atslib_libats_linset_avltree_dats.o

atslib_libats:: atslib_libats_linhashtbl_chain_dats
atslib_libats_linhashtbl_chain_dats: output/atslib_libats_linhashtbl_chain_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linhashtbl_chain_dats.c: ../../libats/DATS/linhashtbl_chain.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linhashtbl_chain_dats.o: output/atslib_libats_linhashtbl_chain_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linhashtbl_chain_dats.c
clean:: ; $(RMF) output/atslib_libats_linhashtbl_chain_dats.o

atslib_libats:: atslib_libats_linralist_nested_dats
atslib_libats_linralist_nested_dats: output/atslib_libats_linralist_nested_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linralist_nested_dats.c: ../../libats/DATS/linralist_nested.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linralist_nested_dats.o: output/atslib_libats_linralist_nested_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linralist_nested_dats.c
clean:: ; $(RMF) output/atslib_libats_linralist_nested_dats.o


######

atslib:: atslib_libats_ML
atslib_libats_ML:: atslib_libats_ML_list0_dats
atslib_libats_ML_list0_dats: output/atslib_libats_ML_list0_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_list0_dats.c: ../../libats/ML/DATS/list0.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_list0_dats.o: output/atslib_libats_ML_list0_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_list0_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_list0_dats.o

atslib_libats_ML:: atslib_libats_ML_option0_dats
atslib_libats_ML_option0_dats: output/atslib_libats_ML_option0_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_option0_dats.c: ../../libats/ML/DATS/option0.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_option0_dats.o: output/atslib_libats_ML_option0_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_option0_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_option0_dats.o

atslib_libats_ML:: atslib_libats_ML_array0_dats
atslib_libats_ML_array0_dats: output/atslib_libats_ML_array0_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_array0_dats.c: ../../libats/ML/DATS/array0.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_array0_dats.o: output/atslib_libats_ML_array0_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_array0_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_array0_dats.o

atslib_libats_ML:: atslib_libats_ML_string_dats
atslib_libats_ML_string_dats: output/atslib_libats_ML_string_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_string_dats.c: ../../libats/ML/DATS/string.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_string_dats.o: output/atslib_libats_ML_string_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_string_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_string_dats.o

atslib_libats_ML:: atslib_libats_ML_strarr_dats
atslib_libats_ML_strarr_dats: output/atslib_libats_ML_strarr_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_strarr_dats.c: ../../libats/ML/DATS/strarr.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_strarr_dats.o: output/atslib_libats_ML_strarr_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_strarr_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_strarr_dats.o


######

atslib_libats_ML:: atslib_libats_ML_filebas_dats
atslib_libats_ML_filebas_dats: output/atslib_libats_ML_filebas_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_filebas_dats.c: ../../libats/ML/DATS/filebas.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_filebas_dats.o: output/atslib_libats_ML_filebas_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_filebas_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_filebas_dats.o

atslib_libats_ML:: atslib_libats_ML_filebas_dirent_dats
atslib_libats_ML_filebas_dirent_dats: output/atslib_libats_ML_filebas_dirent_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_filebas_dirent_dats.c: ../../libats/ML/DATS/filebas_dirent.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_filebas_dirent_dats.o: output/atslib_libats_ML_filebas_dirent_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_filebas_dirent_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_filebas_dirent_dats.o


######

ARR=ar -r
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean
cleanall:: ; $(RMF) output/*
cleanall:: ; $(RMF) Makefile.exe
cleanall:: ; $(RMF) lib/libatslib.a

###### end of [Makefile] ######
