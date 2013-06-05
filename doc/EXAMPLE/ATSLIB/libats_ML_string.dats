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

staload "libats/ML/SATS/string.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/ML/DATS/array0.dats"
staload _(*anon*) = "libats/ML/DATS/string.dats"
//
(* ****** ****** *)

val alphabet0 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

val () =
{
val () = assert (length (alphabet0) = 26)
val () = assert (length (alphabet0 + alphabet0) = 2 * 26)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_strarr.dats] *)
