//
// Computing the factorials
//
// Author: Hongwei Xi (January 2013)
//

(* ****** ****** *)

fun fact
  {n:nat}
  (n: int n): int = let
//
val A = arrayptr_make_intrange (0, n)
//
typedef a = int
typedef tenv = int
implement
array_foreach$fwork<a><tenv> (x, env) = env := env * x
//
var env: tenv = 1
//
val _ = arrayptr_foreach_env<a><tenv> (A, g1int2uint (n), env)
//
val () = arrayptr_free (A)
//
in
  env
end // end of [fact]

(* ****** ****** *)

implement
main (
) = 0 where {
  val N = 12
  val () = println! ("fact(", N, ") = ", fact(N))
} // end of [main]

(* ****** ****** *)

(* end of [fact3.dats] *)
