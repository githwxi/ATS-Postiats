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

postfix 0 sz SZ
macdef sz (x) = i2sz ,(x)
macdef SZ (x) = i2sz ,(x)

(* ****** ****** *)

val () =
{
//
val m = 2 and n = 5
val M = matrixptr_make_elt<int> (m, n, 0)
//
val () = M[0, n, 0] := 0*n + 0
val () = M[0, n, 1] := 0*n + 1
val () = M[1, n, 0] := 1*n + 0
val () = M[1, n, 0] := 1*n + 1
//
val () = matrixptr_free (M)
//
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_matrixptr.dats] *)
