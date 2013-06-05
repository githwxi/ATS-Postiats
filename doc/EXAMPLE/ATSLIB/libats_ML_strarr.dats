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

staload "libats/ML/SATS/strarr.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/ML/DATS/array0.dats"
staload _(*anon*) = "libats/ML/DATS/strarr.dats"
//
(* ****** ****** *)

val alphabet = (strarr)"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

val () =
{
val () = assert (strarr_get_size (alphabet) = 26)
val () = assert (strarr_get_size (alphabet + alphabet) = 2 * 26)
} // end of [val]

(* ****** ****** *)

val () =
{
val AB = strarr_copy (alphabet)
//
val () = fprintln! (stdout_ref, "AB = ", AB)
//
val () = assertloc (strarr_get_size (AB) = strarr_get_size (alphabet))
//
val () = assertloc (AB[0] = 'A')
val () = assertloc (AB[25] = 'Z')
val () = assertloc ( strarr_contains (AB, 'Q'))
val () = assertloc (~strarr_contains (AB, '0'))
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_strarr.dats] *)
