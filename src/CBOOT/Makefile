#
# The main Makefile
# for ATS/Postiats C-bootstrapping
#
######
#
CCOMP=gcc
#
######

LIBGC :=
gcats_o :=

######
#
# GCFLAG=-D_ATS_NGC
# GCFLAG=-D_ATS_GCATS
# GCFLAG=-D_ATS_GCBDW
#
######

ifeq ($(GCFLAG),-D_ATS_GCBDW)
  LIBGC := -lgc
endif
ifeq ($(GCFLAG),-D_ATS_GCATS)
  gcats_o := gcats.o
endif

######

all:: patsopt

######

SOURCES := \
  pats_params.hats \
  pats_error.sats \
  pats_error.dats \
  pats_intinf.sats \
  pats_intinf.dats \
  pats_counter.sats \
  pats_counter.dats \
  pats_utils.sats \
  pats_utils.dats \
  pats_global.sats \
  pats_global.dats \
  pats_basics.sats \
  pats_basics.dats \
  pats_basics.hats \
  pats_stamp.sats \
  pats_stamp.dats \
  pats_symbol.sats \
  pats_symbol.dats \
  pats_filename.sats \
  pats_filename.dats \
  pats_location.sats \
  pats_location.dats \
  pats_location.cats \
  pats_errmsg.sats \
  pats_errmsg.dats \
  pats_reader.sats \
  pats_reader.dats \
  pats_reader.cats \
  pats_lexbuf.sats \
  pats_lexbuf.dats \
  pats_lexbuf.cats \
  pats_lexing.sats \
  pats_lexing.dats \
  pats_lexing.cats \
  pats_lexing_print.dats \
  pats_lexing_error.dats \
  pats_lexing_token.dats \
  pats_label.sats \
  pats_label.dats \
  pats_effect.sats \
  pats_effect.dats \
  pats_fixity.sats \
  pats_fixity_prec.dats \
  pats_fixity_fxty.dats \
  pats_syntax.sats \
  pats_syntax.dats \
  pats_syntax_print.dats \
  pats_depgen.sats \
  pats_depgen.dats \
  pats_taggen.sats \
  pats_taggen.dats \
  pats_tokbuf.sats \
  pats_tokbuf.dats \
  pats_tokbuf.cats \
  pats_parsing.sats \
  pats_parsing.dats \
  pats_parsing_error.dats \
  pats_parsing_util.dats \
  pats_parsing_kwds.dats \
  pats_parsing_base.dats \
  pats_parsing_e0xp.dats \
  pats_parsing_sort.dats \
  pats_parsing_staexp.dats \
  pats_parsing_p0at.dats \
  pats_parsing_dynexp.dats \
  pats_parsing_decl.dats \
  pats_parsing_toplevel.dats \
  pats_symmap.sats \
  pats_symmap.dats \
  pats_symmap_avltree.hats \
  pats_symmap_htlinprb.hats \
  pats_symenv.sats \
  pats_symenv.dats \
  pats_staexp1.sats \
  pats_staexp1.dats \
  pats_staexp1_print.dats \
  pats_dynexp1.sats \
  pats_dynexp1.dats \
  pats_dynexp1_print.dats \
  pats_trans1.sats \
  pats_trans1_env.sats \
  pats_trans1_env.dats \
  pats_e1xpval.sats \
  pats_e1xpval.dats \
  pats_e1xpval_error.dats \
  pats_filename_reloc.dats \
  pats_trans1_error.dats \
  pats_trans1_e0xp.dats \
  pats_trans1_effect.dats \
  pats_trans1_sort.dats \
  pats_trans1_staexp.dats \
  pats_trans1_p0at.dats \
  pats_trans1_syndef.dats \
  pats_trans1_dynexp.dats \
  pats_trans1_decl.dats \
  pats_staexp2.sats \
  pats_staexp2.dats \
  pats_stacst2.sats \
  pats_stacst2.dats \
  pats_staexp2_print.dats \
  pats_staexp2_pprint.dats \
  pats_staexp2_sort.dats \
  pats_staexp2_scst.dats \
  pats_staexp2_svar.dats \
  pats_staexp2_svvar.dats \
  pats_staexp2_hole.dats \
  pats_staexp2_ctxt.dats \
  pats_staexp2_dcon.dats \
  pats_staexp2_skexp.dats \
  pats_staexp2_szexp.dats \
  pats_staexp2_util.sats \
  pats_staexp2_util1.dats \
  pats_staexp2_util2.dats \
  pats_staexp2_util3.dats \
  pats_staexp2_error.sats \
  pats_staexp2_error.dats \
  pats_staexp2_solve.sats \
  pats_staexp2_solve.dats \
  pats_patcst2.sats \
  pats_patcst2.dats \
  pats_dynexp2.sats \
  pats_dynexp2.dats \
  pats_dyncst2.sats \
  pats_dyncst2.dats \
  pats_dynexp2_print.dats \
  pats_dynexp2_dcst.dats \
  pats_dynexp2_dvar.dats \
  pats_dynexp2_dmac.dats \
  pats_dynexp2_util.sats \
  pats_dynexp2_util.dats \
  pats_trans2.sats \
  pats_namespace.sats \
  pats_namespace.dats \
  pats_trans2_env.sats \
  pats_trans2_env.dats \
  pats_trans2_error.dats \
  pats_trans2_sort.dats \
  pats_trans2_staexp.dats \
  pats_trans2_p1at.dats \
  pats_trans2_dynexp.dats \
  pats_trans2_impdec.dats \
  pats_trans2_decl.dats \
  pats_dynexp3.sats \
  pats_dynexp3.dats \
  pats_dynexp3_print.dats \
  pats_trans3.sats \
  pats_trans3_error.dats \
  pats_trans3_util.dats \
  pats_trans3_env.sats \
  pats_trans3_env.dats \
  pats_trans3_env_print.dats \
  pats_trans3_env_scst.dats \
  pats_trans3_env_svar.dats \
  pats_trans3_env_termet.dats \
  pats_trans3_env_effect.dats \
  pats_trans3_env_dvar.dats \
  pats_trans3_env_lamlp.dats \
  pats_trans3_env_pfman.dats \
  pats_trans3_env_lstate.dats \
  pats_dmacro2.sats \
  pats_dmacro2.dats \
  pats_dmacro2_print.dats \
  pats_dmacro2_eval0.dats \
  pats_dmacro2_eval1.dats \
  pats_trans3_p2at.dats \
  pats_trans3_patcon.dats \
  pats_trans3_syncst.dats \
  pats_trans3_dynexp_up.dats \
  pats_trans3_dynexp_dn.dats \
  pats_trans3_appsym.dats \
  pats_trans3_caseof.dats \
  pats_trans3_selab.dats \
  pats_trans3_ptrof.dats \
  pats_trans3_viewat.dats \
  pats_trans3_deref.dats \
  pats_trans3_assgn.dats \
  pats_trans3_xchng.dats \
  pats_trans3_lvalres.dats \
  pats_trans3_fldfrat.dats \
  pats_trans3_looping.dats \
  pats_trans3_decl.dats \
  pats_lintprgm.sats \
  pats_lintprgm.dats \
  pats_lintprgm_print.dats \
  pats_lintprgm_myint.cats \
  pats_lintprgm_myint_int.dats \
  pats_lintprgm_myint_intinf.dats \
  pats_lintprgm_solve.dats \
  pats_constraint3.sats \
  pats_constraint3.dats \
  pats_constraint3_init.dats \
  pats_constraint3_print.dats \
  pats_constraint3_simplify.dats \
  pats_constraint3_icnstr.dats \
  pats_constraint3_solve.dats \
  pats_histaexp.sats \
  pats_histaexp.dats \
  pats_histaexp_print.dats \
  pats_histaexp_funlab.dats \
  pats_hidynexp.sats \
  pats_hidynexp.dats \
  pats_hidynexp_print.dats \
  pats_hidynexp_util.dats \
  pats_typerase.sats \
  pats_typerase_error.dats \
  pats_typerase_staexp.dats \
  pats_typerase_dynexp.dats \
  pats_typerase_decl.dats \
  pats_ccomp.sats \
  pats_ccomp.dats \
  pats_ccomp_print.dats \
  pats_ccomp_hitype.dats \
  pats_ccomp_tmplab.dats \
  pats_ccomp_tmpvar.dats \
  pats_ccomp_d2env.dats \
  pats_ccomp_funlab.dats \
  pats_ccomp_funent.dats \
  pats_ccomp_util.dats \
  pats_ccomp_ccompenv.dats \
  pats_ccomp_instrseq.dats \
  pats_ccomp_hipat.dats \
  pats_ccomp_dynexp.dats \
  pats_ccomp_caseof.dats \
  pats_ccomp_trywith.dats \
  pats_ccomp_claulst.dats \
  pats_ccomp_looping.dats \
  pats_ccomp_decl.dats \
  pats_ccomp_subst.dats \
  pats_ccomp_environ.dats \
  pats_ccomp_template.dats \
  pats_ccomp_emit.dats \
  pats_ccomp_emit2.dats \
  pats_ccomp_emit3.dats \
  pats_ccomp_main.dats \
  pats_comarg.sats \
  pats_comarg.dats \

