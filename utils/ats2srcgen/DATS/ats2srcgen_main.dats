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

dynload "src/pats_utils.dats"

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
