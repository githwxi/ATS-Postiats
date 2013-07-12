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

staload "libats/SATS/gmatrix_row.sats"
staload _ = "libats/DATS/gmatrix_row.dats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val out = stdout_ref
//
val n = 5
val asz = i2sz(n)
//
implement
fprint_val<T> (out, x) =
  ignoret ($extfcall (int, "fprintf", out, "%2.2d", x))
//
local
implement
array_tabulate$fopr<T>
  (i) = g0uint2int_size_int(i)
in (* in of [local] *)
val A = arrayptr_tabulate<T> (asz)
val B = arrayptr_tabulate<T> (asz)
end // end of [local]
//
val pA = ptrcast (A) and pB = ptrcast (B)
//
prval
pfA = arrayptr_takeout{T}(A)
prval
pfB = arrayptr_takeout{T}(B)
//
val (pfM, pfgcM | pM) = matrix_ptr_alloc<T> (asz, asz)
val (pfM2, pfgcM2 | pM2) = matrix_ptr_alloc<T> (asz, asz)
//
prval pfA = array2gvector_v (pfA)
prval pfB = array2gvector_v (pfB)
prval pfM = matrix2gmatrix_v (pfM)
prval pfM2 = matrix2gmatrix_v (pfM2)
//
val () =
  tmulto_gvector_gvector_gmatrow (!pA, !pB, !pM, n, n, 1, 1, n)
val () =
  multo_gmatrow_gmatrow_gmatrow (!pM, !pM, !pM2, n, n, n, n, n, n)
//
prval pfA = gvector2array_v (pfA)
prval pfB = gvector2array_v (pfB)
prval pfM = gmatrix2matrix_v (pfM)
prval pfM2 = gmatrix2matrix_v (pfM2)
//
val () = fprint (out, "A =\n")
val () = fprint_array (out, !pA, asz)
val () = fprint_newline (out)
val () = fprint (out, "B =\n")
val () = fprint_array (out, !pB, asz)
val () = fprint_newline (out)
val () = fprint (out, "M = A(X)B =\n")
val () = fprint_matrix_sep (out, !pM, asz, asz, ", ", "\n")
val () = fprint_newline (out)
val () = fprint (out, "M2 = M(*)M =\n")
val () = fprint_matrix_sep (out, !pM2, asz, asz, ", ", "\n")
val () = fprint_newline (out)
//
prval () = arrayptr_addback (pfA | A)
prval () = arrayptr_addback (pfB | B)
//
val () = matrix_ptr_free (pfM, pfgcM | pM)
val () = matrix_ptr_free (pfM2, pfgcM2 | pM2)
val () = arrayptr_free (A) and () = arrayptr_free (B)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_gmatrix.dats] *)
