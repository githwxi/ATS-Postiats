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

staload "atshwxi/testing/SATS/randgen.sats"

(* ****** ****** *)

implement
main () = 0 where {
  #define N 10
  typedef T = float
  val asz = g1int2uint (N)
  val A =
    randgen_arrayptr<T> (asz)
  // end of [val]
  val p = arrayptr2ptr (A)
  prval pfarr = arrayptr_takeout (A)
  val sum = RSum (!p, N)
  prval () = arrayptr_addback (pfarr | A)
  val () = arrayptr_free (A)
  val () = (
    print "sum of the array = "; print sum; print_newline ()
  ) // end of [val]
} // end of [main]

(* ****** ****** *)

(* end of [program-1-7.dats] *)
