//
// Recursive function for sum
//

(* ****** ****** *)

fun RSum
  {n:int} (
  A: &array(float, n), n: int n
) : float = let
//
prval () = lemma_array_param (A)
//
fun aux {
  n2:int | ~1 <= n2; n2 < n
} .<n2+1>. (
  A: &array(float, n), n2: int n2
) :<> float = let
//
in
  if n2 >= 0 then aux (A, n2-1) + A.[n2] else 0.0f
end // end of [aux]
in
  aux (A, n-1)
end // end of [RSum]

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
  val sum = RSum (!p, N)
  val () = array_ptr_free (pf, pfgc | p)
  val () = (
    print "sum of the array = "; print sum; print_newline ()
  ) // end of [val]
} // end of [main]

(* ****** ****** *)

(* end of [program-1-7.dats] *)
