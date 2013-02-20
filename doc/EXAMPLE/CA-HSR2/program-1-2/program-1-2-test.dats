//
// Selection sort
//

(* ****** ****** *)
//
// HX-2012-07-22:
// A glorious implementation of selection-sort in ATS :)
//
(* ****** ****** *)

staload "./program-1-2.sats"

(* ****** ****** *)

staload "atshwxi/testing/SATS/randgen.sats"

(* ****** ****** *)

implement
main () = 0 where {
  #define N 10
  typedef T = int
//
  val asz = g1int2uint (N)
  val A =
    randgen_arrayptr<T> (asz)
  val p = arrayptr2ptr (A)
  prval pfarr = arrayptr_takeout (A)
//
  val out = stdout_ref
//
  val () = fprint (out, "Array(bef) = ")
  val () = fprint_array<T> (out, !p, asz)
  val () = fprint_newline (out)
//
  val () = SelectionSort (!p, asz)
//
  val () = fprint (out, "Array(aft) = ")
  val () = fprint_array<T> (out, !p, asz)
  val () = fprint_newline (out)
//
  prval () = arrayptr_addback (pfarr | A)
//
  val () = arrayptr_free (A)
//
} // end of [main]

(* ****** ****** *)

(* end of [program-1-2-test.dats] *)
