//
// Permuting the content of an array.
//
// Author: Hongwei Xi (Summer, 2012)
//

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

implement
main0 () = {
//
#define N 5
val asz = g1i2u (N)
val out = stdout_ref
//
val (pf, pfgc | p) = array_ptr_alloc<int> (asz)
//
implement
array_initize$init<int> (i, x) = x := g0u2i(i)+1
val () = array_initize<int> (!p, asz) // array: 1, 2, ..., N-1, N
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprint_newline (out)
//
implement
array_permute$randint<> (n) = pred(n) // this is not random
val () = array_permute<int> (!p, asz) // array: N, 1, 2, ..., N-1
//
val (
) = fprint_array_sep (out, !p, asz, ",")
val () = fprint_newline (out)
//
val () = array_ptr_free (pf, pfgc | p)
//
} // end of [main0]

(* ****** ****** *)

(* end of [apermuate.dats] *)
