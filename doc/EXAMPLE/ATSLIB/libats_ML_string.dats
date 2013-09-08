(*
** for testing [libats/ML/string]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
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
val ds =
string_tabulate
(
  i2sz(10)
, lam i => $UN.cast{charNZ}('0' + g0u2i(i))
) (* end of [val] *)
//
val out = stdout_ref
val () = fprintln! (out, "digits = ", ds)
//
val () =
string_foreach (ds+ds, lam c => fprint(out, c))
//
val () = fprint_newline (out)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_string.dats] *)
