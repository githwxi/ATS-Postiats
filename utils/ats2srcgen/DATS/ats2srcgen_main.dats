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
dynload "src/pats_comarg.dats"
dynload "src/pats_symbol.dats"
dynload "src/pats_filename.dats"
dynload "src/pats_location.dats"
dynload "src/pats_errmsg.dats"
//
dynload "src/pats_effect.dats"
//
dynload "src/pats_symmap.dats"
dynload "src/pats_symenv.dats"
//
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
