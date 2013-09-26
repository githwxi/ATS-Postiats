(*
** for testing [prelude/matrixptr]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "prelude/lmacrodef.sats"

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
val out = stdout_ref
//
val m = 2 and n = 5
val A = (arrayptr)$arrpsz{int}(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
val M = arrayptr2matrixptr (A, m, n)
//
implement{}
fprint_matrix$sep2
  (out) = fprint_string (out, "; ")
//
val () =
  fprint_matrixptr (out, M, (m)sz, (n)sz)
val () = fprint_newline (out)
//
val () = M[0, n, 0] :=* 2
val () = M[0, n, 1] :=* 2
val () = M[0, n, 2] :=* 2
val () = M[0, n, 3] :=* 2
val () = M[0, n, 4] :=* 2
val () = M[1, n, 0] :=/ 2
val () = M[1, n, 1] :=/ 2
val () = M[1, n, 2] :=/ 2
val () = M[1, n, 3] :=/ 2
val () = M[1, n, 4] :=/ 2
//
val () =
  fprint_matrixptr (out, M, (m)sz, (n)sz)
val () = fprint_newline (out)
//
val () = matrixptr_free (M)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_matrixptr.dats] *)
