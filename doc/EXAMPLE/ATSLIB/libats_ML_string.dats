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
val () = assertloc (itoa (12345) = "12345")
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val () = assertloc (length (alphabet) = 26)
val () = assertloc (alphabet = string_copy (alphabet))
val () = assertloc (alphabet = string_make_substring (alphabet, (i2sz)0, (i2sz)26))
//
val () = assertloc (alphabet[0] = 'A')
val () = assertloc (alphabet[25] = 'Z')
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
, lam i => $UN.cast{charNZ}('0'+sz2i(i))
) (* end of [val] *)
//
val out = stdout_ref
val () = fprintln! (out, "digits = ", ds)
//
val () =
string_foreach (ds+ds, lam c => fprint(out, c))
//
val ((*void*)) = fprint_newline (out)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val str = ""
val cs = string_explode (str)
val () = assertloc (str = string_implode(cs))
//
val str = "abcde"
val cs = string_explode (str)
val () = assertloc (str = string_implode(cs))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_string.dats] *)
