//
// Selection sort
//

(* ****** ****** *)
//
// HX-2012-07-22:
// A glorious implementation of selection-sort in ATS :)
//
(* ****** ****** *)

staload "program-1-2.sats"

(* ****** ****** *)

staload "contrib/atshwxi/testing/SATS/randgen.sats"

implement
main () = 0 where {
  #define N 10
  typedef T = int
//
  val asz = g1int2uint (N)
  val (
    pf, pfgc | p
  ) = array_ptr_alloc<T> (asz)
  val () = randgen_array (!p, asz)
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
  val () = array_ptr_free {T} (pf, pfgc | p)
//
} // end of [main]

(* ****** ****** *)

(* end of [program-1-2-test.dats] *)
