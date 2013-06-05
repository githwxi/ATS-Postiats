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

val alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(* ****** ****** *)

val () =
{
//
val () = assertloc (length (alphabet) = 26)
val () = assertloc (alphabet = string_copy (alphabet))
val () = assertloc (alphabet = string_make_substring (alphabet, (i2sz)0, (i2sz)26))
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val () =
string_foreach
(
  alphabet+alphabet, lam c => fprint(out, tolower(c))
) (* end of [val] *)
//
val () = fprint_newline (out)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_string.dats] *)
