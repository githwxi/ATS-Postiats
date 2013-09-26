(*
** for testing [libats/ML/strarr]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

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

val () =
{
//
val out = stdout_ref
//
val digits =
strarr_tabulate (i2sz(10), lam i => '0' + g0u2i(i))
val () = fprintln! (out, "digits = ", digits)
//
val xdigits =
strarr_tabulate
(
  i2sz(16), lam i => if i < 10 then '0' + g0u2i(i) else 'a' + (g0u2i(i)-10)
) (* end of [val] *)
//
val () = fprintln! (out, "xdigits = ", xdigits)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val () = fprint! (out, "foreach: ")
val () = strarr_foreach (alphabet, lam c => fprint (out, c))
val () = fprint_newline (out)
//
val () = fprint! (out, "iforeach: ")
val () = strarr_iforeach (alphabet, lam (i, c) => fprint! (out, "(", c, i, ")"))
val () = fprint_newline (out)
//
val () = fprint! (out, "rforeach: ")
val () = strarr_rforeach (alphabet, lam c => fprint (out, c))
val () = fprint_newline (out)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_strarr.dats] *)
