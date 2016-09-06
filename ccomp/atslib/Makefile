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
all:: ; ranlib lib/libatslib.a

######

atslib:: atslib_prelude

######

atslib_prelude:: atslib_prelude_integer_dats
atslib_prelude_integer_dats: output/atslib_prelude_integer_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_integer_dats.c: ../../prelude/DATS/integer.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_integer_dats.o: output/atslib_prelude_integer_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_integer_dats.c
clean:: ; $(RMF) output/atslib_prelude_integer_dats.o

atslib_prelude:: atslib_prelude_pointer_dats
atslib_prelude_pointer_dats: output/atslib_prelude_pointer_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_pointer_dats.c: ../../prelude/DATS/pointer.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_pointer_dats.o: output/atslib_prelude_pointer_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_pointer_dats.c
clean:: ; $(RMF) output/atslib_prelude_pointer_dats.o


atslib_prelude:: atslib_prelude_integer_long_dats
atslib_prelude_integer_long_dats: output/atslib_prelude_integer_long_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_integer_long_dats.c: ../../prelude/DATS/integer_long.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_integer_long_dats.o: output/atslib_prelude_integer_long_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_integer_long_dats.c
clean:: ; $(RMF) output/atslib_prelude_integer_long_dats.o

atslib_prelude:: atslib_prelude_integer_size_dats
atslib_prelude_integer_size_dats: output/atslib_prelude_integer_size_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_integer_size_dats.c: ../../prelude/DATS/integer_size.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_integer_size_dats.o: output/atslib_prelude_integer_size_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_integer_size_dats.c
clean:: ; $(RMF) output/atslib_prelude_integer_size_dats.o

atslib_prelude:: atslib_prelude_integer_short_dats
atslib_prelude_integer_short_dats: output/atslib_prelude_integer_short_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_integer_short_dats.c: ../../prelude/DATS/integer_short.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_integer_short_dats.o: output/atslib_prelude_integer_short_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_integer_short_dats.c
clean:: ; $(RMF) output/atslib_prelude_integer_short_dats.o


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

atslib_prelude:: atslib_prelude_integer_ptr_dats
atslib_prelude_integer_ptr_dats: output/atslib_prelude_integer_ptr_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_integer_ptr_dats.c: ../../prelude/DATS/integer_ptr.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_integer_ptr_dats.o: output/atslib_prelude_integer_ptr_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_integer_ptr_dats.c
clean:: ; $(RMF) output/atslib_prelude_integer_ptr_dats.o

atslib_prelude:: atslib_prelude_integer_fixed_dats
atslib_prelude_integer_fixed_dats: output/atslib_prelude_integer_fixed_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_integer_fixed_dats.c: ../../prelude/DATS/integer_fixed.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_integer_fixed_dats.o: output/atslib_prelude_integer_fixed_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_integer_fixed_dats.c
clean:: ; $(RMF) output/atslib_prelude_integer_fixed_dats.o


######

atslib_prelude:: atslib_prelude_filebas_dats
atslib_prelude_filebas_dats: output/atslib_prelude_filebas_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_prelude_filebas_dats.c: ../../prelude/DATS/filebas.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_prelude_filebas_dats.o: output/atslib_prelude_filebas_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_prelude_filebas_dats.c
clean:: ; $(RMF) output/atslib_prelude_filebas_dats.o


######

atslib:: atslib_libats

######

atslib_libats:: atslib_libats_stringbuf_dats
atslib_libats_stringbuf_dats: output/atslib_libats_stringbuf_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_stringbuf_dats.c: ../../libats/DATS/stringbuf.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_stringbuf_dats.o: output/atslib_libats_stringbuf_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_stringbuf_dats.c
clean:: ; $(RMF) output/atslib_libats_stringbuf_dats.o


######

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

atslib_libats:: atslib_libats_linralist_nested_dats
atslib_libats_linralist_nested_dats: output/atslib_libats_linralist_nested_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_linralist_nested_dats.c: ../../libats/DATS/linralist_nested.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_linralist_nested_dats.o: output/atslib_libats_linralist_nested_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_linralist_nested_dats.c
clean:: ; $(RMF) output/atslib_libats_linralist_nested_dats.o


######

atslib_libats:: atslib_libats_hashtbl_chain_dats
atslib_libats_hashtbl_chain_dats: output/atslib_libats_hashtbl_chain_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_hashtbl_chain_dats.c: ../../libats/DATS/hashtbl_chain.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_hashtbl_chain_dats.o: output/atslib_libats_hashtbl_chain_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_hashtbl_chain_dats.c
clean:: ; $(RMF) output/atslib_libats_hashtbl_chain_dats.o


######

atslib:: atslib_libats_ML

######

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

atslib_libats_ML:: atslib_libats_ML_matrix0_dats
atslib_libats_ML_matrix0_dats: output/atslib_libats_ML_matrix0_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_matrix0_dats.c: ../../libats/ML/DATS/matrix0.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_matrix0_dats.o: output/atslib_libats_ML_matrix0_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_matrix0_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_matrix0_dats.o

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

atslib_libats_ML:: atslib_libats_ML_gvalue_dats
atslib_libats_ML_gvalue_dats: output/atslib_libats_ML_gvalue_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_gvalue_dats.c: ../../libats/ML/DATS/gvalue.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_gvalue_dats.o: output/atslib_libats_ML_gvalue_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_gvalue_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_gvalue_dats.o


######

atslib_libats_ML:: atslib_libats_ML_dynarray_dats
atslib_libats_ML_dynarray_dats: output/atslib_libats_ML_dynarray_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_dynarray_dats.c: ../../libats/ML/DATS/dynarray.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_dynarray_dats.o: output/atslib_libats_ML_dynarray_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_dynarray_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_dynarray_dats.o

