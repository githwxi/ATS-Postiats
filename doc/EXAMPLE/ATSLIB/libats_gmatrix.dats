(*
** for testing [libats/gmatrix]
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

staload "libats/SATS/gmatrix.sats"
staload _ = "libats/DATS/gmatrix.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
val out = stdout_ref
//
val n = 4
val asz = i2sz(n)
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
val (pfM, pfMgc | pM) = matrix_ptr_alloc<T> (asz, asz)
//
prval pfA = array2gvector_v (pfA)
prval pfB = array2gvector_v (pfB)
prval pfM = matrix2gmatrix_v (pfM)
//
val () = tmulto_gvector_gvector_gmatrow (!pA, !pB, !pM, n, n, 1, 1, n)
//
prval pfA = gvector2array_v (pfA)
prval pfB = gvector2array_v (pfB)
prval pfM = gmatrix2matrix_v (pfM)
//
val () = fprint (out, "A = ")
val () = fprint_array (out, !pA, asz)
val () = fprint_newline (out)
val () = fprint (out, "B = ")
val () = fprint_array (out, !pB, asz)
val () = fprint_newline (out)
val () = fprint (out, "M =\n")
val () = fprint_matrix (out, !pM, asz, asz)
val () = fprint_newline (out)
//
prval () = arrayptr_addback (pfA | A)
prval () = arrayptr_addback (pfB | B)
//
val () = matrix_ptr_free (pfM, pfMgc | pM)
val () = arrayptr_free (A) and () = arrayptr_free (B)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_gmatrix.dats] *)
