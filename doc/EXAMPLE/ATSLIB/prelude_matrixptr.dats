(*
** for testing [prelude/matrixptr]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

postfix 0 SZ sz
macdef SZ (x) = i2sz ,(x)
macdef sz (x) = i2sz ,(x)

(* ****** ****** *)

val () =
{
//
val m = 2sz and n = 5sz
val M = matrixptr_make_elt (m, n, 0)
val () = M[0sz, n, 0sz] := 1
val () = matrixptr_free (M)
//
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_matrixptr.dats] *)
