(*
** for testing [prelude/matrixptr]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
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

implement(a:t0p)
fprint_array<a> (out, A, asz) = let
//
fun loop {n:nat}
(
  out: FILEref, A: &array(a, n), asz: size_t n, i: sizeLte(n)
) : void =
  if i < asz then
  (
    if i > 0 then fprint_array$sep (out);
    fprint_val<a> (out, A[i]); loop (out, A, asz, succ(i))
  ) else () // end of [if]
//
prval () = lemma_array_param (A)
//
in
  loop (out, A, asz, i2sz(0))
end // end of [fprint_array]

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
val () = fprint_matrixptr (out, M, (m)SZ, (n)SZ)
val () = fprint_newline (out)
//
val () = matrixptr_free (M)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_matrixptr.dats] *)