atslib_libats_ML:: atslib_libats_ML_hashtblref_dats
atslib_libats_ML_hashtblref_dats: output/atslib_libats_ML_hashtblref_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_ML_hashtblref_dats.c: ../../libats/ML/DATS/hashtblref.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_ML_hashtblref_dats.o: output/atslib_libats_ML_hashtblref_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_ML_hashtblref_dats.c
clean:: ; $(RMF) output/atslib_libats_ML_hashtblref_dats.o


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

atslib:: atslib_libats_libc

######

atslib_libats_libc:: atslib_libats_libc_errno_dats
atslib_libats_libc_errno_dats: output/atslib_libats_libc_errno_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_errno_dats.c: ../../libats/libc/DATS/errno.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_errno_dats.o: output/atslib_libats_libc_errno_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_errno_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_errno_dats.o

atslib_libats_libc:: atslib_libats_libc_fcntl_dats
atslib_libats_libc_fcntl_dats: output/atslib_libats_libc_fcntl_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_fcntl_dats.c: ../../libats/libc/DATS/fcntl.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_fcntl_dats.o: output/atslib_libats_libc_fcntl_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_fcntl_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_fcntl_dats.o

atslib_libats_libc:: atslib_libats_libc_dirent_dats
atslib_libats_libc_dirent_dats: output/atslib_libats_libc_dirent_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_dirent_dats.c: ../../libats/libc/DATS/dirent.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_dirent_dats.o: output/atslib_libats_libc_dirent_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_dirent_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_dirent_dats.o

atslib_libats_libc:: atslib_libats_libc_stdio_dats
atslib_libats_libc_stdio_dats: output/atslib_libats_libc_stdio_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_stdio_dats.c: ../../libats/libc/DATS/stdio.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_stdio_dats.o: output/atslib_libats_libc_stdio_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_stdio_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_stdio_dats.o

atslib_libats_libc:: atslib_libats_libc_stdlib_dats
atslib_libats_libc_stdlib_dats: output/atslib_libats_libc_stdlib_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_stdlib_dats.c: ../../libats/libc/DATS/stdlib.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_stdlib_dats.o: output/atslib_libats_libc_stdlib_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_stdlib_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_stdlib_dats.o

atslib_libats_libc:: atslib_libats_libc_string_dats
atslib_libats_libc_string_dats: output/atslib_libats_libc_string_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_string_dats.c: ../../libats/libc/DATS/string.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_string_dats.o: output/atslib_libats_libc_string_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_string_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_string_dats.o

atslib_libats_libc:: atslib_libats_libc_strings_dats
atslib_libats_libc_strings_dats: output/atslib_libats_libc_strings_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_strings_dats.c: ../../libats/libc/DATS/strings.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_strings_dats.o: output/atslib_libats_libc_strings_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_strings_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_strings_dats.o

atslib_libats_libc:: atslib_libats_libc_time_dats
atslib_libats_libc_time_dats: output/atslib_libats_libc_time_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_time_dats.c: ../../libats/libc/DATS/time.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_time_dats.o: output/atslib_libats_libc_time_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_time_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_time_dats.o

atslib_libats_libc:: atslib_libats_libc_unistd_dats
atslib_libats_libc_unistd_dats: output/atslib_libats_libc_unistd_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_unistd_dats.c: ../../libats/libc/DATS/unistd.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_unistd_dats.o: output/atslib_libats_libc_unistd_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_unistd_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_unistd_dats.o


######

atslib:: atslib_libats_libc_sys

######

atslib_libats_libc_sys:: atslib_libats_libc_sys_stat_dats
atslib_libats_libc_sys_stat_dats: output/atslib_libats_libc_sys_stat_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_sys_stat_dats.c: ../../libats/libc/sys/DATS/stat.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_sys_stat_dats.o: output/atslib_libats_libc_sys_stat_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_sys_stat_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_sys_stat_dats.o

atslib_libats_libc_sys:: atslib_libats_libc_sys_types_dats
atslib_libats_libc_sys_types_dats: output/atslib_libats_libc_sys_types_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_sys_types_dats.c: ../../libats/libc/sys/DATS/types.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_sys_types_dats.o: output/atslib_libats_libc_sys_types_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_sys_types_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_sys_types_dats.o

atslib_libats_libc_sys:: atslib_libats_libc_sys_socket_dats
atslib_libats_libc_sys_socket_dats: output/atslib_libats_libc_sys_socket_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_sys_socket_dats.c: ../../libats/libc/sys/DATS/socket.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_sys_socket_dats.o: output/atslib_libats_libc_sys_socket_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_sys_socket_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_sys_socket_dats.o

atslib_libats_libc_sys:: atslib_libats_libc_sys_socket_in_dats
atslib_libats_libc_sys_socket_in_dats: output/atslib_libats_libc_sys_socket_in_dats.o ; $(ARR) lib/libatslib.a $<
output/atslib_libats_libc_sys_socket_in_dats.c: ../../libats/libc/sys/DATS/socket_in.dats ; $(PATSOPT) -o $@ --dynamic $<
output/atslib_libats_libc_sys_socket_in_dats.o: output/atslib_libats_libc_sys_socket_in_dats.c ; \
  $(CCOMP) -I$(PATSHOMEQ) -I$(PATSRUNTIME) $(DATSMEMALLOC) $(CCFLAGS) -c -o $@ $<
clean:: ; $(RMF) output/atslib_libats_libc_sys_socket_in_dats.c
clean:: ; $(RMF) output/atslib_libats_libc_sys_socket_in_dats.o


######

ARR=ar -r
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean
cleanall:: ; $(RMF) Makefile.exe
cleanall:: ; $(RMF) lib/libatslib.a

###### end of [Makefile] ######
