//
// Iterative function for sum
//
(* ****** ****** *)
//
// HX-2012-07:
//
// Note that 'iterative' is often referred
// to as 'tail-recursive' in the literature.
//
(* ****** ****** *)

fun Sum
  {n:int} (
  A: &array(float, n), n: int n
) : float = let
//
prval () = lemma_array_param (A)
//
fun loop
  {n:int}{i:nat | i <= n} .<n-i>. (
  A: &array(float, n), n: int n, i: int i, res: float
) :<> float = let
in
  if i < n then loop (A, n, i+1, res+A.[i]) else res
end // end of [loop]
//
in
  loop (A, n, 0, 0.0f)
end // end of [Sum]

(* ****** ****** *)

staload "contrib/atshwxi/testing/SATS/randgen.sats"

implement
main () = 0 where {
  #define N 10
  typedef T = float
  val asz = g1int2uint (N)
  val (
    pf, pfgc | p
  ) = array_ptr_alloc<T> (asz)
  val () = randgen_array<T> (!p, asz)
  val sum = Sum (!p, N)
  val () = array_ptr_free (pf, pfgc | p)
  val () = (
    print "sum of the array = "; print sum; print_newline ()
  ) // end of [val]
} // end of [main]

(* ****** ****** *)

(* end of [program-1-6.dats] *)
