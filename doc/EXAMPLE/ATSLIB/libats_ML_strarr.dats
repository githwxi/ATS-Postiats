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

val alphabet0 = (strarr)"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

val () =
{
val () = assert (strarr_get_size (alphabet0) = 26)
val () = assert (strarr_get_size (alphabet0 + alphabet0) = 2 * 26)
} // end of [val]

(* ****** ****** *)

val () =
{
val AB = strarr_copy (alphabet0)
val () = assert (strarr_get_size (AB) = strarr_get_size (alphabet0))
val () = assert (AB[0] = 'A')
val () = assert (AB[25] = 'Z')
val () = assert ( strarr_contains (AB, 'Q'))
val () = assert (~strarr_contains (AB, '0'))
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_strarr.dats] *)
