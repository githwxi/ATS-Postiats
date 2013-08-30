#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

CCOMP=gcc

######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

ATSGCFLAG=
ATSGCFLAG=-D_ATS_GCATS

ATSCCFLAGS=-g
ATSCCFLAGS=-g -O
ATSCCFLAGS=-g -O2

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


SOURCESsta := $(filter %.sats, $(SOURCES))
SOURCESdyn := $(filter %.dats, $(SOURCES))

######

OBJECTS := \
  pats_error_sats.o \
  pats_error_dats.o \
  pats_intinf_sats.o \
  pats_intinf_dats.o \
  pats_counter_sats.o \
  pats_counter_dats.o \
  pats_utils_sats.o \
  pats_utils_dats.o \
  pats_global_sats.o \
  pats_global_dats.o \
  pats_basics_sats.o \
  pats_basics_dats.o \
  pats_stamp_sats.o \
  pats_stamp_dats.o \
  pats_symbol_sats.o \
  pats_symbol_dats.o \
  pats_filename_sats.o \
  pats_filename_dats.o \
  pats_location_sats.o \
  pats_location_dats.o \
  pats_errmsg_sats.o \
  pats_errmsg_dats.o \
  pats_reader_sats.o \
  pats_reader_dats.o \
  pats_lexbuf_sats.o \
  pats_lexbuf_dats.o \
  pats_lexing_sats.o \
  pats_lexing_dats.o \
  pats_lexing_print_dats.o \
  pats_lexing_error_dats.o \
  pats_lexing_token_dats.o \
  pats_label_sats.o \
  pats_label_dats.o \
  pats_effect_sats.o \
  pats_effect_dats.o \
  pats_fixity_sats.o \
  pats_fixity_prec_dats.o \
  pats_fixity_fxty_dats.o \
  pats_syntax_sats.o \
  pats_syntax_dats.o \
  pats_syntax_print_dats.o \
  pats_depgen_sats.o \
  pats_depgen_dats.o \
  pats_taggen_sats.o \
  pats_taggen_dats.o \
  pats_tokbuf_sats.o \
  pats_tokbuf_dats.o \
  pats_parsing_sats.o \
  pats_parsing_dats.o \
  pats_parsing_error_dats.o \
  pats_parsing_util_dats.o \
  pats_parsing_kwds_dats.o \
  pats_parsing_base_dats.o \
  pats_parsing_e0xp_dats.o \
  pats_parsing_sort_dats.o \
  pats_parsing_staexp_dats.o \
  pats_parsing_p0at_dats.o \
  pats_parsing_dynexp_dats.o \
  pats_parsing_decl_dats.o \
  pats_parsing_toplevel_dats.o \
  pats_symmap_sats.o \
  pats_symmap_dats.o \
  pats_symenv_sats.o \
  pats_symenv_dats.o \
  pats_staexp1_sats.o \
  pats_staexp1_dats.o \
  pats_staexp1_print_dats.o \
  pats_dynexp1_sats.o \
  pats_dynexp1_dats.o \
  pats_dynexp1_print_dats.o \
  pats_trans1_sats.o \
  pats_trans1_env_sats.o \
  pats_trans1_env_dats.o \
  pats_e1xpval_sats.o \
  pats_e1xpval_dats.o \
  pats_e1xpval_error_dats.o \
  pats_trans1_error_dats.o \
  pats_trans1_e0xp_dats.o \
  pats_trans1_effect_dats.o \
  pats_trans1_sort_dats.o \
  pats_trans1_staexp_dats.o \
  pats_trans1_p0at_dats.o \
  pats_trans1_syndef_dats.o \
  pats_trans1_dynexp_dats.o \
  pats_trans1_decl_dats.o \
  pats_staexp2_sats.o \
  pats_staexp2_dats.o \
  pats_stacst2_sats.o \
  pats_stacst2_dats.o \
  pats_staexp2_print_dats.o \
  pats_staexp2_pprint_dats.o \
  pats_staexp2_sort_dats.o \
  pats_staexp2_scst_dats.o \
  pats_staexp2_svar_dats.o \
  pats_staexp2_svvar_dats.o \
  pats_staexp2_hole_dats.o \
  pats_staexp2_ctxt_dats.o \
  pats_staexp2_dcon_dats.o \
  pats_staexp2_skexp_dats.o \
  pats_staexp2_szexp_dats.o \
  pats_staexp2_util_sats.o \
  pats_staexp2_util1_dats.o \
  pats_staexp2_util2_dats.o \
  pats_staexp2_util3_dats.o \
  pats_staexp2_error_sats.o \
  pats_staexp2_error_dats.o \
  pats_staexp2_solve_sats.o \
  pats_staexp2_solve_dats.o \
  pats_patcst2_sats.o \
  pats_patcst2_dats.o \
  pats_dynexp2_sats.o \
  pats_dynexp2_dats.o \
  pats_dyncst2_sats.o \
  pats_dyncst2_dats.o \
  pats_dynexp2_print_dats.o \
  pats_dynexp2_dcst_dats.o \
  pats_dynexp2_dvar_dats.o \
  pats_dynexp2_dmac_dats.o \
  pats_dynexp2_util_sats.o \
  pats_dynexp2_util_dats.o \
  pats_trans2_sats.o \
  pats_namespace_sats.o \
  pats_namespace_dats.o \
  pats_trans2_env_sats.o \
  pats_trans2_env_dats.o \
  pats_trans2_error_dats.o \
  pats_trans2_sort_dats.o \
  pats_trans2_staexp_dats.o \
  pats_trans2_p1at_dats.o \
  pats_trans2_dynexp_dats.o \
  pats_trans2_impdec_dats.o \
  pats_trans2_decl_dats.o \
  pats_dynexp3_sats.o \
  pats_dynexp3_dats.o \
  pats_dynexp3_print_dats.o \
  pats_trans3_sats.o \
  pats_trans3_error_dats.o \
  pats_trans3_util_dats.o \
  pats_trans3_env_sats.o \
  pats_trans3_env_dats.o \
  pats_trans3_env_print_dats.o \
  pats_trans3_env_scst_dats.o \
  pats_trans3_env_svar_dats.o \
  pats_trans3_env_termet_dats.o \
  pats_trans3_env_effect_dats.o \
  pats_trans3_env_dvar_dats.o \
  pats_trans3_env_lamlp_dats.o \
  pats_trans3_env_pfman_dats.o \
  pats_trans3_env_lstate_dats.o \
  pats_dmacro2_sats.o \
  pats_dmacro2_dats.o \
  pats_dmacro2_print_dats.o \
  pats_dmacro2_eval0_dats.o \
  pats_dmacro2_eval1_dats.o \
  pats_trans3_p2at_dats.o \
  pats_trans3_patcon_dats.o \
  pats_trans3_syncst_dats.o \
  pats_trans3_dynexp_up_dats.o \
  pats_trans3_dynexp_dn_dats.o \
  pats_trans3_appsym_dats.o \
  pats_trans3_caseof_dats.o \
  pats_trans3_selab_dats.o \
  pats_trans3_ptrof_dats.o \
  pats_trans3_viewat_dats.o \
  pats_trans3_deref_dats.o \
  pats_trans3_assgn_dats.o \
  pats_trans3_xchng_dats.o \
  pats_trans3_lvalres_dats.o \
  pats_trans3_fldfrat_dats.o \
  pats_trans3_looping_dats.o \
  pats_trans3_decl_dats.o \
  pats_lintprgm_sats.o \
  pats_lintprgm_dats.o \
  pats_lintprgm_print_dats.o \
  pats_lintprgm_myint_int_dats.o \
  pats_lintprgm_myint_intinf_dats.o \
  pats_lintprgm_solve_dats.o \
  pats_constraint3_sats.o \
  pats_constraint3_dats.o \
  pats_constraint3_init_dats.o \
  pats_constraint3_print_dats.o \
  pats_constraint3_simplify_dats.o \
  pats_constraint3_icnstr_dats.o \
  pats_constraint3_solve_dats.o \
  pats_histaexp_sats.o \
  pats_histaexp_dats.o \
  pats_histaexp_print_dats.o \
  pats_histaexp_funlab_dats.o \
  pats_hidynexp_sats.o \
  pats_hidynexp_dats.o \
  pats_hidynexp_print_dats.o \
  pats_hidynexp_util_dats.o \
  pats_typerase_sats.o \
  pats_typerase_error_dats.o \
  pats_typerase_staexp_dats.o \
  pats_typerase_dynexp_dats.o \
  pats_typerase_decl_dats.o \
  pats_ccomp_sats.o \
  pats_ccomp_dats.o \
  pats_ccomp_print_dats.o \
  pats_ccomp_hitype_dats.o \
  pats_ccomp_tmplab_dats.o \
  pats_ccomp_tmpvar_dats.o \
  pats_ccomp_d2env_dats.o \
  pats_ccomp_funlab_dats.o \
  pats_ccomp_funent_dats.o \
  pats_ccomp_util_dats.o \
  pats_ccomp_ccompenv_dats.o \
  pats_ccomp_instrseq_dats.o \
  pats_ccomp_hipat_dats.o \
  pats_ccomp_dynexp_dats.o \
  pats_ccomp_caseof_dats.o \
  pats_ccomp_trywith_dats.o \
  pats_ccomp_claulst_dats.o \
  pats_ccomp_looping_dats.o \
  pats_ccomp_decl_dats.o \
  pats_ccomp_subst_dats.o \
  pats_ccomp_environ_dats.o \
  pats_ccomp_template_dats.o \
  pats_ccomp_emit_dats.o \
  pats_ccomp_emit2_dats.o \
  pats_ccomp_emit3_dats.o \
  pats_ccomp_main_dats.o \
  pats_comarg_sats.o \
  pats_comarg_dats.o \


