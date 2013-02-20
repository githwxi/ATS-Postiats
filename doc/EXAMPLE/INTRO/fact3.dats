//
// Computing the factorials
//
// Author: Hongwei Xi (January 2013)
//

(* ****** ****** *)

staload "prelude/DATS/integer.dats"
staload "prelude/DATS/pointer.dats"
staload "prelude/DATS/array.dats"
staload "prelude/DATS/arrayptr.dats"
staload "prelude/DATS/arrayref.dats"

(*
staload
"prelude/DATS/basics.dats"
staload
"prelude/DATS/float.dats"
staload
"prelude/DATS/filebas.dats"
//
staload
UN = "prelude/SATS/unsafe.sats"
staload
_(*anon*) = "prelude/DATS/unsafe.dats"
*)

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
array_foreach$fwork<a><tenv> (x, env) = env := env * (x+1)
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
