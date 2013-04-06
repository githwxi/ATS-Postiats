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
//
staload _(*anon*) = "libats/ML/DATS/array0.dats"
staload _(*anon*) = "libats/ML/DATS/string0.dats"
//
(* ****** ****** *)

val alphabet0 = (string0)"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

val () =
{
val () = assert (string0_get_size (alphabet0) = 26)
val () = assert (string0_get_size (alphabet0 + alphabet0) = 2 * 26)
} // end of [val]

(* ****** ****** *)

val () =
{
val () = assert (alphabet0[0] = 'A')
val () = assert (alphabet0[25] = 'Z')
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_string0.dats] *)
