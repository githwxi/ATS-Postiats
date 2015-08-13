(*
**
** Ats2srcgen:
** for static meta-programming
**
** Author: Hongwei Xi
** Authoremail: hwxiATgmhwxiDOTcom
** Start time: the 10th of August, 2015
**
*)

(* ****** ****** *)
//
dynload "src/pats_error.dats"
dynload "src/pats_utils.dats"
dynload "src/pats_global.dats"
dynload "src/pats_basics.dats"
dynload "src/pats_errmsg.dats"
dynload "src/pats_comarg.dats"
dynload "src/pats_symbol.dats"
//
dynload "src/pats_filename.dats"
dynload "src/pats_filename_reloc.dats"
//
dynload "src/pats_location.dats"
//
dynload "src/pats_label.dats"
dynload "src/pats_fixity_prec.dats"
dynload "src/pats_fixity_fxty.dats"
//
dynload "src/pats_effect.dats"
//
dynload "src/pats_symmap.dats"
dynload "src/pats_symenv.dats"
//
dynload "src/pats_reader.dats"
dynload "src/pats_lexbuf.dats"
dynload "src/pats_lexing.dats"
dynload "src/pats_lexing_token.dats"
dynload "src/pats_lexing_print.dats"
dynload "src/pats_lexing_error.dats"
//
(* ****** ****** *)

dynload "src/pats_syntax.dats"
dynload "src/pats_syntax_print.dats"

(* ****** ****** *)

dynload "src/pats_tokbuf.dats"
dynload "src/pats_parsing.dats"
dynload "src/pats_parsing_util.dats"
dynload "src/pats_parsing_kwds.dats"
dynload "src/pats_parsing_base.dats"
dynload "src/pats_parsing_error.dats"
dynload "src/pats_parsing_e0xp.dats"
dynload "src/pats_parsing_sort.dats"
dynload "src/pats_parsing_staexp.dats"
dynload "src/pats_parsing_p0at.dats"
dynload "src/pats_parsing_dynexp.dats"
dynload "src/pats_parsing_decl.dats"
dynload "src/pats_parsing_toplevel.dats"

(* ****** ****** *)

dynload "src/pats_staexp1.dats"
dynload "src/pats_staexp1_print.dats"

(* ****** ****** *)

dynload "src/pats_dynexp1.dats"
dynload "src/pats_dynexp1_print.dats"

(* ****** ****** *)

dynload "src/pats_e1xpval.dats"
dynload "src/pats_e1xpval_error.dats"

(* ****** ****** *)

dynload "src/pats_trans1_env.dats"
dynload "src/pats_trans1_e0xp.dats"
dynload "src/pats_trans1_error.dats"
dynload "src/pats_trans1_effect.dats"
dynload "src/pats_trans1_sort.dats"
dynload "src/pats_trans1_staexp.dats"
dynload "src/pats_trans1_p0at.dats"
dynload "src/pats_trans1_syndef.dats"
dynload "src/pats_trans1_dynexp.dats"
dynload "src/pats_trans1_decl.dats"

(* ****** ****** *)

staload "./../SATS/ats2srcgen.sats"

(* ****** ****** *)

implement
main((*void*)) =
{
//
val () = println! ("Hello from [ats2srcgen]!")
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [ats2srcgen_main.dats] *)