######

SOURCESsta := $(filter %.sats, $(SOURCES))
SOURCESdyn := $(filter %.dats, $(SOURCES))

######

OBJECTSsta := $(SOURCESsta)
OBJECTSsta := $(patsubst %.sats, %_sats.o, $(OBJECTSsta))
OBJECTSdyn := $(SOURCESdyn)
OBJECTSdyn := $(patsubst %.dats, %_dats.o, $(OBJECTSdyn))

######

OBJECTSstadyn := $(OBJECTSsta) $(OBJECTSdyn)

######
#
patsopt: \
  pats_main_dats.o $(OBJECTSstadyn) \
  prelude_libats.o libc_libats.o libats_libats.o $(gcats_o) ; \
  $(CCOMP) -O2 -I . $(GCFLAG) -o $@ ccomp/runtime/ats_prelude.c $^ -lgmp $(LIBGC)
#
######

%_sats.o: %_sats.c ; $(CCOMP) -O2 -I . -I ./ccomp/runtime -c -o $@ $<
%_dats.o: %_dats.c ; $(CCOMP) -O2 -I . -I ./ccomp/runtime -c -o $@ $<

######

PRELUDE_OBJECTS := \
  prelude_basics_sta_sats.o \
  prelude_basics_dyn_sats.o \
  prelude_ats_main_prelude_dats.o \
  prelude_DATS_basics_dats.o \
  prelude_DATS_bool_dats.o \
  prelude_DATS_char_dats.o \
  prelude_DATS_float_dats.o \
  prelude_DATS_integer_dats.o \
  prelude_DATS_sizetype_dats.o \
  prelude_DATS_pointer_dats.o \
  prelude_DATS_reference_dats.o \
  prelude_DATS_string_dats.o \
  prelude_DATS_lazy_dats.o \
  prelude_DATS_lazy_vt_dats.o \
  prelude_DATS_printf_dats.o \
  prelude_DATS_filebas_dats.o \
  prelude_DATS_list_dats.o \
  prelude_DATS_list_vt_dats.o \
  prelude_DATS_list0_dats.o \
  prelude_DATS_option_dats.o \
  prelude_DATS_option_vt_dats.o \
  prelude_DATS_option0_dats.o \
  prelude_DATS_array_dats.o \
  prelude_DATS_array0_dats.o \
  prelude_DATS_matrix_dats.o \
  prelude_DATS_matrix0_dats.o \
  prelude_DATS_ptrarr_dats.o \
  prelude_DATS_unsafe_dats.o \

