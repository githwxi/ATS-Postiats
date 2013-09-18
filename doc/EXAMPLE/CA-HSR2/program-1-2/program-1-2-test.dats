//
// Selection sort
//

(* ****** ****** *)
//
// HX-2012-07-22:
// A glorious implementation of selection-sort in ATS :)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/gorder.dats"

(* ****** ****** *)

staload "./program-1-2.sats"
staload _ = "./program-1-2.dats" // for templates

(* ****** ****** *)

implement
main0 () = {
//
#define N 10
typedef T = int
//
val asz = g1int2uint (N)
val A = (arrayptr)$arrpsz{int} (1, 8, 3, 6, 5, 4, 7, 2, 9, 0)
val p = arrayptr2ptr (A)
prval pfarr = arrayptr_takeout (A)
//
val out = stdout_ref
//
val () = fprint (out, "Array(bef) = ")
val () = fprint_val<T> (out, p->[0])
val () = fprint_val<T> (out, p->[1])
val () = fprint_val<T> (out, p->[2])
val () = fprint_val<T> (out, p->[3])
val () = fprint_val<T> (out, p->[4])
val () = fprint_val<T> (out, p->[5])
val () = fprint_val<T> (out, p->[6])
val () = fprint_val<T> (out, p->[7])
val () = fprint_val<T> (out, p->[8])
val () = fprint_val<T> (out, p->[9])
val () = fprint_newline (out)
//
val () = SelectionSort (!p, asz)
//
val () = fprint (out, "Array(aft1) = ")
val () = fprint_array_sep (out, !p, asz, ", ")
val () = fprint_newline (out)
//
implement
SelectionSort$cmp<int> (x1, x2) = x2 - x1
//
val () = SelectionSort (!p, asz)
//
val () = fprint (out, "Array(aft2) = ")
val () = fprint_array_sep (out, !p, asz, ", ")
val () = fprint_newline (out)
//
prval () = arrayptr_addback (pfarr | A)
//
val () = arrayptr_free (A)
//
} // end of [main0]

(* ****** ****** *)

(* end of [program-1-2-test.dats] *)
