(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxiATgmailDOTcom)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)
//
// HX-2016-02-20:
//
#define
ATS_DYNLOADFLAG 0 // manual dynloading
#define
ATS_DYNLOADFUN_NAME "libatsynmark_dynloadall"
//
(* ****** ****** *)
//
(*
dynload "src/pats_error.dats"
dynload "src/pats_utils.dats"
dynload "src/pats_basics.dats"
dynload "src/pats_symbol.dats"
dynload "src/pats_filename.dats"
dynload "src/pats_location.dats"
dynload "src/pats_label.dats"
dynload "src/pats_fixity_prec.dats"
dynload "src/pats_fixity_fxty.dats"
*)
//
(*
dynload "src/pats_reader.dats"
dynload "src/pats_lexbuf.dats"
dynload "src/pats_lexing.dats"
dynload "src/pats_lexing_token.dats"
dynload "src/pats_lexing_print.dats"
dynload "src/pats_lexing_error.dats"
*)
//
(*
dynload "src/pats_tokbuf.dats"
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
*)
//
(*
dynload "src/pats_syntax.dats"
dynload "src/pats_syntax_print.dats"
*)
//
dynload "./DATS/libatsynmark.dats"
dynload "./DATS/libatsynmark_psynmark.dats"
dynload "./DATS/libatsynmark_pats2xhtml.dats"
//
(*
dynload "./DATS/libatsynmark_pats2xhtml_bground.dats"
dynload "./DATS/libatsynmark_pats2xhtml_embedded.dats"
*)
//
(* ****** ****** *)

local
//
extern
fun
libatsopt_dynloadall(): void = "ext#"
//
in (* in-of-local *)

val () = libatsopt_dynloadall((*void*))

end // end of [local]

(* ****** ****** *)

(* end of [dynloadall.dats] *)