prelude_libats.o: $(PRELUDE_OBJECTS) ; ld -r -o $@ $^

prelude_%.o: prelude/%.c ; $(CCOMP) -I . -I ./ccomp/runtime -c -o $@ $<

######

LIBC_OBJECTS := \
  libc_SATS_errno_sats.o \
  libc_SATS_fcntl_sats.o \
  libc_DATS_fcntl_dats.o \
  libc_SATS_stdarg_sats.o \
  libc_SATS_stdio_sats.o \
  libc_SATS_stdlib_sats.o \
  libc_SATS_string_sats.o \
  libc_SATS_time_sats.o \
  libc_SATS_unistd_sats.o \
  libc_DATS_unistd_dats.o \
  libc_sys_SATS_stat_sats.o \
  libc_sys_SATS_types_sats.o \
  libc_SATS_gmp_sats.o \
  libc_DATS_gmp_dats.o \

libc_libats.o: $(LIBC_OBJECTS) ; ld -r -o $@ $^

libc_%.o : libc/%.c ; $(CCOMP) -I . -I ./ccomp/runtime -c -o $@ $<

######

LIBATS_OBJECTS := \
  libats_SATS_funmap_avltree_sats.o \
  libats_DATS_funmap_avltree_dats.o \
  libats_SATS_funset_avltree_sats.o \
  libats_DATS_funset_avltree_dats.o \
  libats_SATS_funset_listord_sats.o \
  libats_DATS_funset_listord_dats.o \
  libats_SATS_funmset_listord_sats.o \
  libats_DATS_funmset_listord_dats.o \
  libats_SATS_hashtable_chain_sats.o \
  libats_DATS_hashtable_chain_dats.o \
  libats_SATS_hashtable_linprb_sats.o \
  libats_DATS_hashtable_linprb_dats.o \
  libats_SATS_linqueue_arr_sats.o \
  libats_DATS_linqueue_arr_dats.o \
  libats_SATS_linqueue_lst_sats.o \
  libats_DATS_linqueue_lst_dats.o \
  libats_ngc_SATS_deque_arr_sats.o \
  libats_ngc_DATS_deque_arr_dats.o \

libats_libats.o: $(LIBATS_OBJECTS) ; ld -r -o $@ $^

libats_%.o : libats/%.c ; $(CCOMP) -I . -I ./ccomp/runtime -c -o $@ $<

######

gcats.o: \
  gcats1_hats \
  gcats1_all_cats.o ; ld -r -o $@ gcats1_all_cats.o

gcats1_hats: ; \
  gcc -E -P -o gcats1.hats -x c ./ccomp/runtime/GCATS/gcats1_master.hats
gcats1_all_cats.o: \
  gcats1_all.cats ; $(CCOMP) -O2 -I . -I ./ccomp/runtime -o $@ -c -x c $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_sats.o
clean:: ; $(RMF) *_dats.o
clean:: ; $(RMF) gcats1.hats
clean:: ; $(RMF) gcats1_all_cats.o

######

cleanall:: clean
cleanall:: ; $(RMF) prelude_libats.o
cleanall:: ; $(RMF) libc_libats.o
cleanall:: ; $(RMF) libats_libats.o
cleanall:: ; $(RMF) gcats.o
cleanall:: ; $(RMF) patsopt

######

###### end of [Makefile] ######