######

all:: patsopt

######
#
# AS-20130407: libats depends on libgmp (hence specified earlier);
# link order matters to GNU ld
#
patsopt: \
  pats_main_dats.o $(OBJECTS) ; \
  $(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ pats_main_dats.o $(OBJECTS) -lats -lgmp
cleanall:: ; $(RMF) patsopt
#
######
#
# for building patsopt through CMake
#
BUILD/init: ; cd BUILD; cmake ..; cd ..
BUILD/clean: ; make -C BUILD -f Makefile clean
BUILD/patsopt: ; make -C BUILD -j8 -f Makefile patsopt
#
######

CBOOT:: ; $(CPF) pats_*.hats CBOOT
CBOOT:: ; $(CPF) pats_*.cats CBOOT
CBOOT:: ; $(CPF) pats_*_sats.c CBOOT
CBOOT:: ; $(CPF) pats_*_dats.c CBOOT

######

TAGATS:: ; $(RMF) $@
TAGATS:: ; $(ATSOPT) -o $@ --taggen -s $(SOURCESsta) -d $(SOURCESdyn)

######

pats_error_sats.c: pats_error.sats; $(ATSCC) -cc $<
pats_error_sats.o: pats_error_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_error_dats.c: pats_error.dats; $(ATSCC) -cc $<
pats_error_dats.o: pats_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_intinf_sats.c: pats_intinf.sats; $(ATSCC) -cc $<
pats_intinf_sats.o: pats_intinf_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_intinf_dats.c: pats_intinf.dats; $(ATSCC) -cc $<
pats_intinf_dats.o: pats_intinf_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_counter_sats.c: pats_counter.sats; $(ATSCC) -cc $<
pats_counter_sats.o: pats_counter_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_counter_dats.c: pats_counter.dats; $(ATSCC) -cc $<
pats_counter_dats.o: pats_counter_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_utils_sats.c: pats_utils.sats; $(ATSCC) -cc $<
pats_utils_sats.o: pats_utils_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_utils_dats.c: pats_utils.dats; $(ATSCC) -cc $<
pats_utils_dats.o: pats_utils_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_global_sats.c: pats_global.sats; $(ATSCC) -cc $<
pats_global_sats.o: pats_global_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_global_dats.c: pats_global.dats; $(ATSCC) -cc $<
pats_global_dats.o: pats_global_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_basics_sats.c: pats_basics.sats; $(ATSCC) -cc $<
pats_basics_sats.o: pats_basics_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_basics_dats.c: pats_basics.dats; $(ATSCC) -cc $<
pats_basics_dats.o: pats_basics_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_stamp_sats.c: pats_stamp.sats; $(ATSCC) -cc $<
pats_stamp_sats.o: pats_stamp_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_stamp_dats.c: pats_stamp.dats; $(ATSCC) -cc $<
pats_stamp_dats.o: pats_stamp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_symbol_sats.c: pats_symbol.sats; $(ATSCC) -cc $<
pats_symbol_sats.o: pats_symbol_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_symbol_dats.c: pats_symbol.dats; $(ATSCC) -cc $<
pats_symbol_dats.o: pats_symbol_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_filename_sats.c: pats_filename.sats; $(ATSCC) -cc $<
pats_filename_sats.o: pats_filename_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_filename_dats.c: pats_filename.dats; $(ATSCC) -cc $<
pats_filename_dats.o: pats_filename_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_location_sats.c: pats_location.sats; $(ATSCC) -cc $<
pats_location_sats.o: pats_location_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_location_dats.c: pats_location.dats; $(ATSCC) -cc $<
pats_location_dats.o: pats_location_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_errmsg_sats.c: pats_errmsg.sats; $(ATSCC) -cc $<
pats_errmsg_sats.o: pats_errmsg_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_errmsg_dats.c: pats_errmsg.dats; $(ATSCC) -cc $<
pats_errmsg_dats.o: pats_errmsg_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_reader_sats.c: pats_reader.sats; $(ATSCC) -cc $<
pats_reader_sats.o: pats_reader_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_reader_dats.c: pats_reader.dats; $(ATSCC) -cc $<
pats_reader_dats.o: pats_reader_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lexbuf_sats.c: pats_lexbuf.sats; $(ATSCC) -cc $<
pats_lexbuf_sats.o: pats_lexbuf_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lexbuf_dats.c: pats_lexbuf.dats; $(ATSCC) -cc $<
pats_lexbuf_dats.o: pats_lexbuf_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lexing_sats.c: pats_lexing.sats; $(ATSCC) -cc $<
pats_lexing_sats.o: pats_lexing_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lexing_dats.c: pats_lexing.dats; $(ATSCC) -cc $<
pats_lexing_dats.o: pats_lexing_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lexing_print_dats.c: pats_lexing_print.dats; $(ATSCC) -cc $<
pats_lexing_print_dats.o: pats_lexing_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lexing_error_dats.c: pats_lexing_error.dats; $(ATSCC) -cc $<
pats_lexing_error_dats.o: pats_lexing_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lexing_token_dats.c: pats_lexing_token.dats; $(ATSCC) -cc $<
pats_lexing_token_dats.o: pats_lexing_token_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_label_sats.c: pats_label.sats; $(ATSCC) -cc $<
pats_label_sats.o: pats_label_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_label_dats.c: pats_label.dats; $(ATSCC) -cc $<
pats_label_dats.o: pats_label_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_effect_sats.c: pats_effect.sats; $(ATSCC) -cc $<
pats_effect_sats.o: pats_effect_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_effect_dats.c: pats_effect.dats; $(ATSCC) -cc $<
pats_effect_dats.o: pats_effect_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_fixity_sats.c: pats_fixity.sats; $(ATSCC) -cc $<
pats_fixity_sats.o: pats_fixity_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_fixity_prec_dats.c: pats_fixity_prec.dats; $(ATSCC) -cc $<
pats_fixity_prec_dats.o: pats_fixity_prec_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_fixity_fxty_dats.c: pats_fixity_fxty.dats; $(ATSCC) -cc $<
pats_fixity_fxty_dats.o: pats_fixity_fxty_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_syntax_sats.c: pats_syntax.sats; $(ATSCC) -cc $<
pats_syntax_sats.o: pats_syntax_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_syntax_dats.c: pats_syntax.dats; $(ATSCC) -cc $<
pats_syntax_dats.o: pats_syntax_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_syntax_print_dats.c: pats_syntax_print.dats; $(ATSCC) -cc $<
pats_syntax_print_dats.o: pats_syntax_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_depgen_sats.c: pats_depgen.sats; $(ATSCC) -cc $<
pats_depgen_sats.o: pats_depgen_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_depgen_dats.c: pats_depgen.dats; $(ATSCC) -cc $<
pats_depgen_dats.o: pats_depgen_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_taggen_sats.c: pats_taggen.sats; $(ATSCC) -cc $<
pats_taggen_sats.o: pats_taggen_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_taggen_dats.c: pats_taggen.dats; $(ATSCC) -cc $<
pats_taggen_dats.o: pats_taggen_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_tokbuf_sats.c: pats_tokbuf.sats; $(ATSCC) -cc $<
pats_tokbuf_sats.o: pats_tokbuf_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_tokbuf_dats.c: pats_tokbuf.dats; $(ATSCC) -cc $<
pats_tokbuf_dats.o: pats_tokbuf_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_sats.c: pats_parsing.sats; $(ATSCC) -cc $<
pats_parsing_sats.o: pats_parsing_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_dats.c: pats_parsing.dats; $(ATSCC) -cc $<
pats_parsing_dats.o: pats_parsing_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_error_dats.c: pats_parsing_error.dats; $(ATSCC) -cc $<
pats_parsing_error_dats.o: pats_parsing_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_util_dats.c: pats_parsing_util.dats; $(ATSCC) -cc $<
pats_parsing_util_dats.o: pats_parsing_util_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_kwds_dats.c: pats_parsing_kwds.dats; $(ATSCC) -cc $<
pats_parsing_kwds_dats.o: pats_parsing_kwds_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_base_dats.c: pats_parsing_base.dats; $(ATSCC) -cc $<
pats_parsing_base_dats.o: pats_parsing_base_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_e0xp_dats.c: pats_parsing_e0xp.dats; $(ATSCC) -cc $<
pats_parsing_e0xp_dats.o: pats_parsing_e0xp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_sort_dats.c: pats_parsing_sort.dats; $(ATSCC) -cc $<
pats_parsing_sort_dats.o: pats_parsing_sort_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_staexp_dats.c: pats_parsing_staexp.dats; $(ATSCC) -cc $<
pats_parsing_staexp_dats.o: pats_parsing_staexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_p0at_dats.c: pats_parsing_p0at.dats; $(ATSCC) -cc $<
pats_parsing_p0at_dats.o: pats_parsing_p0at_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_dynexp_dats.c: pats_parsing_dynexp.dats; $(ATSCC) -cc $<
pats_parsing_dynexp_dats.o: pats_parsing_dynexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_decl_dats.c: pats_parsing_decl.dats; $(ATSCC) -cc $<
pats_parsing_decl_dats.o: pats_parsing_decl_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_parsing_toplevel_dats.c: pats_parsing_toplevel.dats; $(ATSCC) -cc $<
pats_parsing_toplevel_dats.o: pats_parsing_toplevel_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_symmap_sats.c: pats_symmap.sats; $(ATSCC) -cc $<
pats_symmap_sats.o: pats_symmap_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_symmap_dats.c: pats_symmap.dats; $(ATSCC) -cc $<
pats_symmap_dats.o: pats_symmap_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_symenv_sats.c: pats_symenv.sats; $(ATSCC) -cc $<
pats_symenv_sats.o: pats_symenv_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_symenv_dats.c: pats_symenv.dats; $(ATSCC) -cc $<
pats_symenv_dats.o: pats_symenv_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp1_sats.c: pats_staexp1.sats; $(ATSCC) -cc $<
pats_staexp1_sats.o: pats_staexp1_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp1_dats.c: pats_staexp1.dats; $(ATSCC) -cc $<
pats_staexp1_dats.o: pats_staexp1_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp1_print_dats.c: pats_staexp1_print.dats; $(ATSCC) -cc $<
pats_staexp1_print_dats.o: pats_staexp1_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp1_sats.c: pats_dynexp1.sats; $(ATSCC) -cc $<
pats_dynexp1_sats.o: pats_dynexp1_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp1_dats.c: pats_dynexp1.dats; $(ATSCC) -cc $<
pats_dynexp1_dats.o: pats_dynexp1_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp1_print_dats.c: pats_dynexp1_print.dats; $(ATSCC) -cc $<
pats_dynexp1_print_dats.o: pats_dynexp1_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_sats.c: pats_trans1.sats; $(ATSCC) -cc $<
pats_trans1_sats.o: pats_trans1_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_env_sats.c: pats_trans1_env.sats; $(ATSCC) -cc $<
pats_trans1_env_sats.o: pats_trans1_env_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_env_dats.c: pats_trans1_env.dats; $(ATSCC) -cc $<
pats_trans1_env_dats.o: pats_trans1_env_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_e1xpval_sats.c: pats_e1xpval.sats; $(ATSCC) -cc $<
pats_e1xpval_sats.o: pats_e1xpval_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_e1xpval_dats.c: pats_e1xpval.dats; $(ATSCC) -cc $<
pats_e1xpval_dats.o: pats_e1xpval_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_e1xpval_error_dats.c: pats_e1xpval_error.dats; $(ATSCC) -cc $<
pats_e1xpval_error_dats.o: pats_e1xpval_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_error_dats.c: pats_trans1_error.dats; $(ATSCC) -cc $<
pats_trans1_error_dats.o: pats_trans1_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_e0xp_dats.c: pats_trans1_e0xp.dats; $(ATSCC) -cc $<
pats_trans1_e0xp_dats.o: pats_trans1_e0xp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_effect_dats.c: pats_trans1_effect.dats; $(ATSCC) -cc $<
pats_trans1_effect_dats.o: pats_trans1_effect_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_sort_dats.c: pats_trans1_sort.dats; $(ATSCC) -cc $<
pats_trans1_sort_dats.o: pats_trans1_sort_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_staexp_dats.c: pats_trans1_staexp.dats; $(ATSCC) -cc $<
pats_trans1_staexp_dats.o: pats_trans1_staexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_p0at_dats.c: pats_trans1_p0at.dats; $(ATSCC) -cc $<
pats_trans1_p0at_dats.o: pats_trans1_p0at_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_syndef_dats.c: pats_trans1_syndef.dats; $(ATSCC) -cc $<
pats_trans1_syndef_dats.o: pats_trans1_syndef_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_dynexp_dats.c: pats_trans1_dynexp.dats; $(ATSCC) -cc $<
pats_trans1_dynexp_dats.o: pats_trans1_dynexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans1_decl_dats.c: pats_trans1_decl.dats; $(ATSCC) -cc $<
pats_trans1_decl_dats.o: pats_trans1_decl_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_sats.c: pats_staexp2.sats; $(ATSCC) -cc $<
pats_staexp2_sats.o: pats_staexp2_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_dats.c: pats_staexp2.dats; $(ATSCC) -cc $<
pats_staexp2_dats.o: pats_staexp2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_stacst2_sats.c: pats_stacst2.sats; $(ATSCC) -cc $<
pats_stacst2_sats.o: pats_stacst2_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_stacst2_dats.c: pats_stacst2.dats; $(ATSCC) -cc $<
pats_stacst2_dats.o: pats_stacst2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_print_dats.c: pats_staexp2_print.dats; $(ATSCC) -cc $<
pats_staexp2_print_dats.o: pats_staexp2_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_pprint_dats.c: pats_staexp2_pprint.dats; $(ATSCC) -cc $<
pats_staexp2_pprint_dats.o: pats_staexp2_pprint_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_sort_dats.c: pats_staexp2_sort.dats; $(ATSCC) -cc $<
pats_staexp2_sort_dats.o: pats_staexp2_sort_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_scst_dats.c: pats_staexp2_scst.dats; $(ATSCC) -cc $<
pats_staexp2_scst_dats.o: pats_staexp2_scst_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_svar_dats.c: pats_staexp2_svar.dats; $(ATSCC) -cc $<
pats_staexp2_svar_dats.o: pats_staexp2_svar_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_svvar_dats.c: pats_staexp2_svvar.dats; $(ATSCC) -cc $<
pats_staexp2_svvar_dats.o: pats_staexp2_svvar_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_hole_dats.c: pats_staexp2_hole.dats; $(ATSCC) -cc $<
pats_staexp2_hole_dats.o: pats_staexp2_hole_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_ctxt_dats.c: pats_staexp2_ctxt.dats; $(ATSCC) -cc $<
pats_staexp2_ctxt_dats.o: pats_staexp2_ctxt_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_dcon_dats.c: pats_staexp2_dcon.dats; $(ATSCC) -cc $<
pats_staexp2_dcon_dats.o: pats_staexp2_dcon_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_skexp_dats.c: pats_staexp2_skexp.dats; $(ATSCC) -cc $<
pats_staexp2_skexp_dats.o: pats_staexp2_skexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_szexp_dats.c: pats_staexp2_szexp.dats; $(ATSCC) -cc $<
pats_staexp2_szexp_dats.o: pats_staexp2_szexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_util_sats.c: pats_staexp2_util.sats; $(ATSCC) -cc $<
pats_staexp2_util_sats.o: pats_staexp2_util_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_util1_dats.c: pats_staexp2_util1.dats; $(ATSCC) -cc $<
pats_staexp2_util1_dats.o: pats_staexp2_util1_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_util2_dats.c: pats_staexp2_util2.dats; $(ATSCC) -cc $<
pats_staexp2_util2_dats.o: pats_staexp2_util2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_util3_dats.c: pats_staexp2_util3.dats; $(ATSCC) -cc $<
pats_staexp2_util3_dats.o: pats_staexp2_util3_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_error_sats.c: pats_staexp2_error.sats; $(ATSCC) -cc $<
pats_staexp2_error_sats.o: pats_staexp2_error_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_error_dats.c: pats_staexp2_error.dats; $(ATSCC) -cc $<
pats_staexp2_error_dats.o: pats_staexp2_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_solve_sats.c: pats_staexp2_solve.sats; $(ATSCC) -cc $<
pats_staexp2_solve_sats.o: pats_staexp2_solve_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_staexp2_solve_dats.c: pats_staexp2_solve.dats; $(ATSCC) -cc $<
pats_staexp2_solve_dats.o: pats_staexp2_solve_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_patcst2_sats.c: pats_patcst2.sats; $(ATSCC) -cc $<
pats_patcst2_sats.o: pats_patcst2_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_patcst2_dats.c: pats_patcst2.dats; $(ATSCC) -cc $<
pats_patcst2_dats.o: pats_patcst2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_sats.c: pats_dynexp2.sats; $(ATSCC) -cc $<
pats_dynexp2_sats.o: pats_dynexp2_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_dats.c: pats_dynexp2.dats; $(ATSCC) -cc $<
pats_dynexp2_dats.o: pats_dynexp2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dyncst2_sats.c: pats_dyncst2.sats; $(ATSCC) -cc $<
pats_dyncst2_sats.o: pats_dyncst2_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dyncst2_dats.c: pats_dyncst2.dats; $(ATSCC) -cc $<
pats_dyncst2_dats.o: pats_dyncst2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_print_dats.c: pats_dynexp2_print.dats; $(ATSCC) -cc $<
pats_dynexp2_print_dats.o: pats_dynexp2_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_dcst_dats.c: pats_dynexp2_dcst.dats; $(ATSCC) -cc $<
pats_dynexp2_dcst_dats.o: pats_dynexp2_dcst_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_dvar_dats.c: pats_dynexp2_dvar.dats; $(ATSCC) -cc $<
pats_dynexp2_dvar_dats.o: pats_dynexp2_dvar_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_dmac_dats.c: pats_dynexp2_dmac.dats; $(ATSCC) -cc $<
pats_dynexp2_dmac_dats.o: pats_dynexp2_dmac_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_util_sats.c: pats_dynexp2_util.sats; $(ATSCC) -cc $<
pats_dynexp2_util_sats.o: pats_dynexp2_util_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp2_util_dats.c: pats_dynexp2_util.dats; $(ATSCC) -cc $<
pats_dynexp2_util_dats.o: pats_dynexp2_util_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_sats.c: pats_trans2.sats; $(ATSCC) -cc $<
pats_trans2_sats.o: pats_trans2_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_namespace_sats.c: pats_namespace.sats; $(ATSCC) -cc $<
pats_namespace_sats.o: pats_namespace_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_namespace_dats.c: pats_namespace.dats; $(ATSCC) -cc $<
pats_namespace_dats.o: pats_namespace_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_env_sats.c: pats_trans2_env.sats; $(ATSCC) -cc $<
pats_trans2_env_sats.o: pats_trans2_env_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_env_dats.c: pats_trans2_env.dats; $(ATSCC) -cc $<
pats_trans2_env_dats.o: pats_trans2_env_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_error_dats.c: pats_trans2_error.dats; $(ATSCC) -cc $<
pats_trans2_error_dats.o: pats_trans2_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_sort_dats.c: pats_trans2_sort.dats; $(ATSCC) -cc $<
pats_trans2_sort_dats.o: pats_trans2_sort_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_staexp_dats.c: pats_trans2_staexp.dats; $(ATSCC) -cc $<
pats_trans2_staexp_dats.o: pats_trans2_staexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_p1at_dats.c: pats_trans2_p1at.dats; $(ATSCC) -cc $<
pats_trans2_p1at_dats.o: pats_trans2_p1at_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_dynexp_dats.c: pats_trans2_dynexp.dats; $(ATSCC) -cc $<
pats_trans2_dynexp_dats.o: pats_trans2_dynexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_impdec_dats.c: pats_trans2_impdec.dats; $(ATSCC) -cc $<
pats_trans2_impdec_dats.o: pats_trans2_impdec_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans2_decl_dats.c: pats_trans2_decl.dats; $(ATSCC) -cc $<
pats_trans2_decl_dats.o: pats_trans2_decl_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp3_sats.c: pats_dynexp3.sats; $(ATSCC) -cc $<
pats_dynexp3_sats.o: pats_dynexp3_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp3_dats.c: pats_dynexp3.dats; $(ATSCC) -cc $<
pats_dynexp3_dats.o: pats_dynexp3_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dynexp3_print_dats.c: pats_dynexp3_print.dats; $(ATSCC) -cc $<
pats_dynexp3_print_dats.o: pats_dynexp3_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_sats.c: pats_trans3.sats; $(ATSCC) -cc $<
pats_trans3_sats.o: pats_trans3_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_error_dats.c: pats_trans3_error.dats; $(ATSCC) -cc $<
pats_trans3_error_dats.o: pats_trans3_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_util_dats.c: pats_trans3_util.dats; $(ATSCC) -cc $<
pats_trans3_util_dats.o: pats_trans3_util_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_sats.c: pats_trans3_env.sats; $(ATSCC) -cc $<
pats_trans3_env_sats.o: pats_trans3_env_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_dats.c: pats_trans3_env.dats; $(ATSCC) -cc $<
pats_trans3_env_dats.o: pats_trans3_env_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_print_dats.c: pats_trans3_env_print.dats; $(ATSCC) -cc $<
pats_trans3_env_print_dats.o: pats_trans3_env_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_scst_dats.c: pats_trans3_env_scst.dats; $(ATSCC) -cc $<
pats_trans3_env_scst_dats.o: pats_trans3_env_scst_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_svar_dats.c: pats_trans3_env_svar.dats; $(ATSCC) -cc $<
pats_trans3_env_svar_dats.o: pats_trans3_env_svar_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_termet_dats.c: pats_trans3_env_termet.dats; $(ATSCC) -cc $<
pats_trans3_env_termet_dats.o: pats_trans3_env_termet_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_effect_dats.c: pats_trans3_env_effect.dats; $(ATSCC) -cc $<
pats_trans3_env_effect_dats.o: pats_trans3_env_effect_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_dvar_dats.c: pats_trans3_env_dvar.dats; $(ATSCC) -cc $<
pats_trans3_env_dvar_dats.o: pats_trans3_env_dvar_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_lamlp_dats.c: pats_trans3_env_lamlp.dats; $(ATSCC) -cc $<
pats_trans3_env_lamlp_dats.o: pats_trans3_env_lamlp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_pfman_dats.c: pats_trans3_env_pfman.dats; $(ATSCC) -cc $<
pats_trans3_env_pfman_dats.o: pats_trans3_env_pfman_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_env_lstate_dats.c: pats_trans3_env_lstate.dats; $(ATSCC) -cc $<
pats_trans3_env_lstate_dats.o: pats_trans3_env_lstate_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dmacro2_sats.c: pats_dmacro2.sats; $(ATSCC) -cc $<
pats_dmacro2_sats.o: pats_dmacro2_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dmacro2_dats.c: pats_dmacro2.dats; $(ATSCC) -cc $<
pats_dmacro2_dats.o: pats_dmacro2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dmacro2_print_dats.c: pats_dmacro2_print.dats; $(ATSCC) -cc $<
pats_dmacro2_print_dats.o: pats_dmacro2_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dmacro2_eval0_dats.c: pats_dmacro2_eval0.dats; $(ATSCC) -cc $<
pats_dmacro2_eval0_dats.o: pats_dmacro2_eval0_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_dmacro2_eval1_dats.c: pats_dmacro2_eval1.dats; $(ATSCC) -cc $<
pats_dmacro2_eval1_dats.o: pats_dmacro2_eval1_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_p2at_dats.c: pats_trans3_p2at.dats; $(ATSCC) -cc $<
pats_trans3_p2at_dats.o: pats_trans3_p2at_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_patcon_dats.c: pats_trans3_patcon.dats; $(ATSCC) -cc $<
pats_trans3_patcon_dats.o: pats_trans3_patcon_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_syncst_dats.c: pats_trans3_syncst.dats; $(ATSCC) -cc $<
pats_trans3_syncst_dats.o: pats_trans3_syncst_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_dynexp_up_dats.c: pats_trans3_dynexp_up.dats; $(ATSCC) -cc $<
pats_trans3_dynexp_up_dats.o: pats_trans3_dynexp_up_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_dynexp_dn_dats.c: pats_trans3_dynexp_dn.dats; $(ATSCC) -cc $<
pats_trans3_dynexp_dn_dats.o: pats_trans3_dynexp_dn_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_appsym_dats.c: pats_trans3_appsym.dats; $(ATSCC) -cc $<
pats_trans3_appsym_dats.o: pats_trans3_appsym_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_caseof_dats.c: pats_trans3_caseof.dats; $(ATSCC) -cc $<
pats_trans3_caseof_dats.o: pats_trans3_caseof_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_selab_dats.c: pats_trans3_selab.dats; $(ATSCC) -cc $<
pats_trans3_selab_dats.o: pats_trans3_selab_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_ptrof_dats.c: pats_trans3_ptrof.dats; $(ATSCC) -cc $<
pats_trans3_ptrof_dats.o: pats_trans3_ptrof_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_viewat_dats.c: pats_trans3_viewat.dats; $(ATSCC) -cc $<
pats_trans3_viewat_dats.o: pats_trans3_viewat_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_deref_dats.c: pats_trans3_deref.dats; $(ATSCC) -cc $<
pats_trans3_deref_dats.o: pats_trans3_deref_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_assgn_dats.c: pats_trans3_assgn.dats; $(ATSCC) -cc $<
pats_trans3_assgn_dats.o: pats_trans3_assgn_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_xchng_dats.c: pats_trans3_xchng.dats; $(ATSCC) -cc $<
pats_trans3_xchng_dats.o: pats_trans3_xchng_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_lvalres_dats.c: pats_trans3_lvalres.dats; $(ATSCC) -cc $<
pats_trans3_lvalres_dats.o: pats_trans3_lvalres_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_fldfrat_dats.c: pats_trans3_fldfrat.dats; $(ATSCC) -cc $<
pats_trans3_fldfrat_dats.o: pats_trans3_fldfrat_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_looping_dats.c: pats_trans3_looping.dats; $(ATSCC) -cc $<
pats_trans3_looping_dats.o: pats_trans3_looping_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_trans3_decl_dats.c: pats_trans3_decl.dats; $(ATSCC) -cc $<
pats_trans3_decl_dats.o: pats_trans3_decl_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lintprgm_sats.c: pats_lintprgm.sats; $(ATSCC) -cc $<
pats_lintprgm_sats.o: pats_lintprgm_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lintprgm_dats.c: pats_lintprgm.dats; $(ATSCC) -cc $<
pats_lintprgm_dats.o: pats_lintprgm_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lintprgm_print_dats.c: pats_lintprgm_print.dats; $(ATSCC) -cc $<
pats_lintprgm_print_dats.o: pats_lintprgm_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lintprgm_myint_int_dats.c: pats_lintprgm_myint_int.dats; $(ATSCC) -cc $<
pats_lintprgm_myint_int_dats.o: pats_lintprgm_myint_int_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lintprgm_myint_intinf_dats.c: pats_lintprgm_myint_intinf.dats; $(ATSCC) -cc $<
pats_lintprgm_myint_intinf_dats.o: pats_lintprgm_myint_intinf_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_lintprgm_solve_dats.c: pats_lintprgm_solve.dats; $(ATSCC) -cc $<
pats_lintprgm_solve_dats.o: pats_lintprgm_solve_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_constraint3_sats.c: pats_constraint3.sats; $(ATSCC) -cc $<
pats_constraint3_sats.o: pats_constraint3_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_constraint3_dats.c: pats_constraint3.dats; $(ATSCC) -cc $<
pats_constraint3_dats.o: pats_constraint3_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_constraint3_init_dats.c: pats_constraint3_init.dats; $(ATSCC) -cc $<
pats_constraint3_init_dats.o: pats_constraint3_init_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_constraint3_print_dats.c: pats_constraint3_print.dats; $(ATSCC) -cc $<
pats_constraint3_print_dats.o: pats_constraint3_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_constraint3_simplify_dats.c: pats_constraint3_simplify.dats; $(ATSCC) -cc $<
pats_constraint3_simplify_dats.o: pats_constraint3_simplify_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_constraint3_icnstr_dats.c: pats_constraint3_icnstr.dats; $(ATSCC) -cc $<
pats_constraint3_icnstr_dats.o: pats_constraint3_icnstr_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_constraint3_solve_dats.c: pats_constraint3_solve.dats; $(ATSCC) -cc $<
pats_constraint3_solve_dats.o: pats_constraint3_solve_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_histaexp_sats.c: pats_histaexp.sats; $(ATSCC) -cc $<
pats_histaexp_sats.o: pats_histaexp_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_histaexp_dats.c: pats_histaexp.dats; $(ATSCC) -cc $<
pats_histaexp_dats.o: pats_histaexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_histaexp_print_dats.c: pats_histaexp_print.dats; $(ATSCC) -cc $<
pats_histaexp_print_dats.o: pats_histaexp_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_histaexp_funlab_dats.c: pats_histaexp_funlab.dats; $(ATSCC) -cc $<
pats_histaexp_funlab_dats.o: pats_histaexp_funlab_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_hidynexp_sats.c: pats_hidynexp.sats; $(ATSCC) -cc $<
pats_hidynexp_sats.o: pats_hidynexp_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_hidynexp_dats.c: pats_hidynexp.dats; $(ATSCC) -cc $<
pats_hidynexp_dats.o: pats_hidynexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_hidynexp_print_dats.c: pats_hidynexp_print.dats; $(ATSCC) -cc $<
pats_hidynexp_print_dats.o: pats_hidynexp_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_hidynexp_util_dats.c: pats_hidynexp_util.dats; $(ATSCC) -cc $<
pats_hidynexp_util_dats.o: pats_hidynexp_util_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_typerase_sats.c: pats_typerase.sats; $(ATSCC) -cc $<
pats_typerase_sats.o: pats_typerase_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_typerase_error_dats.c: pats_typerase_error.dats; $(ATSCC) -cc $<
pats_typerase_error_dats.o: pats_typerase_error_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_typerase_staexp_dats.c: pats_typerase_staexp.dats; $(ATSCC) -cc $<
pats_typerase_staexp_dats.o: pats_typerase_staexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_typerase_dynexp_dats.c: pats_typerase_dynexp.dats; $(ATSCC) -cc $<
pats_typerase_dynexp_dats.o: pats_typerase_dynexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_typerase_decl_dats.c: pats_typerase_decl.dats; $(ATSCC) -cc $<
pats_typerase_decl_dats.o: pats_typerase_decl_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_sats.c: pats_ccomp.sats; $(ATSCC) -cc $<
pats_ccomp_sats.o: pats_ccomp_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_dats.c: pats_ccomp.dats; $(ATSCC) -cc $<
pats_ccomp_dats.o: pats_ccomp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_print_dats.c: pats_ccomp_print.dats; $(ATSCC) -cc $<
pats_ccomp_print_dats.o: pats_ccomp_print_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_hitype_dats.c: pats_ccomp_hitype.dats; $(ATSCC) -cc $<
pats_ccomp_hitype_dats.o: pats_ccomp_hitype_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_tmplab_dats.c: pats_ccomp_tmplab.dats; $(ATSCC) -cc $<
pats_ccomp_tmplab_dats.o: pats_ccomp_tmplab_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_tmpvar_dats.c: pats_ccomp_tmpvar.dats; $(ATSCC) -cc $<
pats_ccomp_tmpvar_dats.o: pats_ccomp_tmpvar_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_d2env_dats.c: pats_ccomp_d2env.dats; $(ATSCC) -cc $<
pats_ccomp_d2env_dats.o: pats_ccomp_d2env_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_funlab_dats.c: pats_ccomp_funlab.dats; $(ATSCC) -cc $<
pats_ccomp_funlab_dats.o: pats_ccomp_funlab_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_funent_dats.c: pats_ccomp_funent.dats; $(ATSCC) -cc $<
pats_ccomp_funent_dats.o: pats_ccomp_funent_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_util_dats.c: pats_ccomp_util.dats; $(ATSCC) -cc $<
pats_ccomp_util_dats.o: pats_ccomp_util_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_ccompenv_dats.c: pats_ccomp_ccompenv.dats; $(ATSCC) -cc $<
pats_ccomp_ccompenv_dats.o: pats_ccomp_ccompenv_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_instrseq_dats.c: pats_ccomp_instrseq.dats; $(ATSCC) -cc $<
pats_ccomp_instrseq_dats.o: pats_ccomp_instrseq_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_hipat_dats.c: pats_ccomp_hipat.dats; $(ATSCC) -cc $<
pats_ccomp_hipat_dats.o: pats_ccomp_hipat_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_dynexp_dats.c: pats_ccomp_dynexp.dats; $(ATSCC) -cc $<
pats_ccomp_dynexp_dats.o: pats_ccomp_dynexp_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_caseof_dats.c: pats_ccomp_caseof.dats; $(ATSCC) -cc $<
pats_ccomp_caseof_dats.o: pats_ccomp_caseof_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_trywith_dats.c: pats_ccomp_trywith.dats; $(ATSCC) -cc $<
pats_ccomp_trywith_dats.o: pats_ccomp_trywith_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_claulst_dats.c: pats_ccomp_claulst.dats; $(ATSCC) -cc $<
pats_ccomp_claulst_dats.o: pats_ccomp_claulst_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_looping_dats.c: pats_ccomp_looping.dats; $(ATSCC) -cc $<
pats_ccomp_looping_dats.o: pats_ccomp_looping_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_decl_dats.c: pats_ccomp_decl.dats; $(ATSCC) -cc $<
pats_ccomp_decl_dats.o: pats_ccomp_decl_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_subst_dats.c: pats_ccomp_subst.dats; $(ATSCC) -cc $<
pats_ccomp_subst_dats.o: pats_ccomp_subst_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_environ_dats.c: pats_ccomp_environ.dats; $(ATSCC) -cc $<
pats_ccomp_environ_dats.o: pats_ccomp_environ_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_template_dats.c: pats_ccomp_template.dats; $(ATSCC) -cc $<
pats_ccomp_template_dats.o: pats_ccomp_template_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_emit_dats.c: pats_ccomp_emit.dats; $(ATSCC) -cc $<
pats_ccomp_emit_dats.o: pats_ccomp_emit_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_emit2_dats.c: pats_ccomp_emit2.dats; $(ATSCC) -cc $<
pats_ccomp_emit2_dats.o: pats_ccomp_emit2_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_emit3_dats.c: pats_ccomp_emit3.dats; $(ATSCC) -cc $<
pats_ccomp_emit3_dats.o: pats_ccomp_emit3_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_ccomp_main_dats.c: pats_ccomp_main.dats; $(ATSCC) -cc $<
pats_ccomp_main_dats.o: pats_ccomp_main_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_comarg_sats.c: pats_comarg.sats; $(ATSCC) -cc $<
pats_comarg_sats.o: pats_comarg_sats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_comarg_dats.c: pats_comarg.dats; $(ATSCC) -cc $<
pats_comarg_dats.o: pats_comarg_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<

pats_main_dats.c: pats_main.dats; $(ATSCC) -cc $<
pats_main_dats.o: pats_main_dats.c; $(ATSCC) $(ATSCCFLAGS) -c $<



######

#
# HX: '-o .depend' means appending instead of overwriting
#
depend::
	$(RMF) .depend
	$(ATSOPT) -o .depend --depgen -s $(SOURCESsta) -d $(SOURCESdyn)
	$(ATSOPT) -o .depend --depgen -d pats_main.dats
include .depend

######

DIR=.
CPF=cp -f
RMF=rm -f
WCL=wc -l

######

srclines:: ; $(WCL) $(SOURCES) pats_main.dats
liblines:: ; $(WCL) ../prelude/*.sats ../prelude/?ATS/*.?ats ../libc/?ATS/*.?ats ../libats/?ATS/*.?ats

######

clean:: ; $(RMF) $(DIR)/*~
clean:: ; $(RMF) $(DIR)/*_?ats.o
clean:: ; $(RMF) $(DIR)/*_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) TAGATS

###### end of [Makefile] ######
