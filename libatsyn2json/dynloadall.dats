(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: November, 2013
**
*)

(* ****** ****** *)
//
dynload "src/pats_error.dats"
dynload "src/pats_intinf.dats"
dynload "src/pats_counter.dats"
dynload "src/pats_utils.dats"
dynload "src/pats_global.dats"
dynload "src/pats_basics.dats"
dynload "src/pats_stamp.dats"
dynload "src/pats_symbol.dats"
//
dynload "src/pats_filename.dats"
dynload "src/pats_filename_reloc.dats"
dynload "src/pats_location.dats"
//
dynload "src/pats_errmsg.dats"
//
dynload "src/pats_reader.dats"
//
dynload "src/pats_lexbuf.dats"
//
dynload "src/pats_lexing.dats"
dynload "src/pats_lexing_token.dats"
dynload "src/pats_lexing_print.dats"
dynload "src/pats_lexing_error.dats"
//
dynload "src/pats_label.dats"
//
dynload "src/pats_effect.dats"
//
dynload "src/pats_fixity_prec.dats"
dynload "src/pats_fixity_fxty.dats"
//
dynload "src/pats_syntax.dats"
dynload "src/pats_syntax_print.dats"
//
dynload "src/pats_tokbuf.dats"
//
dynload "src/pats_parsing.dats"
dynload "src/pats_parsing_error.dats"
dynload "src/pats_parsing_util.dats"
dynload "src/pats_parsing_kwds.dats"
dynload "src/pats_parsing_base.dats"
dynload "src/pats_parsing_e0xp.dats"
dynload "src/pats_parsing_sort.dats"
dynload "src/pats_parsing_staexp.dats"
dynload "src/pats_parsing_p0at.dats"
dynload "src/pats_parsing_dynexp.dats"
dynload "src/pats_parsing_decl.dats"
dynload "src/pats_parsing_toplevel.dats"
//
dynload "src/pats_symmap.dats"
dynload "src/pats_symenv.dats"
//
dynload "src/pats_staexp1.dats"
dynload "src/pats_staexp1_print.dats"
dynload "src/pats_dynexp1.dats"
dynload "src/pats_dynexp1_print.dats"
//
dynload "src/pats_staexp2.dats"
dynload "src/pats_stacst2.dats"
dynload "src/pats_staexp2_print.dats"
dynload "src/pats_staexp2_pprint.dats"
dynload "src/pats_staexp2_sort.dats"
dynload "src/pats_staexp2_scst.dats"
dynload "src/pats_staexp2_svar.dats"
dynload "src/pats_staexp2_svvar.dats"
dynload "src/pats_staexp2_hole.dats"
dynload "src/pats_staexp2_ctxt.dats"
dynload "src/pats_staexp2_dcon.dats"
dynload "src/pats_staexp2_skexp.dats"
dynload "src/pats_staexp2_szexp.dats"
dynload "src/pats_staexp2_util1.dats"
dynload "src/pats_staexp2_util2.dats"
dynload "src/pats_staexp2_util3.dats"
//
dynload "src/pats_dynexp2.dats"
dynload "src/pats_dyncst2.dats"
dynload "src/pats_dynexp2_print.dats"
dynload "src/pats_dynexp2_dcst.dats"
dynload "src/pats_dynexp2_dvar.dats"
dynload "src/pats_dynexp2_dmac.dats"
dynload "src/pats_dynexp2_util.dats"
//
dynload "src/pats_trans1_env.dats"
//
dynload "src/pats_e1xpval.dats"
dynload "src/pats_e1xpval_error.dats"
//
dynload "src/pats_trans1_error.dats"
dynload "src/pats_trans1_e0xp.dats"
dynload "src/pats_trans1_effect.dats"
dynload "src/pats_trans1_sort.dats"
dynload "src/pats_trans1_staexp.dats"
dynload "src/pats_trans1_p0at.dats"
dynload "src/pats_trans1_syndef.dats"
dynload "src/pats_trans1_dynexp.dats"
dynload "src/pats_trans1_decl.dats"
//
dynload "src/pats_namespace.dats"
dynload "src/pats_trans2_env.dats"
dynload "src/pats_trans2_error.dats"
dynload "src/pats_trans2_sort.dats"
dynload "src/pats_trans2_staexp.dats"
dynload "src/pats_trans2_p1at.dats"
dynload "src/pats_trans2_dynexp.dats"
dynload "src/pats_trans2_impdec.dats"
dynload "src/pats_trans2_decl.dats"
//
dynload "src/pats_comarg.dats"
//
(* ****** ****** *)

dynload "libatsyn2json/DATS/libatsyn2json.dats"
dynload "libatsyn2json/DATS/libatsyn2json_p2at.dats"
dynload "libatsyn2json/DATS/libatsyn2json_d2exp.dats"
dynload "libatsyn2json/DATS/libatsyn2json_d2ecl.dats"

(* ****** ****** *)

(* end of [dynloadall.dats] *)
