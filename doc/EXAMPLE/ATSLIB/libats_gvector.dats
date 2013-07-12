(*
** for testing [libats/gvector]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
staload _ = "prelude/DATS/gorder.dats"
staload _ = "prelude/DATS/gnumber.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload _ = "libats/DATS/gvector.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val n = 5
val asz = i2sz(n)
//
val out = stdout_ref
//
val A = arrayptr_make_intrange (0, n)
val B = arrayptr_make_intrange (0, n)
//
val pA = ptrcast (A)
val pB = ptrcast (B)
//
prval
pfA = arrayptr_takeout{T}(A)
prval
pfB = arrayptr_takeout{T}(B)
//
prval pfA = array2gvector_v (pfA)
prval pfB = array2gvector_v (pfB)
//
val () = fprint (out, "A = ")
val () = fprint_gvector (out, !pA, n, 1)
val () = fprint_newline (out)
val () = fprint (out, "B = ")
val () = fprint_gvector (out, !pB, n, 1)
val () = fprint_newline (out)
//
val dp = mul_gvector_gvector_scalar (!pA, !pB, n, 1, 1)
//
val () = println! ("dotprod(A, B) = ", dp)
//
prval pfA = gvector2array_v (pfA)
prval pfB = gvector2array_v (pfB)
//
prval () = arrayptr_addback (pfA | A)
prval () = arrayptr_addback (pfB | B)
//
val () = arrayptr_free (A) and () = arrayptr_free (B)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_gvector.dats] *)
