(*
** for testing [prelude/string]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/string0.sats"

(* ****** ****** *)

val alphabet0 = (string0)"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

val () =
{
val () = assert (string0_get_size (alphabet0) = 26)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_string0.dats] *)
